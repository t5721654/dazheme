/**
 * Copyright &copy; 2012-2013 <a
 * href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.cn.ant.modules.sys.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cn.ant.common.persistence.Page;
import com.cn.ant.common.service.BaseService;
import com.cn.ant.common.utils.CacheUtils;
import com.cn.ant.modules.sys.dao.DictMapper;
import com.cn.ant.modules.sys.entity.Dict;
import com.cn.ant.modules.sys.utils.DictUtils;

/**
 * 字典Service
 * 
 * @author ThinkGem
 * @version 2013-5-29
 */
@Service
@Transactional(readOnly = true)
public class DictService extends BaseService {

	@Autowired
	private DictMapper dictMapper;

	public Dict get(String id) {
		return dictMapper.get(id);
	}

	public Page<Dict> find(Page<Dict> page, Dict dict) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", dict.getType());
		params.put("startIdx", page.getFirstResult());
		params.put("endIdx", page.getLastResult());
		page.setCount(dictMapper.findByTypeCount(params));
		page.setList(dictMapper.findByType(params));

		return page;
	}

	public List<String> findTypeList() {
		return dictMapper.findTypeList();
	}

	public List<String> findDescList() {
		return dictMapper.findDescList();
	}

	@Transactional(readOnly = false)
	public void save(Dict dict) {
		dictMapper.insert(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}

	@Transactional(readOnly = false)
	public void update(Dict dict) {
		dictMapper.update(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}

	@Transactional(readOnly = false)
	public void delete(String id) {
		dictMapper.delete(id);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}

    public List<Dict> findDescAndType() {
		return dictMapper.findDescAndType();
    }

}
