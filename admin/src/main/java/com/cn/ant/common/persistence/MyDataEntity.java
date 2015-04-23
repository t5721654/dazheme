/**
 * Copyright &copy; 2012-2013 <a
 * href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.cn.ant.common.persistence;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.MappedSuperclass;

import com.cn.ant.modules.sys.utils.UserUtils;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 数据Entity类
 * 
 * @author 黄根华
 * @version 2013-08-05
 */
@MappedSuperclass
public abstract class MyDataEntity extends BaseEntity implements Serializable
{

   private static final long serialVersionUID = 1L;
	protected String remarks; // 备注
	protected String createBy; // 创建者
	protected Date createDate;// 创建日期
	protected String updateBy; // 更新者
	protected Date updateDate;// 更新日期
	protected String delFlag; // 删除标记（0：正常；1：删除；2：审核）

   public MyDataEntity()
   {
      super();
      this.delFlag = DEL_FLAG_NORMAL;
   }

   public void prePersist()
   {
      if (this.createBy != null)
      {
         this.updateBy = UserUtils.getUser().getId();
         this.updateDate = new Date();
         return;
      }
      this.updateBy = UserUtils.getUser().getId();
      this.updateDate = new Date();
      this.createBy = this.updateBy;
      this.createDate = this.updateDate;
   }

   public void preUpdate()
   {
      this.updateBy = UserUtils.getUser().getId();
      this.updateDate = new Date();
   }

   public String getRemarks()
   {
      return remarks;
   }

   public void setRemarks(String remarks)
   {
      this.remarks = remarks;
   }

   public String getCreateBy()
   {
      return createBy;
   }

   public void setCreateBy(String createBy)
   {
      this.createBy = createBy;
   }

   @JsonFormat(timezone = "GMT+8:00", pattern = "yyyy-MM-dd HH:mm:ss")
   public Date getCreateDate()
   {
      return createDate;
   }

   public void setCreateDate(Date createDate)
   {
      this.createDate = createDate;
   }

   public String getUpdateBy()
   {
      return updateBy;
   }

   public void setUpdateBy(String updateBy)
   {
      this.updateBy = updateBy;
   }

   @JsonFormat(timezone = "GMT+8:00", pattern = "yyyy-MM-dd HH:mm:ss")
   public Date getUpdateDate()
   {
      return updateDate;
   }

   public void setUpdateDate(Date updateDate)
   {
      this.updateDate = updateDate;
   }

   public String getDelFlag()
   {
      return delFlag;
   }

   public void setDelFlag(String delFlag)
   {
      this.delFlag = delFlag;
   }

}
