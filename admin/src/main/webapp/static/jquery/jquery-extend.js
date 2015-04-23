/*
*jQuery 扩展方法
*/

jQuery.fn.extend({
	//初始化日期控件
	date:function(options){
		var def = {
				dateFmt:"yyyy-MM-dd HH:mm:ss",
				isShowClear:true
			}
		if(options!=undefined){
			$.extend(def,options);
			//显示格式化格式
			if(options.fmt!=null && options.fmt!=undefined && options.fmt==2){
				def.dateFmt = "yyyy-MM-dd";
			}
			//是否有最小日期
			if(options.minDate != undefined){
				//是否今天
				if(options.minDate == "today"){
					def.minDate = "%y-%M-%d %H:%m:%s";
				}else{
					//判断是否指定日期
					var onech = options.minDate.substring(0,1);
					if("#"==onech){
						//指定对象
						def.minDate = "#F{$dp.$D(\'"+options.minDate.substr(1)+"\')}"
					}else{
						//指定时间
						def.minDate = options.minDate;
					}
				}
			}
			//是否有最大日期
			if(options.maxDate != undefined){
				if(options.maxDate == "today"){
					def.maxDate = "%y-%M-%d %H:%m:%s";
				}else{
					def.maxDate = options.maxDate;
				}
			}
		}
		var _this = this;
		$(_this).attr("readonly",true);
		$(_this).addClass("Wdate");
		$(_this).click(function(){
			WdatePicker(def);
		});
	},
	form:function(url,success,error){
		var _this = this;
		if(error==undefined){
			error = function(){
				return false;
			}
		}
		if($(_this).valid()){
			top.$.jBox.tip("后台正在处理,请稍后....", 'loading');
			$.post(url,$(_this).serialize(),function(data){
				top.$.jBox.closeTip();
				if(data.result=="success"){
					top.$.jBox.tip(data.msg,"success",{closed:success});
				}else{
					top.$.jBox.tip(data.msg,"error",{closed:error});
				}
			});
		}else{
			top.$.jBox.tip("输入有误，请正确输入数据","error",{closed:function(){return false;}});
		}
	}
});

