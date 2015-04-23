<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ page import="com.cn.ant.common.beanvalidator.BeanValidators"%>
<%@ page import="org.slf4j.Logger,org.slf4j.LoggerFactory" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%response.setStatus(200);%>
<%
	Throwable ex = null;
	if (exception != null)
		ex = exception;
	if (request.getAttribute("javax.servlet.error.exception") != null)
		ex = (Throwable) request.getAttribute("javax.servlet.error.exception");
	//记录日志
	Logger logger = LoggerFactory.getLogger("500.jsp");
	logger.error(ex.getMessage(), ex);
%>
<html>
<head>
	<title>500 - 系统内部错误</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<link href="${ctxStatic}/bootstrap/metronic/css/error.css" type="text/css" rel="stylesheet" />
</head>
<body>
	<div class="row-fluid">
		<div class="span12 page-500">
			<div class=" number">500</div>
			<div class=" details">
				<h3>非常抱歉,系统发生内部错误.</h3>
				<p>
					亲，非常抱歉,系统发生内部错误,请联系管理员!<br />
					请点击<a href="${ctx }/sys/user/home" target="_self">这里</a>跳转到首页.<br /><br />
				</p>
			</div>
		</div>
	</div>
	<div class="row-fluid" style="margin-top: 20px;">
		<p>
		错误信息：
		<%
			if (ex!=null){
				if (ex instanceof javax.validation.ConstraintViolationException){
					for (String s : BeanValidators.extractPropertyAndMessageAsList((javax.validation.ConstraintViolationException)ex, ": ")){
						out.print(s+"<br/>");
					}
				}else{
					out.print(ex+"<br/>");
				}
			}
		%>
		</p>
	</div>
</body>
</html>