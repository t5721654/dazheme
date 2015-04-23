<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>区域管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<div class="portlet box dark">
		<div class="portlet-title">
			<div class="caption">区域基本信息</div>
		</div>
		<div class="portlet-body">
			<form:form id="inputForm" modelAttribute="area" action="${ctx}/sys/area/save" method="post" class="form-horizontal">
				<form:hidden path="id"/>
				<tags:message content="${message}"/>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span6">
							<label class="control-label">上级区域:</label>
							<div class="controls">
								<tags:treeselect id="area" name="parent.id" value="${area.parent.id}" labelName="parent.name" labelValue="${area.parent.name}"
									title="区域" url="/sys/area/treeData" extId="${area.id}" cssClass="required"/>
							</div>
						</div>
						<div class="span6">
							<label class="control-label">区域名称:</label>
							<div class="controls">
								<form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
							</div>
						</div>
					</div>
					<div class="control-group">
						<div class="span6">
							<label class="control-label">区域编码:</label>
							<div class="controls">
								<form:input path="code" htmlEscape="false" maxlength="50"/>
							</div>
						</div>
						<div class="span6">
							<label class="control-label">区域类型:</label>
							<div class="controls">
								<form:select path="type">
									<form:options items="${fns:getDictList('sys_area_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</div>
						</div>
					</div>
					<div class="control-group">
						<div class="span6">
							<label class="control-label">备注:</label>
							<div class="controls">
								<form:textarea path="remarks" htmlEscape="false" rows="2" maxlength="200" class="input-xlarge"/>
							</div>
						</div>
						<div class="span6">
						<div class="form-actions">
							<shiro:hasPermission name="sys:area:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
							<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
						</div>
						</div>
					</div>
				</div>
			</form:form>
		</div>
	</div>
</body>
</html>