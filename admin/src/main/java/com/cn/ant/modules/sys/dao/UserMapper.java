package com.cn.ant.modules.sys.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cn.ant.common.persistence.MyBatisRepository;
import com.cn.ant.modules.sys.entity.User;
@MyBatisRepository
public interface UserMapper {
	public int delete(String id);
	public int insert(User record);
	public User get(String id);
	public int update(User record);
	public User findByLoginName(@Param(value="loginName") String loginName);
	public int updatePasswordById(Map<String,String> params);
	public int updateLoginInfo(Map<String,Object> params);
	public List<User> find(Map<String, Object> params);
	public int count(Map<String, Object> params);
}