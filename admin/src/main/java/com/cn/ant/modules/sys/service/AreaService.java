/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.cn.ant.modules.sys.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cn.ant.common.service.BaseService;
import com.cn.ant.common.utils.Identities;
import com.cn.ant.modules.sys.dao.AreaMapper;
import com.cn.ant.modules.sys.entity.Area;
import com.cn.ant.modules.sys.utils.UserUtils;

/**
 * 区域Service
 * 
 * @author ThinkGem
 * @version 2013-5-29
 */
@Service
@Transactional(readOnly = true)
public class AreaService extends BaseService {

    @Autowired
    private AreaMapper mapper;

	public Area get(String id) {
		return mapper.get(id);
	}
	
	public List<Area> findAll(){
		return UserUtils.getAreaList();
	}

	@Transactional(readOnly = false)
	public void save(Area area) {
        area.setParentId(area.getParent().getId());
		String oldParentIds = area.getParentIds(); // 获取修改前的parentIds，用于更新子节点的parentIds
		area.setParentIds(area.getParent().getParentIds()+area.getParent().getId()+",");
		if (StringUtils.isBlank(area.getId())) {
			area.setId(Identities.generateUUID());
			area.prePersist();
			mapper.insert(area);
		} else {
			area.preUpdate();
			mapper.update(area);
		}
		// 更新子节点 parentIds
		List<Area> list = mapper.findByParentIdsLike("%," + area.getId() + ",%");
		if (list != null && list.size() > 0) {
			for (Area e : list) {
				e.setParentIds(e.getParentIds().replace(oldParentIds, area.getParentIds()));
			}
			mapper.batchUpdate(list);
		}
        UserUtils.removeCache(UserUtils.CACHE_AREA_LIST);
	}
	
	@Transactional(readOnly = false)
	public void delete(String id) {
		mapper.delete(id);
		mapper.deleteChilds(id);
		UserUtils.removeCache(UserUtils.CACHE_AREA_LIST);
	}
	
}
