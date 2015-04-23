<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单导航</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic }/common/ace.min.css" /> 
  	<link rel="stylesheet" href="${ctxStatic }/common/ace-skins.min.css" />
  	<link rel="stylesheet" href="${ctxStatic }/bootstrap/2.3.1/font/font-awesome.min.css" />
  	<style type="text/css">
  	.menu-text {
  		font-family:'\5FAE\8F6F\96C5\9ED1', arial;
		font-size: 13px;
	}
  	</style>
</head>
<body>
	<c:set var="firstMenu" value="true" />
	<div class="sidebar" id="sidebar">
			<!--#sidebar-shortcuts-->
			<ul class="nav nav-list">
				<c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
					<c:if test="${menu.parent.id eq parentId }">
						<c:choose>
							<c:when test="${ not empty menu.href }">
								<li class="<c:if test='${firstMenu }'>active</c:if>">
									<i class="icon-${not empty menu.icon ? menu.icon : 'other'}"></i>
									<a href="${ctx }${menu.href }"> <i class="${menu.icon }"></i> 
									<span class="menu-text"> ${menu.name } </span> </a>
								</li>
								<c:set var="firstMenu" value="false"/>
							</c:when>
							<c:otherwise>
								<li>
									<a href="#" class="dropdown-toggle">
										<i class="icon-${not empty menu.icon ? menu.icon : 'other'}"></i>
										<span class="menu-text"> ${menu.name } </span> 
										<b class="arrow icon-angle-down"></b>
									</a>
									<ul class="submenu">
										<c:forEach items="${menuList}" var="submenu">
											<c:if test="${submenu.parent.id eq menu.id }">
												<li class="<c:if test='${firstMenu }'>active</c:if>">
													<a href="${ctx }${submenu.href }" target="mainFrame">
													<span class="menu-text">${submenu.name }</span>
													</a>
												</li>
												<c:set var="firstMenu" value="false"/>
											</c:if>
										</c:forEach>
									</ul>
								</li>
							</c:otherwise>
						</c:choose>
					</c:if>
				</c:forEach>
			</ul>
			<!--/.nav-list-->
			<div class="sidebar-collapse" id="sidebar-collapse" style="display: none;">
				<i class="icon-double-angle-left" data-icon1="icon-double-angle-left"
					data-icon2="icon-double-angle-right"></i>
			</div>
		</div>
		<script src="${ctxStatic }/common/ace.min.js"></script>
		<script src="${ctxStatic }/common/ace-extra.min.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			$("#sidebar .nav li").click(function(){
				var _this = this;
				if(!$(_this).find("a:first").hasClass("dropdown-toggle")){
					$("#sidebar .nav li.active").removeClass("active");
					$(_this).addClass("active");
				}
			});
			$("ul.nav li a.dropdown-toggle:first").find(".menu-text").click();
			$("#sidebar").find("li.active").find(".menu-text").click();
			
		});
		</script>
</body>
</html>
