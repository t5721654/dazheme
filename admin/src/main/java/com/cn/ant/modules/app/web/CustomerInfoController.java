package com.cn.ant.modules.app.web;


import com.cn.ant.common.mapper.JsonMapper;
import com.cn.ant.common.utils.Identities;
import com.cn.ant.common.utils.StringUtils;
import com.cn.ant.common.web.BaseController;
import com.cn.ant.modules.customer.entity.CustomerInfo;
import com.cn.ant.modules.customer.service.CustomerInfoService;
import com.cn.ant.modules.sys.service.SystemService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * 会员信息Controller
 *
 * @author AntDream
 * @version 2014-11-03
 */
@Controller
@RequestMapping(value = "${appPath}/customer/customerInfo")
public class CustomerInfoController extends BaseController {
    private Logger logger = LoggerFactory.getLogger(CustomerInfoController.class);

    @Autowired
    private CustomerInfoService customerInfoService;

    /**
     * 用户注册
     *
     * @param customerInfo
     * @return
     */
    @RequestMapping(value = "save")
    @ResponseBody
    public Map<String, String> save(CustomerInfo customerInfo) {
        Map<String, String> retMap = new HashMap<String, String>();
        try {
            if (StringUtils.isBlank(customerInfo.getUserId())) {
                customerInfo.setUserId(Identities.generateUUID());
                customerInfo.setPassword(SystemService.entryptPassword(customerInfo.getPassword()));
                customerInfoService.save(customerInfo);
            } else {
                customerInfoService.update(customerInfo);
            }
            result = SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            result = ERROR;
        }
        retMap.put("result", result);
        return retMap;
    }

    /**
     * 判断手机号是否已经注册
     *
     * @param mobile
     * @return
     */
    @RequestMapping(value = "mobileExists")
    @ResponseBody
    public Map<String, String> mobileExists(String mobile) {
        Map<String, String> retMap = new HashMap<String, String>();
        try {
            CustomerInfo customer = customerInfoService.findByMobile(mobile);
            if (customer != null) {
                result = RS_0001;
            }
        } catch (Exception e) {
            result = ERROR;
            logger.error("判断" + mobile + "是否重复失败,失败原因为:" + e.getMessage());
            e.printStackTrace();
        }
        retMap.put("result", result);
        return retMap;
    }

    /**
     * 判断用户名是否已经注册
     *
     * @param loginName
     * @return
     */
    @RequestMapping(value = "loginNameExists")
    @ResponseBody
    public Map<String, String> loginNameExists(String loginName) {
        Map<String, String> retMap = new HashMap<String, String>();
        try {
            CustomerInfo customer = customerInfoService.findByLoginName(loginName);
            if (customer != null) {
                result = RS_0002;
            }
        } catch (Exception e) {
            result = ERROR;
            logger.error("判断" + loginName + "是否重复失败,失败原因为:" + e.getMessage());
            e.printStackTrace();
        }
        retMap.put("result", result);
        return retMap;
    }

    /**
     * 修改用户手机号
     *
     * @param userId
     * @param loginName
     * @param mobile
     * @return
     */
    @RequestMapping(value = "updateMobile")
    @ResponseBody
    public Map<String, String> updateMobile(String userId, String loginName, String mobile) {
        Map<String, String> retMap = new HashMap<String, String>();
        try {
            customerInfoService.updateMobile(userId, loginName, mobile);
        } catch (Exception e) {
            result = ERROR;
            logger.error("修改手机号码异常,失败原因为:" + e.getMessage());
            e.printStackTrace();
        }
        retMap.put("result", result);
        return retMap;
    }

    /**
     * 更改用户密码
     *
     * @param userId
     * @param loginName
     * @param oldPassWord
     * @param newPassWord
     * @return
     */
    @RequestMapping(value = "updatePassword")
    @ResponseBody
    public Map<String, String> updatePassword(String userId, String loginName, String oldPassWord, String newPassWord) {
        Map<String, String> retMap = new HashMap<String, String>();
        try {
            //判断原密码是否正确
            CustomerInfo customerInfo = customerInfoService.get(userId);
            if (customerInfo != null) {
                if (SystemService.validatePassword(oldPassWord, customerInfo.getPassword())) {
                    //原密码正确
                    newPassWord = SystemService.entryptPassword(newPassWord);
                    customerInfoService.updatePassword(userId, loginName, newPassWord);
                } else {
                    result = RS_0003;
                }
            }

        } catch (Exception e) {
            logger.error("用户" + loginName + "修改密码异常,异常原因:" + e.getMessage());
            result = ERROR;
            e.printStackTrace();
        }
        retMap.put("result", result);
        return retMap;
    }

    /**
     * 用户登录
     *
     * @param loginName
     * @param password
     * @return
     */
    @RequestMapping(value = "login")
    @ResponseBody
    public Map<String, Object> login(String loginName, String password) {
        Map<String, Object> retMap = new HashMap<String, Object>();
        try {
            CustomerInfo customerInfo = customerInfoService.findByLoginName(loginName);
            if (customerInfo != null) {
                if (SystemService.validatePassword(password, customerInfo.getPassword())) {
                    String data = JsonMapper.getInstance().toJson(customerInfo);
                    retMap.put("data", data);
                } else {
                    result = RS_0004;
                }
            } else {
                result = RS_0004;
            }
        } catch (Exception e) {
            logger.error("用户" + loginName + "登录异常,异常原因:" + e.getMessage());
            result = ERROR;
            e.printStackTrace();
        }
        retMap.put("result", result);
        return retMap;
    }

}
