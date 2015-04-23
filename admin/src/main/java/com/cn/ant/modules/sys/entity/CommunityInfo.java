package com.cn.ant.modules.sys.entity;

import com.cn.ant.common.persistence.MyDataEntity;

public class CommunityInfo extends MyDataEntity {

	private static final long serialVersionUID = 1L;
	private String id;
	private String code;//小区编号
	private String name;//小区名称
	private String prov;//省份
	private String city;//城市
	private String area;//区县
	private String address;//地址
	private String x;//坐标
	private String y;
	private Double square;//面积

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id == null ? null : id.trim();
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code == null ? null : code.trim();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null ? null : name.trim();
	}

	public String getProv() {
		return prov;
	}

	public void setProv(String prov) {
		this.prov = prov == null ? null : prov.trim();
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city == null ? null : city.trim();
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area == null ? null : area.trim();
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address == null ? null : address.trim();
	}

	public String getX() {
		return x;
	}

	public void setX(String x) {
		this.x = x == null ? null : x.trim();
	}

	public String getY() {
		return y;
	}

	public void setY(String y) {
		this.y = y == null ? null : y.trim();
	}

	public Double getSquare() {
		return square;
	}

	public void setSquare(Double square) {
		this.square = square;
	}
}