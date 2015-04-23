<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>水果管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div class="portlet box dark">
		<div class="portlet-title">
			<div class="caption">水果信息(编号：)</div>
		</div>
		<div class="portlet-body">
			<form:form id="inputForm" modelAttribute="fruit" action="" method="post" class="form-horizontal">
				<form:hidden path="id"/>
				<tags:message content="${message}"/>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span6">
							<label class="control-label">水果标题:</label>
							<div class="controls">
								<form:input path="name" htmlEscape="false" maxlength="200" class="required measure-input input-xlarge"/>
								<input type="checkbox" name="isHot" id="isHot" value="1" title="是否热门">热门&nbsp;&nbsp;
								<input type="checkbox" name="isOrganic" id="isOrganic" value="1" title="是否有机水果">有机
								<span class="important">*</span>
							</div>
						</div>
						<div class="span6">
							<label class="control-label">副标题:</label>
							<div class="controls">
								<form:input path="summary" htmlEscape="false" maxlength="200" class="measure-input input-xlarge"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span6">
							<label class="control-label">种类:</label>
							<div class="controls">
								<tags:treeselect id="category" name="category.id" value="${fruit.category.id }" labelName="category.name" labelValue="${fruit.category.name }"
									title="水果种类" url="/product/fruit/fruitCategory/treeData" cssClass="required input-xlarge"/>
								<span class="important">*</span>
							</div>
						</div>
						<div class="span6">
							<label class="control-label">单位:</label>
							<div class="controls">
								<form:input path="unit" htmlEscape="false" maxlength="200" class="required input-xlarge"/>
								<span class="important">*</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span6">
							<label class="control-label">单价:</label>
							<div class="controls">
								<form:input path="price" htmlEscape="false" maxlength="200" class="required number input-xlarge"/>
								<span class="important">*</span>
							</div>
						</div>
						<div class="span6">
							<label class="control-label">单量:</label>
							<div class="controls">
								<form:input path="number" htmlEscape="false" maxlength="200" class="required number input-xlarge"/>
								<span class="important">*</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span6">
							<label class="control-label">品牌:</label>
							<div class="controls">
								<form:input path="brand" htmlEscape="false" maxlength="200" class="input-xlarge"/>
							</div>
						</div>
						<div class="span6">
							<label class="control-label">产地:</label>
							<div class="controls">
								<form:input path="origin" htmlEscape="false" maxlength="200" class="input-xlarge"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span6">
							<label class="control-label">促销单价:</label>
							<div class="controls">
								<form:input path="promotionPrice" htmlEscape="false" maxlength="200" class="number input-xlarge"/>
								<form:checkbox path="showPromotion" value="1"/>显示
							</div>
						</div>
						<div class="span6">
							<label class="control-label">促销单量:</label>
							<div class="controls">
								<form:input path="promotionNum" htmlEscape="false" maxlength="200" class="number input-xlarge"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span6">
							<label class="control-label">净含量:</label>
							<div class="controls">
								<form:input path="weight" htmlEscape="false" maxlength="200" class="input-xlarge"/>
							</div>
						</div>
						<div class="span6">
							<label class="control-label">生产日期:</label>
							<div class="controls">
								<form:input path="productDate" htmlEscape="false" maxlength="200" class="input-xlarge"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span6">
							<label class="control-label">保质期:</label>
							<div class="controls">
								<form:input path="shelfLife" htmlEscape="false" maxlength="200" class="input-xlarge"/>
							</div>
						</div>
						<div class="span6">
							<label class="control-label">包装方式:</label>
							<div class="controls">
								<form:input path="packingWay" htmlEscape="false" maxlength="200" class="input-xlarge"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div  class="control-group">
						<label class="control-label">标签:</label>
						<div class="controls">
							<input type="text" name="productTag" id="productTag" value="" class="input-xxlarge"/>
						</div>
					</div>
				</div>
				<div class="form-actions">
					<shiro:hasPermission name="product:fruit:fruit:edit"><input id="btnSubmit" class="btn btn-primary" type="button" value="保 存"/>&nbsp;</shiro:hasPermission>
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</form:form>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#productDate").date({
				minDate:"today"
			});
			$("#btnSubmit").click(function(){
				$("#inputForm").form("${ctx}/product/fruit/fruit/save",function(){
					window.location.href = "${ctx}/product/fruit/fruit/list";
				});
			});
		});
	</script>
</body>
</html>
