package ${packageName}.${moduleName}.web${subModuleName};

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cn.ant.common.config.Global;
import com.cn.ant.common.persistence.Page;
import com.cn.ant.common.web.BaseController;
import com.cn.ant.modules.sys.entity.User;
import com.cn.ant.modules.sys.utils.UserUtils;
import com.cn.ant.common.utils.Identities;
import com.cn.ant.common.utils.StringUtils;
import ${packageName}.${moduleName}.entity${subModuleName}.${ClassName};
import ${packageName}.${moduleName}.service${subModuleName}.${ClassName}Service;

/**
 * ${functionName}Controller
 * @author ${classAuthor}
 * @version ${classVersion}
 */
@Controller
@RequestMapping(value = "${r"${adminPath}"}/${urlPrefix}")
public class ${ClassName}Controller extends BaseController {

	@Autowired
	private ${ClassName}Service ${className}Service;
	
	@ModelAttribute
	public ${ClassName} get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return ${className}Service.get(id);
		}else{
			return new ${ClassName}();
		}
	}
	
	@RequiresPermissions("${permissionPrefix}:view")
	@RequestMapping(value = {"list", ""})
	public String list(${ClassName} ${className}, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		if (!user.isAdmin()){
			${className}.setCreateBy(user);
		}
        Page<${ClassName}> page = ${className}Service.find(WebUtils.initPage(request, response), ${className});
        model.addAttribute("page", page);
		return "${viewPrefix}List";
	}

	@RequiresPermissions("${permissionPrefix}:view")
	@RequestMapping(value = "form")
	public String form(${ClassName} ${className}, Model model) {
		model.addAttribute("${className}", ${className});
		return "${viewPrefix}Form";
	}

	@RequiresPermissions("${permissionPrefix}:edit")
	@RequestMapping(value = "save")
	@ResponseBody
	public Map<String, Object> save(${ClassName} ${className}, Model model, RedirectAttributes redirectAttributes) {
		try {
			if (!beanValidator(model, ${className})) {
				result = ERROR;
				msg = "数据校验失败,请重试!";
			} else {
				if (StringUtils.isBlank(logisticsTemplate.getId())) {
					${className}.setId(Identities.generateUUID());
					${className}Service.save(${className});
				} else {
					${className}Service.update(${className});
				}
			}
			msg = "保存${functionName}'" + ${className}.getName() + "'成功";
		} catch (Exception e) {
			e.printStackTrace();
			result = ERROR;
			msg = "操作失败,请联系管理员";
		}
		retMap.put("result", result);
		retMap.put("msg", msg);
		return retMap;
	}
	
	@RequiresPermissions("${permissionPrefix}:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		${className}Service.delete(id);
		addMessage(redirectAttributes, "删除${functionName}成功");
		return "redirect:"+Global.getAdminPath()+"/${viewPrefix}/?repage";
	}

}
