package com.cn.ant.modules.map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cn.ant.common.web.BaseController;

@Controller
@RequestMapping(value = "map")
public class MapController extends BaseController {

	@RequestMapping(value = "simple")
	public String simple(HttpServletRequest request,Model model){
		return "modules/maps/map";
	}
}
