<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>水果管理</title>
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
	<div class="portlet box dark">
		<div class="portlet-title">
			<div class="caption">水果列表</div>
		</div>
		<div class="portlet-body">
			<form:form id="searchForm" modelAttribute="fruit" action="${ctx}/product/fruit/fruit/" method="post" class="breadcrumb form-search">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<label>名称 ：</label><form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/>
				&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
			</form:form>
			<tags:message content="${message}"/>
			<table id="contentTable" class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>水果名称</th>
						<th>水果种类</th>
						<th>水果品牌</th>
						<th>水果单价</th>
						<th>促销价格</th>
						<th>热门</th>
						<shiro:hasPermission name="product:fruit:fruit:edit">
							<th>
								操作
							</th>
						</shiro:hasPermission>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.list}" var="fruit">
					<tr>
						<td><a href="${ctx}/product/fruit/fruit/form?id=${fruit.id}">${fruit.name}</a></td>
						<td>${fruit.category.name}</td>
						<td>${fruit.brand }</td>
						<td>${fruit.price }/${fruit.number }${fruit.unit }</td>
						<td>${fruit.promotionPrice }/${fruit.promotionNum }${fruit.unit }</td>
						<td>${fruit.isHot }</td>
						<shiro:hasPermission name="product:fruit:fruit:edit"><td>
		    				<a href="${ctx}/product/fruit/fruit/form?id=${fruit.id}">修改</a>
							<a href="${ctx}/product/fruit/fruit/delete?id=${fruit.id}" onclick="return confirmx('确认要删除该水果吗？', this.href)">删除</a>
						</td></shiro:hasPermission>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<div class="pagination">${page}</div>
		</div>
	</div>
</body>
</html>
