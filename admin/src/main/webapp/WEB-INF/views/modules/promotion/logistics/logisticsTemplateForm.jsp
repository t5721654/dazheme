<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>物流模板管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div class="portlet box dark">
		<div class="portlet-title">
			<div class="caption">电子券/礼品券基本信息</div>
		</div>
		<div class="portlet-body">
			<form:form id="inputForm" modelAttribute="logisticsTemplate" action="${ctx}/promotion/logistics/logisticsTemplate/save" method="post" class="form-horizontal">
				<form:hidden path="id"/>
				<div class="control-group">
					<label class="control-label">名称:</label>
					<div class="controls">
						<form:input path="name" htmlEscape="false" maxlength="200" class="required input-xlarge"/>
						<span class="important">*</span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">起始地址:</label>
					<div class="controls">
						<form:input path="address" htmlEscape="false" maxlength="200" class="required input-xlarge"/>
						<span class="important">*</span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">发送时间:</label>
					<div class="controls">
						<form:input path="sendRange" htmlEscape="false" maxlength="200" class="required input-xlarge"/>
						<span class="important">*</span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">是否包邮:</label>
					<div class="controls">
						<form:radiobutton path="isFree" value="1" label="是"/>
						<form:radiobutton path="isFree" value="0" label="否"/>
						<span class="important">*</span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">配送费用:</label>
					<div class="controls">
						<form:input path="fee" htmlEscape="false" maxlength="200" class="required input-xlarge"/> 元
						<span class="important">*</span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">满免邮:</label>
					<div class="controls">
						<form:input path="overFree" htmlEscape="false" maxlength="200" class="required input-xlarge"/>
						<span class="help-inline">订单满多少就免邮</span>
					</div>
				</div>
				<div class="form-actions">
					<shiro:hasPermission name="promotion:logistics:logisticsTemplate:edit"><input id="btnSubmit" class="btn btn-primary" type="button" value="保 存"/>&nbsp;</shiro:hasPermission>
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</form:form>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#btnSubmit").click(function(){
				var url= "${ctx}/promotion/logistics/logisticsTemplate/save";
				$("#inputForm").form(url,function(){
					window.location.href = "${ctx}/promotion/logistics/logisticsTemplate/list";
				});
			});
		});
	</script>
</body>
</html>
