package com.cn.ant.interfaces;

import com.cn.ant.common.persistence.Page;
import com.cn.ant.model.CommunityInfo;

import java.util.List;
import java.util.Map;

/**
 * 小区管理
 * Created by huanggenhua on 2015/4/26.
 */
public interface ICommunityInfoService {
    /**
     * 获取小区信息
     * @param id
     * @return
     */
    public CommunityInfo get(String id);

    public Page<CommunityInfo> find(Page<CommunityInfo> page, Map<String, Object> params);

    public void save(CommunityInfo communityInfo);

    public void update(CommunityInfo communityInfo);

    public void delete(String id);

    public List<CommunityInfo> findBySiteId(String siteId);
}
