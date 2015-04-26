package com.cn.ant;

import com.cn.ant.redis.dao.IUserDao;
import com.cn.ant.redis.entity.User;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by huanggenhua on 2015/4/25.
 */
@ContextConfiguration(locations = {"classpath*:applicationContext.xml"})
public class RedisTest extends AbstractJUnit4SpringContextTests {
    @Autowired
    private IUserDao userDao;
    @Test
    public void testAddUser() {
        User user = new User();
        user.setId("user1");
        user.setName("java2000_wl");
        boolean result = userDao.add(user);
    }

    /**
     * 批量新增 普通方式,效率低
     */
    @Test
    public void testAddUsers1() {
        List<User> list = new ArrayList<User>();
        for (int i = 10; i < 50000; i++) {
            User user = new User();
            user.setId("user" + i);
            user.setName("java2000_wl" + i);
            list.add(user);
        }
        long begin = System.currentTimeMillis();
        for (User user : list) {
            userDao.add(user);
        }
        System.out.println(System.currentTimeMillis() - begin);
    }

    /**
     * 批量新增 pipeline方式,效率高
     */
    @Test
    public void testAddUsers2() {
        List<User> list = new ArrayList<User>();
        for (int i = 10; i < 50000; i++) {
            User user = new User();
            user.setId("user" + i);
            user.setName("java2000_wl" + i);
            list.add(user);
        }
        long begin = System.currentTimeMillis();
        boolean result = userDao.add(list);
        System.out.println(System.currentTimeMillis() - begin);
    }

    /**
     * 修改
     */
    @Test
    public void testUpdate() {
        User user = new User();
        user.setId("user1");
        user.setName("new_password");
        boolean result = userDao.update(user);
        System.out.println(result);
    }

    @Test
    public void testAddList(){
        List<User> list = new ArrayList<User>();
        for (int i = 10; i < 500; i++) {
            User user = new User();
            user.setId("user" + i);
            user.setName("java2000_wl" + i);
            list.add(user);
        }
        long begin = System.currentTimeMillis();
        boolean result = userDao.add("userList", list);
        System.out.println(System.currentTimeMillis() - begin);
    }

    @Test
    public void testGetList() {
        List<User> userList = userDao.getByKey("userList");
        System.out.println(userList.size());
    }

}
