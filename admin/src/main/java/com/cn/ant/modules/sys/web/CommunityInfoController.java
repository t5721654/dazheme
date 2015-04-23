package com.cn.ant.modules.sys.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cn.ant.common.config.Global;
import com.cn.ant.common.persistence.Page;
import com.cn.ant.common.utils.Identities;
import com.cn.ant.common.utils.StringUtils;
import com.cn.ant.common.web.BaseController;
import com.cn.ant.modules.sys.entity.CommunityInfo;
import com.cn.ant.modules.sys.entity.Office;
import com.cn.ant.modules.sys.entity.User;
import com.cn.ant.modules.sys.service.CommunityInfoService;
import com.cn.ant.modules.sys.service.OfficeService;
import com.cn.ant.modules.sys.utils.UserUtils;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 小区表Controller
 * 
 * @author 黄根华
 * @version 2013-08-16
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/communityInfo")
public class CommunityInfoController extends BaseController {

	@Autowired
	private CommunityInfoService communityInfoService;
	@Autowired
	private OfficeService officeService;

	@ModelAttribute
	public CommunityInfo get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return communityInfoService.get(id);
		} else {
			return new CommunityInfo();
		}
	}

	@RequiresPermissions("sys:communityInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(CommunityInfo communityInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		communityInfo.setCreateBy(user.getId());
		Map<String, Object> params = new HashMap<String, Object>();
		Page<CommunityInfo> page = communityInfoService.find(new Page<CommunityInfo>(request, response), params);
		model.addAttribute("page", page);
		return "modules/sys/communityInfoList";
	}

	@RequiresPermissions("sys:communityInfo:view")
	@RequestMapping(value = "form")
	public String form(CommunityInfo communityInfo, Model model) {
		model.addAttribute("communityInfo", communityInfo);
		return "modules/sys/communityInfoForm";
	}

	@RequiresPermissions("sys:communityInfo:edit")
	@RequestMapping(value = "save")
	@ResponseBody
	public Map<String, String> save(CommunityInfo communityInfo, Model model, RedirectAttributes redirectAttributes) {
		Map<String, String> retMap = new HashMap<String, String>();
		String result = "success";
		String msg = "保存小区" + communityInfo.getName() + "'成功";
		try {
			if (StringUtils.isBlank(communityInfo.getId())) {
				communityInfo.setId(Identities.generateUUID());
				communityInfo.prePersist();
				communityInfoService.save(communityInfo);
			} else {
				communityInfo.preUpdate();
				communityInfoService.update(communityInfo);
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

	@RequiresPermissions("sys:communityInfo:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		communityInfoService.delete(id);
		addMessage(redirectAttributes, "删除小区表成功");
		return "redirect:" + Global.getAdminPath() + "/sys/communityInfo/?repage";
	}

	/**
	 * 获取小区树
	 * 
	 * @param extId
	 * @param parentId
	 * @param response
	 * @param request
	 * @return
	 */
	@RequiresUser
	@ResponseBody
	@RequestMapping(value = "treeData", method = RequestMethod.GET)
	public List<Map<String, Object>> treeData(@RequestParam(required = false) String extId, @RequestParam(required = false) String parentId,
			HttpServletResponse response, HttpServletRequest request) {
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<CommunityInfo> resultLst = communityInfoService.findBySiteId(parentId);
		if (resultLst != null && resultLst.size() > 0) {
			CommunityInfo temp = null;
			for (int i = 0; i < resultLst.size(); i++) {
				temp = resultLst.get(i);
				Map<String, Object> tempMap = Maps.newHashMap();
				tempMap.put("id", temp.getId());
				tempMap.put("pId", parentId);
				tempMap.put("name", temp.getName());
				mapList.add(tempMap);
			}
			// 加入服务站的信息
			Office serverSite = officeService.get(parentId);
			if (serverSite != null) {
				Map<String, Object> tempMap = Maps.newHashMap();
				tempMap.put("id", parentId);
				tempMap.put("pid", 0);
				tempMap.put("name", serverSite.getName());
				mapList.add(tempMap);
			}
		}
		return mapList;
	}

}
