var caseTmpl ='<div  class="col-md-12 margin-top-10 segmentcontain" data-type="segment">'+
    	'<div class="segmenttitle">segment<span class="close">X</span></div>'+
    	'<div class="col-md-12 margin-top-10"><label class="control-label">condition</label>'+
    	'<div class="input-group" style="display:inline-block"> '+
    	'<input class="form-control" data-type="condition" style="width:410px; display:none" type="text" readonly placeholder="XPath">'+
    	'<span class="input-group-btn"   data-target="none" style="display:none"> <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-remove"></i></button> </span>'+
    	'<span class="input-group-btn"   data-target="condition" style="display:inline-block;"> <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-plus"></i></button> </span> </div></div>'+
    	'<div class="col-md-12  margin-top-10"><label class="control-label"><span class="red">*</span>condition</label><div class="input-group" style="display:inline-block"> '+
    	'<input  data-type="expression" class="form-control" style="width:410px" type="text" readonly placeholder="XPath"> <span class="input-group-btn"   data-target="variable" style="display:inline-block">'+
    	'<button class="btn btn-default" type="button"><i class="glyphicon glyphicon-pencil"></i></button> </span> </div><label class="control-label"><span class="red">*</span>Variable:</label><input data-type="varitable" class="form-control" style="width:210px; display:inline-block" type="text"></div></div>';

//默认有一个条件
addSegment();

function clearCondition() {
	$("#asignfix2 div[class='col-md-12 margin-top-10 segmentcontain']").remove();
	$("#FinalValpress input[type='text']").val("");
	$("#globalCondition").css("display","none").val("").siblings("span[data-target='none']").css("display","none").parent().find("i").addClass("glyphicon-plus").removeClass("glyphicon-pencil").next().css("display","none");
	addSegment();
	$("#asignfix2 .emptyvalidate").removeClass("emptyvalidate");
}

function addSegment() {
	var segmentdom=$(caseTmpl).get(0);
	var segmentjq=$(segmentdom);
	var id = Math.uuid();
	segmentjq.find("input[data-type='condition']").val()
	segmentjq.find("input[data-type='expression']").val()
	segmentjq.find("input[data-type='varitable']").val()
	segmentjq.attr("id",id)
	$('#transformMain').append(segmentjq);
}

function fillCaseSegment(contExp) {
	if(isEmpty(contExp)) {
		return;
	}
	if(!isEmpty(contExp.finalValue)) {
		$('#FinalValpress input[type=text]').val(contExp.finalValue);
	}
	if(!isEmpty(contExp.globalCondition)) {
		$("#globalCondition").css("display","block").val(contExp.globalCondition).siblings("span[data-target='none']").css("display","inline-block");
		$("#globalCondition").parent().find("i").addClass("glyphicon-pencil").removeClass("glyphicon-plus");
	}
	if(!isEmpty(contExp.condition) && contExp.condition.length > 0) {
		$("#asignfix2 div[class='col-md-12 margin-top-10 segmentcontain']").remove();
		for(var i=0; i<contExp.condition.length; i++) {
			var cont = contExp.condition[i];
			var segmentdom=$(caseTmpl).get(0);
			var segmentjq=$(segmentdom);
			var id = Math.uuid();
			if(!isEmpty(cont.condition)) {
				segmentjq.find("input[data-type='condition']").css("display","block").val(cont.condition).siblings("span[data-target='none']").css("display","inline-block");
				segmentjq.find("input[data-type='condition']").parent().find("i").addClass("glyphicon-pencil").removeClass("glyphicon-plus");
			}
			segmentjq.find("input[data-type='expression']").val(cont.expression);
			segmentjq.find("input[data-type='varitable']").val(cont.variable);
			segmentjq.attr("id",id)
			$('#transformMain').append(segmentjq);
		}
	} else {
		$("#asignfix2 div[class='col-md-12 margin-top-10 segmentcontain']").remove();
	}
}

function emptyValidate(){
	var result=true;
	$("#transformMain input[data-type='varitable']").each(function(index, element) {
        if($(this).val()==""){
			$(this).addClass("emptyvalidate").attr("placeholder","the variable must not be null");
			result=false;
			}
		else{
			$(this).removeClass("emptyvalidate");
			}
    });
	$("#transformMain input[data-type='expression']").each(function(index, element) {
        if($(this).val()==""){
			$(this).addClass("emptyvalidate").attr("placeholder","the expression must not be null");
			result=false;
			}
		else{
			$(this).removeClass("emptyvalidate");
			}
    });
	if($("#FinalValpress input.form-control").val()==""){
		$("#FinalValpress input.form-control").addClass("emptyvalidate").attr("placeholder","the final value must not be null");
		result=false;
		}
	else{
		$("#FinalValpress input.form-control").removeClass("emptyvalidate");
		}
	return result;
}


jQuery(document).ready(function() {
	// var caseTmp2 ='<div id="othersegmentnode"  class="col-md-12 margin-top-10 segmentcontain"><div class="segmenttitle">Segment<span class="close">X</span></div><div class="col-md-12  margin-top-10"><label class="control-label"  style="padding-top:5px">Expression:</label><div class="input-group" style="display:inline-block"> <input  data-type="expression" class="form-control margin-left-10" style="width:410px" type="text" readonly placeholder="XPath"  value="soapenv:Envelope/[node=tear]/itemvalue"> <span class="input-group-btn"   data-target="variable" style="display:inline-block"> <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-pencil"></i></button> </span> </div><label class="control-label margin-left-10"  style="padding-top:5px">Variable:</label><input data-type="varitable" class="form-control margin-left-10" style="width:210px; display:inline-block" type="text"  value="v2"></div></div>';
	$('#asignfix2 input[data-dismiss="modal"]').on("click", function(){
		if($("#chooseTemplate li[class='active'] a").attr("href") == '#asignfix2') {
			clearCondition();
		};
	});
	
	$('#chooseTemplate button[data-dismiss="modal"]').on("click", function(){
		if($("#chooseTemplate li[class='active'] a").attr("href") == '#asignfix2') {
			clearCondition();
		};
	});
	
    $('body').on('click', '[data-add="case"]', function() {
    	addSegment();
    })
	$(".segmentcontain .close").live("click",function(){
		$(this).closest(".segmentcontain").remove();
		})
    $('body').on('click', '[data-delete="case"]', function() {
      if($('#builder-basic').children('dl').size()>1){
        $(this).closest('dl').remove();
      }
    })
    $('body').on('click', '[data-add="rule"]', function() {
      $(this).closest('.rules-group-container').find('dl').before(ruleTmpl)
    })
    $('body').on('click', '[data-delete="rule"]', function() {
       $(this).closest('li').remove();
    })
	$("b.add").click(function(){
		$("#valueadaper").show();
		})
	//弹框
	alert("er")
	$("body").delegate('.input-group-btn','click',function(){
		alert("er")
		$(".input-group-btn[data-modal='true']").removeAttr("data-modal");
		$(this).attr("data-modal","true");
		//$(".pathList").html($(".GooFlow_work_inner .baseversion").html());
		$(".pathList").height("310").parent().height("310");
		if($(this).attr("data-target")=="condition"){
			$("#pathModal").modal("show");
			$("#conditionAE").html("");
			$("#pathmain .pathList").html($(".GooFlow_work_inner .baseversion").html());
			$("#pathmain .head span:not('.title')").remove();
			$("#pathmain .pathList").find(".d-s").remove();
			var textc=$(this).prevAll("input").val();
			var textc=textc.replace(/ and /g,"*-*and*-*");
			var textc=textc.replace(/ or /g,"*-*or*-*");
			var textarray=textc.split("*-*")
			for(i=0;i<textarray.length;i++){
				if(textarray[i]=="or"){
					var domtext="<p atr='or'>or</p>"
					
					}
				else if(textarray[i]=="and"){
					var domtext="<p atr='and'>and</p>"
					}
				else if(textarray[i]!=""){
					var domtext="<p desid='undefine' atr=\""+textarray[i]+"\">"+textarray[i]+"</p>"
					}
				$("#conditionAE").append(domtext)
				}
			}
		else if($(this).attr("data-target")=="variable"){
			$("#variableModal").modal("show");
			$("#pathmain2 .pathList").html($(".GooFlow_work_inner .baseversion").html());
			$("#pathmain2 .head span:not('.title')").remove();
			$("#pathmain2 .pathList").find(".d-s").remove();
			$("#variAE2").val($(this).prev("input").val());
			}
		else if($(this).attr("data-target")=="variableFun"){
			$("#variableModal").modal("show");
			}
		else if($(this).attr("data-target")=="variable2"){
			$("#variableModal").modal("show");
			$("#pathmain2 .pathList").html($(".GooFlow_work_inner .baseversion").html());
			var text='<ul id="baseVersion1" class="l"><div class="head" style="background: rgb(255, 140, 0) none repeat scroll 0% 0%;"><span tip="Field" class="title">Field</span></div><li nodePath="Field.Value" class="child "><span class="d-t"><em style="margin-left:15px">Field.Value</em></span><div class="tips">Field.Value</div></li><li  nodePath="Field.Name" class="child "><span class="d-t"><em style="margin-left:15px">Field.Name</em></span><div class="tips">Field.Name</div></li></ul>';
			$("#pathmain2 .pathList").prepend(text);
			$("#pathmain2 .head span:not('.title')").remove();
			$("#pathmain2 .pathList").find(".d-s").remove();
			$("#variAE2").val($(this).prev("input").val());
			}
		else if($(this).attr("data-target")=="final"){
			resetVariable();
			$("#finalvariableModal").modal("show");
			$("#finalvariablevalue").val($(".input-group-btn[data-modal='true']").prev("input").val())
			}
		else if($(this).attr("data-target")=="none"){
			$(this).siblings("input").css("display","none").val("");
			$(this).hide().siblings(".input-group-btn").find("i").removeClass("glyphicon-pencil").addClass("glyphicon-plus");
		}
		else if($(this).attr("data-target")=="sourcelist"){
			$("#itemNodeop").modal("show");
		}
		})
	//condition path节点获取
	var nodepath,nodedesid;
    var nodeLocal;
	$("#pathmain .pathList li").live("click",function(){
		nodepath=$(this).attr("nodePath");
		nodeLocal=$(this).attr("nodeLocal");
		nodedesid=$(this).attr("nodedescid");
		if(nodeLocal && nodepath) {
			if(nodeLocal == "1") {
				nodepath = "$HEADER:"+nodepath;
			} else if(nodeLocal == "2") {
				nodepath = "$BODY:"+nodepath;
			} else if(nodeLocal == "4") {
				nodepath = "$URL:"+nodepath;
			} else if(nodeLocal == "7") {
				nodepath = "$ATTR:"+nodepath;
			}
		}
		if($("#nodeOperand").val()==""){
			$("#nodeOperand").val(nodepath)
			}
		else{
			var text=$("#nodeOperand").val();
			
			if(typeof(variablestart) == "undefined"){
				variablestart=$("#nodeOperand").val().length;
				variableend=$("#nodeOperand").val().length;
				}
			if(variablestart==variableend){
				var ec1=text.substring(0,variablestart)
				var ec2=text.substring(variablestart)
				text=ec1+nodepath+ec2;
				}
			else{
				text=text.substring(variablestart,variableend)
				text=$("#nodeOperand").val().replace(text,nodepath);
				}
			$("#nodeOperand").val(text);
			}
		})
	//condition增加和更新操作
	$("#nodeAdd").click(function(){
		if($("#nodeOperand").val()!=""){
			var thistext=$("#nodeOperand").val()+" "+$("#nodeOperator").val()+" "+$("#nodeValue").val();
			if($("#conditionAE p").length>0){
				$("#conditionAE").append('<p  atr="'+$("input[name='conjunction']:checked").val()+'">'+$("input[name='conjunction']:checked").val()+'</p>');
				$("#conditionAE").append('<p desid='+nodedesid+' atr="'+thistext+'">'+thistext+'</p>');
				}
			else{$("#conditionAE").append('<p desid='+nodedesid+'  atr="'+thistext+'">'+thistext+'</p>');}
		}
		})
	$("#nodeUpdate").click(function(){
		$("#conditionAE").append('<p desid='+nodedesid+'>'+$("#nodeOperand").val()+$("#nodeOperator").val()+$("#nodeValue").val()+'</p>');
		})	
	//condition条件结果清除修改
	$("#clearCondition").click(function(){
		$("#conditionAE").html("");	
		})
	//condition 单条删除
	$("#deleteCondition").click(function(){
		if($("#conditionAE p.cur").index()<1){
			$("#conditionAE p.cur").next().remove();
			$("#conditionAE p.cur").remove();
			}
		else{
			$("#conditionAE p.cur").prev("p").remove();
			$("#conditionAE p.cur").remove();
			}
		$(this).css("visibility","hidden");
		})
	$("#conditionAE p[desid]").live("click",function(){
		$("#conditionAE p.cur").removeClass("cur");
		$(this).addClass('cur');
		$("#deleteCondition").css("visibility","visible");
		})
	//condition提交	
	$("#conditionOk").live('click',function(){
		$("#pathModal").modal("hide");
		var thistext="";
		$("#conditionAE p").each(function(index, element){
           	thistext+=$(this).html()+" ";
        });
		thistext=thistext.replace(new RegExp("&gt;",'gm'),">");
		thistext=thistext.replace(new RegExp("&lt;",'gm'),"<")
		if(thistext!=""){
			$(".input-group-btn[data-modal='true']").siblings("input").css("display","block").val(thistext).siblings("span[data-target='none']").css("display","inline-block");	
			$(".input-group-btn[data-modal='true']").find("i").addClass("glyphicon-pencil").removeClass("glyphicon-plus");
		}
		clearconditionModel();
	});
	
	function clearconditionModel(){
		$("#nodeOperand").val("")
		$("#nodeValue").val("")
	}
	
	//variable 变量节点方法和操作
	
	var varipath,variname,varilocal;
	$("#pathmain2 .pathList li").live("click",function(){
		$("#pathmain2 li.act").removeClass("act");
		$(this).addClass("act");
		varipath=$(this).attr("nodePath");
		variname=$(this).attr("name");
		varilocal=$(this).attr("nodeLocal");
		if(varilocal && varipath) {
			if(varilocal == "1") {
				varipath = "$HEADER:"+varipath;
			} else if(varilocal == "2") {
				varipath = "$BODY:"+varipath;
			} else if(varilocal == "4") {
				varipath = "$URL:"+varipath;
			} else if(varilocal == "7") {
				varipath = "$ATTR:"+varipath;
			}
		}
		if($("#variAE2").val()==""){
			$("#variAE2").val(varipath)
			}
		else{
			var text=$("#variAE2").val();
			
			if(typeof(variablestart) == "undefined"){
				variablestart=$("#variAE2").val().length;
				variableend=$("#variAE2").val().length;
				}
			if(variablestart==variableend){
				var ec1=text.substring(0,variablestart)
				var ec2=text.substring(variablestart)
				text=ec1+varipath+ec2;
				}
			else{
				text=text.substring(variablestart,variableend)
				text=$("#variAE2").val().replace(text,varipath);
				}
			$("#variAE2").val(text);
			}
		
		})
	//variable OK	
	$("#variOk").live('click',function(){
		$("#variableModal").modal("hide"); 
		var text=$("#variAE2").val();
		$(".input-group-btn[data-modal='true']").prev("input").val(text);
		if($(".input-group-btn[data-modal='true']").parent().siblings("input").val()==""){
			$(".input-group-btn[data-modal='true']").parent().siblings("input").val(variname);
			var varitext=$("#transformMain input[data-type='varitable']").eq(0).val();
			}
		resetVariable();
	})
	
	$("#variAE2 input").live('click',function(){
		$(this).addClass("cur").siblings("input").removeClass("cur")
		})
	
	
	//finalval  最终结果变量调整
	$("#varilist li").live("click",function(){
		var thisvariable=$(this).html();
		var text=$("#finalvariablevalue").val();
		if(variablestart==variableend){
			//text=text.replace(,)
			var ec1=text.substring(0,variablestart)
			var ec2=text.substring(variablestart)
			text=ec1+thisvariable+ec2;
			$("#finalvariablevalue").val(text);
			}
		else{
			text=text.substring(variablestart,variableend)
			text=$("#finalvariablevalue").val().replace(text,thisvariable);
			$("#finalvariablevalue").val(text);
			}
		})
		
	function resetVariable(){
		$("#varilist>li").remove();
		var variArray = [];
		$("#transformMain input[data-type=varitable]").each(function(){
			if($(this).val() == null || $(this).val() == "") {
				return;
			}
			var con = false;
			for(var i=0; i<variArray.length; i++) {
				if(variArray[i] == "$"+$(this).val()) {
					con = true;
				}
			}
			if(!con) {
				variArray.push("$"+$(this).val());
				$("#varilist").append("<li>$"+$(this).val()+"</li>");
				//$("#FinalValpress input").val("fn:conact("+variArray.join(",")+")");
			}
		});
	};
	
	$(".itemnodelist ul li").live("click",function(){
		$(this).addClass("cur").siblings().removeClass("cur");
		})
	$("#itemNLmiddle span.itemoperatebtn").live("click",function(){
		if($(this).attr("optype")=="add"){$("#itemNLright ul").append($("#itemNLleft ul li.cur").removeClass("cur").remove())}
		else if($(this).attr("optype")=="remove"){$("#itemNLleft ul").append($("#itemNLright ul li.cur").removeClass("cur").remove())}
		else if($(this).attr("optype")=="addall"){$("#itemNLright ul").append($("#itemNLleft ul li").removeClass("cur").remove())}
		else if($(this).attr("optype")=="removeall"){$("#itemNLleft ul").append($("#itemNLright ul li").removeClass("cur").remove())}
		})
	$("#nodenameOk").live("click",function(){
		var text="";
		$("#itemNLright ul li").each(function(index, element) {
			if($(this).index()==0){text+=$(this).html()}
            else{text+=","+$(this).html()}
        });
		
		$(".input-group-btn[data-modal='true']").siblings("input").val(text);	
	})
	
	$("#finalOk").live('click',function(){
		$("#finalvariableModal").modal("hide"); 
		var text=$("#finalvariablevalue").val();
		$("#FinalValpress input").val(text);
		})	
	//文本框点位位置获取
	var variablestart,variableend
	$("textarea[type='data-area']").live('mouseup',function(e){
		var thisid=$(this).attr("id");
		variablestart=document.getElementById(thisid).selectionStart;
		variableend=document.getElementById(thisid).selectionEnd;
		})
	$("textarea[type='data-area']").live('change',function(e){
		var thisid=$(this).attr("id");
		variablestart=document.getElementById(thisid).selectionStart;
		variableend=document.getElementById(thisid).selectionEnd;
		})
	//function点击	
	$("ul.functionOp li").live("click",function(){
		var fun=$(this).attr("type");
		var target=$(this).parent().attr("function-target");
		$("#"+target).val(xqueryFunction($("#"+target).val(),fun));
	})
	//设置最终变量初始化
	function setFinalVariable(){
		var variarray=[];
		$("#varilist").empty();
		for(i=0;i<$("#transformMain input[data-type='varitable']").length;i++){
			variarray.push($("#transformMain input[data-type='varitable']").eq(i).val())
			$("#varilist").append("<li>"+$("#transformMain input[data-type='varitable']").eq(i).val()+"</li>")
		}
		$("#FinalValpress input").val("fn:conact("+variarray.join(",")+")");
	}
	//单个变量调整同步最终变量
	$("#transformMain input[data-type='varitable']").live("change",function(){
		if(!isEmpty($(this).val())) {
			$(this).removeClass("emptyvalidate");
		}
	});
	//配置涵数列表
	function setFunction(){
		$.ajax({
			type: "POST",
			async:true,
		    url: "../newadapter/getFunctionList.shtml",
		    dataType:'json',
			success:function(msg){
				 if('success' == msg.code){
					 $("ul.functionOp").empty();
					 var functionObj = msg.result;
					 if(functionObj && functionObj.functionList) {
						 funList = functionObj.functionList;
						 $.each(functionObj.functionList, function(){
							 var funItem = this;
							 $("ul.functionOp").append("<li type='"+funItem.name+"'>fn:"+funItem.name+"</li>");
						 })
					 }
				 }else{
					 alert(dataDoerror);
				 }
            }
       });
	}
	var funList = null;
	setFunction();
	//function实例
	function xqueryFunction(str,fun){
		var funStr = "";
		if(str==""){
			str="value"
			}
		if(funList) {
			$.each(funList, function(){
				var funItem = this;
				if(fun==funItem.name) {
					funStr += "fn:"+fun+"(";
					$.each(funItem.paramDetail, function(){
						var paramItem = this;
						if(funStr.charAt(funStr.length-1) != "(") {
							funStr += ",";
						}
						if(paramItem.isMulti && paramItem.isMulti == true) {
							if(paramItem.dataType == "union") {
								if(paramItem.paramName && paramItem.paramName.length > 0) {
									$.each(paramItem.paramName, function(){
										var paramChildItem = this;
										funStr += paramChildItem.paramName+"1,";
									});
									$.each(paramItem.paramName, function(){
										var paramChildItem = this;
										funStr += paramChildItem.paramName+"2,";
									});
									funStr += "..."
								}
							} else {
								funStr += str +","+paramItem.paramName+"2,...";
							}
						} else {
							if(paramItem.paramName=="str" || paramItem.paramName=="defaultResult") {
								funStr += str;
							} else {
								funStr += paramItem.paramName;
							}
						}
					});
					funStr += ")";
					return;
				}
			});
		}
		return funStr;
	}
	function clearModel(){
		$("#nodeOperand").val("")
		$("#nodeValue").val("")
	}
	$(".stolist ul.l .head").live("click",function(){	
		$(this).parent().toggleClass("contract");
		$(this).find(".title").toggleClass("t");
	});
  });