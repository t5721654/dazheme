<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>水果种类管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
</head>
<body>
	<div class="row-fluid">
		<div class="span8">
			<div class="portlet box dark">
				<div class="portlet-title">
					<div class="caption">水果种类管理</div>
				</div>
				<div class="portlet-body">
					<table id="treeTable" class="table table-striped table-bordered table-condensed">
						<tr><th>种类名称</th><th>是否热门</th><th>添加日期</th><th>添加人员</th><shiro:hasPermission name="sys:office:edit"><th>操作</th></shiro:hasPermission></tr>
						<c:forEach items="${list}" var="category">
							<tr id="${category.id}" pId="${category.parent.id ne rootcategory.id ? category.parent.id : '0'}">
								<td><a href="javascript:;" onclick="treeTableTrtoggle('${category.id}')">${category.name}</a></td>
								<td>${category.isHot}</td>
								<td>
									<fmt:formatDate value="${category.createDate}" pattern="yyyy-MM-dd"/>
								</td>
								<td>${category.createBy}</td>
								<shiro:hasPermission name="sys:office:edit"><td>
									<a href="JavaScript:;" onclick="update('${category.id }');">修改</a>
									<a href="JavaScript:;" onclick="deleteCategory('${category.id }');">删除</a>
								</td></shiro:hasPermission>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
		<div class="span4">
			<div class="portlet box dark">
				<div class="portlet-title">
					<div class="caption">水果种类添加</div>
				</div>
				<div class="portlet-body">
					<form:form id="inputForm" modelAttribute="fruitCategory" action="${ctx}/product/fruit/fruitCategory/save" method="post" class="form-horizontal">
						<form:hidden path="id"/>
						<div class="control-group">
							<label>上级种类:</label>
							<tags:treeselect id="parent" name="parent.id" value="${fruitCategory.parent.id}" labelName="parent.name" labelValue="${fruitCategory.parent.name}"
								title="上级分类" url="/product/fruit/fruitCategory/treeData" extId="${fruitCategory.id}" cssClass="input-medium"/>
						</div>
						<div class="control-group">
							<label>种类名称:</label>
							<form:input path="name" htmlEscape="false" maxlength="200" class="required"/>
						</div>
						<div class="control-group">
							<label>是否热门:</label>
							<input type="radio" name="isHot" value="0">否
							<input type="radio" name="isHot" value="1" checked="checked">是
						</div>
						<div class="form-actions">
							<shiro:hasPermission name="product:fruit:fruitCategory:edit"><input id="btnSubmit" class="btn btn-primary" type="button" value="保 存"/>&nbsp;</shiro:hasPermission>
							<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#treeTable").treeTable({expandLevel : 1});
			
			$("#btnSubmit").click(function(){
				$("#inputForm").form("${ctx}/product/fruit/fruitCategory/save",function(){
					window.location.href="${ctx}/product/fruit/fruitCategory/form";
				});
			});
		});
		
		function update(id){
			
		}
		
		function deleteCategory(id){
			top.$.jBox.confirm("要删除该机构及所有子机构项吗？", "提示", function(){
				$.post("${ctx}/product/fruit/fruitCategory/delete",{id:id},function(data){
					if(data=="success"){
						window.location.href="${ctx}/product/fruit/fruitCategory/form";
					}
				});
			});
		}
	</script>
</body>
</html>
