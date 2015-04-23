<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%response.setStatus(200);%>
<html>
<head>
    <title>404 - 页面不存在</title>
    <link href="${ctxStatic}/bootstrap/metronic/css/error.css" type="text/css" rel="stylesheet" />
</head>

<body>
<div class="row-fluid">
    <div class="span12 page-404">
        <div class="number">
            404
        </div>
        <div class="details">
            <h3>页面不存在.</h3>
            <p>
                亲，我们不能找到您的请求，请重试.<br />
            </p>
            <p>
                请点击<a href="${ctx }/sys/user/home" target="_self">这里</a>跳转到首页.<br /><br />
            </p>
        </div>
    </div>
</div>
</body>
</html>