package com.cn.ant.modules.sys.dao;

import java.util.List;
import java.util.Map;

import com.cn.ant.common.persistence.MyBatisRepository;
import com.cn.ant.modules.sys.entity.Role;

/**
 * 用户角色表
 * 
 * @author dream 2014-7-26
 */
@MyBatisRepository
public interface RoleMapper {
	public int delete(String id);
    public int insert(Role record);
	public Role get(String id);
	public int update(Role record);
	public Role findByName(String name);
	public List<Role> find(Map<String, String> params);
}