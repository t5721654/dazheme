<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>403 - 用户权限不足</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<link href="${ctxStatic}/bootstrap/metronic/css/error.css" type="text/css" rel="stylesheet" />
</head>
<body>
	<div class="row-fluid">
		<div class="span12 page-404">
			<div class="number">
				403
			</div>
			<div class="details">
				<h3>用户权限不足.</h3>
				<p>
					亲，您没有权限使用这个功能，请联系管理员.<br />
				</p>
				<p>
					请点击<a href="${ctx }/sys/user/home" target="_self">这里</a>跳转到首页.<br /><br />
				</p>
			</div>
		</div>
	</div>
</body>
</html>