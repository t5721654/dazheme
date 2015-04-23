/**
 * 全局JS方法,在页面初始化时候执行
 */
var isMozilla = /firefox/.test(navigator.userAgent.toLowerCase());
var isWebkit = /webkit/.test(navigator.userAgent.toLowerCase());
var isOpera = /opera/.test(navigator.userAgent.toLowerCase());
var isMsie = /msie/.test(navigator.userAgent.toLowerCase());
(function(){
})(jQuery);

// 引入js和css文件
function include(id, path, file){
	if (document.getElementById(id)==null){
        var files = typeof file == "string" ? [file] : file;
        for (var i = 0; i < files.length; i++){
            var name = files[i].replace(/^\s|\s$/g, "");
            var att = name.split('.');
            var ext = att[att.length - 1].toLowerCase();
            var isCSS = ext == "css";
            var tag = isCSS ? "link" : "script";
            var attr = isCSS ? " type='text/css' rel='stylesheet' " : " type='text/javascript' ";
            var link = (isCSS ? "href" : "src") + "='" + path + name + "'";
            document.write("<" + tag + (i==0?" id="+id:"") + attr + link + "></" + tag + ">");
        }
	}
}

// 打开一个窗体
function windowOpen(url, name, width, height){
	var top=parseInt((window.screen.height-height)/2,10),left=parseInt((window.screen.width-width)/2,10),
		options="location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,"+
		"resizable=yes,scrollbars=yes,"+"width="+width+",height="+height+",top="+top+",left="+left;
	window.open(url ,name , options);
}

// 显示加载框
function loading(mess){
	top.$.jBox.tip.mess = null;
	top.$.jBox.tip(mess,'loading',{opacity:0});
}

// 确认对话框
function confirmx(mess, href){
	top.$.jBox.confirm(mess,'系统提示',function(v,h,f){
		if(v=='ok'){
			loading('正在提交，请稍等...');
			location = href;
		}
	},{buttonsFocus:1});
	top.$('.jbox-body .jbox-icon').css('top','55px');
	return false;
}

/**
 * 显示提示信息
 * @param type:可选的参数为:success,error,alert,warning,information
 * @param callBack
 * @param message
 */
function showNote(type, callBack, message,layout) {
	if (type == "" || type == null) {
		type = "success";
	}
	if(layout==null || layout==""){
		layout = "center";
	}
	if (message == "" || message == null) {
		if (type == "success") {
			message = "操作成功!";
		} else {
			message = "操作失败!";
		}
	}
	noty({
		"text" : message,
		"layout" : layout,
		"type" : type,
		"onClose" : callBack
	});
}

//计算时间间隔，得出一个人性化的时间
function getDateDiff(date){
    if(!date)return false;
    var cstDiff=0;
    if(typeof(date)=="string"){
    	
    	if(date.toLowerCase().indexOf("cst")!=-1)cstDiff=14*60*60*1000;// 处理CST时间
    	date=date
    		.replace(/\-/ig,"/")
    		.replace(".0","");
    	date=new Date(date);
    }
    var diff=new Date().getTime()-date.getTime()+cstDiff;// 得出目标时间与当前时间的毫秒差
    var diffText="未知";// 初始化时间差表述文字
    var diffExt=(diff<0)?"后":"前";
    diff=Math.abs(diff);
    if(diff<60*1000)diffText = Math.round(diff/1000)+"秒";// 如果小于1分钟则返回秒数
    if(diff<60*60*1000&&diffText=="未知")diffText = Math.round(diff/1000/60)+"分钟";// 如果小于1小时则返回分钟数
    if(diff<60*60*24*1000&&diffText=="未知")diffText = Math.round(diff/1000/60/60)+"小时";// 如果小于1天则返回小时数
    if(diff<60*60*24*7*1000&&diffText=="未知")diffText = Math.round(diff/1000/60/60/24)+"天";// 如果小于7天则返回天数
    if(diff<60*60*24*30*1000&&diffText=="未知")diffText = Math.round(diff/1000/60/60/24/7)+"周";// 如果小于30天则返回周数
    if(diff<60*60*24*360*1000&&diffText=="未知")diffText = Math.round(diff/1000/60/60/24/30)+"个月";// 如果小于360天则返回月数
    if(diff>60*60*24*360*1000)diffText = Math.round(diff/1000/60/60/24/360)+"年";// 如果大于360天则返回年数
    
    return diffText+diffExt;
}
//判断两个日期相差天数
function dayDiff(from,to){
	from = format(from);
	to = format(to);
	return (to - from)/(1000*60*60*24);
	//格式化入参，让两个日期都自动转换为日期格式并把时间清为00:00:00
	function format(date){
		if(typeof(date)=="string")date = date.replace(/-/ig,"/");
		if(Object.prototype.toString.apply(date) != '[object Date]')date = new Date(date); 
		date = date.setHours(0,0,0,0);
		return new Date(date).getTime();
	}
}
//返回某年某月的天数
function daysInMonth(year, month) {  
    if (month == 1) {  
        if (year % 4 == 0 && year % 100 != 0)  
           return 29;  
       else  
             return 28;  
     } else if ((month <= 6 && month % 2 == 0) || (month = 6 && month % 2 == 1))  
         return 31;  
     else  
         return 30;  
 }
//当前日期减去num个月得到'yyyy-mm-01'的字符串 	归档查询使用	
function minusMonth(num) {  
  var time=new Date();
  var y = time.getFullYear();  
  var m = time.getMonth()+1;  
  var nextY = y;  
  var nextM = m;  
  if(m > num){  
      nextM = m - 6  
 }else{  
    nextY = y - 1;  
    nextM = m + 6  
  }
  var  date=""+nextY;
  if(nextM<10){
	  date=date+"-0"+(nextM);
  }else{
	  date=date+"-"+(nextM);  
  }
  date=date+"-01";
  return date;
}  

//比较时间差，返回差异的毫秒数
function dateDiff(time1,time2){
	var d1=new Date(time1).getTime();
	var d2=new Date(time2).getTime();
	return d2-d1;
}
//日期转换格式
function dateFormat(date,format)
{
	if(Object.prototype.toString.apply(date) != '[object Date]')date = new Date(date);
	var o = {
	"M+" : date.getMonth()+1, //month
	"d+" : date.getDate(),    //day
	"h+" : date.getHours(),   //hour
 	"m+" : date.getMinutes(), //minute
	"s+" : date.getSeconds(), //second
 	"q+" : Math.floor((date.getMonth()+3)/3),  //quarter
 	"S" : date.getMilliseconds() //millisecond
	};

    if(/(y+)/.test(format)) 
	  format=format.replace(RegExp.$1,(date.getFullYear()+"").substr(4 - RegExp.$1.length));   
    for(var k in o)if(new RegExp("("+ k +")").test(format))   
      format = format.replace(RegExp.$1,RegExp.$1.length==1 ? o[k] :("00"+ o[k]).substr((""+ o[k]).length));   
    return format;  
}
/**
 * 将URL请求转换为JS数组对象,获取方法为:reqeust("key");
 * @param paras
 * @returns
 */
function request(paras) {
	var url = location.href;
	var paraString = url.substring(url.indexOf("?") + 1, url.length).split("&");
	var paraObj = {};
	for (var i = 0; j = paraString[i]; i++) {
		paraObj[j.substring(0, j.indexOf("=")).toLowerCase()] = j.substring(j
				.indexOf("=") + 1, j.length);
	}
	var returnValue = paraObj[paras.toLowerCase()];
	if (typeof (returnValue) == "undefined") {
		return "";
	} else {
		return returnValue;
	}
}

function error(obj, msg, className) {
	if (!className) {
		className = "";
	}
	var dialog = "<span class='alert alert-error " + className
			+ "'><span class='close'>&times;</span>" + msg + "</span>";
	obj.html(dialog);
	obj.show();
}

//验证手机号码
var validateMobile = function(mobile){
	if(mobile!=""){
		var pattern = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]))+\d{8})$/;
		var len = mobile.length;
		return (len==11&&pattern.test(mobile));
	}else{
		return false;
	}
};
//验证电话
var validatePhone = function(phone){
	if(phone!=""){
		var pattern = /(^0[1-9]{1}\d{9,10}$)|(^1[3,5,8]\d{9}$)/g;
		var len = phone.length;
		return (pattern.test(phone));
	}else{
		return false;
	}
};
//获取站点根目录
function getRootPath(){
	var strFullPath=window.document.location.href;
    var strPath=window.document.location.pathname;
    var pos=strFullPath.indexOf(strPath);
    var prePath=strFullPath.substring(0,pos);
    var postPath=strPath.substring(0,strPath.substr(1).indexOf('/')+1);
    return(prePath);
}
//锁屏
var blockUI = function(el, centerY){
	var el = jQuery(el); 
	var imgUrl = getRootPath()+"/static/images/loading.gif";
    el.block({
            message: '<img src="'+imgUrl+'" align="">',
            centerY: centerY != undefined ? centerY : true,
            css: {
                top: '10%',
                border: 'none',
                padding: '2px',
                backgroundColor: 'none'
            },
            overlayCSS: {
                backgroundColor: '#000',
                opacity: 0.05,
                cursor: 'wait'
            }
        });
};
//解屏
var unblockUI = function(el){
	jQuery(el).unblock({
        onUnblock: function () {
            jQuery(el).removeAttr("style");
        }
    });
};

//目标窗体只允许输入数字
(function($) {
  $.fn.isNumber = function(setting){
    var $self=this;
    setting=setting||{};
    this.bind("keyup",function(){
    	var str=this.value;
    	if(isNaN(str))
        this.value=getNumber(str);
      if(setting.min&&this.value*1<setting.min)this.value=setting.min;
      if(setting.max&&this.value*1>setting.max)this.value=setting.max;
    })
    /*
	 * this.bind("input",function(){ var str=this.value;
	 * this.value=getNumber(str); });
	 */
    this.bind("focus",function(){
      this.select()||this.focus();
    })
    function getNumber(number){
    	 return number.replace(/[^\d.]/g,"").replace(/^\./g,"").replace(/\.{2,}/g,".").replace(".","$#$").replace(/\./g,"").replace("$#$",".");
    }
    return $self;
  }
})(jQuery);

//根据身份证信息计算年龄和出生年月,yyyy-MM-dd格式
var reckonBirth = function(cardNo){
	var year = cardNo.substr(6,4);
	var month = cardNo.substr(10,2);
	var day = cardNo.substr(12,2);
	var birth = year+"-"+month+"-"+day;
	return birth;
};

var reckonAge = function(birth){
	var today = new Date();
    var birthDate = new Date(birth);
    var age = today.getFullYear() - birthDate.getFullYear();
    var m = today.getMonth() - birthDate.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }
    return age;
};

/**
 * 模拟sleep方法
 * @returns
 */
var sleep = function(millis,callback){
	setTimeout(callback,millis);
};

//treeTable树切换
function treeTableTrtoggle(id){
	var visible = $("tr." + id).is(":visible");
	$("tr.active").removeClass("active");
	$("#"+id).addClass("active");
	if(visible){
		$("tr." + id).hide();
		$("#"+id).find("span.default_active_node").removeClass("default_open").addClass("default_last_shut");
	}else{
		$("tr." + id).show();
		$("#"+id).find("span.default_active_node").removeClass("default_last_shut").addClass("default_open");
	}
};
