<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
  <head>
    <title>地图</title>
	<meta name="decorator" content="default"/>
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<style type="text/css">
		html{
			height:100%;
		}
		body{height:100%;margin:0px;padding:0px;background-color: #fff;}
		#container{height:383px;}
	</style>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=IplHC5ojOIjZevY4k7pu0KaQ"></script>
  </head>
  
  <body>
  <div style="padding-top: 2px;">
  	<input type="text" id="keyword" name="keyword" placeholder="请输入地点查询" style="margin-bottom: 2px;margin-left: 4px;">
  	<div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
  </div>
  <div id="container"></div>
  <div>
  	<input type="hidden" name="currentx" id="currentx">
  	<input type="hidden" name="currenty" id="currenty">
  </div>
  <script type="text/javascript">
     var map = null;  
	 $(document).ready(function(){
		map = new BMap.Map("container");          // 创建地图实例
		//根据IP定位当前的城市
		var myCity　= new BMap.LocalCity();
		myCity.get(myFun);
		map.addControl(new BMap.NavigationControl()); //平移缩放控件
		map.addControl(new BMap.MapTypeControl());//地图类型控件
		map.addControl(new BMap.ScaleControl());//比例尺控件
		map.addControl(new BMap.OverviewMapControl());//地图
		map.enableScrollWheelZoom(true); //启动鼠标滚轮
		map.addEventListener("load",function(e){
			var centerPoint = map.getBounds().getCenter();
			var marker = new BMap.Marker(centerPoint);
			marker.enableDragging();//启动拖动功能
			$("#currentx").val(centerPoint.lng);
			$("#currenty").val(centerPoint.lat);
			marker.addEventListener("dragend",function(type){
				$("#currentx").val(type.point.lng);
				$("#currenty").val(type.point.lat);
			});
			map.addOverlay(marker);
		});
		
		
		//关键字提示
		var ac = new BMap.Autocomplete({
			"input" : "keyword",
			"location" : map
		});
		ac.addEventListener("onhighlight",function(e){
			var str = "";
			var _value = e.fromitem.value;
			var value = "";
			if (e.fromitem.index > -1) {
				value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
			}    
			str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;
			
			value = "";
			if (e.toitem.index > -1) {
				_value = e.toitem.value;
				value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
			}    
			str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
			$("#searchResultPanel").innerHTML = str;
		});
		ac.addEventListener("onconfirm",function(e){
			var _value = e.item.value;
			myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
			$("#searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
			setPlace();
		});
		
		//获取当前地图的中心点，并打上标记
	 });
	
	//根据城市定位
	function myFun(result){
		var cityName = result.name;
		map.centerAndZoom(cityName,13);
	}
	
	//定位选中的关键字
	function setPlace(){
		map.clearOverlays();    //清除地图上所有覆盖物
		function myFun(){
			var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
			map.centerAndZoom(pp, 18);
			map.addOverlay(new BMap.Marker(pp));    //添加标注
		}
		var local = new BMap.LocalSearch(map, { //智能搜索
		  onSearchComplete: myFun
		});
		local.search(myValue);
	}
  </script>
  </body>
</html>
