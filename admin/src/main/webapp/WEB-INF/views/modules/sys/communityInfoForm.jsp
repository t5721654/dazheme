<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>小区表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			//加载地市三级级联
			var prov = "${communityInfo.prov}";
			var city = "${communityInfo.city}";
			var area = "${communityInfo.area}";
			if(prov==""){
				prov = "湖南";
				city = "长沙";
				area = "芙蓉区";
			}
			$("#addrDiv").citySelect({
				url:"${ctxStatic }/city/city.min.js",
		    	prov:prov, 
		    	city:city,
				dist:area,
				nodata:"none"
			}); 
			
			//提交
			$("#btnSubmit").click(function(){
				if($("#inputForm").valid()){
					var url = "${ctx}/sys/communityInfo/save";
					top.$.jBox.tip("后台正在处理,请稍后....", 'loading');
					$.post(url,$("#inputForm").serialize(),function(data){
						top.$.jBox.closeTip();
						if(data.result=="success"){
							top.$.jBox.tip(data.msg,"success",{closed:function(){
								window.location.href="${ctx}/sys/communityInfo";
							}});
						}else{
							top.$.jBox.tip(data.msg,"error",{closed:function(){return false;}});
						}
					});
				}else{
					top.$.jBox.tip("输入有误，请正确输入数据","error",{closed:function(){return false;}});
				}
			});
			
			//打开地图
			$("#openMap").click(function(){
				top.$.jBox.open("iframe:${context}/map/simple", "选择小区地理位置", $(top.document).width()-520,500, 
				{ 
					persistent:true,
					buttons: { '确定':'ok','关闭': 'closed'},
					loaded:function(e){
						top.$("#jbox-content").css("overflow-y","hidden");
					},
					submit:function(v,h,f){
						if("ok"==v){
							//将 选择的对象赋值到界面中
							var iframeName = h.children(0).attr("name");
      							var container = top.window.frames[iframeName].document;
      							var lng = $("#currentx", container).val();
      							var lat = $("#currenty", container).val();
      							//赋值到表单中
      							$("#x").val(lng);
      							$("#y").val(lat);
						}
					}
				});
			});
		});
	</script>
</head>
<body>
	<div class="row-fluid">
		<div class="portlet box dark">
			<div class="portlet-title">
				<div class="caption">小区基本信息</div>
			</div>
			<div class="portlet-body">
			<form:form id="inputForm" modelAttribute="communityInfo" action="" method="post" class="form-horizontal">
				<form:hidden path="id"/>
				<tags:message content="${message}"/>
				<div class="row-fluid">
					<div class="control-group">
						<div class="span6">
							<label class="control-label">名称:</label>
							<div class="controls">
								<form:input path="name" htmlEscape="false" maxlength="20" class="required"/>
								<span class="important">*</span>
							</div>
						</div>
						<div class="span6">
							<label class="control-label">小区编号:</label>
							<div class="controls">
								<form:input path="code" htmlEscape="false" maxlength="20" class="required"/>
								<span class="important">*</span>
							</div>
						</div>
					</div>
					<div class="control-group">
						<div class="span12">
							<label class="control-label">社区地址:</label>
							<div class="controls" id="addrDiv">
								<select class="prov input-medium" name="prov"></select>
								<select class="city input-medium" name="city" disabled="disabled"></select>
				        		<select class="dist input-medium" name="area" disabled="disabled"></select>
							</div>
						</div>
					</div>
					<div class="control-group">
						<div class="span12">
							<label class="control-label">街道信息:</label>
							<div class="controls" id="addrDiv">
								<form:input path="address" htmlEscape="false" class="required input-xxlarge" maxlength="30"/>
								<span class="important">*</span>
							</div>
						</div>
					</div>
					<div class="control-group">
						<div class="span8">
							<label class="control-label">经纬度:</label>
							<div class="controls">
								<form:input path="x" htmlEscape="false" maxlength="20" class="required" placeholder="经度"/>
								<span class="important">*</span>
								<form:input path="y" htmlEscape="false" maxlength="20" class="required" placeholder="纬度"/>
								<span class="important">*</span>
							</div>
						</div>
						<div class="span2">
							<div class="controls">
								<input type="button" name="openMap" id="openMap" value="地图" class="btn btn-info">
							</div>
						</div>
					</div>
					<div class="control-group">
						<div class="span6">
							<label class="control-label">小区面积:</label>
							<div class="controls">
								<form:input path="square" htmlEscape="false" maxlength="20" class="required"/>
								<span class="important">*</span>
							</div>
						</div>
					</div>
					<div class="control-group">
						<div class="span12">
							<label class="control-label">备注:</label>
							<div class="controls">
								<form:input path="remarks" htmlEscape="false" class="input-xxlarge" maxlength="80"/>
							</div>
						</div>
					</div>
					<div class="form-actions">
						<div class="span12">
							<shiro:hasPermission name="sys:communityInfo:edit"><input id="btnSubmit" class="btn btn-primary" type="button" value="保 存"/>&nbsp;</shiro:hasPermission>
							<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
						</div>
					</div>
				</div>
			</form:form>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="${ctxStatic }/city/jquery.cityselect.js"></script>
</body>
</html>
