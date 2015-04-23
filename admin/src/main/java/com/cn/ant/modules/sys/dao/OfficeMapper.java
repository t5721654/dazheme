package com.cn.ant.modules.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cn.ant.common.persistence.MyBatisRepository;
import com.cn.ant.modules.sys.entity.Office;

/**
 * 部门
 * 
 * @author dream 2014-7-26
 */
@MyBatisRepository
public interface OfficeMapper {
	public int delete(String id);
    public int insert(Office record);
    public Office get(String id);
    public int update(Office record);
	public List<Office> findByParentIdsLike(@Param(value = "parentIds") String parentIds);
	// 批量更新
	public int batchUpdate(@Param("list") List<Office> list);
	public int deleteByParent(String id);
	public List<Office> findAllList();
}