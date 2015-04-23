<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>电子券/礼品券管理</title>
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
			<div class="caption">电子券/礼品券基本信息</div>
		</div>
		<div class="portlet-body">
			<form:form id="searchForm" modelAttribute="coupon" action="${ctx}/promotion/coupon/coupon/" method="post" class="breadcrumb form-search">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<label>名称 ：</label><form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/>
				&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
			</form:form>
			<tags:message content="${message}"/>
			<table id="contentTable" class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>优惠券名称</th>
						<th>样式</th>
						<th>优惠券编码</th>
						<th>优惠券类型</th>
						<th>金额</th>
						<th>生效时间</th>
						<th>有效日期</th>
						<th>商家</th>
					<shiro:hasPermission name="promotion:coupon:coupon:edit"><th>操作</th></shiro:hasPermission>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.list}" var="coupon">
					<tr>
						<td><a href="${ctx}/promotion/coupon/coupon/form?id=${coupon.id}">${coupon.name}</a></td>
						<td>${coupon.picUrl}</td>
						<td>${coupon.code}</td>
						<td>${coupon.picUrl}</td>
						<td>${coupon.amount}</td>
						<td>
							<fmt:formatDate value="${coupon.startTime }" pattern="yyyy-MM-dd HH:mm"/>
						</td>
						<td>
							<fmt:formatDate value="${coupon.validate }" pattern="yyyy-MM-dd HH:mm"/>
						</td>
						<td>${coupon.office.name}</td>
						<shiro:hasPermission name="promotion:coupon:coupon:edit"><td>
		    				<a href="${ctx}/promotion/coupon/coupon/form?id=${coupon.id}">修改</a>
							<a href="${ctx}/promotion/coupon/coupon/delete?id=${coupon.id}" onclick="return confirmx('确认要删除该电子券/礼品券吗？', this.href)">删除</a>
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
