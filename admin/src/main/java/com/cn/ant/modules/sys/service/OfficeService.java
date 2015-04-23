package com.cn.ant.modules.sys.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cn.ant.common.service.BaseService;
import com.cn.ant.modules.sys.dao.OfficeMapper;
import com.cn.ant.modules.sys.entity.Office;
import com.cn.ant.modules.sys.utils.UserUtils;

/**
 * 机构Service
 * 
 * @author ThinkGem
 * @version 2013-5-29
 */
@Service
@Transactional(readOnly = true)
public class OfficeService extends BaseService {

	@Autowired
	private OfficeMapper officeMapper;
	
	public Office get(String id) {
		return officeMapper.get(id);
	}

	/**
	 * 根据用户的权限,查询机构
	 * 
	 * @param scope
	 * @return
	 */
	public List<Office> findByScope(String scope) {
		return null;
	}

	public List<Office> findAll(){
		return UserUtils.getOfficeList();
	}
	
	@Transactional(readOnly = false)
	public void save(Office office) {
		office.setParent(this.get(office.getParent().getId()));
		office.setParentIds(office.getParent().getParentIds()+office.getParent().getId()+",");
		officeMapper.insert(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}
	
	@Transactional(readOnly = false)
	public void update(Office office) {
		office.setParent(this.get(office.getParent().getId()));
		String oldParentIds = office.getParentIds(); // 获取修改前的parentIds，用于更新子节点的parentIds
		office.setParentIds(office.getParent().getParentIds() + office.getParent().getId() + ",");
		officeMapper.update(office);
		// 更新子节点 parentIds
		List<Office> list = officeMapper.findByParentIdsLike("%," + office.getId() + ",%");
		for (Office e : list) {
			e.setParentIds(e.getParentIds().replace(oldParentIds, office.getParentIds()));
		}
		if(list.size()>0){
			officeMapper.batchUpdate(list);
		}
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}

	@Transactional(readOnly = false)
	public void delete(String id) {
		officeMapper.delete(id);
		officeMapper.deleteByParent(id);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}
	
}
