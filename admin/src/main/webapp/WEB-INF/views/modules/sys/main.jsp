<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
	<head>
    	<meta name="decorator" content="cleanzone"/>
	</head>
</html>
<body>
	<div id="cl-wrapper" class="fixed-menu">
		<div class="cl-sidebar">
			<div class="cl-toggle">
				<i class="fa fa-bars"></i>
			</div>
			<div class="cl-navblock">
				<div class="menu-space">
					<div class="content">
						<div class="side-user">
							<div class="avatar">
								<img src="${ctxStatic}/cleanzone/images/avatar1_50.jpg"
									alt="Avatar" />
							</div>
							<div class="info">
								<a href="#">黄根华</a>
								<img src="${ctxStatic}/cleanzone/images/state_online.png"
									alt="Status" />
								<span>在线</span>
							</div>
							<ul class="cl-vnavigation">
								<li>
									<a href="#"><i class="fa fa-home"></i><span>Dashboard</span>
									</a>
									<ul class="sub-menu">
										<li class="active">
											<a href="http://www.baidu.com" target="mainFrame">Version 1</a>
										</li>
										<li>
											<a href="http://www.google.com" target="mainFrame">
											<span class="label label-primary pull-right">New</span> Version 2</a>
										</li>
									</ul>
								</li>
								<c:forEach items="${fns:getMenuList() }" var="menu" varStatus="statu">
									<c:if test="${menu.parent.id eq '1' && menu.isShow eq '1' }">
										<li>
											<a href="#">
												<i class="fa fa-home"></i>
												<span>${menu.name }</span>
											</a>
											<ul class="sub-menu">
												<c:forEach items="${fns:getMenuList() }" var="submenu" varStatus="substatu">
													<c:if test="${menu.id eq submenu.parent.id && submenu.isShow eq '1' }">
														<li>
															<a href="${submenu.href }" target="mainFrame">${submenu.name }</a>
														</li>
													</c:if>
												</c:forEach>
											</ul>
										</li>
									</c:if>
								</c:forEach>
							</ul>
							<div class="text-right collapse-button" style="padding: 5px 5px 5px 0px;">
								<input type="text" class="form-control search"
									placeholder="Search..." />
								<button id="sidebar-collapse" class="btn btn-default" style="">
									<i style="color: #fff;" class="fa fa-angle-left"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="container-fluid" id="pcont">
			<iframe name="mainFrame" src="http://www.baidu.com" width="100%" height="99%" style="overflow: auto;border: none;"></iframe>
		</div>
	</div>
</body>
</html>
