<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>小区表管理</title>
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
			<div class="caption">小区信息列表</div>
		</div>
		<div class="portlet-body">
			<form:form id="searchForm" modelAttribute="communityInfo" action="${ctx}/sys/communityInfo/" method="post" class="breadcrumb form-search">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<label>名称 ：</label><form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/>
				&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
			</form:form>
			<tags:message content="${message}"/>
				<table id="contentTable" class="table table-striped table-bordered table-condensed">
					<thead>
						<tr>
							<th>
								小区名称
							</th>
							<th>
								小区编号
							</th>
							<th>
								城市
							</th>
							<th>
								地址
							</th>
							<th>
								添加人员
							</th>
							<th>
								添加时间
							</th>
							<shiro:hasPermission name="sys:communityInfo:edit">
								<th>
									操作
								</th>
							</shiro:hasPermission>
						</tr>
					</thead>
					<tbody>
				<c:forEach items="${page.list}" var="communityInfo">
					<tr>
						<td><a href="${ctx}/sys/communityInfo/form?id=${communityInfo.id}">${communityInfo.name}</a></td>
						<td>${communityInfo.code }</td>
						<td>${communityInfo.prov }${communityInfo.city }${communityInfo.area }</td>
						<td title="${communityInfo.address}">
						<c:choose>
							<c:when test="${fn:length(communityInfo.address) >20 }">
								${fn:substring(communityInfo.address,0,20) }...
							</c:when>
							<c:otherwise>${communityInfo.address }</c:otherwise>
						</c:choose>
						</td>
						<td>${communityInfo.createBy}</td>
						<td><fmt:formatDate value="${communityInfo.createDate}" pattern="yyyy-MM-dd"/></td>
						<shiro:hasPermission name="sys:communityInfo:edit"><td>
		    				<a href="${ctx}/sys/communityInfo/form?id=${communityInfo.id}">修改</a>
							<a href="${ctx}/sys/communityInfo/delete?id=${communityInfo.id}" onclick="return confirmx('确认要删除该小区表吗？', this.href)">删除</a>
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
