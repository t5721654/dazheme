package com.cn.ant.modules.sys.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cn.ant.common.persistence.MyBatisRepository;
import com.cn.ant.modules.sys.entity.CommunityInfo;
@MyBatisRepository
public interface CommunityInfoMapper {

	public int delete(String id);

	public int insert(CommunityInfo record);

	public CommunityInfo get(String id);

	public int update(CommunityInfo record);
	
	public List<CommunityInfo> query(Map<String, Object> params);

	public List<CommunityInfo> findBySiteId(@Param("siteId") String siteId);
}