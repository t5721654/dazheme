package com.cn.ant.modules.sys.dao;

import java.util.List;
import java.util.Map;

import com.cn.ant.common.persistence.MyBatisRepository;
import com.cn.ant.modules.sys.entity.Dict;

@MyBatisRepository
public interface DictMapper {
	public int delete(String id);
    public int insert(Dict record);
	public Dict get(String id);
	public int update(Dict record);
	public List<Dict> findAll();
	public List<String> findTypeList();
	public List<Dict> findByType(Map<String, Object> params);
	public int findByTypeCount(Map<String, Object> params);
	public List<String> findDescList();
	public List<Dict> findDescAndType();
}