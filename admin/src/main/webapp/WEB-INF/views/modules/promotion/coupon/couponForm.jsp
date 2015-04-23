<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>电子券/礼品券管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div class="portlet box dark">
		<div class="portlet-title">
			<div class="caption">电子券/礼品券基本信息</div>
		</div>
		<div class="portlet-body">
			<form:form id="inputForm" modelAttribute="coupon" action="" method="post" class="form-horizontal">
				<form:hidden path="id"/>
				<tags:message content="${message}"/>
				<div class="control-group">
					<label class="control-label">礼券标题:</label>
					<div class="controls">
						<form:input path="name" htmlEscape="false" maxlength="200" class="required input-xlarge"/>
						<span class="important">*</span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">礼券编号:</label>
					<div class="controls">
						<form:input path="code" htmlEscape="false" maxlength="200" class="required input-xlarge"/>
						<span class="important">*</span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">礼券类型:</label>
					<div class="controls">
						<form:input path="type" htmlEscape="false" maxlength="200" class="required input-xlarge"/>
						<span class="important">*</span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">礼券金额:</label>
					<div class="controls">
						<form:input path="amount" htmlEscape="false" maxlength="200" class="required input-xlarge"/> 元
						<span class="important">*</span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">生效时间:</label>
					<div class="controls">
						<form:input path="startTime" htmlEscape="false" maxlength="200" class="input-xlarge"/>
						<span class="help-inline">如不填,则表示立即生效</span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">有效期:</label>
					<div class="controls">
						<form:input path="validate" htmlEscape="false" maxlength="200" class="input-xlarge"/>
						<span class="help-inline">如不填,则表示永久有效</span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">礼券样式:</label>
					<div class="controls">
						<form:input path="picUrl" htmlEscape="false" maxlength="200" class="input-xlarge"/>
					</div>
				</div>
				<div class="form-actions">
					<shiro:hasPermission name="promotion:coupon:coupon:edit"><input id="btnSubmit" class="btn btn-primary" type="button" value="保 存"/>&nbsp;</shiro:hasPermission>
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</form:form>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#startTime").date();
			$("#validate").date({
				minDate:"#startTime"
			});
			$("#btnSubmit").click(function(){
				var url = "${ctx}/promotion/coupon/coupon/save";
				$("#inputForm").form(url,function(){
					window.location.href = "${ctx}/promotion/coupon/coupon/list";
				},function(){
					return false;
				});
			});
		});
	</script>
</body>
</html>
