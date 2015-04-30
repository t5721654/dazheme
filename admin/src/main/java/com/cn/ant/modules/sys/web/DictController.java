/**
 * Copyright &copy; 2012-2013 <a
 * href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.cn.ant.modules.sys.web;

import com.cn.ant.common.config.Global;
import com.cn.ant.common.persistence.Page;
import com.cn.ant.common.utils.Identities;
import com.cn.ant.common.utils.WebUtils;
import com.cn.ant.common.web.BaseController;
import com.cn.ant.modules.sys.entity.Dict;
import com.cn.ant.modules.sys.service.DictService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 字典Controller
 * 
 * @author ThinkGem
 * @version 2013-3-23
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/dict")
public class DictController extends BaseController {

	@Autowired
	private DictService dictService;

	@ModelAttribute
	public Dict get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return dictService.get(id);
		} else {
			return new Dict();
		}
	}

	@RequiresPermissions("sys:dict:view")
	@RequestMapping(value = { "list", "" })
	public String list(Dict dict, HttpServletRequest request,
			HttpServletResponse response, Model model) {
        List<Dict> dictList = dictService.findDescAndType();
        model.addAttribute("dictList", dictList);
		return "modules/sys/dictList";
	}

	/**
	 * 查询字典条目
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("sys:dict:view")
    @RequestMapping(value = "itemlist")
    public String itemList(HttpServletRequest request, HttpServletResponse response, Model model) {
        Dict dict = new Dict();
        String type = request.getParameter("type");
        dict.setType(type);
        Page<Dict> page = dictService.find(WebUtils.initPage(request, response), dict);
        model.addAttribute("page", page);
        return "modules/sys/dictItemList";
    }

	@RequiresPermissions("sys:dict:view")
	@RequestMapping(value = "form")
	public String form(Dict dict, Model model) {
		model.addAttribute("dict", dict);
		return "modules/sys/dictForm";
	}

	@RequiresPermissions("sys:dict:edit")
	@RequestMapping(value = "save")
	// @Valid
	public String save(Dict dict, Model model,
			RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, dict)) {
			return form(dict, model);
		}
		if (StringUtils.isBlank(dict.getId())) {
			dict.setId(Identities.generateUUID());
			dictService.save(dict);
		} else {
			dictService.update(dict);
		}
		addMessage(redirectAttributes, "保存字典'" + dict.getLabel() + "'成功");
        return "redirect:" + Global.getAdminPath() + "/sys/dict/itemlist?repage&type="
				+ dict.getType();
	}

	@RequiresPermissions("sys:dict:edit")
	@RequestMapping(value = "delete")
    public String delete(Dict dict,String id, RedirectAttributes redirectAttributes) {
        String type = dict.getType();
		dictService.delete(id);
		addMessage(redirectAttributes, "删除字典成功");
        return "redirect:" + Global.getAdminPath() + "/sys/dict/itemlist?repage&type=" + type;
	}

}
