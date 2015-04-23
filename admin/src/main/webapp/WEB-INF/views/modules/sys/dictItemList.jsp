<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>字典管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div class="portlet box dark">
		<div class="portlet-title">
			<div class="caption">区域基本信息</div>
		</div>
		<div class="portlet-body">
		<tags:message content="${message}"/>
		<input type="hidden" name="type" id="type" value="${param.type}">
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead><tr><th>标签</th><th>键值</th><th>类型</th><th>描述</th><th>排序</th><shiro:hasPermission name="sys:dict:edit"><th>操作</th></shiro:hasPermission></tr></thead>
			<tbody>
			<c:forEach items="${page.list}" var="dict">
				<tr>
					<td><a href="${ctx}/sys/dict/form?id=${dict.id}">${dict.label}</a></td>
					<td>${dict.value}</td>
					<td><a href="javascript:" onclick="$('#type').val('${dict.type}');$('#searchForm').submit();return false;">${dict.type}</a></td>
					<td>${dict.description}</td>
					<td>${dict.sort}</td>
					<shiro:hasPermission name="sys:dict:edit"><td>
	    				<a href="${ctx}/sys/dict/form?id=${dict.id}">修改</a>
						<a href="${ctx}/sys/dict/delete?id=${dict.id}" onclick="return confirmx('确认要删除该字典吗？', this.href)">删除</a>
	    				<a href="<c:url value='${fns:getAdminPath()}/sys/dict/form?type=${dict.type}'><c:param name='description' value='${dict.description}'/></c:url>">添加键值</a>
					</td></shiro:hasPermission>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<div class="pagination">${page}</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
		});
	
		function page(n,s){
			var type = $("#type").val();
			var url = "${ctx }/sys/dict/itemlist?pageNo="+n+"&pageSize="+s+"&type="+type;
			window.location.href = url;
	    }
	</script>
</body>
</html>