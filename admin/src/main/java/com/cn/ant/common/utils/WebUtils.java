package com.cn.ant.common.utils;

import com.cn.ant.common.config.Global;
import com.cn.ant.common.persistence.Page;
import com.cn.ant.common.persistence.PageEntity;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by huanggenhua on 2015/4/26.
 */
public class WebUtils {

    private static int defaultPageNo = 1; // 当前页码
    private static int defaultPageSize = Integer.valueOf(Global.getConfig("page.pageSize")); // 页面大小，设置为“-1”表示不进行分页（分页无效）;
    /**
     * 构建PageEntity对象
     *
     * @param request
     * @param response
     * @return
     */
    public static PageEntity getPageEntity(HttpServletRequest request, HttpServletResponse response) {
        return getPageEntity(request, response, -2);
    }

    /**
     * 构造方法
     *
     * @param request
     *            传递 repage 参数，来记住页码
     * @param response
     *            用于设置 Cookie，记住页码
     * @param pageSize
     *            分页大小，如果传递 -1 则为不分页，返回所有数据
     */
    public static PageEntity getPageEntity(HttpServletRequest request, HttpServletResponse response, int pageSize) {
        PageEntity pageEntity = new PageEntity();
        pageEntity.setPageNo(defaultPageNo);//默认当前页码
        pageEntity.setPageSize(defaultPageSize);//默认当前页面大小
        // 设置页码参数（传递repage参数，来记住页码）
        String no = request.getParameter("pageNo");
        if (StringUtils.isNumeric(no)) {
            CookieUtils.setCookie(response, "pageNo", no);
            pageEntity.setPageNo(Integer.parseInt(no));
        } else if (request.getParameter("repage") != null) {
            no = CookieUtils.getCookie(request, "pageNo");
            if (StringUtils.isNumeric(no)) {
                pageEntity.setPageNo(Integer.parseInt(no));
            }
        }
        // 设置页面大小参数（传递repage参数，来记住页码大小）
        String size = request.getParameter("pageSize");
        if (StringUtils.isNumeric(size)) {
            CookieUtils.setCookie(response, "pageSize", size);
            pageEntity.setPageSize(Integer.parseInt(size));
        } else if (request.getParameter("repage") != null) {
            no = CookieUtils.getCookie(request, "pageSize");
            if (StringUtils.isNumeric(size)) {
                pageEntity.setPageSize(Integer.parseInt(size));
            }
        }
        if (pageSize != -2) {
            pageEntity.setPageSize(pageSize);
        }
        // 设置排序参数
        String orderBy = request.getParameter("orderBy");
        if (org.apache.commons.lang3.StringUtils.isNotBlank(orderBy)) {
            pageEntity.setOrderColumn(orderBy);
        }
        return pageEntity;
    }

    /**
     * 构建分页对象
     * @param request
     * @param response
     * @return
     */
    public static Page initPage(HttpServletRequest request, HttpServletResponse response) {
        Page page = new Page(getPageEntity(request, response));
        return page;
    }

    /**
     * 构建分页对象
     * @param request
     * @param response
     * @param pageSize
     *          分页大小，如果传递 -1 则为不分页，返回所有数据
     * @return
     */
    public static Page initPage(HttpServletRequest request, HttpServletResponse response, int pageSize) {
        Page page = new Page(getPageEntity(request, response,pageSize));
        return page;
    }

}
