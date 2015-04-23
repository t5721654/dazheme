package com.cn.ant.modules.sys.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.cn.ant.common.persistence.Page;
import com.cn.ant.common.service.BaseService;
import com.cn.ant.modules.sys.dao.CommunityInfoMapper;
import com.cn.ant.modules.sys.entity.CommunityInfo;

/**
 * 小区表Service
 * 
 * @author 黄根华
 * @version 2013-08-16
 */
@Component
@Transactional(readOnly = true)
public class CommunityInfoService extends BaseService {

	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(CommunityInfoService.class);

	@Autowired
	private CommunityInfoMapper communityInfoMapper;

	public CommunityInfo get(String id) {
		return communityInfoMapper.get(id);
	}

	public Page<CommunityInfo> find(Page<CommunityInfo> page, Map<String, Object> params) {
		if (!page.isDisabled()) {

		}
		page.setList(communityInfoMapper.query(params));
		return page;
	}

	@Transactional(readOnly = false)
	public void save(CommunityInfo communityInfo) {
		communityInfoMapper.insert(communityInfo);
	}

	@Transactional(readOnly = false)
	public void update(CommunityInfo communityInfo) {
		communityInfoMapper.update(communityInfo);
	}

	@Transactional(readOnly = false)
	public void delete(String id) {
		communityInfoMapper.delete(id);
	}

	/**
	 * 获取机构附近的小区信息
	 * 
	 * @param siteId
	 * @return
	 */
	public List<CommunityInfo> findBySiteId(String siteId) {
		return communityInfoMapper.findBySiteId(siteId);
	}
}
