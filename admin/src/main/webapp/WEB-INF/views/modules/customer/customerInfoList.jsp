<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会员信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/customer/customerInfo/">会员信息列表</a></li>
		<shiro:hasPermission name="customer:customerInfo:edit"><li><a href="${ctx}/customer/customerInfo/form">会员信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="customerInfo" action="${ctx}/customer/customerInfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>名称 ：</label><form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/>
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>名称</th><th>备注</th><shiro:hasPermission name="customer:customerInfo:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="customerInfo">
			<tr>
				<td><a href="${ctx}/customer/customerInfo/form?id=${customerInfo.id}">${customerInfo.name}</a></td>
				<td>${customerInfo.remarks}</td>
				<shiro:hasPermission name="customer:customerInfo:edit"><td>
    				<a href="${ctx}/customer/customerInfo/form?id=${customerInfo.id}">修改</a>
					<a href="${ctx}/customer/customerInfo/delete?id=${customerInfo.id}" onclick="return confirmx('确认要删除该会员信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
