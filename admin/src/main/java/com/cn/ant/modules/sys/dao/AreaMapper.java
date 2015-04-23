package com.cn.ant.modules.sys.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cn.ant.common.persistence.MyBatisRepository;
import com.cn.ant.modules.sys.entity.Area;
@MyBatisRepository
public interface AreaMapper {
	public int delete(@Param(value = "id") String id);
	public int deleteChilds(@Param(value = "id") String id);
	public int insert(Area record);
	public Area get(String id);
	public int update(Area record);
	public int batchUpdate(List<Area> list);
	public List<Area> findByParentIdsLike(@Param(value = "parentIds") String parentIds);
	public List<Area> findAllList(Map<String, String> params);
	public List<Area> findAllChild(Map<String, String> params);
}