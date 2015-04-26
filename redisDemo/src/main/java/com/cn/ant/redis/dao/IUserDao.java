package com.cn.ant.redis.dao;

import com.cn.ant.redis.entity.User;
import java.util.List;
/**
 * Created by huanggenhua on 2015/4/25.
 */
public interface IUserDao {

    /**
     * 新增
     * <br>------------------------------<br>
     * @param user
     * @return
     */
    boolean add(User user);

    /**
     * 批量新增 使用pipeline方式
     * <br>------------------------------<br>
     * @param list
     * @return
     */
    boolean add(List<User> list);

    boolean add(String key, List<User> list);

    /**
     * 删除
     * <br>------------------------------<br>
     * @param key
     */
    void delete(String key);

    /**
     * 删除多个
     * <br>------------------------------<br>
     * @param keys
     */
    void delete(List<String> keys);

    /**
     * 修改
     * <br>------------------------------<br>
     * @param user
     * @return
     */
    boolean update(User user);

    /**
     * 通过key获取
     * <br>------------------------------<br>
     * @param keyId
     * @return
     */
    User get(String keyId);

    List<User> getByKey(String keyId);
}
