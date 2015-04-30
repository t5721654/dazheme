package com.cn.ant.modules.community.mapper;

import com.cn.ant.common.persistence.MyBatisRepository;
import com.cn.ant.model.CommunityInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@MyBatisRepository
public interface CommunityInfoMapper {

	public int delete(String id);

	public int insert(CommunityInfo record);

	public CommunityInfo get(String id);

	public int update(CommunityInfo record);
	
	public List<CommunityInfo> query(Map<String, Object> params);

	public List<CommunityInfo> findBySiteId(@Param("siteId") String siteId);
}