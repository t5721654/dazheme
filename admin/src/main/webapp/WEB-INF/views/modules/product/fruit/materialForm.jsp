<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>素材管理</title>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/jquery/colorbox.css">
	<link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/jquery.fileupload.css">
	<link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/jquery.fileupload-ui.css">
	<noscript><link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/jquery.fileupload-noscript.css"></noscript>
	<noscript><link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/jquery.fileupload-ui-noscript.css"></noscript>
	<style type="text/css">
	.ztree li button.add {margin-left:5px;margin-right:-1px;height:20px;width:20px; vertical-align:top; *vertical-align:middle}
	</style>
</head>
<body>
	<div class="row-fluid">
		<div class="span3">
			<div class="portlet box dark">
				<div class="portlet-title">
					<div class="caption">素材种类</div>
				</div>
				<div class="portlet-body">
					<ul id="folderTree" class="ztree"></ul>
				</div>
			</div>
		</div>
		<div class="span9">
			<div class="portlet box dark">
				<div class="portlet-title">
					<div class="caption">素材信息</div>
				</div>
				<div class="portlet-body">
					<ul class="thumbnail gallery" style="height: 500px;">
						<li id="image-1" class="thumbnail">
							<a style="background:url(${ctxStatic}/images/bg1.jpg)" title="Sample Image 1" href="${ctxStatic}/images/bg1.jpg">
								<img class="small" src="${ctxStatic}/images/bg1.jpg" alt="Sample Image 1">
							</a>
						</li>
						<li id="image-1" class="thumbnail">
							<a style="background:url(${ctxStatic}/images/bg1.jpg)" title="Sample Image 1" href="img/gallery/1.jpg">
								<img class="small" src="${ctxStatic}/images/bg1.jpg" alt="Sample Image 1">
							</a>
						</li>
						<li id="image-1" class="thumbnail">
							<a style="background:url(${ctxStatic}/images/bg1.jpg)" title="Sample Image 1" href="img/gallery/1.jpg">
								<img class="small" src="${ctxStatic}/images/bg1.jpg" alt="Sample Image 1">
							</a>
						</li>
						<li id="image-1" class="thumbnail">
							<a style="background:url(${ctxStatic}/images/bg1.jpg)" title="Sample Image 1" href="img/gallery/1.jpg">
								<img class="small" src="${ctxStatic}/images/bg1.jpg" alt="Sample Image 1">
							</a>
						</li>	
						<li id="image-1" class="thumbnail">
							<a style="background:url(${ctxStatic}/images/bg1.jpg)" title="Sample Image 1" href="img/gallery/1.jpg">
								<img class="small" src="${ctxStatic}/images/bg1.jpg" alt="Sample Image 1">
							</a>
						</li>	
						<li id="image-1" class="thumbnail">
							<a style="background:url(${ctxStatic}/images/bg1.jpg)" title="Sample Image 1" href="img/gallery/1.jpg">
								<img class="small" src="${ctxStatic}/images/bg1.jpg" alt="Sample Image 1">
							</a>
						</li>						
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="modal hide fade in" id="addModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>分类目录名称</h3>
		</div>
		<div class="modal-body">
			<input type="text" name="folderName" id="folderName" class="input-large" style="margin-left: 5px;" placeholder="请输入节点名称" maxlength="10"/>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">关闭</a>
			<a href="#" class="btn btn-primary" id="addFolderBtn">确认</a>
		</div>
	</div>
	<script type="text/javascript" src="${ctxStatic }/jquery/jquery.colorbox.min.js"></script>
	<script type="text/javascript">
		var zNodes = ""; 
		$(document).ready(function() {
			var setting = {
				view: {
					addHoverDom: addHoverDom,
					removeHoverDom: removeHoverDom,
					selectedMulti: false
				},
				edit: {
					enable: true,
					editNameSelectAll: true
				},
				data: {
					simpleData: {
						enable: true
					}
				},
				callback: {
					beforeDrag: beforeDrag,
					beforeEditName: beforeEditName,
					beforeRemove: beforeRemove,
					beforeRename: beforeRename,
					onRemove: onRemove,
					onRename: onRename
				}
			};
			zNodes = '${folderJsonData}';
			zNodes = JSON.parse(zNodes);
			$.fn.zTree.init($("#folderTree"), setting, zNodes);
			$('.thumbnail a').colorbox({rel:'thumbnail a', transition:"elastic", maxWidth:"95%", maxHeight:"95%"});
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
		
		var log, className = "dark";
		function beforeDrag(treeId, treeNodes) {
			return false;
		}
		function beforeEditName(treeId, treeNode) {
			className = (className === "dark" ? "":"dark");
			var zTree = $.fn.zTree.getZTreeObj("folderTree");
			zTree.selectNode(treeNode);
			return confirm("编辑类目 -- " + treeNode.name + " 吗？");
		}
		function beforeRemove(treeId, treeNode) {
			className = (className === "dark" ? "":"dark");
			var zTree = $.fn.zTree.getZTreeObj("folderTree");
			zTree.selectNode(treeNode);
			return confirm("确认删除 类目 -- " + treeNode.name + " 吗？");
		}
		function onRemove(e, treeId, treeNode) {
			var url = "${ctx}/product/fruit/materialFolder/delete";
			$.post(url,{id:treeNode.id,"name":treeNode.name},function(data){
				if(data.result=="success"){
					top.$.jBox.tip(data.msg,"success",{closed:function(){return false;}});
				}
			})
		}
		function beforeRename(treeId, treeNode, newName) {
			className = (className === "dark" ? "":"dark");
			if (newName.length == 0) {
				alert("节点名称不能为空.");
				var zTree = $.fn.zTree.getZTreeObj("folderTree");
				setTimeout(function(){zTree.editName(treeNode)}, 10);
				return false;
			}
			return true;
		}
		function onRename(e, treeId, treeNode) {
			//提交更新数据
			var url = "${ctx}/product/fruit/materialFolder/save";
			$.post(url,{id:treeNode.id,"name":treeNode.name},function(data){
				if(data.result=="success"){
					top.$.jBox.tip(data.msg,"success",{closed:function(){return false;}});
				}
			})
		}

		var newCount = 1;
		function addHoverDom(treeId, treeNode) {
			var sObj = $("#" + treeNode.tId + "_span");
			if (treeNode.editNameFlag || $("#addBtn_"+treeNode.id).length>0) return;
			var addStr = "<span class='button add' id='addBtn_" + treeNode.id
				+ "' title='添加节点'></span>";
			sObj.append(addStr);
			var btn = $("#addBtn_"+treeNode.id);
			if (btn) btn.bind("click", function(){
				//添加节点
				$("#addModal").modal("show");
				$("#addFolderBtn").click(function(){
					var zTree = $.fn.zTree.getZTreeObj("folderTree");
					var folderName = $("#folderName").val();
					var parentId = treeNode.id;
					var url = "${ctx}/product/fruit/materialFolder/save";
					$.post(url,{"name":folderName,"parent.id":parentId},function(data){
						if(data.result=="success"){
							zTree.addNodes(treeNode, {id:data.nodeId, pId:treeNode.id, name:folderName});
							$("#addModal").modal("hide");
							return false;
						}else{
							top.$.jBox.tip(data.msg,"error",{closed:function(){return false;}});
						}
					});
				});
			});
		};
		function removeHoverDom(treeId, treeNode) {
			$("#addBtn_"+treeNode.id).unbind().remove();
		};
		function selectAll() {
			var zTree = $.fn.zTree.getZTreeObj("folderTree");
			zTree.setting.edit.editNameSelectAll =  $("#selectAll").attr("checked");
		}
		
	</script>
</body>
</html>
