	var oXMLDoc=null;
	var oXSLDoc=null;
	var xmlNode=null;
	var sOriCanvas="";
	var loadXMLFile = function (xmlFile) { 
            var xmlDoc; 
            if (window.ActiveXObject) { 
                xmlDoc = new ActiveXObject('Microsoft.XMLDOM');//IE浏览器 
                xmlDoc.async = false; 
                xmlDoc.load(xmlFile); 
            } 
            else if (isFirefox=navigator.userAgent.indexOf("Firefox")>0) { //火狐浏览器 
                xmlDoc = document.implementation.createDocument('', '', null); 
				xmlDoc.async = false; 
                xmlDoc.load(xmlFile); 
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
            if (window.ActiveXObject) { 
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
			if (window.ActiveXObject) {
				XMLNode = xmlOdc.selectNodes(Xpath)[0];
			   }
			else{
				XMLNode = xmlOdc.evaluate(Xpath, xmlOdc, null, XPathResult.ANY_TYPE, null);
				XMLNode =XMLNode.iterateNext();
				}
			return XMLNode;
		}
		var loadXMLNode=function(Xpath,xmlOdc){
			var XMLNode;
			if (window.ActiveXObject) {
				XMLNode = xmlOdc.selectNodes(Xpath);
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
    		if (window.ActiveXObject)    // IE
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
	function openMessageFlowList(){
		var retDoc=loadXMLStr(ajaxInteractive("/messageFlow/getCreatedMessageFlowList.shtml?"))
		if (window.ActiveXObject) {
				xmlNodes = retDoc.selectNodes("//MESSAGEFLOW");
			   }
			else{
				xmlNodes = retDoc.getElementsByTagName("MESSAGEFLOW");
				}
		var messageFlowTab=document.getElementById("messageflowtab");
		$(messageFlowTab).text("");
		var newrow=null,newcell=null,tableth=null; 
		newrow=messageFlowTab.insertRow();
		//messageFlowTab.addChild(newrow);
		newrow.height=20;
		//newcell=newrow.insertCell();
		newcell = document.createElement("th");
		newrow.appendChild(newcell);
		newcell.style.cssText="width:10%";
		//newcell.style.cssText="border-width: 1px;padding: 3px;border-style: solid;border-color: #666666;background-color: #fefcf6;";	
		newcell.innerHTML="<b>"+getInternationalMessage("eaap.op2.conf.messageArrange.dialog.head.choose")+"</b>";
		newcell.align="center";
		//newcell.width=30;
		//newcell=newrow.insertCell();
		newcell = document.createElement("th");
		newrow.appendChild(newcell);		
		newcell.style.cssText="width:25%";
		//newcell.style.cssText="border-width: 1px;padding: 3px;border-style: solid;border-color: #666666;background-color: #fefcf6;";
		newcell.innerHTML="<b>"+getInternationalMessage("eaap.op2.conf.messageArrange.dialog.head.messageFlowID")+"</b>";
		newcell.align="center";
		//newcell.width=60;
		//newcell=newrow.insertCell();
		newcell = document.createElement("th");
		newrow.appendChild(newcell);		
		newcell.style.cssText="width:50%";
		//newcell.style.cssText="border-width: 1px;padding: 3px;border-style: solid;border-color: #666666;background-color: #fefcf6;";	
		newcell.innerHTML="<b>"+getInternationalMessage("eaap.op2.conf.messageArrange.dialog.head.messageFlowName")+"</b>";
		newcell.align="center";
		//newcell.width=300;
		//newcell.style.background='#F0F8FF';
		//newcell.style.cssText="border-width: 1px;padding: 3px;border-style: solid;border-color: #666666;background-color: #fefcf6;";
		//newcell=newrow.insertCell();
		newcell = document.createElement("th");
		newrow.appendChild(newcell);		
		newcell.style.cssText="width:15%";
		//newcell.style.cssText="border-width: 1px;padding: 3px;border-style: solid;border-color: #666666;background-color: #fefcf6;";
		newcell.innerHTML="<b>"+getInternationalMessage("eaap.op2.conf.messageArrange.dialog.head.status")+"</b>";
		newcell.align="center";
		newcell.width=30;
		for (var i=0;i<xmlNodes.length;i++) {
			newrow=messageFlowTab.insertRow();
			newrow.height=20;
			newcell=newrow.insertCell();
			//newcell.style.cssText="border-width: 1px;padding: 3px;border-style: solid;border-color: #666666;background-color:#ffffff;";
			newcell.innerHTML="<input type='radio' name='xxxmod' value='"+xmlNodes[i].getAttribute("message_Flow_Id")
					+"' onclick='message_Id.value=this.value;'>";
			newcell=newrow.insertCell();
			//newcell.style.cssText="border-width: 1px;padding: 3px;border-style: solid;border-color: #666666;background-color:#ffffff;";
			newcell.innerHTML=xmlNodes[i].getAttribute("message_Flow_Id");
			newcell=newrow.insertCell();
			//newcell.style.cssText="border-width: 1px;padding: 3px;border-style: solid;border-color: #666666;background-color:#ffffff;";
			newcell.innerHTML=xmlNodes[i].getAttribute("message_Flow_Name");
			newcell=newrow.insertCell();
			//newcell.style.cssText="border-width: 1px;padding: 3px;border-style: solid;border-color: #666666;background-color:#ffffff;";
			var state = xmlNodes[i].getAttribute("state");
			if(state=='A')
				//newcell.innerHTML='在用';
				newcell.innerHTML=getInternationalMessage("eaap.op2.conf.messageArrange.dialog.column.status.inService");
			else if(state=='X')
				//newcell.innerHTML='注销';
				newcell.innerHTML=getInternationalMessage("eaap.op2.conf.messageArrange.dialog.column.status.cancelled");
			else
				newcell.innerHTML='';			
		}
		if (i==0) {
			newrow=messageFlowTab.insertRow();
			newcell=newrow.insertCell();
			newcell.colspan=4;
			newcell.align="center";
			//newcell.innerHTML="<font color='red'>没有您创建的流程模板</font>";
			newcell.innerHTML="<font color='red'>"+getInternationalMessage("eaap.op2.conf.messageArrange.dialog.content.promt.noFlowCreated");+"</font>";
		}	
		messageFlowTab.className="tab_css_1";
		addHover("messageflowtab");
		retDoc=null;
		return true;		
	}
	
	function getMessageFlowNameByMessageId(message_Flow_Id){
		var retDoc=new ActiveXObject("Microsoft.XMLDOM");
		retDoc.async=false; 
		retDoc.loadXML(ajaxInteractive("/messageFlow/getCreatedMessageFlowList.shtml?")); 
		if (retDoc.parseError.errorCode!=0) {
				alert("GET FLOWMOD LIST ERROR！");
				return false;
		}
		xmlNode=retDoc.selectNodes("//MESSAGEFLOW[@message_Flow_Id='"+message_Flow_Id+"'");
		var message_Flow_Name="";
		if(xmlNode!=null){
			message_Flow_Name=xmlNodes[i].getAttribute("message_Flow_Id");
		}
		return message_Flow_Name;
	}
	
	function openMessage(oContainer,message_Flow_Id){
		if(message_Flow_Id==null||message_Flow_Id=='')
			return;
		oContainer.innerHTML="";
		initMessage_FlowInfo(oContainer);
		var openMessageAction="/messageFlow/getMessageArrangeData.shtml";
		var actionParam="message_Flow_Id="+message_Flow_Id;
		var actionUrl=openMessageAction+"?"+actionParam;
		var sRet=ajaxInteractive(actionUrl);
		if (oXMLDoc==null) 
			{oXMLDoc=new ActiveXObject("Microsoft.XMLDOM");}
		oXMLDoc=loadXMLStr(sRet);
		//载入界面
		
		var sHtml=loadTransformNode(oXMLDoc,oXSLDoc);
		//从XML节点获取端点路径信息展现出来
		initEndpoint();
		initServiceRouteConfig();
		if ($('#tt').tabs('exists', getInternationalMessage("eaap.op2.conf.messageArrange.tab.title.Temp"))){
			$('#tt').tabs('select', getInternationalMessage("eaap.op2.conf.messageArrange.tab.title.Temp"));
			$('#tt').tabs('getTab', getInternationalMessage("eaap.op2.conf.messageArrange.tab.title.Temp")).panel('options').tab.hide();
		}		
		addTempTab();
		if ($('#tt').tabs('exists', getInternationalMessage("eaap.op2.conf.messageArrange.tab.title.Temp"))){
			$('#tt').tabs('select', getInternationalMessage("eaap.op2.conf.messageArrange.tab.title.Temp"));
			$('#tt').tabs('getTab', getInternationalMessage("eaap.op2.conf.messageArrange.tab.title.Temp")).panel('options').tab.hide();
		}
		closeTempTab();
		resetMenuItemCss('messageFlow','open');
		
		//设置消息流名称：
		var messageNode;
		if (window.ActiveXObject) {
			var messageNode=oXMLDoc.selectNodes("//MESSAGE");
		}
		else{
			var messageNode=oXMLDoc.getElementsByTagName("MESSAGE");
		}
		var messageFlowName= messageNode[0].getAttribute("message_flow_name");
		document.getElementById("messageFlowName").innerHTML = messageFlowName;
		
	}
	
	function saveMessage(saveType){
		var result = checkMessageData();
		if(result=='false'){
			$('#MessageInfoCheck').window('open');
			return;
		}
		var actionUrl="/messageFlow/saveMessageArrangeData.shtml?saveType="+saveType;
		var retDoc;
		var sRet;
		if (window.ActiveXObject) { 
				var sRet=ajaxInteractive(actionUrl,oXMLDoc.xml);
                var retDoc=new ActiveXObject("Microsoft.XMLDOM");
				retDoc.async=false;
				retDoc.loadXML(sRet)
            } 
            else { //火狐浏览器  
               	var sRet=ajaxInteractive(actionUrl,serializeXml(oXMLDoc));
			    parser=new DOMParser();
                retDoc=parser.parseFromString(sRet,"text/xml");
            } ;
		if (window.ActiveXObject) {
			sRet=loadXMLsNode("//ERROR",retDoc).text;
			var sNew=loadXMLsNode("//new_Message_Flow_Id",retDoc).text;
		}
		else{
			sRet=loadXMLsNode("//ERROR",retDoc).innerHTML;
			var sNew=loadXMLsNode("//new_Message_Flow_Id",retDoc).innerHTML;
			}
		retDoc=null;
		if (sRet=="success") {
			//alert("操作成功保存！界面将被重新刷新");
			alert(getInternationalMessage("eaap.op2.conf.messageArrange.alert.info.saveAndRefresh"));
			openMessage(group,sNew);
		}
		else
			//alert("保存失败！");		
			alert(getInternationalMessage("eaap.op2.conf.messageArrange.alert.info.saveErrot"));
	}
	
	function initMessage_FlowInfo(oContainer){
		oXMLDoc=loadXMLFile($("#projectRootPath").val()+"/xml/blank.xml");
		oXSLDoc=loadXMLFile($("#projectRootPath").val()+"/xsl/data.xsl");
		initTab();
	}	
	function initEndpoint(){
		var endpointNodes,aObj;
		if (window.ActiveXObject){
			endpointNodes=oXMLDoc.selectNodes("//ENDPOINT_COLLECTION/*");
			}
		else{
			endpointNodes=oXMLDoc.getElementsByTagName("ENDPOINT");
			}

			count=endpointNodes.length;
		for (var i=0;i<count;i++) {
			aObj=endpointNodes[i];
			var endpoint_id,endpoint_sub_img
			if (window.ActiveXObject){
				//endpoint_id=document.getElementById(endpointNodes[i].firstChild.firstChild.getAttribute("endpoint_id"));
				endpoint_sub_img=endpointNodes[i].firstChild.childNodes[0];
			}
			else{
				endpoint_sub_img=endpointNodes[i].firstElementChild.childNodes[0];
				//var firstchilddNode;
  				//firstchilddNode=endpointNodes[i].firstChild.nextSibling;
				//endpoint_sub_img=firstchilddNode.childNodes[0];
			}
			//endpoint_id=document.getElementById(endpointNodes[i].firstChild.firstChild.getAttribute("endpoint_id"));
			//endpoint_sub_img=endpointNodes[i].firstChild.childNodes[0];
			//alert(endpoint_sub_img.xml);
			var id = getAttributeValue(endpointNodes[i],"id");
			var strStyle = getAttributeValue(endpoint_sub_img,"style");
			//alert("strStyle="+strStyle);
			var style = new Style();
			style.setStyle(strStyle);
			var node = new NodeImg();
			node.id = getAttributeValue(endpointNodes[i],"endpoint_id");
			//alert("endpoint_Spec_Id="+getAttributeValue(endpointNodes[i],"endpoint_spec_id"));
			node.endpoint_Spec_Id = getAttributeValue(endpointNodes[i],"endpoint_spec_id");
			node.name = getAttributeValue(endpointNodes[i],"endpoint_name");
			node.type = "node";
			node.shape = "img";
			node.number = 3;
			node.left = style.left;
			node.top = style.top;
			node.width = style.width;
			node.height = style.height;
			
			var endpointSpecNode =loadXMLsNode("//ENDPOINT_SPEC_COLLECTION/ENDPOINT_SPEC[@endpoint_spec_id='"+node.endpoint_Spec_Id+"']",oXMLDoc);
			//alert(endpointSpecNode.xml);
			var pic = getAttributeValue(endpointSpecNode,"endpoint_spec_pic");
			node.src = '../resource/common/images/messageArray/endpointSpec/'+pic;
			
			//alert("node.left="+node.left+" node.top="+node.top+" node.width="+node.width+" node.height="+node.height);
			node.property = [{"id":"n_p_id","text":"span","value":"node_1"},
							{"id":"n_p_name","text":"input","value":"流量控制"},
							{"id":"n_p_desc","text":"textarea","value":""},
							{"id":"n_p_group","text":"input","value":""},
							{"id":"n_p_role","text":"input","value":""},
							{"id":"n_p_node","text":"input","value":""},
							{"id":"n_p_num","text":"input","value":""},
							{"id":"n_p_other","text":"input","value":""}];
			node.init();	
		}			
	}
	
	function initServiceRouteConfig(){
		var serviceRouteConfigNodes,aObj;
		//serviceRouteConfigNodes=oXMLDoc.selectNodes("//SERVICE_ROUTE_CONFIG_COLLECTION/*");
		if (window.ActiveXObject){
			serviceRouteConfigNodes=oXMLDoc.selectNodes("//SERVICE_ROUTE_CONFIG_COLLECTION/*");
			}
		else{
			serviceRouteConfigNodes=oXMLDoc.getElementsByTagName("SERVICE_ROUTE_CONFIG");
			}
		var line=null;
		var serviceRouteConfig=null;
		for (var i=0;i<serviceRouteConfigNodes.length;i++) {
			aObj=serviceRouteConfigNodes[i];
			if (window.ActiveXObject)
				{serviceRouteConfigNode=serviceRouteConfigNodes[i].firstChild.firstChild;}
			else{
				var firstchilddNode;
  				firstchilddNode=serviceRouteConfigNodes[i].firstChild.nextSibling;
				serviceRouteConfigNode=firstchilddNode.childNodes[0];
			}
			line = new PolyLine();
			line.id = getAttributeValue(serviceRouteConfigNodes[i],"route_id");
			line.name = getAttributeValue(serviceRouteConfigNode,"name");
			line.type = 'line';
			line.shape = "line";
			line.number = getAttributeValue(serviceRouteConfigNode,"number");
			line.fromX = 267.5;
			line.fromY = 571;
			line.toX = 346.5;
			line.toY = 660;
			line.polyDot = []; 
			//line.property = json.property;
			var nodes = GLOBALOBJECT.nodes;
			var nodeNum = nodes.length;
			var node = null;
			var from_endpoint_id=getAttributeValue(aObj,"from_endpoint_id");
			var to_endpoint_id=getAttributeValue(aObj,"to_endpoint_id");
			for ( var m = 0; m < nodeNum; m++) {
				node = nodes[m];
				if (node.id == from_endpoint_id) {
					line.fromObj = node;
				} else if (node.id == to_endpoint_id) {
					line.toObj = node;
				}
			}			
			line.init();
			line.relink();
		}			
	}
	
	function showMessageInfo(){
		fPropertyChange=false;
		xmlNode=loadXMLsNode("/MESSAGE_FLOW/MESSAGE",oXMLDoc);		
	}
	
	function initConfigInfo(){
		
	}
	
	
	/**
	 * 根据名称获取节点属性值
	 * @param xmlNode
	 * @param name
	 * @return
	 */
	function getAttributeValue(xmlNode,name){
		if(xmlNode.getAttribute(name)!=null)
			return  xmlNode.getAttribute(name);
		else
			return '';
	}
	
	/**
	 * 通过ajax与后数据交互获取信息
	 * @param action
	 * @param xml
	 * @return
	 */
	function ajaxInteractive(action,xml){ 
		var sRet="";
		var oXMLHTTP;
		if (window.XMLHttpRequest){
  			var oXMLHTTP=new XMLHttpRequest();
 	 		}
		else{
  			var oXMLHTTP=new ActiveXObject("Microsoft.XMLHTTP");
  			}
		//var oXMLHTTP=new ActiveXObject("Microsoft.XMLHTTP");
		oXMLHTTP.open("post",document.getElementById("projectRootPath").value+action,false);
		try{
			if (xml==null)
				oXMLHTTP.send();
			else
				oXMLHTTP.send(xml);
			sRet=oXMLHTTP.responseText;
			//alert(oXMLHTTP.responseText);
		} 
		catch(e) { 
			alert(getInternationalMessage("eaap.op2.conf.messageArrange.alert.info.errorInAjaxInteractive")); 
		}
		return sRet;
	}
	
	function newMessage_Flow(oContainer,fConfirm){
		var messageInfo="";
		if (oXMLDoc!=null && fConfirm==null) {
			//messageInfo ="请确认是否要新建消息流？\n\n旧消息流将被新消息流覆盖，操作前请及时存盘！";
			messageInfo = getInternationalMessage("eaap.op2.conf.messageArrange.alert.info.createNewMessageFlowCoverOld");
		}else{
			//messageInfo ="请确认是否要新建消息流?";
			messageInfo = getInternationalMessage("eaap.op2.conf.messageArrange.alert.info.createNewMessageFlow");
		}
		//$.messager.confirm('确认', messageInfo, function(r) {
		$.messager.confirm('Confirm', messageInfo, function(r) {
			if (r) {
				//$.messager.prompt("消息流名称", "请输入新建的消息流名称", function (data) {
				$.messager.prompt(getInternationalMessage("eaap.op2.conf.messageArrange.alert.info.messageFlowName"),
						getInternationalMessage("eaap.op2.conf.messageArrange.alert.info.inputMessageFlowName"), function (data) {
		            if (data) {
						
						oContainer.innerHTML="";
						
						initMessage_FlowInfo(oContainer);
						var newMessageAction="/messageFlow/getNewMessageArrangeData.shtml";
						var actionUrl=newMessageAction+"?";
						var sRet=ajaxInteractive(actionUrl);
						if (window.ActiveXObject) { 
                			if (oXMLDoc==null){oXMLDoc=new ActiveXObject("Microsoft.XMLDOM");}
                			oXMLDoc.async=false;
                			oXMLDoc.loadXML(sRet);
            				} 
            			else { //火狐浏览器 
                			parser=new DOMParser();
							oXMLDoc.async=false;
                			oXMLDoc=parser.parseFromString(sRet,"text/xml");
            				} 
						var flowNode;
						
						if (window.ActiveXObject) { 
							flowNode=oXMLDoc.selectNodes("/MESSAGE_FLOW/MESSAGE")[0];
							flowNode.attributes.getNamedItem("message_flow_name").text=data;
							}
						else{
							flowNode=oXMLDoc.getElementsByTagName("MESSAGE")[0];
							flowNode.attributes.getNamedItem("message_flow_name").value=data;
							}
						resetMenuItemCss('messageFlow','new');
		            }
		        });
			}
		});	
	}
	/**
	 * 添加新的线数据
	 * @param line
	 * @param vml
	 */
	function addNewPolyLineToXML(line,vml){
		xmlNode=loadXMLsNode("//SERVICE_ROUTE_CONFIG_COLLECTION",oXMLDoc);
		var oElem;
		oElem=oXMLDoc.createElement("SERVICE_ROUTE_CONFIG");
		oElem.setAttribute("route_id",line.id);
		oElem.setAttribute("route_policy_id","");
		oElem.setAttribute("from_endpoint_id",line.fromObj.id);
		oElem.setAttribute("to_endpoint_id",line.toObj.id);
		oElem.setAttribute("message_flow_id","");
		oElem.setAttribute("syn_asyn","SYN");
		oElem.setAttribute("state","A");
		oElem.setAttribute("create_date","2013/02/26 11:50:07");
		oElem.setAttribute("lastest_date","2013/02/26 11:50:07");
		xmlNode=xmlNode.appendChild(oElem);
		//alert(oElem.xml);
		tmpDoc=loadXMLStr("<service_route_config_ss xmlns:v='urn:schemas-microsoft-com:vml'>"+vml+"</service_route_config_ss>");
		var tmpNode=tmpDoc.documentElement;
		//alert(tmpNode.xml);
		tmpNode=tmpNode.cloneNode(true);
		xmlNode.appendChild(tmpNode);
		tmpDoc=null;	
	}	
	/**
	 * 拉线时默认加载路由信息
	 */
	function addRouteConf(line){
		//初使化路由操作
		document.getElementById('rule_Strategy_Id').value="";
		document.getElementById('route_Cond_Id').value="";
		document.getElementById('route_Condition').value="";
		document.getElementById('syn_Asyn').value="";
		//展示界面路由信息
		var curNode =loadXMLsNode("//SERVICE_ROUTE_CONFIG_COLLECTION/SERVICE_ROUTE_CONFIG[@route_id='"+line.id+"']",oXMLDoc);
		//this.setPageTabValue("syn_Asyn","select",curNode,'syn_asyn');
		var attrValue = curNode.getAttribute('syn_asyn');
		document.getElementById("syn_Asyn").value = attrValue;
		selectOptionRemove("rule_Strategy_Id");
		
		document.getElementById('rule_Strategy_Id').value=1;//第一项选中
		document.getElementById('nodeImageSelectId').value = line.id;
		document.getElementById('objectSelectType').value = line.type;
		editAttr('rule_strategy_id','1','selected_rule_Strategy_Id');
		//ruleStrategyState(document.getElementById('rule_Strategy_Id'));
		///////////
	}
	/**
	 * 添加端点
	 */
	function addNewEndpointToXML(endpoint,vml){
		//alert("addNewEndpointToXML:"+oXMLDoc.xml);
		var xmlNode=loadXMLsNode("//ENDPOINT_COLLECTION",oXMLDoc);
		//判断此节点在XML是否存在
		var oElem;
		var existElem = getObjectInXML(xmlNode,'endpoint',endpoint.id);
		if(existElem==null){
			oElem=oXMLDoc.createElement("ENDPOINT");
			oElem.setAttribute("endpoint_id",endpoint.id);
			oElem.setAttribute("endpoint_spec_id",endpoint.endpoint_Spec_Id);
			oElem.setAttribute("endpoint_name",endpoint.name);
			oElem.setAttribute("in_data_type_id","1");
			oElem.setAttribute("out_data_type_id","1");
			//oElem.setAttribute("endpoint_code","test"+endpoint.id);
			oElem.setAttribute("enable_in_trace","Y");
			oElem.setAttribute("enable_out_trace","Y");
			oElem.setAttribute("enable_in_log","Y");
			oElem.setAttribute("enable_out_log","Y");
			oElem.setAttribute("state","A");
			oElem.setAttribute("lastest_date","2013/02/26 11:50:07");
			oElem.setAttribute("endpoint_desc","");
			xmlNode=xmlNode.appendChild(oElem);	
			var tmpDoc=loadXMLStr("<endpoint_ss xmlns:v='urn:schemas-microsoft-com:vml'>"+vml+"</endpoint_ss>")
			var tmpNode=tmpDoc.documentElement;
			//alert(tmpNode.xml);
			tmpNode=tmpNode.cloneNode(true);
			xmlNode.appendChild(tmpNode);
			tmpDoc=null;
		}else{
			oElem=existElem;
			xmlNode=existElem;
		}		
	}
	
	function getObjectInXML(xmlNode,type,id){
		var oElem=null;
		if(type=='endpoint'){
			var oElem=loadXMLsNode("//ENDPOINT_COLLECTION/*[@endpoint_id='"+id+"']",oXMLDoc);
			return oElem
		}
	}
	
	/**
	 * 编辑属性时将值保存到对应XML节点中
	 * @param attrName
	 * @param attrVal
	 * @param attrObj
	 * @return
	 */
	function editAttr(attrName,attrVal,attrObj){
		//var num = g.selectedObj.length;
		var routePloicyNode = null;
		if (attrVal==null) return;
		var attrNode=null; 
		var selectNodeSelectId =document.getElementById('nodeImageSelectId').value;
		var objectSelectType =document.getElementById('objectSelectType').value;
		
		if(selectNodeSelectId ==null||selectNodeSelectId ==''){
			return;
		}
		if (attrObj) {
			if(objectSelectType=='node'){
				xmlNode=loadXMLsNode("/MESSAGE_FLOW//*[@id='E"+selectNodeSelectId+"']",oXMLDoc);
				xmlNode=xmlNode.parentNode.parentNode;
				attrNode=xmlNode.attributes.getNamedItem(attrName);
				if(attrName=='endpoint_Name')
					attrNode=xmlNode.attributes.getNamedItem('endpoint_name');				
			}else if(objectSelectType=='line'){
				xmlNode=loadXMLsNode("/MESSAGE_FLOW//*[@route_id='"+selectNodeSelectId+"']",oXMLDoc);
				//xmlNode=xmlNode.parentNode.parentNode;
				attrNode=xmlNode.attributes.getNamedItem(attrName);
				if(attrName=='route_cond_id'){
					if(loadXMLsNode("/MESSAGE_FLOW//*[@route_id='"+selectNodeSelectId+"']//ROUTE_POLICY",oXMLDoc)==null){
						var oElem;
						//var route_policy_id = getNewRuleStrategyId();  
						var route_policy_id = getNewRouteConfId();    
						oElem=oXMLDoc.createElement("ROUTE_POLICY");
						oElem.setAttribute("route_cond_id","");
						oElem.setAttribute("route_policy_id",route_policy_id);
						oElem.setAttribute("rule_strategy_id","");
						xmlNode.setAttribute("route_policy_id",route_policy_id);
						xmlNode=xmlNode.appendChild(oElem);
					}
					routePloicyNode = loadXMLsNode("/MESSAGE_FLOW//*[@route_id='"+selectNodeSelectId+"']//ROUTE_POLICY",oXMLDoc);					
					attrNode=routePloicyNode.attributes.getNamedItem(attrName);	
				}
				if(attrName=='rule_strategy_id'){
					if(loadXMLsNode("/MESSAGE_FLOW//*[@route_id='"+selectNodeSelectId+"']//ROUTE_POLICY",oXMLDoc)==null){
						var oElem;
						var route_policy_id = getNewRulePolicyId();
						oElem=oXMLDoc.createElement("ROUTE_POLICY");
						oElem.setAttribute("route_cond_id","");
						oElem.setAttribute("route_policy_id",route_policy_id);
						oElem.setAttribute("rule_strategy_id","");
						xmlNode.setAttribute("route_policy_id",route_policy_id);
						xmlNode=xmlNode.appendChild(oElem);
					}					
					routePloicyNode = loadXMLsNode("/MESSAGE_FLOW//*[@route_id='"+selectNodeSelectId+"']//ROUTE_POLICY",oXMLDoc);
					attrNode=routePloicyNode.attributes.getNamedItem(attrName);	
				}
					
			}

		}
		if (xmlNode==null) {
			alert("无法从XML文件中找到对应节点");
			return;
		}
		
		//气愤，为了处理这些特殊字符，还要写了这么多垃圾
		attrVal=attrVal.replace(/"/gi,'&quot;');
		//attrVal=attrVal.replace(/'/gi,'&apos;');
		attrVal=attrVal.replace(/</gi,'&lt;');
		attrVal=attrVal.replace(/>/gi,'&gt;');
		
		attrVal=attrVal.replace(/&apos;/gi,'`0~!apos;');
		attrVal=attrVal.replace(/&quot;/gi,'`0~!quot;');
		attrVal=attrVal.replace(/&lt;/gi,'`0~!lt;');
		attrVal=attrVal.replace(/&gt;/gi,'`0~!gt;');
		attrVal=attrVal.replace(/&amp;/gi,'`0~!amp;');
		attrVal=attrVal.replace(/&/gi,'&amp;');
		attrVal=attrVal.replace(/`0~!/gi,'&');
		if (window.ActiveXObject){
			if (attrNode!=null&&attrNode.text!=attrVal) {
				attrNode.text=attrVal;
				}
			}
		else{
			if (attrNode!=null&&attrNode.value!=attrVal) {
				attrNode.value=attrVal;
				}
			}
		if(attrName=='endpoint_Name'){
			var divobj=document.getElementById("T"+selectNodeSelectId);
			divobj.innerHTML=attrVal;
		}
	}
	
	/**
	 * 编辑属性时将值保存到对应XML节点中
	 * @param attrName
	 * @param attrVal
	 * @param attrObj
	 * @return
	 */
	function editDynamicAttr(attrName,attrVal,attrObj,endpoint_Spec_Attr_Id){
		if (attrVal==null) return;
		var attrNode=null; 
		var selectNodeSelectId =document.getElementById('nodeImageSelectId').value;
		var objectSelectType =document.getElementById('objectSelectType').value;
		
		if(selectNodeSelectId ==null||selectNodeSelectId ==''){
			return;
		}
		if (attrObj) {
			if(objectSelectType=='node'){
				endpointNode=loadXMLsNode("/MESSAGE_FLOW/ENDPOINT_COLLECTION/ENDPOINT[@endpoint_id='"+selectNodeSelectId+"']",oXMLDoc)
				if(endpointNode!=null){
					xmlNode=loadXMLsNode("/MESSAGE_FLOW/ENDPOINT_COLLECTION/ENDPOINT[@endpoint_id='"+selectNodeSelectId+"'/ENDPOINT_ATTR_VALUE_COLLECTION/ENDPOINT_ATTR_VALUE[@endpoint_id='"
							+selectNodeSelectId+"' and @endpoint_spec_attr_id='"+endpoint_Spec_Attr_Id+"']",oXMLDoc);
					attrNode=xmlNode.attributes.getNamedItem(attrName);
					if(attrName=='endpoint_Name')
						attrNode=xmlNode.attributes.getNamedItem('endpoint_name');						
				}
			
			}else if(objectSelectType=='line'){
				xmlNode=loadXMLsNode("/MESSAGE_FLOW//*[@route_id='"+selectNodeSelectId+"']",oXMLDoc)
				attrNode=xmlNode.attributes.getNamedItem(attrName);					
			}

		}
		
		//气愤，为了处理这些特殊字符，还要写了这么多垃圾
//		attrVal=attrVal.replace(/"/gi,'&quot;');
//		//attrVal=attrVal.replace(/'/gi,'&apos;');
//		attrVal=attrVal.replace(/</gi,'&lt;');
//		attrVal=attrVal.replace(/>/gi,'&gt;');
//		
//		attrVal=attrVal.replace(/&apos;/gi,'`0~!apos;');
//		attrVal=attrVal.replace(/&quot;/gi,'`0~!quot;');
//		attrVal=attrVal.replace(/&lt;/gi,'`0~!lt;');
//		attrVal=attrVal.replace(/&gt;/gi,'`0~!gt;');
//		attrVal=attrVal.replace(/&amp;/gi,'`0~!amp;');
//		//attrVal=attrVal.replace(/&/gi,'&amp;');
//		attrVal=attrVal.replace(/`0~!/gi,'&');
		if (window.ActiveXObject){
			if (attrNode!=null&&attrNode.text!=attrVal) {
				attrNode.text=attrVal;
				}
			}
		else{
			if (attrNode!=null&&attrNode.value!=attrVal) {
				attrNode.value=attrVal;
				}
			}
	}	

	function getNewRouteConfId(){
		var rule_strategy_id = ajaxInteractive("/serviceRouteConfig/getServiceRouteCondSequence.shtml");
		return rule_strategy_id;
	}
	
	function getNewRulePolicyId(){
		var rule_strategy_id = ajaxInteractive("/serviceRouteConfig/getRulePolicySequence.shtml");
		return rule_strategy_id;
	}
	
	//改变环节名字保存了到XML中
	function chgEndpointNameToXml(xml_node,act_name) {
		var act_node=getXmlChildByName(xml_node,"v:textbox");
		if (act_node!=null) {
			act_node.text=act_name;
		}
		else 
			alert("no found");
	}	
	
	//根据 名字获取XML中子对象
	function getXmlChildByName(xml_node,ElemName) {  
		for (var i=0;i<xml_node.childNodes.length;i++) {
		var node=xml_node.childNodes.item(i);
		if (node.nodeName==ElemName) 
			return node;
		else if (node.hasChildNodes())
			return getXmlChildByName(node,ElemName);
		}
	}
	
    function show(){
        document.getElementById("fugai").style.display="block";
        document.getElementById("ch").style.display="";
        document.getElementById("ch").style.left="50px";
        document.getElementById("ch").style.top="20px";
    }
    function choose(value){
        document.getElementById("fugai").style.display="none";
        document.getElementById("ch").style.display="none";
        document.getElementById("address").firstChild.data=value;
    }
    function move(element,event){
        var x=parseInt(element.style.left);
        var y=parseInt(element.style.top);
        var maxLeft=parseInt(document.body.clientWidth)-parseInt(element.clientWidth);
        var maxTop=parseInt(document.body.clientHeight)-parseInt(element.clientHeight);

        var deltaX=event.clientX-x;
        var deltaY=event.clientY-y;
        //添加临时事件
        if(document.addEventListener){//2级DOM
            document.addEventListener("mousemove",moveHandler,true);
            document.addEventListener("mouseup",upHandler,true);
        }else if(document.attachEvent){//IE5+
            document.attachEvent("onmousemove",moveHandler);
            document.attachEvent("onmouseup",upHandler);
        }else{//IE4
            var oldonmousemove=document.onmousemove;
            var oldonmouseup=document.onmouseup;
            document.onmousemove=moveHandler;
            document.onmouseup=upHandler;
        }
        //我们处理该事件,不让其他元素见到它
        if(event.preventDefault){//2级DOM
            event.preventDefault();
        }else{//IE
            event.returnValue=false;
        }

        //鼠标移动事件
        function moveHandler(e){
            if(!e){//IE
                e=window.event;
            }

            element.style.left=(e.clientX-deltaX)+"px";
            element.style.top=(e.clientY-deltaY)+"px";
            var left=parseInt(element.style.left);
            var top=parseInt(element.style.top);
            if(left<0){
                element.style.left="0px";
            }
            if(left>maxLeft){
                element.style.left=maxLeft+"px";
            }
            if(top<0){
                element.style.top="0px";
            }
            if(top>maxTop){
                element.style.top=maxTop+"px";
            }
            if(e.stopPropagation){//2级DOM
                e.stopPropagation();
            }else{//IE
                e.cancelBubble=true;
            }
        }
        //鼠标按键弹起
        function upHandler(e){
            if(!e){
                e=window.event;
            }
            if(document.removeEventListener){//2级DOM
                document.removeEventListener("mouseup",upHandler,true);
                document.removeEventListener("mousemove",moveHandler,true);
            }else if(document.detachEvent){//IE5+
                document.detachEvent("onmouseup",upHandler);
                document.detachEvent("onmousemove",moveHandler);
            }else{//IE4
                document.onmouseup=oldonmouseup;
                document.onmousemove=oldonmousemove;
            }
            if(e.stopPropagation){//2级DOM
                e.stopPropagation();
            }else{//IE
                e.cancelBubble=true;
            }
        }
    }
    
    /**
     * 在鼠标悬停时突出显示行--jQuery处理表格  
     *
     * @tab table id
     */
    function addHover(tab){
       $('#'+tab+' tr').hover(
          function(){
             $(this).find('td').addClass('hover');
          },
       function(){
          $(this).find('td').removeClass('hover');
       }
       );
    } 
	//火狐获取XML字符串   
	function serializeXml(oNode) {
         var oSerializer = new XMLSerializer();
         return oSerializer.serializeToString(oNode);
     } 