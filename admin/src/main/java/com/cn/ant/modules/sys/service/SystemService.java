/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.cn.ant.modules.sys.service;

import com.cn.ant.common.persistence.Page;
import com.cn.ant.common.security.Digests;
import com.cn.ant.common.service.BaseService;
import com.cn.ant.common.utils.DateUtils;
import com.cn.ant.common.utils.Encodes;
import com.cn.ant.common.utils.Identities;
import com.cn.ant.modules.sys.dao.MenuMapper;
import com.cn.ant.modules.sys.dao.RoleMapper;
import com.cn.ant.modules.sys.dao.UserMapper;
import com.cn.ant.modules.sys.entity.Menu;
import com.cn.ant.modules.sys.entity.Role;
import com.cn.ant.modules.sys.entity.User;
import com.cn.ant.modules.sys.security.SystemAuthorizingRealm;
import com.cn.ant.modules.sys.utils.UserUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 系统管理，安全相关实体的管理类,包括用户、角色、菜单.
 * 
 * @author ThinkGem
 * @version 2013-5-15
 */
@Service
@Transactional(readOnly = true)
public class SystemService extends BaseService {
	
	public static final String HASH_ALGORITHM = "SHA-1";
	public static final int HASH_INTERATIONS = 1024;
	public static final int SALT_SIZE = 8;
	
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private RoleMapper roleMapper;
	@Autowired
	private MenuMapper menuMapper;
	@Autowired
	private SystemAuthorizingRealm systemRealm;

	//-- User Service --//
	
	public User getUser(String id) {
		return userMapper.get(id);
	}
	
	public Page<User> findUser(Page<User> page, Map<String, Object> params) {
		page.setCount(userMapper.count(params));
		if (!page.isDisabled()) {
			params.put("start", page.getFirstResult());
			params.put("pageSize", page.getPageSize());
		} else {
			params.put("start", 0);
			params.put("pageSize", page.getCount());
		}
		page.setList(userMapper.find(params));
		return page;
	}

	public User getUserByLoginName(String loginName) {
		User user = userMapper.findByLoginName(loginName);
		return userMapper.findByLoginName(loginName);
	}

	@Transactional(readOnly = false)
	public void saveUser(User user) {
		if (StringUtils.isBlank(user.getId())) {
			user.setId(Identities.generateUUID());
			userMapper.insert(user);
		} else {
			userMapper.update(user);
		}
		systemRealm.clearAllCachedAuthorizationInfo();
	}

	@Transactional(readOnly = false)
	public void deleteUser(String id) {
		userMapper.delete(id);
	}
	
	@Transactional(readOnly = false)
	public void updatePasswordById(String id, String loginName, String newPassword) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("password", entryptPassword(newPassword));
		params.put("id", id);
		userMapper.updatePasswordById(params);
		systemRealm.clearCachedAuthorizationInfo(loginName);
	}
	
	@Transactional(readOnly = false)
	public void updateUserLoginInfo(String id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("loginIp", SecurityUtils.getSubject().getSession().getHost());
		params.put("loginDate", DateUtils.getCurrDate());
		params.put("id", id);
		userMapper.updateLoginInfo(params);
	}
	/**
	 * 生成安全的密码，生成随机的16位salt并经过1024次 sha-1 hash
	 */
	public static String entryptPassword(String plainPassword) {
		byte[] salt = Digests.generateSalt(SALT_SIZE);
		byte[] hashPassword = Digests.sha1(plainPassword.getBytes(), salt, HASH_INTERATIONS);
		return Encodes.encodeHex(salt)+Encodes.encodeHex(hashPassword);
	}

	/**
	 * 验证密码
	 * 
	 * @param plainPassword
	 *            明文密码
	 * @param password
	 *            密文密码
	 * @return 验证成功返回true
	 */
	public static boolean validatePassword(String plainPassword, String password) {
		byte[] salt = Encodes.decodeHex(password.substring(0,16));
		byte[] hashPassword = Digests.sha1(plainPassword.getBytes(), salt, HASH_INTERATIONS);
		return password.equals(Encodes.encodeHex(salt)+Encodes.encodeHex(hashPassword));
	}
	
	//-- Role Service --//
	
	public Role getRole(String id) {
		return roleMapper.get(id);
	}

	public Role findRoleByName(String name) {
		return roleMapper.findByName(name);
	}
	
	public List<Role> findAllRole(){
		return UserUtils.getRoleList();
	}
	
	@Transactional(readOnly = false)
	public void saveRole(Role role) {
		if (StringUtils.isBlank(role.getId())) {
			role.setId(Identities.generateUUID());
			roleMapper.insert(role);
		} else {
			roleMapper.update(role);
		}
		systemRealm.clearAllCachedAuthorizationInfo();
		UserUtils.removeCache(UserUtils.CACHE_ROLE_LIST);
	}

	@Transactional(readOnly = false)
	public void deleteRole(String id) {
		roleMapper.delete(id);
		systemRealm.clearAllCachedAuthorizationInfo();
		UserUtils.removeCache(UserUtils.CACHE_ROLE_LIST);
	}
	
	@Transactional(readOnly = false)
	public Boolean outUserInRole(Role role, String userId) {
		User user = userMapper.get(userId);
		List<String> roleIds = user.getRoleIdList();
		List<Role> roles = user.getRoleList();
		if (roleIds.contains(role.getId())) {
			roles.remove(role);
			saveUser(user);
			return true;
		}
		return false;
	}
	
	@Transactional(readOnly = false)
	public User assignUserToRole(Role role, String userId) {
		User user = userMapper.get(userId);
		List<String> roleIds = user.getRoleIdList();
		if (roleIds.contains(role.getId())) {
			return null;
		}
		user.getRoleList().add(role);
		saveUser(user);		
		return user;
	}

	//-- Menu Service --//
	
	public Menu getMenu(String id) {
		return menuMapper.get(id);
	}

	public List<Menu> findAllMenu(){
		return UserUtils.getMenuList();
	}
	
	@Transactional(readOnly = false)
	public void saveMenu(Menu menu) {
		menu.setParent(this.getMenu(menu.getParent().getId()));
		String oldParentIds = menu.getParentIds(); // 获取修改前的parentIds，用于更新子节点的parentIds
		menu.setParentIds(menu.getParent().getParentIds()+menu.getParent().getId()+",");
		if (StringUtils.isBlank(menu.getId())) {
			menu.setId(Identities.generateUUID());
			menuMapper.insert(menu);
		} else {
			menuMapper.update(menu);
		}
		// 更新子节点 parentIds
		List<Menu> list = menuMapper.findByParentIdsLike("%," + menu.getId() + ",%");
		if (list != null && list.size() > 0) {
			for (Menu e : list) {
				e.setParentIds(e.getParentIds().replace(oldParentIds, menu.getParentIds()));
			}
			menuMapper.batchUpdate(list);
		}
		systemRealm.clearAllCachedAuthorizationInfo();
		UserUtils.removeCache(UserUtils.CACHE_MENU_LIST);
	}

	@Transactional(readOnly = false)
	public void deleteMenu(String id) {
		menuMapper.delete(id);
		menuMapper.deleteByParent(id);
		systemRealm.clearAllCachedAuthorizationInfo();
		UserUtils.removeCache(UserUtils.CACHE_MENU_LIST);
	}
}
