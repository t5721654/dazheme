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
			<div class="caption">字典列表信息</div>
		</div>
		<div class="portlet-body">
			<div class="row-fluid">
				<c:forEach items="${dictList }" var="dict">
					<span class="span2" style="margin-left: 0;"><a href="${ctx }/sys/dict/itemlist?type=${dict.type}">${dict.description}</a></span>
				</c:forEach>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
		});
	</script>
</body>
</html>