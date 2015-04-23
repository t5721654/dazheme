<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div id="head-nav" class="navbar navbar-default navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse">
				<span class="fa fa-gear"></span>
			</button>
			<a class="navbar-brand" href="${ctx }">
				<span>${fns:getConfig('productName')}</span>
			</a>
		</div>
		<c:if test="${!empty param.parentId }">
			<c:set var="parentMenuId" value="${param.parentId}" />
		</c:if>
		<c:set var="firstMenu" value="true" />
		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<c:choose>
					<c:when test="${!empty parentMenuId }">
						<c:forEach items="${fns:getMenuList() }" var="menu" varStatus="statu">
							<c:if test="${menu.parent.id eq '1' && menu.isShow eq '1' }">
									<li class="menu ${menu.id eq parentMenuId ? 'active' : ''}">
										<a href="javascript:;" onclick="changeMainMenu('${menu.id}');">${menu.name}</a>
									</li>
							</c:if>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:forEach items="${fns:getMenuList() }" var="menu" varStatus="statu">
							<c:if test="${menu.parent.id eq '1' && menu.isShow eq '1' }">
								<li class="menu ${firstMenu ? 'active' : ''}">
									<a href="javascript:;" onclick="changeMainMenu('${menu.id}');">${menu.name}</a>
								</li>
								<c:if test="${firstMenu}">
									<c:set var="parentMenuId" value="${menu.id}" />
								</c:if>
								<c:set var="firstMenu" value="false" />
							</c:if>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</ul>
			<ul class="nav navbar-nav navbar-right user-nav">
				<li class="dropdown profile_menu">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"><img
							alt="Avatar" src="${ctxStatic}/cleanzone/images/avatar2.jpg" /><span>Jeff 
							Hanneman</span> <b class="caret"></b>
					</a>
					<ul class="dropdown-menu">
						<li>
							<a href="#">My Account</a>
						</li>
						<li>
							<a href="#">Profile</a>
						</li>
						<li>
							<a href="#">Messages</a>
						</li>
						<li class="divider"></li>
						<li>
							<a href="#">Sign Out</a>
						</li>
					</ul>
				</li>
			</ul>
			
			<ul class="nav navbar-nav navbar-right not-nav">
				<li class="button dropdown">
					<a href="javascript:;" class="dropdown-toggle"
						data-toggle="dropdown"><i class=" fa fa-comments"></i>
					</a>
					<ul class="dropdown-menu messages">
						<li>
							<div class="nano nscroller">
								<div class="content">
									<ul>
										<li>
											<a href="#"> <img
													src="${ctxStatic}/cleanzone/images/avatar2.jpg"
													alt="avatar" /><span class="date pull-right">13
													Sept.</span> <span class="name">Daniel</span> I'm following you,
												and I want your money! </a>
										</li>
										<li>
											<a href="#"> <img
													src="${ctxStatic}/cleanzone/images/avatar_50.jpg"
													alt="avatar" /><span class="date pull-right">20
													Oct.</span><span class="name">Adam</span> is now following you </a>
										</li>
										<li>
											<a href="#"> <img
													src="${ctxStatic}/cleanzone/images/avatar4_50.jpg"
													alt="avatar" /><span class="date pull-right">2 Nov.</span><span
												class="name">Michael</span> is now following you </a>
										</li>
										<li>
											<a href="#"> <img
													src="${ctxStatic}/cleanzone/images/avatar3_50.jpg"
													alt="avatar" /><span class="date pull-right">2 Nov.</span><span
												class="name">Lucy</span> is now following you </a>
										</li>
									</ul>
								</div>
							</div>
							<ul class="foot">
								<li>
									<a href="#">View all messages </a>
								</li>
							</ul>
						</li>
					</ul>
				</li>
				<li class="button dropdown">
					<a href="javascript:;" class="dropdown-toggle"
						data-toggle="dropdown"><i class="fa fa-globe"></i><span
						class="bubble">2</span>
					</a>
					<ul class="dropdown-menu">
						<li>
							<div class="nano nscroller">
								<div class="content">
									<ul>
										<li>
											<a href="#"><i class="fa fa-cloud-upload info"></i><b>Daniel</b>
												is now following you <span class="date">2 minutes
													ago.</span>
											</a>
										</li>
										<li>
											<a href="#"><i class="fa fa-male success"></i> <b>Michael</b>
												is now following you <span class="date">15 minutes
													ago.</span>
											</a>
										</li>
										<li>
											<a href="#"><i class="fa fa-bug warning"></i> <b>Mia</b>
												commented on post <span class="date">30 minutes ago.</span>
											</a>
										</li>
										<li>
											<a href="#"><i class="fa fa-credit-card danger"></i> <b>Andrew</b>
												killed someone <span class="date">1 hour ago.</span>
											</a>
										</li>
									</ul>
								</div>
							</div>
							<ul class="foot">
								<li>
									<a href="#">View all activity </a>
								</li>
							</ul>
						</li>
					</ul>
				</li>
				<li class="button">
					<a href="javascript:;" class="speech-button"><i
						class="fa fa-microphone"></i>
					</a>
				</li>
			</ul>

		</div>
		<!--/.nav-collapse animate-collapse -->
	</div>
</div>
