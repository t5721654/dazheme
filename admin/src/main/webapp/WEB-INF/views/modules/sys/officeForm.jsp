<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div class="portlet box dark">
		<div class="portlet-title">
			<div class="caption">商户基本信息</div>
		</div>
		<div class="portlet-body">
			<form:form id="inputForm" modelAttribute="office" action="" method="post" class="form-horizontal">
				<form:hidden path="id"/>
				<tags:message content="${message}"/>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span6">
							<label class="control-label">上级机构:</label>
							<div class="controls">
				                <tags:treeselect id="office" name="parent.id" value="${office.parent.id}" labelName="parent.name" labelValue="${office.parent.name}"
									title="机构" url="/sys/office/treeData" extId="${office.id}" cssClass="required"/>
							</div>
						</div>
						<div class="span6">
							<label class="control-label">归属区域:</label>
							<div class="controls">
				                <tags:treeselect id="area" name="area.id" value="${office.area.id}" labelName="area.name" labelValue="${office.area.name}"
									title="区域" url="/sys/area/treeData" cssClass="required"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span6">
							<label class="control-label">机构名称:</label>
							<div class="controls">
								<form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
							</div>
						</div>
						<div class="span6">
							<label class="control-label">机构编码:</label>
							<div class="controls">
								<form:input path="code" htmlEscape="false" maxlength="50"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span6">
							<label class="control-label">机构类型:</label>
							<div class="controls">
								<form:select path="type">
									<form:options items="${fns:getDictList('sys_office_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</div>
						</div>
						<div class="span6">
							<label class="control-label">机构级别:</label>
							<div class="controls">
								<form:select path="grade">
									<form:options items="${fns:getDictList('sys_office_grade')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span6">
							<label class="control-label">联系地址:</label>
							<div class="controls">
								<form:input path="address" htmlEscape="false" maxlength="50"/>
							</div>
						</div>
						<div class="span6">
							<label class="control-label">邮政编码:</label>
							<div class="controls">
								<form:input path="zipCode" htmlEscape="false" maxlength="50"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span6">
							<label class="control-label">负责人:</label>
							<div class="controls">
								<form:input path="master" htmlEscape="false" maxlength="50"/>
							</div>
						</div>
						<div class="span6">
							<label class="control-label">电话:</label>
							<div class="controls">
								<form:input path="phone" htmlEscape="false" maxlength="50"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span6">
							<label class="control-label">传真:</label>
							<div class="controls">
								<form:input path="fax" htmlEscape="false" maxlength="50"/>
							</div>
						</div>
						<div class="span6">
							<label class="control-label">邮箱:</label>
							<div class="controls">
								<form:input path="email" htmlEscape="false" maxlength="50"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span6">
							<label class="control-label">LOGO:</label>
							<div class="controls">
								<form:input path="logo" htmlEscape="false" maxlength="50"/>
								<input id="btnUpload" class="btn btn-info" type="submit" value="上传"/>
							</div>
						</div>
						<div class="span6">
							<label class="control-label">使用状态:</label>
							<div class="controls">
								<form:select path="status">
									<form:option value="1">可用</form:option>
									<form:option value="0">不可用</form:option>
								</form:select>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span6">
							<label class="control-label">有效日期:</label>
							<div class="controls">
								<input id="validDate" name="validDate" value="${validDate }" type="text"/>
							</div>
						</div>
						<div class="span6">
							<label class="control-label">授权号码:</label>
							<div class="controls">
								<form:input path="authNum" htmlEscape="false" maxlength="50"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span8">
							<label class="control-label">地理位置:</label>
							<div class="controls">
								<form:input path="lng" htmlEscape="false" maxlength="20" placeholder="经度"/>
								<form:input path="lat" htmlEscape="false" maxlength="20" placeholder="纬度"/>
							</div>
						</div> 
						<div class="span2">
							<div class="controls">
								<input type="button" name="openMap" id="openMap" class="btn btn-info" value="地图" />
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span12">
							<label class="control-label">备注:</label>
							<div class="controls">
								<form:textarea path="remarks" htmlEscape="false" rows="2" maxlength="200" cssClass="input-xxlarge"/>
							</div>
						</div>
					</div>
				</div>
				<div class="form-actions">
					<shiro:hasPermission name="sys:office:edit"><input id="btnSubmit" class="btn btn-primary" type="button" value="保 存"/>&nbsp;</shiro:hasPermission>
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</form:form>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#validDate").date({
				minDate:"today"
			});
			//提交
			$("#btnSubmit").click(function(){
				if($("#inputForm").valid()){
					var url = "${ctx}/sys/office/save";
					top.$.jBox.tip("后台正在处理,请稍后....", 'loading');
					$.post(url,$("#inputForm").serialize(),function(data){
						top.$.jBox.closeTip();
						if(data.result=="success"){
							top.$.jBox.tip(data.msg,"success",{closed:function(){
								window.location.href="${ctx}/sys/office/list";
							}});
						}else{
							top.$.jBox.tip(data.msg,"error",{closed:function(){return false;}});
						}
					});
				}else{
					top.$.jBox.tip("输入有误，请正确输入数据","error",{closed:function(){return false;}});
				}
			});
		});
		
		//打开地图
		$("#openMap").click(function(){
			top.$.jBox.open("iframe:${context}/map/simple", "选择小区地理位置", $(top.document).width()-520,500, 
			{ 
				persistent:true,
				buttons: { '确定':'ok','关闭': 'closed'},
				loaded:function(e){
					top.$("#jbox-content").css("overflow-y","hidden");
				},
				submit:function(v,h,f){
					if("ok"==v){
						//将 选择的对象赋值到界面中
						var iframeName = h.children(0).attr("name");
  							var container = top.window.frames[iframeName].document;
  							var lng = $("#currentx", container).val();
  							var lat = $("#currenty", container).val();
  							//赋值到表单中
  							$("#lng").val(lng);
  							$("#lat").val(lat);
					}
				}
			});
		});
	</script>
</body>
</html>