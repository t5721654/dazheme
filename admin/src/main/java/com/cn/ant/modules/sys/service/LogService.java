/**
 * Copyright &copy; 2012-2013 <a href="httparamMap://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.cn.ant.modules.sys.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cn.ant.common.persistence.Page;
import com.cn.ant.common.service.BaseService;
import com.cn.ant.modules.sys.dao.LogMapper;
import com.cn.ant.modules.sys.entity.Log;

/**
 * 日志Service
 * 
 * @author ThinkGem
 * @version 2013-6-2
 */
@Service
@Transactional(readOnly = true)
public class LogService extends BaseService {

	@Autowired
	private LogMapper logMapper;
	
	public Log get(Long id) {
		return logMapper.get(id);
	}
	
	public Page<Log> find(Page<Log> page, Map<String, Object> paramMap) {
		page.setList(logMapper.find());
		return page;
	}
	
}
