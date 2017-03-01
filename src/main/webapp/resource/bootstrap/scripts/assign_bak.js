jQuery(document).ready(function() {
//	$("#chooseTemplate").modal("show");
		
    var caseTmpl ='<div  class="col-md-12 margin-top-10 segmentcontain"><div class="segmenttitle">Segment<span class="close">X</span></div><div class="col-md-12 margin-top-10"><label class="control-label"  style="padding-top:5px">Condition:</label><div class="input-group margin-left-10" style="display:inline-block"> <input class="form-control margin-left-10" style="width:410px; display:none" type="text" readonly placeholder="XPath"> <span class="input-group-btn"   data-target="none" style="display:none"> <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-remove"></i></button> </span><span class="input-group-btn  margin-left-10"   data-target="condition" style="display:inline-block; margin-left:50px"> <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-plus"></i></button> </span> </div></div><div class="col-md-12  margin-top-10"><label class="control-label"  style="padding-top:5px">Expression:</label><div class="input-group" style="display:inline-block"> <input  data-type="expression" class="form-control margin-left-10" style="width:410px" type="text" readonly placeholder="XPath"> <span class="input-group-btn"   data-target="variable" style="display:inline-block"> <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-pencil"></i></button> </span> </div><label class="control-label margin-left-10"  style="padding-top:5px">Variable:</label><input data-type="varitable" class="form-control margin-left-10" style="width:210px; display:inline-block" type="text"></div></div>';
	var caseTmp2 ='<div  class="col-md-12 margin-top-10 segmentcontain"><div class="segmenttitle">Segment<span class="close">X</span></div><div class="col-md-12  margin-top-10"><label class="control-label"  style="padding-top:5px">Expression:</label><div class="input-group" style="display:inline-block"> <input  data-type="expression" class="form-control margin-left-10" style="width:410px" type="text" readonly placeholder="XPath"  value="soapenv:Envelope/[node=tear]/itemvalue"> <span class="input-group-btn"   data-target="variable" style="display:inline-block"> <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-pencil"></i></button> </span> </div><label class="control-label margin-left-10"  style="padding-top:5px">Variable:</label><input data-type="varitable" class="form-control margin-left-10" style="width:210px; display:inline-block" type="text"  value="v2"></div></div>';
	var finalVariableList = [];

    $('body').on('click', '[data-add="case"]', function() {
      $('#transformMain').append(caseTmpl);
    })
	$('body').on('click', '[data-add="other"]', function() {
		if($('#othrssegment .segmentcontain').length<1){
           $('#othrssegment').append(caseTmp2);
		}
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
		
	$("#finalvariableModal").on('show.bs.modal', function () {
		$("#varilist>li").remove();
	})
	//弹框
	$(".input-group-btn").live('click',function(){
		$(".input-group-btn[data-modal='true']").removeAttr("data-modal");
		$(this).attr("data-modal","true");
		//$(".pathList").html($(".GooFlow_work_inner .baseversion").html());
		$(".pathList").height("350").parent().height("350");
		if($(this).attr("data-target")=="condition"){
			$("#pathModal").modal("show");
			$("#pathmain .pathList").html($(".GooFlow_work_inner .baseversion").html());
			$("#pathmain .pathList").find(".d-s").remove();
			}
		else if($(this).attr("data-target")=="variable"){
			$("#variableModal").modal("show");
			$("#pathmain2 .pathList").html($(".GooFlow_work_inner .baseversion").html());
			$("#pathmain2 .pathList").find(".d-s").remove();
			$("#variAE2").val($(this).prev("input").val());
			}
		else if($(this).attr("data-target")=="final"){
			$("#finalvariableModal").modal("show");
			$("#finalvariablevalue").val($(".input-group-btn[data-modal='true']").prev("input").val())
			}
		else if($(this).attr("data-target")=="none"){
			$(this).siblings("input").css("display","none").val("");
			$(this).hide();
			}
		})
	//condition path节点获取
	var nodepath,nodedesid;
	$("#pathmain .pathList li").live("click",function(){
		nodepath=$(this).attr("path");
		nodedesid=$(this).attr("nodedescid");
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
			var thistext=$("#nodeOperand").val()+$("#nodeOperator").val()+$("#nodeValue").val();
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
           	thistext+=$(this).attr("atr")+" ";
        });
		if(thistext!=""){
			$(".input-group-btn[data-modal='true']").siblings("input").css("display","block").val(thistext).siblings("span[data-target='none']").css("display","inline-block");	
		}
		})
	
	//variable 变量节点方法和操作
	
	var varipath,variname
	$("#pathmain2 .pathList li").live("click",function(){
		$("#pathmain2 li.act").removeClass("act");
		$(this).addClass("act");
		varipath=$(this).attr("path");
		variname=$(this).attr("name");
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
				text=ec1+variname+ec2;
				}
			else{
				text=text.substring(variablestart,variableend)
				text=$("#variAE2").val().replace(text,variname);
				}
			$("#variAE2").val(text);
			}
		
		})
	//variable OK
	$("#variOk").live('click',function(){
		$("#variableModal").modal("hide"); 
		var text=$("#variAE2").val();
		$(".input-group-btn[data-modal='true']").prev("input").val(text);
		$(".input-group-btn[data-modal='true']").parent().siblings("input").val(variname);
		var varitext="$"+$("#transformMain input[data-type='varitable']").eq(0).val();
		for(i=1;i<$("#transformMain input[data-type='varitable']").length;i++){
			varitext+=","+"&"+$("#transformMain input[data-type='varitable']").eq(i).val()
		}
		$("#FinalValpress input").val("$.conact("+varitext+")");
		
		var conditionInfo = {};
		conditionInfo.expression = $(".input-group-btn[data-modal='true']").prev("input").val();
		conditionInfo.variname = variname;
		conditionInfo.condition = $(".input-group-btn[data-modal='true']").prev("input[type=text]").val();
		finalVariableList.push(conditionInfo);
	})
	
	$("#variAE2 input").live('click',function(){
		$(this).addClass("cur").siblings("input").removeClass("cur")
	});
	
	
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
	//function点击	
	$("ul.functionOp li").click(function(){
		var fun=$(this).attr("type");
		var target=$(this).parent().attr("function-target");
		$("#"+target).val(xqueryFunction($("#"+target).val(),fun));
		})
	//function实例
	function xqueryFunction(str,fun){
		var funStr;
		if(str==""){
			str="value"
			}
		if(fun=="conact"){
			funStr="$conact("+str+",value2,...)";
			}
		else if(fun=="substring"){
			funStr="$substring("+str+",beginIndex, endIndex)";
			}
		else if(fun=="lower"){
			funStr="$lower("+str+")";
			}
		else if(fun=="upper"){
			funStr="$upper("+str+")";
			}
		return funStr;
		}
  });