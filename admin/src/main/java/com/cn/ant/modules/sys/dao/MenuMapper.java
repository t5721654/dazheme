package com.cn.ant.modules.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cn.ant.common.persistence.MyBatisRepository;
import com.cn.ant.modules.sys.entity.Menu;
@MyBatisRepository
public interface MenuMapper {
	public int delete(@Param(value = "id") String id);
	public int deleteByParent(@Param(value = "id") String id);
	public int insert(Menu record);
	public Menu get(String id);
	public int update(Menu record);
	public int batchUpdate(List<Menu> list);
	public List<Menu> findByParentIdsLike(@Param(value = "parentIds") String parentIds);
	public List<Menu> findAllList();
	public List<Menu> findByUserId(@Param(value = "userId") String userId);
}