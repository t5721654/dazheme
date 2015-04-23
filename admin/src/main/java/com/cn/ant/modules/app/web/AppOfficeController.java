/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.cn.ant.modules.app.web;

import com.cn.ant.common.web.BaseController;
import com.cn.ant.modules.sys.entity.User;
import com.cn.ant.modules.sys.service.OfficeService;
import com.cn.ant.modules.sys.service.SystemService;
import com.cn.ant.modules.sys.web.OfficeController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * 机构Controller
 *
 * @author ThinkGem
 * @version 2013-5-15
 */
@Controller
@RequestMapping(value = "${appPath}/office")
public class AppOfficeController extends BaseController {
    private Logger logger = LoggerFactory.getLogger(OfficeController.class);
    @Autowired
    private OfficeService officeService;
    @Autowired
    private SystemService systemService;

    /**
     * 商户用户注册
     *
     * @param loginName
     * @param mobile
     * @param password
     * @return
     */
    @RequestMapping(value = "register")
    @ResponseBody
    public Map<String, Object> register(String loginName, String mobile, String password) {
        try {
            User user = new User();
            user.setLoginName(loginName);
            user.setPassword(SystemService.entryptPassword(password));
            systemService.saveUser(user);
        } catch (Exception e) {
            logger.error("商户用户");
            e.printStackTrace();
        }
        retMap.put("result", result);
        return retMap;
    }

    @RequestMapping(value = "test", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> test(HttpServletRequest request) {
        String userName = request.getParameter("name");
        retMap.put("result", result);
        return retMap;
    }

}
