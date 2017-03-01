// JavaScript Document
	function isIE() {
 	if (!!window.ActiveXObject || "ActiveXObject" in window)  
      return true;  
  	else  
      return false;  
	}
	var oXMLDoc=null;
	var oXSLDoc=null;
	var xmlNode=null;
	var sOriCanvas="";
	
	var loadXMLFile = function (xmlFile) { 
        var xmlDoc; 
        if (window.ActiveXObject) { 
            xmlDoc = new ActiveXObject('Microsoft.XMLDOM');//IE浏览器 
            xmlDoc.async = false; 
            xmlDoc.loadXML(xmlFile); 
        } 
        else if (isFirefox=navigator.userAgent.indexOf("Firefox")>0) { //火狐浏览器 
            xmlDoc = document.implementation.createDocument('', '', null); 
			xmlDoc.async = false; 
            xmlDoc.loadXML(xmlFile); 
        } 
        else{ //谷歌浏览器 
          var xmlhttp = new window.XMLHttpRequest(); 
            xmlhttp.open("GET",xmlFile,false); 
            xmlhttp.send(null); 
            if(xmlhttp.readyState == 4){ 
            xmlDoc = xmlhttp.responseXML.documentElement; 
            }  
        } 
        return xmlDoc; 
    }
		var loadXMLStr = function (xmlFile) { 
            var xmlStr; 
            if (isIE()) { 
                xmlStr = new ActiveXObject('Microsoft.XMLDOM');
                xmlStr.async = false; 
                xmlStr.loadXML(xmlFile); 
            } 
            else {  
                parser=new DOMParser();
                xmlStr=parser.parseFromString(xmlFile,"text/xml");
            } 
            return xmlStr; 
        }  
		var loadXMLsNode=function(Xpath,xmlOdc){
			var XMLNode;
			if (isIE()) {
			//	XMLNode = xmlOdc.selectNodes(Xpath)[0];
			   }
			else{
				XMLNode = xmlOdc.evaluate(Xpath, xmlOdc, null, XPathResult.ANY_TYPE, null);
				XMLNode =XMLNode.iterateNext();
				}
			return XMLNode;
		}
		var loadXMLNode=function(Xpath,xmlOdc){
			var XMLNode;
			if (isIE()) {
				//XMLNode = xmlOdc.selectNodes(Xpath);
			   }
			else{
				XMLNode = xmlOdc.evaluate(Xpath, xmlOdc, null, XPathResult.ANY_TYPE, null);
				}
			return XMLNode;
		}
		var loadTransformNode=function(xmlDoc, xslDoc)
		{
    		if (null==xmlDoc)    return "";
   		 	if (null==xslDoc)    return "";
    		if (isIE())    // IE
    			{
        		return xmlDoc.transformNode(xslDoc);
    			}
    		else  
    			{
        		var xsltProcessor=new XSLTProcessor();
        		xsltProcessor.importStylesheet(xslDoc);
        		var result=xsltProcessor.transformToDocument(xmlDoc);
        		var xmls=new XMLSerializer();
       		 	var rt = xmls.serializeToString(result);
        		return rt;
    			}
		}

		function getAttributeValue(xmlNode,name){
		if(xmlNode.getAttribute(name)!=null)
			return  xmlNode.getAttribute(name);
		else
			return '';
		}
		
var oJSONDoc = "";
var finalStr = {
    "process": {"processId":""},
    "lines": {},
    "nodes": {}
};
var processId = "";
 
var pathTaskConfJson = JSON.parse('[]');
var pathDetJson = JSON.parse('[]');
var pathAutoExecuteMethodJson = JSON.parse('[]');
var opActMod = null;
var nextTacheJson = null;
var flowIdPage = "";
var fPropertyChange = false;
var FlowCountryMidJson = null;
var beginNodeId = "";
var sOriCanvas = "";

(function($) {

    function init() {  
        $("#group1").html("");
        $("#group1").append(initSvg("drawsvg", $("#group1").width(), $("#group1").height()));
    };
    $.fn.messagesport = function(option) {
        // console.log("fn.messagesport");
        var defaulto = {
            startposition: [],
            fromid: "", //起点id
            toid: "", //终点id
            istemp: 0, //是否是临时线
            idindex: 0, //节点数索引
            isdrag: 0,
            mouseX: 0,
            mouseY: 0,
            currid: "",
            lineself: 0,
            optype: "move",
            targetId: this.attr("id"), //操作区id
            arear: this.find("#group1"), //操作区
        };
        var opt = $.extend({}, defaulto, option);
        init();
        //查看
        var status= $('#status').val();
        var statusUp = $('#statusUp').val();
        if(status=='B'){
        	$('#saveProecss').hide();//tacheOk  routeOk
        	$('.savebtn').hide();
        	
        }else if(status=='D'){
        	if(statusUp=='E'||statusUp=='F'){
        		$('#saveProecss').show();
            	$('.savebtn').show();
        	}else{
        		$('#saveProecss').hide();//tacheOk  routeOk
            	$('.savebtn').hide();
            	
        	}
        }else if(status=='A'||status=='C'||status=='G'){
        	$('#saveProecss').show();
        	$('.savebtn').show();
        }
		laodData();
        this.curid = "";
        this.delegate(".page-sidebar-menu li", "mousedown", function(e) {
            $(this).addClass("checked").siblings().removeClass("checked");
			opt.optype = $(this).attr("id");
			if(opt.optype == "begin"||opt.optype == "end"||opt.optype == "rect"||opt.optype == "decision"||opt.optype == "fork"||opt.optype == "join"){
			var text="<div id='dragOper' class='dragOper' style='left:"+e.pageX+"px"+";top:"+e.pageY+"px"+"'>"+$(this).find(".title").html()+"</div>";
			$("body").append(text);}
            
            //保存工作流
            if (opt.optype == "save") {
            }
        })
		$(document).mousemove(function(e){
			$("#dragOper").css({left:(e.pageX+2)+"px",top:(e.pageY+2)+"px"})
			})
		$(document).mouseup(function(e){
			$("#dragOper").remove();
			})
        this.delegate("#group1", "mouseup", function(e) {
			$("#dragOper").remove();
            opt.lineself = 0;
            opt.fromid = "";
            if (opt.optype == "path") {}
			else if (opt.optype == "move") {} 
			else if (opt.optype == "delete") {}
			else if (opt.optype == "move") {}
			else {
                var newopjX = e.pageX - $(this).offset().left + "px";
                var newopjY = e.pageY - $(this).offset().top + "px";
                var opj;
				if(opt.idindex==0){opt.idindex=$(".messagenode").length+$(".line").length}
                var obj_id=opt.idindex;
                // console.log("创建新的节点。");
                //获取节点id， 初始化节点名
              //  debugger;
				 
				var jsonData =null;
				jsonData= GetBgValSSIAJAX("/process/getActivityModelSequence.shtml",null);
				
				if(jsonData.code=='0000'){
					obj_id = 'T'+jsonData.resTEXTData;
				} 
				 
                finalStr.nodes[obj_id] = {
                		"id": obj_id,
                        "name": obj_id+'Name',
                        "act_type": opt.optype,
                        "act_mod": obj_id,
                        "act_name": obj_id+'actName',
                        "remark":"",
                        "auto_exec_method":3,
                        "invoke_api":"",
                        "inParam":"",
                        "outParam":"",
                        "messageFlowId":"",
                        "serInvokeInsId":"",
                        "invoke_api_name":"",
                        "isSchedule":"0",
                        "expressId":"",
                        "scheduleCount":10
                }
                if (opt.optype == "userTask") {
                	 
                    opj = '<div class="messagenode usertask" name="' + "userTask" + obj_id + '" id="' + obj_id + '"  type="userTask" style="left:' + newopjX + ';top:' + newopjY + '"><span>' + opt.optype + obj_id +'</span></div>';
                    
                    
                    // console.log(finalStr["nodes"]["T"+opt.idindex]);
                }else if (opt.optype == "receiveTask") {       
                    opj = '<div class="messagenode receivetask" name="' + "receiveTask" + obj_id + '" id="' + obj_id + '"  type="receiveTask" style="left:' + newopjX + ';top:' + newopjY + '"><span>' + opt.optype + obj_id +'</span></div>';
					                   
                }else if (opt.optype == "serviceTask") {       
                    opj = '<div class="messagenode servicetask" name="' + "serviceTask" + obj_id + '" id="' + obj_id + '"  type="serviceTask" style="left:' + newopjX + ';top:' + newopjY + '"><span>' + opt.optype + obj_id +'</span></div>';
					                   
                }else if (opt.optype == "decision") {       
                    opj = '<div class="messagenode judge" id="' + obj_id + '"  type="4" style="left:' + newopjX + ';top:' + newopjY + '"><span>' + opt.optype + obj_id +'</span></div>';
					
                } else if (opt.optype == "exclusiveGateway") {                    
                    opj = '<div class="messagenode exclusive" name="' + "exclusiveGateway" + obj_id + '" id="' +  obj_id + '"  type="exclusiveGateway" style="left:' + newopjX + ';top:' + newopjY + '"><span></span></div>';
                   

                }else if (opt.optype == "parallelGateway") {                    
                    opj = '<div class="messagenode parallel" name="' + "parallelGateway" + obj_id + '" id="' +  obj_id + '"  type="parallelGateway" style="left:' + newopjX + ';top:' + newopjY + '"><span></span></div>';
                   

                }  else if (opt.optype == "inclusiveGateway") {                    
                    opj = '<div class="messagenode inclusive" name="' + "inclusiveGateway" + obj_id + '" id="'  + obj_id + '"  type="inclusiveGateway" style="left:' + newopjX + ';top:' + newopjY + '"><span></span></div>';
                   
                } 
				else if (opt.optype == "begin") {
					
                    opj = '<div class="messagenode oval begin" id="' + obj_id + '"  type="startEvent" name="startEvent" style="left:' + newopjX + ';top:' + newopjY + '"><span></span></div>';
					
                    if ($(".messagenode.begin").length > 0) {
						alert("Existing start node ！");
						opt.optype=null;
                        return;
                    }
                   
                } else if (opt.optype == "end") {

                    opj = '<div class="messagenode oval end" id="' +  obj_id + '" name="endEvent"  type="endEvent" style="left:' + newopjX + ';top:' + newopjY + '"><span></span></div>';
                    if ($(".messagenode.end").length > 0) {
						alert("Existing end node ！");
						opt.optype=null;
                        return;
                    }

                }
                $(this).append(opj);
                opt.idindex++;
				opt.optype="move"
            }
        })
        $(document).keydown({
            inthis: this
        }, function(e) {

            var This = e.data.inthis;
            if (window.ActiveXObject) {
                kcode = e.keyCode
            } else {
                kcode = e.which
            }
            switch (kcode) {
                case 46:
                    $("#" + This.curid).remove();
                    $(".line").each(function() {
                        if ($(this).attr("from") == This.curid || $(this).attr("to") == This.curid) {
                            $(this).remove()
                        };
                    });
                    break;
                default:
            }
        })
		this.delegate("#submit", "click", function(e) {
			saveAs();
			})
        this.delegate("div.messagenode", "mousedown", {
            inthis: this
        }, function(e) {
            $(this).addClass("act").siblings().removeClass("act");
            var This = e.data.inthis;
            getPosition(opt.currid);
            if (opt.optype == "path") {
                opt.istemp = 1;
                if ($(this).hasClass("end")) {
                    return;
                }
                if ($(this).hasClass("begin")) {
                    if ($(".line[from='" + beginNodeId + "']").length > 0) {
                        return;
                    }
                }
                opt.fromid = $(this).attr("id");
                var point1 = [];
                opt.startposition[0] = parseInt($(this).css("left")) + $(".messagenode").width() * 0.5;
                opt.startposition[1] = parseInt($(this).css("top")) + $(".messagenode").height() * 0.5;
                var line = $(drawSvgline("templine", null, null));
                if ($("#templine").length <= 0) {
                    $("#drawsvg").append(line);
                    $("#templine path").attr("d", "M " + opt.startposition[0] + " " + opt.startposition[1] + " L " + opt.startposition[0] + " " + opt.startposition[1] + "");
                }
            } else {
                if (opt.optype == "delete") {
                    opt.currid = "";
                    $(this).remove();
                    delete finalStr.nodes[$(this).attr("id")];
                    //删除路径关系
                    deletePathDetJson($(this).attr("id"));

                    var thisid = $(this).attr("id");
                    $(".line").each(function() {
                        if ($(this).attr("from") == thisid || $(this).attr("to") == thisid) {
                            $(this).remove();
                            delete finalStr.lines[$(this).attr("id")];
                        };
                    });
                    e.stopPropagation();
                }
                if (opt.optype != "move") {
                    $(".form-group a:first").addClass("checked").siblings().removeClass("checked");
                    opt.optype = "move";
                }
                opt.isdrag = 1;
                opt.currid = $(this).attr("id");
                This.curid = $(this).attr("id");
                opt.mouseX = e.pageX - $("#" + opt.currid).offset().left;
                opt.mouseY = e.pageY - $("#" + opt.currid).offset().top;
            }
        })
        this.delegate("div.messagenode", "mouseover", function(e) {
            $(this).css("opacity", "0.9")
        })
        this.delegate("div.messagenode", "mouseout", function(e) {
            $(this).css("opacity", "1")
        })
        this.delegate("div.messagenode", "mouseup", function(e) {

            opt.isdrag = 0;
            if (opt.optype == "path") {
                if (opt.fromid != "") {
                    if ($(this).hasClass("begin")) {
                        return;
                    }
                    opt.toid = $(this).attr("id");
                    if (opt.fromid == opt.toid) {
                        return;
                    }
                    if ($(this).hasClass("end")) {
                        if (opt.fromid == beginNodeId) {
                            return;
                        }
                    }
                    var num = 0;
                    if (opt.toid == opt.fromid && $(this).attr("type") != "1") {

                        if (opt.lineself == 1) {
                            opt.lineself = 0;
                            $(".form-group a:first").addClass("checked").siblings().removeClass("checked");
                            opt.optype = "move";
                            if ($(".line[from=" + opt.fromid + "][to=" + opt.fromid + "]").length > 0) {
                                //连接已经建立
                                alert(getInternationalMessage('WF_PD.CONNECTION_ESTABLISHED'));
                                return;
                            }
                            var isround = 0;
                            drawSvgline(null, opt.fromid, opt.toid, isround);
                        }
                    } else if (opt.toid != opt.fromid) {

                        if ($(".line[from=" + opt.fromid + "][to=" + opt.toid + "]").length > 0) {
                            alert(getInternationalMessage('WF_PD.CONNECTION_ESTABLISHED'));
                            return;
                        }
                        var isround = 0;
                        if ($(".line[from=" + opt.toid + "][to=" + opt.fromid + "]").length > 0) {
                            isround = 1;
                        }


                        drawSvgline(null, opt.fromid, opt.toid, isround);
                    }
                    opt.fromid = "";
                    opt.toid = "";
                    opt.istemp = 0;
                    $("#templine").remove();
                }
            }
        });
        this.delegate("#group1", "mousemove", function(e) {

                if (opt.isdrag) {
                    getPosition(opt.currid);
                    $("#" + opt.currid).css("left", e.pageX - $(this).offset().left - opt.mouseX + "px");
                    $("#" + opt.currid).css("top", e.pageY - $(this).offset().top - opt.mouseY + "px");
                    if (parseInt($("#" + opt.currid).css("left")) < 0) {
                        $("#" + opt.currid).css("left", "0");
                    }
                    if (parseInt($("#" + opt.currid).css("top")) < 0) {
                        $("#" + opt.currid).css("top", "2px");
                    }
                    if (parseInt($("#" + opt.currid).css("left")) > $(this).width() - $("#" + opt.currid).width()) {
                        $("#" + opt.currid).css("left", $(this).width() - $("#" + opt.currid).width() + "px");
                    }
                    if (parseInt($("#" + opt.currid).css("top")) > $(this).height() - $("#" + opt.currid).height()) {
                        $("#" + opt.currid).css("top", $(this).height() - $("#" + opt.currid).height() + "px");
                    }
                    $(".line").each(function() {
                        opt.fromid = $(this).attr("from");
                        opt.toid = $(this).attr("to");
                        var fromid = opt.fromid;
                        var toid = opt.toid;
                        if ($(this).attr("from") == $("#" + opt.currid).attr("id") || $(this).attr("to") == $("#" + opt.currid).attr("id")) {
                            var points = [
                                [0, 0],
                                [0, 0]
                            ];
                            if (opt.fromid == opt.toid) {
                                var fl = parseInt($("#" + fromid).css("left"));
                                var ft = parseInt($("#" + fromid).css("top"));
                                $(this).find("path").attr("d", "M " + (fl + 31) + " " + (ft) + " C " + (fl + 31) + " " + (ft - 40) + " " + (fl - 60) + " " + (ft - 20) + " " + (fl) + " " + (ft + 22))
                            } else {
                                points = getPosition(opt.fromid, opt.toid);
                                if ($(".line[from=" + opt.toid + "][to=" + opt.fromid + "]").length <= 0) {
                                    $(this).attr("isround", 0)
                                }
                                if ($(this).attr("isround") == 1) {
                                    $(this).find("path").attr("d", "M " + points[0][0] + " " + points[0][1] + " C " + (points[0][0] + points[1][0]) / 2 + " " + points[0][1] + " " + (points[0][0] + points[1][0]) / 2 + " " + points[0][1] + " " + points[1][0] + " " + points[1][1] + "");
                                } else {
                                    $(this).find("path").attr("d", "M " + points[0][0] + " " + points[0][1] + " L " + points[1][0] + " " + points[1][1] + "")
                                }
                            }
                            if ($(this).find("path:eq(1)").attr("marker-end") == "url(\"#arrow2\")") {
                                $(this).find("path:eq(1)").attr("marker-end", "url(#arrow3)");
                            } else {
                                $(this).find("path:eq(1)").attr("marker-end", "url(#arrow2)");
                            }
                        }
                    });
                }
                if (opt.istemp) {
                    X = e.pageX - opt.arear.offset().left;
                    Y = e.pageY - opt.arear.offset().top;
                    $("#templine path").attr("d", "M " + opt.startposition[0] + " " + opt.startposition[1] + " L " + X + " " + Y);
                    if ($("#templine path:eq(1)").attr("marker-end") == "url(\"#arrow2\")") {
                        $("#templine path:eq(1)").attr("marker-end", "url(#arrow3)");
                    } else {
                        $("#templine path:eq(1)").attr("marker-end", "url(#arrow2)");
                    }
                }
            })
            //点击节点，当前状态改为节点操作
        this.delegate("div.messagenode", "click", function(e) {
                $(".form-group a:first").addClass("checked").siblings().removeClass("checked");
                opt.optype = "move";
            })
            //双击节点，初拟弹属性框
        this.delegate("div.messagenode", "dblclick", function(e) { 
            var node = finalStr.nodes[this.id];
            opActMod = this.id
            if(node.act_type != "receiveTask"&&node.act_type != "userTask"&&node.act_type != "serviceTask"){
            	return;
            }

            $("#act_type").val(node.act_type);
            $("#tache_id").val(node.id);
            $("#tache_name").val(node.name);
            $("#exec_method").val(node.exec_method);
            $("#exec_proc").val(node.exec_proc);
            $("#remark").val(node.remark);
            $("#messageFlowId").val(node.messageFlowId);
            $("#serInvokeInsId").val(node.serInvokeInsId);
            $("#inParam").val(node.inParam);
            $("#outParam").val(node.outParam);
            $("#INVOKE_API").val(node.invoke_api);
            $("#INVOKE_API_NAME").val(node.invoke_api_name);
            if($("#INVOKE_API").val()==""||null==$("#INVOKE_API").val()){
            	//$('#inParamBut').attr('disabled',true);
            	//$('#outParamBut').attr('disabled',true);
            	$('#msgFlowConfigBut').attr('disabled',true);
            }
            if(node.act_type=="receiveTask"){
            	$('#PollingTd').show();
            	//是否轮询
	            var isSchedule = node.isSchedule;
	            if(isSchedule == 1){
	            	jQuery("input[name='taskConf']").eq(1).attr('checked','true');
	            }else{
	            	jQuery("input[name='taskConf']").eq(0).attr('checked','true');
	            }
            }else{
            	$('#PollingTd').hide();
            }
         //alert($("#INVOKE_API").val());
           // loadPathAutoExecuteMethod(this);
         

            $("#tachInfo").modal('show');

        })
        this.delegate("div.messagenode", "mouseout", function(e) {
                if (opt.optype == "path" && opt.fromid != "") {
                    opt.lineself = 1;
                }
            })
            //选中线
        this.delegate("g", "click", {
            inthis: this
        }, function(e) {
            var This = e.data.inthis;
            if (opt.optype == "delete") {
                delete finalStr.lines[$(this).attr("id")];
                $(this).remove();
                $(".form-group a:first").addClass("checked").siblings().removeClass("checked");
                opt.optype = "move";
            } else {
                //alert("line-clu");
            	 
                TranstionAttr($(this).attr("id"));

            }
            This.curid = $(this).attr("id");
        })
        this.mouseup(function(e) {
            $("#templine").remove();
            opt.istemp = 0;
            opt.isdrag = 0;
        });
        this.load(function(e) {
                alert("ccc");
            })
            //打开工作流
        this.delegate("#select_contry,#select_system", "change", function(e) {
            init();
        })
        
        //-----------In Used-----------------AUTO_EXEC_METHOD
    	$(document).on('click', '#AUTO_EXEC_METHOD', function() { 
    		//debugger;
             var rtValue = this.value;
	          if(rtValue=="1"){
	             // $('').show();
	              $('#invokeApiTr').show();
	              $('#invokeScriptTr').hide();
	          }else if(rtValue=="2"){
	              $('#invokeScriptTr').show();
	              $('#invokeApiTr').hide();
	          }

	      
        })
    //弹出表格操作
        loadChooseServiceTable();
    }
    

    function drawLine(id, fromid, toid) {
        //console.log('drawLine');
    };

    function drawSvgline(id, fromid, toid, isround) {
        //debugger;

        var thisId;
        if (id == null) {
        	thisId ="transition"+$(".line").length;
        	var jsonData =null; 
			jsonData= GetBgValSSIAJAX("/process/getActivityModelSequence.shtml",null);
			if(jsonData.code=='0000'){
				thisId = 'transition'+jsonData.resTEXTData;
			} 
            
        } else thisId = id;
        var line;
        var points = [
            [0, 0],
            [0, 0]
        ];
        if (id != "templine") {
            points = getPosition(fromid, toid);
        }
        line = document.createElementNS("http://www.w3.org/2000/svg", "g");
        var hi = document.createElementNS("http://www.w3.org/2000/svg", "path");
        var path = document.createElementNS("http://www.w3.org/2000/svg", "path");
        line.setAttribute("id", thisId);
        hi.setAttribute("stroke", "#fff");
        hi.setAttribute("stroke-width", 7);
        hi.setAttribute("fill", "none");
        hi.style.opacity = 0.1;
        path.setAttribute("stroke", "#070707");
        path.setAttribute("marker-end", "url(#arrow3)");
        path.style.fill = "none";
        if (fromid == toid && fromid != null && document.getElementById(fromid).getAttribute("type") != "oval") {
            var fl = parseInt($("#" + fromid).css("left"));
            var ft = parseInt($("#" + fromid).css("top"));
            path.setAttribute("d", "M " + (fl + 31) + " " + (ft) + " C " + (fl + 31) + " " + (ft - 40) + " " + (fl - 60) + " " + (ft - 20) + " " + (fl) + " " + (ft + 22));
            hi.setAttribute("d", "M " + (fl + 31) + " " + (ft) + " C " + (fl + 31) + " " + (ft - 40) + " " + (fl - 60) + " " + (ft - 20) + " " + (fl) + " " + (ft + 22));
        } else if (fromid != toid) {
            if (isround == 1) {
                path.setAttribute("d", "M " + points[0][0] + " " + points[0][1] + " C " + (points[0][0] + points[1][0]) / 2 + " " + (points[0][1] - 10) + " " + (points[0][0] + points[1][0]) / 2 + " " + (points[1][1] + 20) + " " + points[1][0] + " " + points[1][1] + "");
                hi.setAttribute("d", "M " + points[0][0] + " " + points[0][1] + " C " + (points[0][0] + points[1][0]) / 2 + " " + (points[0][1] - 10) + " " + (points[0][0] + points[1][0]) / 2 + " " + (points[1][1] + 20) + " " + points[1][0] + " " + points[1][1] + "");
            }
            if (isround == 0) {
                path.setAttribute("d", "M " + points[0][0] + " " + points[0][1] + " L " + points[1][0] + " " + points[1][1] + "");
                hi.setAttribute("d", "M " + points[0][0] + " " + points[0][1] + " L " + points[1][0] + " " + points[1][1] + "");
            }
        }
        if (id == "templine") {
            path.setAttribute("stroke-dasharray", "6,5");
        } else {
        	//debugger;
            line.setAttribute("class", "line");
            //<TRANSTION delay_time="0" exclude_path="" tran_type="1" act_mod="80000520" new_flag="0" next_act_mod="80000521">
            //"actMod":"2000",      "nextActMod":"2001","from":"T0","to":"T1","isround":"0"
            //debugger;
            
            var fid = fromid;
            
            var tid =  toid;
            //debugger;
            
            if (null==finalStr.lines[thisId]||'undefined'==finalStr.lines[thisId]) {
                finalStr.lines[thisId] = {
                	"id":thisId,
                    "to": toid,
                    "isround": isround,
                    "from": fromid,
                    "actMod": fid,
                    "nextActMod": tid,
                    "delay_time": 0,
                    "act_mod": fid,
                    "next_act_mod": tid,
                    "exclude_path": "",
                    "tran_type": 1,
                    "new_flag": 0,
                    "condition":"",
                    "conditionValue":""
                };
            }
        }
        line.appendChild(hi);
        line.appendChild(path);
        line.style.zIndex = "999";
        line.setAttribute("id", thisId);
        line.setAttribute("isround", isround);
        line.setAttribute("from", fromid);
        line.setAttribute("to", toid);
         
        $("#drawsvg").append(line);
    }

    function getSvgMarker(id, color) {
        var m = document.createElementNS("http://www.w3.org/2000/svg", "marker");
        m.setAttribute("id", id);
        m.setAttribute("viewBox", "0 0 6 6");
        m.setAttribute("refX", 5);
        m.setAttribute("refY", 3);
        m.setAttribute("markerUnits", "strokeWidth");
        m.setAttribute("markerWidth", 10);
        m.setAttribute("markerHeight", 10);
        m.setAttribute("orient", "auto");
        var path = document.createElementNS("http://www.w3.org/2000/svg", "path");
        path.setAttribute("d", "M 0 0 L 6 3 L 0 6 z");
        path.setAttribute("fill", color);
        path.setAttribute("stroke-width", 0);
        m.appendChild(path);
        return m;
    }

    function initSvg(id, width, height) {

        var elem;
        var svg = document.createElementNS("http://www.w3.org/2000/svg", "svg"); //可创建带有指定命名空间的元素节点
        var defs = document.createElementNS("http://www.w3.org/2000/svg", "defs");
        defs.appendChild(getSvgMarker("arrow3", "#070707"));
        defs.appendChild(getSvgMarker("arrow2", "#070707"));
        svg.appendChild(defs);
        svg.setAttribute("id", id);
        svg.style.width = width + "px";
        svg.style.height = height + "px";
        return svg;
    }

    function getPosition(fromid, toid) {
        // var Ch = $(".messagenode").height();
        var Cw = $(".messagenode").width();
        var Cwf = $("#" + fromid).width();
        var Cwt = $("#" + toid).width();
        var Chf = $("#" + fromid).height(); //add
        var Cht = $("#" + toid).height(); //add
        var FromLeft = parseInt($("#" + fromid).css("left"));
        var FromTop = parseInt($("#" + fromid).css("top"));
        var ToLeft = parseInt($("#" + toid).css("left"));
        var ToTop = parseInt($("#" + toid).css("top"));
        var pForm = new Array(4);
        var pTo = new Array(4);
        for (var i = 0; i < 4; i++) {
            pForm[i] = new Array();
            pTo[i] = new Array();
            if (i == 0) {
                pForm[i][0] = FromLeft;
                pForm[i][1] = FromTop + Chf / 2;
                pTo[i][0] = ToLeft;
                pTo[i][1] = ToTop + Cht / 2;
            }
            if (i == 1) {
                pForm[i][0] = FromLeft + Cwf / 2;
                pForm[i][1] = FromTop;
                pTo[i][0] = ToLeft + Cwt / 2;
                pTo[i][1] = ToTop;
            }
            if (i == 2) {
                pForm[i][0] = FromLeft + Cwf;
                pForm[i][1] = FromTop + Chf / 2;
                pTo[i][0] = ToLeft;
                pTo[i][1] = ToTop + Cht / 2;
            }
            if (i == 3) {
                pForm[i][0] = FromLeft + Cwf / 2;
                pForm[i][1] = FromTop + Chf;
                pTo[i][0] = ToLeft + Cwt / 2;
                pTo[i][1] = ToTop + Cht;
            }
        }
        var MinLen = 999999999;
        var i_Index = 0;
        j_Index = 0;
        for (var i = 0; i < 4; i++)
            for (var j = 0; j < 4; j++) {
                var dist = Math.pow(pForm[i][0] - pTo[j][0], 2) + Math.pow(pForm[i][1] - pTo[j][1], 2);
                if (dist < MinLen) {
                    MinLen = dist;
                    i_Index = i;
                    j_Index = j;
                }
            }
        var points = [
            [0, 0],
            [0, 0]
        ];
        points[0][0] = pForm[i_Index][0];
        points[0][1] = pForm[i_Index][1];
        points[1][0] = pTo[j_Index][0];
        points[1][1] = pTo[j_Index][1];
        return points;
    }

    function saveAs() { 
	    var xmlNodes;
		var count,count2;
		 
			xmlNodes=oXMLDoc.getElementsByTagName("process");
			xmlNodes[0].setAttribute("id","ott_" + $('#systemId').val());
			xmlNodes[0].setAttribute("name","ott_" + $('#systemId').val());
			count=xmlNodes[0].childNodes.length;
			
		var extensionEleNodes = oXMLDoc.createElement("extensionElements");
		var endListener = oXMLDoc.createElement("activiti:executionListener");
		endListener.setAttribute("event","end");
		endListener.setAttribute("delegateExpression","${endListener}"); 
		extensionEleNodes.appendChild(endListener);
		xmlNodes[0].appendChild(extensionEleNodes);
			 
		for (var i=0;i<count;i++) {
			
				var y=xmlNodes[0].childNodes[0];
				y.parentNode.removeChild(y);
				}
			
			
		
			//xmlPositonNodes=oXMLDoc.getElementsByTagName("bpmndi:BPMNPlane");
			if(window.navigator.userAgent.indexOf("Chrome")!=-1){xmlPositonNodes=oXMLDoc.getElementsByTagName("BPMNPlane");}
			else{xmlPositonNodes=oXMLDoc.getElementsByTagName("bpmndi:BPMNPlane");}
		
			count2=xmlPositonNodes[0].childNodes.length;
			
		for (var i=0;i<count2;i++) {
			
				var y=xmlPositonNodes[0].childNodes[0];
				y.parentNode.removeChild(y);
				
			}
			
		var oElem,OLine,oPositon,lPosition,opId,omgdcB,omgdiW,condition,extension,taskListener;
		var beginnum =0;
		var endnum =0;
		$("#group1 .messagenode").each(function(index, element) {
            var thisId=$(this).attr("id");
			var type=$(this).attr("type");
			if(type=="begin"){
				beginnum++;
			}
			if(type=="end"){
				endnum++;
			}
			
			var name=$(this).attr("name");
			var left=$(this).position().left;
			var top=$(this).position().top;
			var opId="BPMNShape_"+thisId;
			var width=$(this).width();
			var height=$(this).height();
			
			oElem=oXMLDoc.createElement(type);
			oElem.setAttribute("id",thisId);
			oElem.setAttribute("name",name);
			
			if(type=="userTask"||type=="receiveTask"){
			//oElem.setAttribute("activiti:async",true);
			extension = oXMLDoc.createElement("extensionElements");
			
			
			if(type=="userTask"){
				taskListener = oXMLDoc.createElement("activiti:taskListener");
				taskListener.setAttribute("event","create");
			}else if(type=="receiveTask"){
				taskListener = oXMLDoc.createElement("activiti:executionListener");
				taskListener.setAttribute("event","start");
			}
			
			taskListener.setAttribute("delegateExpression","${"+type+"Listener}");
			extension.appendChild(taskListener);
			oElem.appendChild(extension);
 
			}else if(type=="serviceTask"){
				oElem.setAttribute("activiti:delegateExpression","${"+type+"Listener}");
			}
			
			
			oPositon=oXMLDoc.createElement("bpmndi:BPMNShape");
			oPositon.setAttribute("bpmnElement",thisId);
			oPositon.setAttribute("id",opId);
			
			mgdcB=oXMLDoc.createElement("omgdc:Bounds");
			mgdcB.setAttribute("width",width);
			mgdcB.setAttribute("height",height);
			mgdcB.setAttribute("x",left);
			mgdcB.setAttribute("y",top);
			
			oPositon.appendChild(mgdcB);
			
			
				xmlNodes[0].appendChild(oElem);
				xmlPositonNodes[0].appendChild(oPositon);
				
			
        });
//		if(beginnum<1||endnum<1){
//			alert("A Process must include BeginNode and EndNode!");
//			return false;
//		}
		$("#group1 .line").each(function(index, element) {
            var thisId=$(this).attr("id");
			var type="sequenceFlow";
			var opId="BPMNShape_"+thisId;
			var from=$(this).attr("from");
			var to=$(this).attr("to");
			
			oLine=oXMLDoc.createElement(type);
			oLine.setAttribute("id",thisId);
			oLine.setAttribute("sourceRef",$(this).attr("from"));
			oLine.setAttribute("targetRef",$(this).attr("to"));
			condition=oXMLDoc.createElement("conditionExpression");
			condition.setAttribute("xsi:type","tFormalExpression");
			//获取这条线的condition值   循环pathDetJson
			var condHTML = "";
			
			var linetemp = finalStr.lines[thisId];
			var conditionkeystemp = linetemp.condition;
			var conditionValuestemp = linetemp.conditionValue;
			if(conditionkeystemp.length>0){
				condHTML = "<![CDATA[${";
			for(var x = 0;x<conditionkeystemp.length;x++){
				 if (x == 0) {
			            condHTML += thisId+"_"+conditionkeystemp[x]+"=='"+conditionValuestemp[x]+"'";
			        } else {
			            condHTML +="&&"+thisId+"_"+conditionkeystemp[x]+"=='"+conditionValuestemp[x]+"'";
			        }
				
			}
			 	condHTML +="}]]>";
			}
			
//		    if (pathDetJson != null && pathDetJson.length > 0) {
//		        for (var i = 0; pathDetJson.length > i; i++) {
//		            var actModJObjJson = pathDetJson[i];
//		            var actMod = actModJObjJson.ACT_MOD;
//		            if (from == actMod) {
//		                var nextActDetListJson = actModJObjJson.NEXT_ACT_DET;
//		                for (var n = 0; nextActDetListJson.length > n; n++) {
//		                    
//		                    var nextActDetObjJson = nextActDetListJson[n];
//		                    if (nextActDetObjJson) {
//		                       // var nextActMod = nextActDetObjJson.NEXT_ACT_MOD;
//		                    	debugger;
//		                        var conditionListJson = nextActDetObjJson.CONDITIONS;
//		                        condHTML = "<![CDATA[${";
//		                        for (var c = 0; conditionListJson.length > c; c++) {
//		                            var conditionObjJson = conditionListJson[c];
//		                            var conditionId = conditionObjJson.CONDITION_ID;
//		                            //var conditionName = conditionObjJson.CONDITION_NAME;
//		                            var valueId = conditionObjJson.VALUE_ID; 
//		                           // var valueText = conditionObjJson.VALUE_TEXT;
////		                            <![CDATA[${transition100001196_1106 = 12&& transition100001196_1107=13}]]>
//		                            debugger;
//		                            if (c == 0) {
//		                                condHTML += conditionId+"=="+valueId;
//		                            } else {
//		                                condHTML +="&&"+conditionId+"=="+valueId;
//		                            }
//		                            
//		                        } 
//		                        condHTML +="}]]>";
//		                    }
//		                }
//		                break;
//		            }
//		        }
//		    }
			
			
			  
			//condition.innertext =condHTML;
			 var newText;
			if(condHTML!=""){ 
				newText=oXMLDoc.createTextNode(condHTML);
				condition.appendChild(newText);
				oLine.appendChild(condition);
			}
			
//			 <sequenceFlow id="flow4" name="不同意" sourceRef="exclusivegateway5" targetRef="modifyApply">
//		      <conditionExpression xsi:type="tFormalExpression"><![CDATA[${!deptLeaderPass}]]></conditionExpression>
//		    </ sequenceFlow >
			lPositon=oXMLDoc.createElement("bpmndi:BPMNEdge");
			lPositon.setAttribute("bpmnElement",thisId);
			lPositon.setAttribute("id",opId);
			
			points = getPosition(from, to);
			omgdiW=oXMLDoc.createElement("omgdi:waypoint");
			omgdiW.setAttribute("x",points[0][0]);
			omgdiW.setAttribute("y",points[0][1]);
			lPositon.appendChild(omgdiW);
						
			var omgdiW2=oXMLDoc.createElement("omgdi:waypoint");
			omgdiW2.setAttribute("x",points[1][0]);
			omgdiW2.setAttribute("y",points[1][1]);
			lPositon.appendChild(omgdiW2);
			
			
				xmlNodes[0].appendChild(oLine);
				xmlPositonNodes[0].appendChild(lPositon);
				
        	}); 
		var XMLtext;
		if(oXMLDoc.xml){//不在IE中,会返回undefined
			XMLtext =oXMLDoc.xml.replace(/ xmlns\=\"\"/g,'');
			oXMLDoc=new ActiveXObject("Microsoft.XMLDOM");
			oXMLDoc.loadXML(XMLtext); 
		}else{
			XMLtext=new XMLSerializer().serializeToString(oXMLDoc);
			XMLtext =XMLtext.replace(/ xmlns\=\"\"/g,'');
			parser=new DOMParser();  
			oXMLDoc=parser.parseFromString(XMLtext,"text/xml"); 
		}
		XMLtext = UnReplaceW(XMLtext);
		//XMLtext = encodeURI(XMLtext);
		XMLtext = encodeURIComponent(XMLtext);
		
		$("#XMLtextShow").val(XMLtext);
		return XMLtext;

    }
    //流程保存
    $('#saveProecss').bind('click', function() { 
    	//debugger;
    	var XMLtext = saveAs(); 
    	 
    	var a = $('#systemId').val(); 
    	var xmlStr = {'xml':XMLtext,
    			      'finalStr':JSON.stringify(finalStr),
    			      'system_id':$('#systemId').val(),
    			      'processName':$('#processName').val()
    			      };
    	var jsonData = GetBgValSSIAJAX("/process/saveOpeningProcess.shtml?",xmlStr);
    	 if(jsonData.code=='0000'){
    		 processId = jsonData.resTEXTData;
    		} else{
    			toastr.error('Save Fail.');
    			return;
    		}
    	 
    	//alert(processId);
    	 var processTemp = finalStr.process;
    	 processTemp.processId = processId;
    	 finalStr.process = processTemp;
    	 var processNamesave = "processName";
    	 if($('#processName').val()!=""){
    		 processNamesave = $('#processName').val();
    	 } 
    	$('#processId').val(processId);
    	window.opener.document.getElementById('sysProcessId').value=processId;
    	
    	//$(window.parent.document).find('#inParam').val(pageContractAdapterId);
    	    var str ="<a href='javascript:;' class='delProcess btn default btn-sm'>Delete</a>";
    	    var str2 = "<a href='javascript:;' class='editProcess' id="+processId+"> "+processNamesave+"</a>" ;
	  		var tr=[];
	  		tr.push("<td>"+1+"</td>");
	  	    tr.push("<td>"+str2+"</td>");//<td><a href="#" class="addCapability">Add </a></td>
	  		tr.push("<td>description</td>");
	  		tr.push("<td> </td>");
	  	    tr.push("<td> </td>");
  		
	  		tr.push("<td>"+str+"</td>");
	  		//tr.push("<td>"+$(objTr).children('td').eq(4).html()+"</td>");
	  		//tr.push('<td><a href="#" class="btn default btn-sm black btn-del"> <i class="fa fa-trash-o"></i> Delete </a></td>');
	  		var trStr="<tr id='TR"+processId+"'>"+tr.join("")+"</tr>";
	  		//debugger;
	  		var len = $(window.parent.document).find("table[id=processTable]>tbody>tr").length;
	  		if(len>0){
	  			$('#TR'+processId).remove();
	  		}
	  		$(window.parent.document).find("#proccesSysModalTB").append(trStr);
	  		//debugger;
	  		//var btn = $(window.parent.document).find('#addprocessbtn');
	  		
	  		toastr.success($.i18n.prop('eaap.op2.portal.mgr.message.success'));
            
//	  		$('#addprocessbtn').hide();
//	  		$('#addprocessbtn2').show();
	  		//$('.add-process').attr('hidden',true);
    	
    	
    })
    
    

     
    function laodData(procId) { 
        //获取对应的country 和system 的 flow_id
        // var jsonStr = GetBgValSSIJSON("/workflow/client/process/getFlowCountryMidJson.shtml");
		var linearray=[]; 
		 var strXml="";
		if($("#flag").val()=="1"){
			strXml = $('#XMLtextShow').val();
			oXMLDoc=loadXMLStr(strXml);
			var jsonData="";
			jsonData = GetBgValSSIAJAX("/process/getFlowProcessJson.shtml?processId=" + $('#processId').val(),null);
		    if(jsonData.code=='0000'){
		    	 // debugger;
		    	finalStr = jsonData.resTEXTData;
	    	 } 
		    
		}else{
			strXml = '<?xml version="1.0" encoding="UTF-8"?>'
				     +'<definitions xmlns="http://www.omg.org/spec/BPMN/20100524/MODEL" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:activiti="http://activiti.org/bpmn" xmlns:bpmndi="http://www.omg.org/spec/BPMN/20100524/DI" xmlns:omgdc="http://www.omg.org/spec/DD/20100524/DC" xmlns:omgdi="http://www.omg.org/spec/DD/20100524/DI" typeLanguage="http://www.w3.org/2001/XMLSchema" expressionLanguage="http://www.w3.org/1999/XPath" targetNamespace="http://www.activiti.org/test">'
			         +'<process id="myProcess" name="My process" isExecutable="true"/>'
			         +'<bpmndi:BPMNDiagram id="BPMNDiagram_myProcess">'
			         +'<bpmndi:BPMNPlane bpmnElement="myProcess" id="BPMNPlane_myProcess"/>'
			         +'</bpmndi:BPMNDiagram>'
			         +'</definitions>';
			oXMLDoc=loadXMLStr(strXml);
			var sysname = window.opener.document.getElementById('hidComponentName').value;
			$('#processName').val(sysname+"_Process");
		} 
		var endpointNodes,aObj,count;
		
			endpointNodes=oXMLDoc.getElementsByTagName("process");
			count=endpointNodes[0].childNodes.length;
			//var name= getAttributeValue(aObj,"name");
		for (var i=0;i<count;i++) {
			if (isIE()){
				aObj=endpointNodes[0].childNodes[i]	
			}
			else{
				aObj=endpointNodes[0].childNodes[i]	
				if(aObj.nodeType==1){
					aObj=endpointNodes[0].childNodes[i]
					}
				else{
				    continue;	
				}
			}
			 
			var name= getAttributeValue(aObj,"name");
			var id = getAttributeValue(aObj,"id");
			var type=aObj.tagName;
			var opj;
			if (type == "userTask") {
                    opj = '<div class="messagenode usertask" type="'+type+'"  id="' + id + '"  name="' + name + '"><span>' + name + '</span></div>';
                }
				else if (type == "receiveTask") {                    
                    opj = '<div class="messagenode  receivetask" type="'+type+'"  id="' + id + '"  name="' + name + '"><span>' + name + '</span></div>';
                } 
				
				else if (type == "serviceTask") {                    
                    opj = '<div class="messagenode  servicetask" type="'+type+'"  id="' + id + '"  name="' + name + '"><span>' + name + '</span></div>';
                } 
				 else if (type == "parallelGateway") {                    
                    opj = '<div class="messagenode  parallel" type="'+type+'"   id="' + id + '"  name="' + name + '"><span></span></div>';
                } else if (type == "exclusiveGateway") {                    
                    opj = '<div class="messagenode  exclusive" type="'+type+'"   id="' + id + '"  name="' + name + '"><span></span></div>';
					
                }else if (type == "inclusiveGateway") {                    
                    opj = '<div class="messagenode  inclusive" type="'+type+'"   id="' + id + '"  name="' + name + '"><span></span></div>';
					
                }else if (type == "startEvent") {	
                    opj = '<div class="messagenode oval begin" type="'+type+'"   id="' + id + '"  name="' + name + '"><span></span></div>';
                   
                } else if (type == "endEvent") {
                    opj = '<div class="messagenode oval end" type="'+type+'"   id="' + id + '"  name="' + name + '"><span></span></div>';
                }
				else if (type == "sequenceFlow") {
					var fname=getAttributeValue(aObj,"sourceRef");
					var tname=getAttributeValue(aObj,"targetRef");
					linearray.push(id+","+fname+","+tname)
                }			
			$("#group1").append(opj);
			opj=null;
		}
		
		var positionNodes;
		
		if(window.navigator.userAgent.indexOf("Chrome")!=-1){
			positionNodes=oXMLDoc.getElementsByTagName("BPMNPlane");
			}else{
				positionNodes=oXMLDoc.getElementsByTagName("bpmndi:BPMNPlane");
				}
		count=positionNodes[0].childNodes.length;
			
		
		for (var i=0;i<count;i++) {
			if (isIE()){
				aObj=positionNodes[0].childNodes[i]	
			}
			else{
				aObj=positionNodes[0].childNodes[i]	
				if(aObj.nodeType==1){
					aObj=positionNodes[0].childNodes[i]
					}
				else{
				    continue;	
				}
			}
			var opId=getAttributeValue(aObj,"bpmnElement");
			var aObjChild;
			if(aObj.childNodes[0].nodeType==1){
				aObjChild=aObj.childNodes[0];
				}
			else{aObjChild=aObj.childNodes[1]}
			var opLeft=getAttributeValue(aObjChild,"x");
			var opRight=getAttributeValue(aObjChild,"y");
			if($("#"+opId).length>0){
				$("#"+opId).css({left:opLeft+"px",top:opRight+"px"});
				}
		}
        for(z=0;z<linearray.length;z++){
			var linelist=linearray[z].split(",");
			drawSvgline(linelist[0],linelist[1],linelist[2],"0")
			}
		
    }


})(jQuery);


 


function GetBgValSSIJSON(action, xml) {
        var sRet = "";
        var oXMLHTTP;
        if (window.ActiveXObject) {
            //IE5 IE6是以activexobject的方式引入xmlhttprequset对象的
            oXMLHTTP = new ActiveXObject("Microsoft.XMLHTTP");
        } else if (window.XMLHttpRequest) {
            //除ie5 IE6以外的浏览器xmlhttprequset是window的子对象
            oXMLHTTP = new XMLHttpRequest();
        }
        oXMLHTTP.open("post", APP_PATH+action, false);

        //oXMLHTTP.open("post","http://localhost:8090/workClientWeb"+action,false);
        try {
            if (xml == null)
                oXMLHTTP.send();
            else
                oXMLHTTP.send(xml);
            sRet = oXMLHTTP.responseText;
        } catch (e) {
            alert("Error Ocurr in GetBgVal ");
        }
        return sRet;
    }
//同步执行
function GetBgValSSIAJAX(action, xml) {
	 
	var ajaxData;
	 $.ajax({
         url: APP_PATH+action,
         data: xml,
         type: "post",
         dataType:"json",
         async : false, 
         success: function(backdata) { 
        	// debugger;
             if (backdata.code == '0000') { 
            	 ajaxData = backdata;
               //  toastr.success($.i18n.prop('eaap.op2.portal.mgr.message.saveSuccess'));
                 
             } else  {
            	 ajaxData = backdata;
              //   toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
             }
         },
         error: function(error) {
            // toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
         }
     });
	 //debugger;
	 return ajaxData;
} 
 

 


//保存环节配置属性路径api 信息------------------In Used-----------
function pathAutoExecuteMethodJsonUpdate() {
 
		 //保存消息流跟服务调用实例的后台保存
	    /**jsonObject参数形式
		 * {
		    'messageFlowId':123456,
		    'name':'mawl'
			'transformerOne':123456,
			'call':34567,
			'transformerTwo':123456,
			'type':'old'
			}*/
	var apiId = $('#INVOKE_API').val();
	var  messageFlowId="";
	var serInvokeInsId="";
	if(apiId!=null&&apiId!=""){
		
		messageFlowId = $('#messageFlowId').val();
		serInvokeInsId = $('#serInvokeInsId').val();
		if(null==messageFlowId||""==messageFlowId){
 
	   var jsonObject = { 
				'messageFlowId':$('#messageFlowId').val(),
	             'name':'msgFlowName'+$('#INVOKE_API').val(),
	   'transformerOne':$('#inParam').val(),
			'serviceId':$('#INVOKE_API').val(),
	   'transformerTwo':$('#outParam').val(),
			     'type':'new',
	      'componentId':$('#systemId').val()
	    };
	    var datas = {'jsonObject':jsonObject};
	   
	    
	    
	    $.ajax({
	        url: APP_PATH+"/messageFlow/saveMessageFlow.shtml?jsonObject="+JSON.stringify(jsonObject),
	        data: "",
	        type: "post",
	        dataType:"json",
	        async : false, 
	        success: function(backdata) { 
	       	if (backdata.result == 'success') { 
	           	 messageFlowId= backdata.id; 
	           	$('#messageFlowId').val(messageFlowId);
	           	var jsonIns={
		        		'messageFlowId':messageFlowId,
		        		'serInvokeInsId':$('#serInvokeInsId').val(),
		        		'componentId':$('#systemId').val(),
		        		'serviceId':$('#INVOKE_API').val(),
		        		'name':'insName'+$('#INVOKE_API').val()
		        		};
	           	  
	           	//服务调用实例
		           	$.ajax({
		    	        url: APP_PATH+"/messageFlow/saveSerInvokeIns.shtml?jsonObject="+JSON.stringify(jsonIns),
		    	        data: "",
		    	        type: "post",
		    	        dataType:"json",
		    	        async : false, 
		    	        success: function(backdata) { 
		    	       	 //debugger;
		    	            if (backdata.result == 'success') { 
		    	            	serInvokeInsId= backdata.id; 
		    	           	$('#serInvokeInsId').val(serInvokeInsId);
		    	           	   toastr.success($.i18n.prop('eaap.op2.portal.mgr.message.success'));
		    	                
		    	            } else  {
		    	               toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
		    	            }
		    	        },
		    	        error: function(error) {
		    	        	toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
		    	        }
		    	    });
	              //  toastr.success($.i18n.prop('eaap.op2.portal.mgr.message.saveSuccess'));
	                
	            } else   {
	            	toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
	            }
	        },
	        error: function(error) {
	        	toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
	        }
	    });
		}
	}

	    //保存基础信息到json。
        var pathAutoErr = "";
        var nodeid = $("#tache_id").val();
        var node = finalStr.nodes[nodeid];
        $('#'+nodeid).attr('name',$("#tache_name").val());
        node.name = $("#tache_name").val();
        node.act_type = $("#act_type").val();
        node.split_type = $("#split_type").val();
        //node.exec_method = $("#exec_method").val();
        node.exec_proc = $("#exec_proc").val();
        node.act_name = $("#tache_name").val();
        node.remark = $("#remark").val();
        node.split_expr = $("#split_expr").val();
        //API的信息
        node.auto_exec_method = $("#API_PARAMTER_COMBO").val();
        node.invoke_api = $("#INVOKE_API").val();
        node.invoke_api_name=$('#INVOKE_API_NAME').val();
        //api——出参，入参
        node.inParam = $("#inParam").val();
        node.outParam = $("#outParam").val();
        node.messageFlowId =messageFlowId;
        node.serInvokeInsId = serInvokeInsId;
        node.isSchedule = jQuery("input[name='Polling']:checked").val();
        
        finalStr.nodes[nodeid] = node;
        //回写流程页面。
        var tacheNameDiv = document.getElementById(nodeid);
        tacheNameDiv.innerHTML = "<span>" + $("#tache_name").val() + "</span>";
        if (opActMod == null) {
            $("#tachInfo").hide();
            return;
        }
        var isHas = false;
       // var exec_method = $("#exec_method").val();
        var exec_proc = $("#exec_proc").val();
        var autoExecMethod = document.getElementById("AUTO_EXEC_METHOD").value;
        var invokeApi = document.getElementById("INVOKE_API").value;
        var invokeApiName = document.getElementById("INVOKE_API_NAME").value;
//        var taskConfId = jQuery("#TASK_CONF_ID").val();
//        var taskConf = jQuery("input[name='taskConf']:checked").val();
//        var taskCycle = jQuery('#TASK_CYCLE_COMBO').val();
//        var overTime = jQuery('#TASK_TIMEOUT').val();
//        var paramMod = jQuery('#API_PARAMTER_COMBO').val();
        //验证值/
//            if (autoExecMethod == 1 && invokeApi == "") {
//                pathAutoErr += AddErrMsg(getInternationalMessage('WF_PD.WHEN_TACHE') + nodeid + getInternationalMessage('WF_PD.AUTO_MUST_FUNC_EXEC'), "exec_proc", nodeid);
//                //pathAutoErr+=AddErrMsg(getInternationalMessage('WF_PD.FLOW_NOT_EMPTY'),"proc_name","");
//
//            } else if (autoExecMethod == 2 && exec_proc == "") {
//                pathAutoErr += AddErrMsg(getInternationalMessage('WF_PD.WHEN_TACHE') + nodeid + getInternationalMessage('WF_PD.AUTO_MUST_FUNC_EXEC'), "exec_proc", nodeid);
//
//            }
//            if (pathAutoErr != "") {
//                var ErrContent = document.all.ErrContent;
//                ErrContent.innerHTML = pathAutoErr;
//                $("#ErrMsg").show();
//                return;
//            }
 

        var tacheJSon = pathAutoExecuteMethodJson;
        if (tacheJSon != null && tacheJSon.length > 0) {
            for (var i = 0; tacheJSon.length > i; i++) {
                var tacheJObjSon = tacheJSon[i];
                var actMod = tacheJObjSon.ACT_MOD;
                if (opActMod == actMod) {
                    eval("pathAutoExecuteMethodJson[" + i + "].AUTO_EXEC_METHOD='" + autoExecMethod + "'");
                    eval("pathAutoExecuteMethodJson[" + i + "].INVOKE_API='" + invokeApi + "'");
                    eval("pathAutoExecuteMethodJson[" + i + "].INVOKE_API_NAME='" + invokeApiName + "'");
                    isHas = true;
                    break;
                }
            }
        }
        $("#tachInfo").modal("hide");
        
        
        
       
    } 

 
 
 

//更新取流程路径的确定方法信息（由弹出小窗口调用）：
function updatePathDetJson(fromTacheMod,nextTacheMod, conditionId, conditionName, valueId, valueText) {
//debugger;
    var isHasActMod = false;
    for (var i = 0; pathDetJson.length > i; i++) {
        var actModJObjJson = pathDetJson[i];
        var actMod = actModJObjJson.ACT_MOD;
        var fromMod=fromTacheMod;
        if (fromMod == actMod) {
            isHasActMod = true;

            var isHasNextActMod = false;
            var nextActDetListJson = actModJObjJson.NEXT_ACT_DET;
            for (var n = 0; nextActDetListJson.length > n; n++) {
                var nextActDetObjJson = nextActDetListJson[n];
                var nextActMod = nextActDetObjJson.NEXT_ACT_MOD;
                if (nextActMod == nextTacheMod) {
                    isHasNextActMod = true;
                    var isHasCondition = false;
                    var conditionListJson = nextActDetObjJson.CONDITIONS;
                    for (var c = 0; conditionListJson.length > c; c++) {
                        var conditionObjJson = conditionListJson[c];
                        var cConditionId = conditionObjJson.CONDITION_ID;
                        if (cConditionId == conditionId) {
                            isHasCondition = true;
                            pathDetJson[i].NEXT_ACT_DET[n].CONDITIONS[c].VALUE_ID = valueId;
                            pathDetJson[i].NEXT_ACT_DET[n].CONDITIONS[c].VALUE_TEXT = valueText;
                            break;
                        }
                    }
                    if (!isHasCondition) {
                    	//debugger;
                        var cJsonStr = '{"CONDITION_ID":"' + conditionId + '","CONDITION_NAME":"' + conditionName + '","VALUE_ID":"' + valueId + '","VALUE_TEXT":"' + valueText + '"}';
                        var cJson = JSON.parse(cJsonStr);
                        pathDetJson[i].NEXT_ACT_DET[n].CONDITIONS.push(cJson);
                    }
                    break;
                }
            }
            if (!isHasNextActMod) {
            	//debugger;
                var tJsonStr = '{"NEXT_ACT_MOD":"' + nextTacheMod + '","CONDITIONS":[]}';
                var ntJson = JSON.parse(tJsonStr);
                pathDetJson[i].NEXT_ACT_DET.push(ntJson);
                updatePathDetJson(fromMod,nextTacheMod, conditionId, conditionName, valueId, valueText);
            }

            break;
        }
    }
    if (!isHasActMod) {
        var pdJsonStr = '{"PROC_MOD":"' + 1 + '","ACT_MOD":"' + fromTacheMod + '","NEXT_ACT_DET":[]}';
        var pdJson = JSON.parse(pdJsonStr);
        pathDetJson.push(pdJson);
        updatePathDetJson(fromTacheMod,nextTacheMod, conditionId, conditionName, valueId, valueText);
    }
}

//清除（由弹出小窗口调用）：
function clearPathDetJson(nextTacheMod) {
    //debugger;
    document.getElementById("DET_" + nextTacheMod).innerHTML = "";
    for (var i = 0; pathDetJson.length > i; i++) {
        var actModJObjJson = pathDetJson[i];
        var actMod = actModJObjJson.ACT_MOD;
        if (opActMod == actMod) {
            var nextActDetListJson = actModJObjJson.NEXT_ACT_DET;
            for (var n = 0; nextActDetListJson.length > n; n++) {
                var nextActDetObjJson = nextActDetListJson[n];
                var nextActMod = nextActDetObjJson.NEXT_ACT_MOD;
                if (nextActMod == nextTacheMod) {
                    pathDetJson[i].NEXT_ACT_DET[n].CONDITIONS = [];
                    break;
                }
            }
        }
    }
}

//删除（由弹出小窗口调用）：
function deletePathDetJson(nextTacheMod) {

    //document.getElementById("DET_"+nextTacheMod).innerHTML = "";
    for (var i = 0; pathDetJson.length > i; i++) {
        var actModJObjJson = pathDetJson[i];
        var actMod = actModJObjJson.ACT_MOD;

        var nextActDetListJson = actModJObjJson.NEXT_ACT_DET;
        for (var n = 0; nextActDetListJson.length > n; n++) {
            var nextActDetObjJson = nextActDetListJson[n];
            var nextActMod = "T" + nextActDetObjJson.NEXT_ACT_MOD;
            if (nextActMod == nextTacheMod) {
                //pathDetJson[i].NEXT_ACT_DET[n].CONDITIONS = [];
                delete pathDetJson[i].NEXT_ACT_DET[n];
                break;
            }
        }

    }
}
//------------InUsed-----------------------------------------
function setPathdetWayInfo(lineIdstr,nextTacheMod,procMod,opActMod) {
   //debugger;
    var procMod = flowIdPage;
     
    var jsonData = GetBgValSSIAJAX("/process/setBpmPathDetInfoJson.shtml?nextTacheMod=" + nextTacheMod + "&procMod=" + procMod + "&actMod=" + opActMod+"&systemId="+$('#systemId').val(),null);//opActMod ---fromID
    //debugger;
    var xx ;
    if(jsonData.code=='0000'){
		xx = jsonData.resTEXTData;
	} 
    var aa = xx.split("|&");
    var ff = JSON.parse(aa[0]);
    var nextnode = aa[1];
    var PathDetJson = ff;
     //获取condition 的值
 
    var line = finalStr.lines[lineIdstr];
    var conditionArr = line.condition;
    var conditionValueArr = line.conditionValue;

 
    var tableHtml = "";
    var conditionValueId="";
    for (var i = 0; PathDetJson.length > i; i++) {
    	  // debugger;
    	conditionValueId=""
    	for(var w =0;w<conditionArr.length;w++){
    		if(PathDetJson[i].CONDITION_ID == conditionArr[w]){
    			conditionValueId =conditionValueArr[w];
    		}
    		
        }
         var isCheck = "";
        if (conditionValueId != "") {
            isCheck = "checked";
        }
        
        tableHtml += "<tr>";
        tableHtml += "<td><input class='checkbox' type='checkbox' name='selectCon' value='" + PathDetJson[i].CONDITION_ID + "'  " + isCheck + "></td>";
        tableHtml += "<td>" + PathDetJson[i].CONDITION_NAME + "</td>";
        tableHtml += "<td>";
        var conditionValue = PathDetJson[i].CONDITION_VALUE;
      
        if(PathDetJson[i].CONDITION_ID == '10004'){
        	tableHtml += "  <select class='multiselect' multiple='multiple' style='width:100%' CONDITION_ID='" + PathDetJson[i].CONDITION_ID + "'  CONDITION_NAME='" + PathDetJson[i].CONDITION_NAME + "'    onchange='selectChange(this)'  >";
        	 for (var v = 0; conditionValue.length > v; v++) {
                 var isSelect = "";
                var conditionValueIds = conditionValueId.split("|");
                for(var cod =0;conditionValueIds.length>cod;cod++){
                	if (conditionValueIds[cod] == conditionValue[v].VALUE_ID) {
                        isSelect = "selected";
                    }
                }
                 
                 tableHtml += "  <option value='" + conditionValue[v].VALUE_ID + "'  " + isSelect + ">" + conditionValue[v].VALUE_TEXT + "</option>";
 
        	 }
        	 tableHtml += "  </select>";
        }else{
        	tableHtml += "  <select class='form-control' CONDITION_ID='" + PathDetJson[i].CONDITION_ID + "'  CONDITION_NAME='" + PathDetJson[i].CONDITION_NAME + "'    onchange='selectChange(this)'>";
            
        	 for (var v = 0; conditionValue.length > v; v++) {
                 var isSelect = "";
                 if (conditionValueId == conditionValue[v].VALUE_ID) {
                     isSelect = "selected";
                 }
                 tableHtml += "  <option value='" + conditionValue[v].VALUE_ID + "'  " + isSelect + ">" + conditionValue[v].VALUE_TEXT + "</option>";
             }
        	 tableHtml += "  </select>";
        } 
        tableHtml += "</td>";
        tableHtml += "</tr>";
    }
    //tableHtml+="</table>";
    var pathDetList = document.getElementById("pathDetList");
    pathDetList.innerHTML = tableHtml;
    $('.multiselect').multiselect();
    $("#tachInfoSet").modal("show");
   

}
 

 

//路径属性-------------------在用
function TranstionAttr(obj) {
    //debugger;
    var lineJson = finalStr.lines[obj];
    //XmlNode=oXMLDoc.selectSingleNode("//TRANSTIONMODEL/TRANSTION/transtion_ss/*[@id='"+obj+"']");
    if (lineJson == null) {
        alert(getInternationalMessage('WF_PD.NOT_FIND_PATH_PROP'));
        //alert("线不存在");
        return false;
    }
 
    var node1 = finalStr.nodes[lineJson.from]; //oXMLDoc.selectSingleNode("//ACTIVITYMODEL/ACTIVITY[@act_mod='"+XmlNode.getAttribute("act_mod")+"']");
    var node3 = finalStr.nodes[lineJson.to]; //oXMLDoc.selectSingleNode("//ACTIVITYMODEL/ACTIVITY[@act_mod='"+XmlNode.getAttribute("next_act_mod")+"']");
    if(null==node1||""==node1){
    	return;
    }
    if(node1.act_type!="inclusiveGateway"){
    	return;
    }
    $('#from_tache').val(node1.name);
    $('#from_tache_id').val(node1.id);
    $('#to_tache').val(node3.name);
    $('#to_tache_id').val(node3.id);
    $('#line_id').val(obj);
    
    $("#tachInfoRoute").modal("show"); 
    
    setPathdetWayInfo(obj,lineJson.next_act_mod,1,lineJson.act_mod);
    
    
    fPropertyChange = true; 
}



 


//生成服务调用实例并弹出消息流配置框
function msgFlowConfig(){
	var messageFlowId=$('#messageFlowId').val();
	var apiId = $('#INVOKE_API').val();
	if(apiId!=null&&apiId!=""){
		if(null==messageFlowId||""==messageFlowId){
	 
	   var jsonObject = { 
				'messageFlowId':$('#messageFlowId').val(),
	             'name':'msgFlowName'+$('#INVOKE_API').val(),
	   'transformerOne':$('#inParam').val(),
			'serviceId':$('#INVOKE_API').val(),
	   'transformerTwo':$('#outParam').val(),
			     'type':'new',
	      'componentId':$('#systemId').val()
	    };
	    var datas = {'jsonObject':jsonObject};
	   
	    
	    var serInvokeInsId;
	    $.ajax({
	        url: APP_PATH+"/messageFlow/saveMessageFlow.shtml?jsonObject="+JSON.stringify(jsonObject),
	        data: "",
	        type: "post",
	        dataType:"json",
	        async : false, 
	        success: function(backdata) { 
	       	if (backdata.result == 'success') { 
	           	 messageFlowId= backdata.id; 
	           	$('#messageFlowId').val(messageFlowId);
	           	var jsonIns={
		        		'messageFlowId':messageFlowId,
		        		'serInvokeInsId':$('#serInvokeInsId').val(),
		        		'componentId':$('#systemId').val(),
		        		'serviceId':$('#INVOKE_API').val(),
		        		'name':'insName'+$('#INVOKE_API').val()
		        		};
	           	  
	           	//服务调用实例
		           	$.ajax({
		    	        url: APP_PATH+"/messageFlow/saveSerInvokeIns.shtml?jsonObject="+JSON.stringify(jsonIns),
		    	        data: "",
		    	        type: "post",
		    	        dataType:"json",
		    	        async : false, 
		    	        success: function(backdata) { 
		    	       	 //debugger;
		    	            if (backdata.result == 'success') { 
		    	            	serInvokeInsId= backdata.id; 
		    	           	$('#serInvokeInsId').val(serInvokeInsId);
		    	           	//转到消息流编排页面
		    	           	var openURL = $('#messageFlowUrl').val()+'/messageFlow/toSomeMessageArrangeConfig.shtml?flag=portal&messageFlowId='+messageFlowId;
		                    var curr_window;
		                    x = (window.screen.width - 1100) / 2;
		                    y = (window.screen.height - 570) / 2 - 30;
		                    curr_window = window.open(openURL, 'Message Flow Configuration');
		                    curr_window.focus();  
		    	           	   //toastr.success('Success!');
		    	                
		    	            } else  {
		    	            	 toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
		    	            }
		    	        },
		    	        error: function(error) {
		    	        	 toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
		    	        }
		    	    });
	              //  toastr.success($.i18n.prop('eaap.op2.portal.mgr.message.saveSuccess'));
	                
	            } else   {
   	        	 toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
	            }
	        },
	        error: function(error) {
	        	 toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
	        }
	    });
		}else{
			var openURL = $('#messageFlowUrl').val()+'/messageFlow/toSomeMessageArrangeConfig.shtml?flag=portal&messageFlowId='+messageFlowId;
            var curr_window;
            x = (window.screen.width - 1100) / 2;
            y = (window.screen.height - 570) / 2 - 30;
            curr_window = window.open(openURL, 'Message Flow Configuration');
            curr_window.focus();
		}
	}else{
		toastr.error('Please choose a API!');
	}
	
}
function outParamChoose(){
	var url = APP_PATH + "/newadapter/showNewAdapter.shtml?intoOrOut=out&transformerRuleId="+$('#outParam').val();
	   $('#outParamiframe').attr('src',url);
	   $('#apiParamModalout').modal('show');
}
function inParamChoose(){
      //debugger;
	var url = APP_PATH + "/newadapter/showNewAdapter.shtml?intoOrOut=in&transformerRuleId="+$('#inParam').val();
	   $('#inParamiframe').attr('src',url);
	   $('#apiParamModal').modal('show');
} 
 
 
  
 
 
    //判断是否数字
function IsDigit(sStr) {
    sStr = sStr.replace(/^-/g, "");
    sStr = sStr.replace(/./g, "");
    if (sStr.match(/\D/) != null)
        return false;
    else
        return true;
}

 

/**
 * ------------------tacheSet 整合入主页面-----
 */
function onClickOK() { 
    var retHtml = "";
    var conditionArr = new Array();
    var valueArr = new Array();
    var checkboxList = document.getElementsByName("selectCon");
    var num=0;
    for (var j = 0; checkboxList.length > j; j++) {
        var checkBoxObj = checkboxList[j];
        if (checkBoxObj.checked == false) {
            continue;
        }
        var selValue = checkBoxObj.value;
        var selObjList = document.getElementsByTagName("select");
      
        for (var i = 0; selObjList.length > i; i++) {
            var selectObj = selObjList[i];
            var conditionId = selectObj.getAttribute("CONDITION_ID");
            if (selValue == conditionId) { 
            	var objValue="";
            	var valueId="";
                var conditionName = selectObj.getAttribute("CONDITION_NAME");
                for (var x =0;selectObj.options.length>x;x++){
                	if(selectObj.options[x].selected){
                		if(valueId==""){
                			valueId=selectObj.options[x].value;
                			objValue = selectObj.options[x].text;
                		}else{
                			valueId += "|"+selectObj.options[x].value;
                			objValue += ","+selectObj.options[x].text;
                		}
                		
                	}
                }
                 
                if (retHtml == "") {
                    retHtml += "<b>" + conditionName + ":</b>" + objValue;
                } else {
                    retHtml += ", <b>" + conditionName + ":</b>" + objValue;
                }
                
                var valueText = selectObj.options[selectObj.selectedIndex].text; 
                conditionArr[num]=conditionId;
                valueArr[num]=valueId;
                num++; 
                updatePathDetJson($('#from_tache_id').val(),$('#to_tache_id').val(), conditionId, conditionName, valueId, valueText);
 
            }
        }
    } 
    var lineID=$('#line_id').val(); 
    var lineJsonUp = finalStr.lines[lineID]; 
    lineJsonUp.condition=conditionArr;
    lineJsonUp.conditionValue=valueArr;
    finalStr.lines[lineID] = lineJsonUp;
    toastr.success($.i18n.prop('eaap.op2.portal.mgr.message.success'));
    
    $("#tachInfoRoute").modal("hide");
}

function onClickClose() {
    window.close();
}

function onClickClear() {
    window.opener.clearPathDetJson(document.getElementById("nextTacheMod").value);
    window.close();
}

function allSelect() {
    var allCheck = false;
    if (document.getElementById("allSelectCon").checked == true) {
        allCheck = true;
    }
    var checkboxList = document.getElementsByName("selectCon");
    for (var j = 0; checkboxList.length > j; j++) {
        checkboxList[j].checked = allCheck;
    }
}

function selectChange(selectObj) {
    var checkboxList = document.getElementsByName("selectCon");
    for (var j = 0; checkboxList.length > j; j++) {
        if (checkboxList[j].value == selectObj.getAttribute("CONDITION_ID")) {
            checkboxList[j].checked = true;
        }
    }
}

//--------------------------In Used-----------------------
function getInternationalMessage(key){
 
}
//替换字符将&amp;,&quot;,&lt;,&gt; 换成&,",<,>
function UnReplaceW(str) {
	var sRet=str;
	if (str==null || str=="")
		return "";
	else {
		sRet=sRet.replace(/&amp;/gi,'&');
		sRet=sRet.replace(/&quot;/gi,'"');
		sRet=sRet.replace(/&lt;/gi,'<');
		sRet=sRet.replace(/&gt;/gi,'>');
		return sRet;
	}
}

toastr.options = {
        positionClass: 'toast-bottom-right',
        closeButton: true,
        timeOut: 2000,
    }

