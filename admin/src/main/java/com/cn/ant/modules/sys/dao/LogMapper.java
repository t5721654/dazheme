package com.cn.ant.modules.sys.dao;

import java.util.List;

import com.cn.ant.common.persistence.MyBatisRepository;
import com.cn.ant.modules.sys.entity.Log;

@MyBatisRepository
public interface LogMapper {
	public int delete(Long id);
    public int insert(Log record);
	public Log get(Long id);
	public int update(Log record);
	public List<Log> find();
}