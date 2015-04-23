package com.cn.ant.modules.sys.entity;

import java.util.List;

import com.cn.ant.common.persistence.MyDataEntity;
import com.google.common.collect.Lists;

/**
 * 区域Entity sys_area
 * 
 * @author 黄根华
 * @version 2013-05-15
 */
public class Area extends MyDataEntity {

	private static final long serialVersionUID = 1L;
	private String id; // 编号
	private Area parent; // 父级编号
	private String parentIds; // 所有父级编号
	private String code; // 区域编码
	private String name; // 区域名称
	private String type; // 区域类型（1：国家；2：省份、直辖市；3：地市；4：区县）
	
	private List<Office> officeList = Lists.newArrayList(); // 部门列表
	private List<Area> childList = Lists.newArrayList(); // 拥有子区域列表

	private String parentId;// 父类
	public Area(){
		super();
	}
	
	public Area(String id) {
		this();
		this.id = id;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public Area getParent() {
		return parent;
	}

	public void setParent(Area parent) {
		this.parent = parent;
	}

	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public List<Office> getOfficeList() {
		return officeList;
	}

	public void setOfficeList(List<Office> officeList) {
		this.officeList = officeList;
	}

	public List<Area> getChildList() {
		return childList;
	}

	public void setChildList(List<Area> childList) {
		this.childList = childList;
	}

	public static void sortList(List<Area> list, List<Area> sourcelist, String parentId){
		for (int i=0; i<sourcelist.size(); i++){
			Area e = sourcelist.get(i);
			if (e.getParent()!=null && e.getParent().getId()!=null
					&& e.getParent().getId().equals(parentId)){
				list.add(e);
				// 判断是否还有子节点, 有则继续获取子节点
				for (int j = 0; j < sourcelist.size(); j++) {
					Area childe = sourcelist.get(j);
					if (childe.getParent()!=null && childe.getParent().getId()!=null
							&& childe.getParent().getId().equals(e.getId())){
						sortList(list, sourcelist, e.getId());
						break;
					}
				}
			}
		}
	}

	public boolean isAdmin(){
		return isAdmin(this.id);
	}
	
	public static boolean isAdmin(String id) {
		return id != null && id.equals("1");
	}

	public String getParentId() {
        return parentId;
    }

	public void setParentId(String parentId) {
        this.parentId = parentId;
    }

}