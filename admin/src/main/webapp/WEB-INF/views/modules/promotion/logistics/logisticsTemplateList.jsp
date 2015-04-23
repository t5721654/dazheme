<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>物流模板管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
	</script>
</head>
<body>
	<div class="portlet box dark">
		<div class="portlet-title">
			<div class="caption">电子券/礼品券基本信息</div>
		</div>
		<div class="portlet-body">
			<form:form id="searchForm" modelAttribute="logisticsTemplate" action="${ctx}/promotion/logistics/logisticsTemplate/" method="post" class="form-horizontal  form-search">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<label>名称 ：</label><form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/>
				&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
			</form:form>
			<tags:message content="${message}"/>
			<table id="contentTable" class="table table-striped table-bordered table-condensed">
				<thead><tr>
					<th>名称</th>
					<th>发货时间</th>
					<th>是否包邮</th>
					<th>配送费用</th>
					<th>满多少免邮</th>
					<th>状态</th>
					<th>更新时间</th>
					<shiro:hasPermission name="promotion:logistics:logisticsTemplate:edit"><th>操作</th></shiro:hasPermission>
				</tr></thead>
				<tbody>
				<c:forEach items="${retList}" var="logisticsTemplate">
					<tr>
						<td><a href="${ctx}/promotion/logistics/logisticsTemplate/form?id=${logisticsTemplate.id}">${logisticsTemplate.name}</a></td>
						<td>${logisticsTemplate.sendRange}</td>
						<td>${logisticsTemplate.isFree}</td>
						<td>${logisticsTemplate.fee}</td>
						<td>${logisticsTemplate.overFree}</td>
						<td>${logisticsTemplate.status}</td>
						<td>${logisticsTemplate.createDate}</td>
						<shiro:hasPermission name="promotion:logistics:logisticsTemplate:edit"><td>
		    				<a href="${ctx}/promotion/logistics/logisticsTemplate/form?id=${logisticsTemplate.id}">修改</a>
							<a href="${ctx}/promotion/logistics/logisticsTemplate/delete?id=${logisticsTemplate.id}" onclick="return confirmx('确认要删除该物流模板吗？', this.href)">删除</a>
						</td></shiro:hasPermission>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>
