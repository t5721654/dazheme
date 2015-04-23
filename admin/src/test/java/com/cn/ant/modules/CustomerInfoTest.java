package com.cn.ant.modules;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by AntDream on 2014/11/5.
 */
public class CustomerInfoTest extends BaseTest {

    public void testSave() {
        String url = "http://localhost:8080/iguor/app/customer/customerInfo/save";
        Map<String, String> params = new HashMap<String, String>();
        params.put("userid", "18c0184756fe42cdb2a61edb5976d2d1");
        params.put("sex", "M");
        params.put("birthday", "2014-10-12");
        params.put("age", "23");
        params.put("email", "123@126.com");
        String result = post(url, params);
        System.out.println(result);
    }

    public void testMobile() {
        String url = "http://localhost:8080/iguor/app/customer/customerInfo/mobileExists";
        Map<String, String> params = new HashMap<String, String>();
        params.put("mobile", "18664530870");
        String result = get(url, params);
        System.out.println(result);
    }

    public void testLoginName() {
        String url = "http://localhost:8080/iguor/app/customer/customerInfo/loginNameExists";
        Map<String, String> params = new HashMap<String, String>();
        params.put("loginName", "zhangsan");
        String result = get(url, params);
        System.out.println(result);
    }

    public void testUpdateMobile(){
        String url = "http://localhost:8080/iguor/app/customer/customerInfo/updateMobile";
        Map<String, String> params = new HashMap<String, String>();
        params.put("userId", "18c0184756fe42cdb2a61edb5976d2d1");
        params.put("loginName", "zhangsan");
        params.put("mobile", "1569898655");
        String result = post(url, params);
        System.out.println(result);
    }

    public void testUpdatePassword(){
        String url = "http://localhost:8080/iguor/app/customer/customerInfo/updatePassword";
        Map<String, String> params = new HashMap<String, String>();
        params.put("userId", "18c0184756fe42cdb2a61edb5976d2d1");
        params.put("loginName", "zhangsan");
        params.put("oldPassWord", "zhangsan");
        params.put("newPassWord", "123456");
        String result = post(url, params);
        System.out.println(result);
    }

    public void testLogin(){
        String url = "http://localhost:8080/iguor/app/customer/customerInfo/login";
        Map<String, String> params = new HashMap<String, String>();
        params.put("loginName", "zhangsan");
        params.put("password", "12dfg3456");
        String result = post(url, params);
        System.out.println(result);

    }
}
