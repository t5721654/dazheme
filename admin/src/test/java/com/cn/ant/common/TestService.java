package com.cn.ant.common;

import com.cn.ant.modules.sys.dao.UserMapper;
import com.cn.ant.modules.sys.entity.User;
import com.cn.ant.modules.sys.service.SystemService;
import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class TestService extends SpringTransactionalContextTests {
    static Logger logger = Logger.getLogger(TestService.class);
    @Autowired
    private UserMapper userMapper;



    public void testUser() {
        User user = userMapper.findByLoginName("superadmin");
    }

    @Test
    public void test(){
        for (int i = 0; i < 10; i++) {
            System.out.println(SystemService.entryptPassword("admin"));
        }

    }


}
