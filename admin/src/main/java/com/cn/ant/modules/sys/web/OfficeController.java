/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.cn.ant.modules.sys.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cn.ant.common.config.Global;
import com.cn.ant.common.utils.Identities;
import com.cn.ant.common.web.BaseController;
import com.cn.ant.modules.sys.entity.Office;
import com.cn.ant.modules.sys.entity.User;
import com.cn.ant.modules.sys.service.OfficeService;
import com.cn.ant.modules.sys.utils.UserUtils;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 机构Controller
 * 
 * @author ThinkGem
 * @version 2013-5-15
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/office")
public class OfficeController extends BaseController {

	@Autowired
	private OfficeService officeService;
	
	@ModelAttribute("office")
	public Office get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return officeService.get(id);
		}else{
			return new Office();
		}
	}

	@RequiresPermissions("sys:office:view")
	@RequestMapping(value = {"list", ""})
	public String list(Office office, Model model) {
		office.setId("1");
		model.addAttribute("office", office);
		List<Office> list = Lists.newArrayList();
		List<Office> sourcelist = officeService.findAll();
		Office.sortList(list, sourcelist, office.getId());
        model.addAttribute("list", list);
		return "modules/sys/officeList";
	}

	@RequiresPermissions("sys:office:view")
	@RequestMapping(value = "form")
	public String form(Office office, Model model) {
		User user = UserUtils.getUser();
		if (office.getParent()==null || office.getParent().getId()==null){
			office.setParent(user.getOffice());
		}
		office.setParent(officeService.get(office.getParent().getId()));
		if (office.getArea()==null){
			office.setArea(user.getOffice().getArea());
		}
		model.addAttribute("office", office);
		return "modules/sys/officeForm";
	}
	
	@RequiresPermissions("sys:office:edit")
	@RequestMapping(value = "save")
	@ResponseBody
	public Map<String, String> save(Office office, Model model, RedirectAttributes redirectAttributes) {
		Map<String, String> retMap = new HashMap<String, String>();
		String result = "success";
		String msg = "操作成功";
		try {
			if (Global.isDemoMode()) {
				result = "error";
				msg = "演示模式，不允许操作！";
			}
			if (!beanValidator(model, office)) {
				result = "error";
				msg = "数据校验失败,请重试!";
			}
			if (StringUtils.isNotBlank(office.getId())) {
				office.preUpdate();
				officeService.update(office);
			} else {
				office.setId(Identities.generateUUID());
				office.prePersist();
				officeService.save(office);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = "error";
			msg = "操作失败,请联系管理员";
		} finally {
			retMap.put("result", result);
			retMap.put("msg", msg);
		}
		return retMap;
	}
	
	@RequiresPermissions("sys:office:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:"+Global.getAdminPath()+"/sys/office/";
		}
		if (Office.isRoot(id)){
			addMessage(redirectAttributes, "删除机构失败, 不允许删除顶级机构或编号空");
		}else{
			officeService.delete(id);
			addMessage(redirectAttributes, "删除机构成功");
		}
		return "redirect:"+Global.getAdminPath()+"/sys/office/";
	}

	@RequiresUser
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) Long extId, @RequestParam(required=false) Long type,
			@RequestParam(required=false) Long grade, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
//		User user = UserUtils.getUser();
		List<Office> list = officeService.findAll();
		for (int i=0; i<list.size(); i++){
			Office e = list.get(i);
			if ((extId == null || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1))
					&& (type == null || (type != null && Integer.parseInt(e.getType()) <= type.intValue()))
					&& (grade == null || (grade != null && Integer.parseInt(e.getGrade()) <= grade.intValue()))){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
//				map.put("pId", !user.isAdmin() && e.getId().equals(user.getOffice().getId())?0:e.getParent()!=null?e.getParent().getId():0);
				map.put("pId", e.getParent()!=null?e.getParent().getId():0);
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
}
