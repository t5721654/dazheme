package com.cn.ant.modules.sys.entity;

import java.util.List;

import com.cn.ant.common.persistence.MyDataEntity;
import com.google.common.collect.Lists;

/**
 * 机构Entity sys_office
 * 
 * @author ThinkGem
 * @version 2013-05-15
 */
public class Office extends MyDataEntity {

	private static final long serialVersionUID = 1L;
	private String id; // 编号
	private Office parent; // 父级编号
	private String parentIds; // 所有父级编号
	private Area area; // 归属区域
	private String code; // 机构编码
	private String name; // 机构名称
	private String type; // 机构类型（1：公司；2：部门；3：小组）
	private String grade; // 机构等级（1：一级；2：二级；3：三级；4：四级）
	private String address; // 联系地址
	private String zipCode; // 邮政编码
	private String master; // 负责人
	private String phone; // 电话
	private String fax; // 传真
	private String email; // 邮箱
	private String logo;//logo
	private String status;// 机构状态
	private String validDate;// 有效日期
	private String authNum;
	private double lng;// 经度
	private double lat;// 纬度
	
	private List<User> userList = Lists.newArrayList(); // 拥有用户列表
	private List<Office> childList = Lists.newArrayList();// 拥有子机构列表

	public Office(){
		super();
	}
	
	public Office(String id) {
		this();
		this.id = id;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public Office getParent() {
		return parent;
	}

	public void setParent(Office parent) {
		this.parent = parent;
	}

	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}

	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
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

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getMaster() {
		return master;
	}

	public void setMaster(String master) {
		this.master = master;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	public List<User> getUserList() {
		return userList;
	}

	public void setUserList(List<User> userList) {
		this.userList = userList;
	}

	public List<Office> getChildList() {
		return childList;
	}

	public void setChildList(List<Office> childList) {
		this.childList = childList;
	}

	public static void sortList(List<Office> list, List<Office> sourcelist,
			String parentId) {
		for (int i=0; i<sourcelist.size(); i++){
			Office e = sourcelist.get(i);
			if (e.getParent()!=null && e.getParent().getId()!=null
					&& e.getParent().getId().equals(parentId)){
				list.add(e);
				// 判断是否还有子节点, 有则继续获取子节点
				for (int j = 0; j < sourcelist.size(); j++) {
					Office child = sourcelist.get(j);
					if (child.getParent()!=null && child.getParent().getId()!=null
							&& child.getParent().getId().equals(e.getId())){
						sortList(list, sourcelist, e.getId());
						break;
					}
				}
			}
		}
	}

	public boolean isRoot(){
		return isRoot(this.id);
	}
	
	public static boolean isRoot(String id) {
		return id != null && id.equals(1L);
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getValidDate() {
		return validDate;
	}

	public void setValidDate(String validDate) {
		this.validDate = validDate;
	}

	public String getAuthNum() {
		return authNum;
	}

	public void setAuthNum(String authNum) {
		this.authNum = authNum;
	}

	public double getLng() {
		return lng;
	}

	public void setLng(double lng) {
		this.lng = lng;
	}

	public double getLat() {
		return lat;
	}

	public void setLat(double lat) {
		this.lat = lat;
	}

}