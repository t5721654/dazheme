<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')}</title>
	<%@include file="/WEB-INF/views/include/dialog.jsp" %>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic }/common/ace.min.css" /> 
  	<link rel="stylesheet" href="${ctxStatic }/common/ace-skins.min.css" />
  	<link rel="stylesheet" href="${ctxStatic }/bootstrap/2.3.1/font/font-awesome.min.css" />
  	<script type="text/javascript"> 
		$(document).ready(function() {
			var clientWidth = document.body.clientWidth;
			var frameWidth = clientWidth - 192;
			$("#mainFrame").attr("width",frameWidth);
			$("#menu a.menu").click(function(){
				$("#menu li.menu").removeClass("active");
				$(this).parent().addClass("active");
				if(!$("#openClose").hasClass("close")){
					$("#openClose").click();
				}
			});
		});
	</script>
</head>
<body>
	<div class="navbar" id="navbar">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a href="#" class="brand"> <small> <i
						class="icon-leaf"></i>${fns:getConfig('productName')}</small> </a>
				<ul id="menu" class="nav">
				 <c:set var="firstMenu" value="true"/>
				 <c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
					<c:if test="${menu.parent.id eq '1' &&menu.isShow eq '1'}">
						<li class="menu ${firstMenu?' active':''}"><a class="menu" href="${ctx}/sys/menu/tree?parentId=${menu.id}" target="menuFrame" >${menu.name}</a></li>
						<c:if test="${firstMenu}">
							<c:set var="firstMenuId" value="${menu.id}"/>
						</c:if>
						<c:set var="firstMenu" value="false"/>
					</c:if>
				 </c:forEach>
	           </ul>
				<!--/.brand-->
				<ul class="nav ace-nav pull-right">
					<li class="grey">
						<a data-toggle="dropdown" class="dropdown-toggle" href="#">
							<i class="icon-tasks"></i> <span class="badge badge-grey">4</span>
						</a>
						<ul
							class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-closer">
							<li class="nav-header">
								<i class="icon-ok"></i> 4 Tasks to complete
							</li>
							<li>
								<a href="#">
									<div class="clearfix">
										<span class="pull-left">Software Update</span>
										<span class="pull-right">65%</span>
									</div>
									<div class="progress progress-mini ">
										<div style="width: 65%" class="bar"></div>
									</div> </a>
							</li>
							<li>
								<a href="#"> See tasks with details <i
									class="icon-arrow-right"></i> </a>
							</li>
						</ul>
					</li>
					<li class="purple">
						<a data-toggle="dropdown" class="dropdown-toggle" href="#">
							<i class="icon-bell-alt icon-animated-bell"></i> <span
							class="badge badge-important">8</span> </a>
						<ul
							class="pull-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-closer">
							<li class="nav-header">
								<i class="icon-warning-sign"></i> 8 Notifications
							</li>
							<li>
								<a href="#">
									<div class="clearfix">
										<span class="pull-left"> <i
											class="btn btn-mini no-hover btn-pink icon-comment"></i>
											New Comments </span>
										<span class="pull-right badge badge-info">+12</span>
									</div> </a>
							</li>
							<li>
								<a href="#">
									<div class="clearfix">
										<span class="pull-left"> <i
											class="btn btn-mini no-hover btn-info icon-twitter"></i>
											Followers </span>
										<span class="pull-right badge badge-info">+11</span>
									</div> </a>
							</li>
							<li>
								<a href="#"> See all notifications <i
									class="icon-arrow-right"></i> </a>
							</li>
						</ul>
					</li>
					<li class="green">
						<a data-toggle="dropdown" class="dropdown-toggle" href="#">
							<i class="icon-envelope icon-animated-vertical"></i> <span
							class="badge badge-success">5</span> </a>
						<ul
							class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-closer">
							<li class="nav-header">
								<i class="icon-envelope-alt"></i> 5 Messages
							</li>
							<li>
								<a href="#"> <img src="assets/avatars/avatar4.png"
										class="msg-photo" alt="Bob's Avatar" /> <span
									class="msg-body"> <span class="msg-title"> <span
											class="blue">Bob:</span> Nullam quis risus eget urna mollis
											ornare ... </span> <span class="msg-time"> <i
											class="icon-time"></i> <span>3:15 pm</span> </span> </span> </a>
							</li>
							<li>
								<a href="#"> See all messages <i class="icon-arrow-right"></i>
								</a>
							</li>
						</ul>
					</li>
					<li class="light-blue">
						<a data-toggle="dropdown" href="#" class="dropdown-toggle">
							<span class="user-info"> <small>Welcome,</small>
								Jason </span> <i class="icon-caret-down"></i> </a>
						<ul
							class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-closer">
							<li>
								<a href="#"> <i class="icon-cog"></i> Settings </a>
							</li>
							<li>
								<a href="#"> <i class="icon-user"></i> Profile </a>
							</li>
							<li class="divider"></li>
							<li>
								<a href="#"> <i class="icon-off"></i> Logout </a>
							</li>
						</ul>
					</li>
				</ul>
				<!--/.ace-nav-->
			</div>
			<!--/.container-fluid-->
		</div>
		<!--/.navbar-inner-->
	</div>
	<div class="main-container container-fluid">
		<div id="content" class="row-fluid">
			<iframe id="menuFrame" name="menuFrame" src="${ctx}/sys/menu/tree?parentId=${firstMenuId}" style="overflow:visible;" scrolling="no" frameborder="no" width="189" height="800"></iframe>
			<iframe id="mainFrame" name="mainFrame" src="" style="overflow:visible;margin-left: -6px;border-left: 1px #B9C0C0 solid;" scrolling="no" frameborder="no" height="800"></iframe>
		</div>
		<!--/.main-content-->
	</div>
	<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-small btn-inverse"> <i class="icon-double-angle-up icon-only bigger-110"></i> </a>
	<script src="${ctxStatic }/common/ace.min.js"></script>
	<script src="${ctxStatic }/common/ace-extra.min.js"></script> 
	</body>
</html>