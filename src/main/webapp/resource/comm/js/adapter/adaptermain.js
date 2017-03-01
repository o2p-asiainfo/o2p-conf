	var xmlTarDoc=null;   //目标文档XML结构对象
	var targetDocumentStructure=null;  //目标文档XML树
	var xmlAdapterConfigDoc=null;  //对应数据库中的协议适配信息
	var projectRootPath="";
	
	function testProtocalAdapter(){
		var exampleSrcDocument = document.getElementById("exampleSrcDocument").value;
		var adapterId = document.getElementById("adapterId").value;
		var inProtocol = document.getElementById("inProtocol").value;
		var outProtocol = document.getElementById("outProtocol").value;
		var outType = document.getElementById("outType").value;
		var inType = document.getElementById("inType").value;
		var adapterProcessCode = document.getElementById("adapterProcessCode").value;
		if(exampleSrcDocument==''){
			//$.messager.alert('提示','请输入源报文','info'); 
			$.messager.alert('Prompt','Please make sure the source xml is not null!','info');
			return;
		}
		var actionUrl = "/adapter/testProtocalAdapter.shtml?"
		var param="adapterId="+adapterId+"&inProtocol="+inProtocol+"&outProtocol="+outProtocol+"&adapterProcessCode="
				+adapterProcessCode+"&outType="+outType+"&inType="+inType;
		var sRet="";
		if(inType=="1"){
			sRet=ajaxInteractive(actionUrl+param,exampleSrcDocument);
		}else if(inType=="2"){
			//入参是地址类型 的话，将其封装成一个XML
			param = param+"&exampleSrcDocument="+exampleSrcDocument;
			var paramXml = null;
			paramXml=new ActiveXObject("Microsoft.XMLDOM");
			var strXML = "<PARAMS></PARAMS>";
			paramXml.loadXML(strXML);
			var paramsNode = paramXml.selectSingleNode("/PARAMS");
			var paramNode;
			paramNode = paramXml.createElement("exampleSrcDocument");	
			paramNode.text = exampleSrcDocument;
			paramsNode=paramsNode.appendChild(paramNode);
			sRet=ajaxInteractive(actionUrl+param,paramXml);
		}
		document.getElementById("tarDocument").value=sRet;
	}
	
	function loadTargetDoucumentStructure(adapterId){
		loadProtocolAdapterConfigInfo(adapterId);
		initTargetDoucumentStructure(adapterId);
		refreshTargetDoucumentStructure(adapterId);
	}
	
	/**
	 * 初始化目标文档树结构
	 * @return
	 */
	function initTargetDoucumentStructure(adapterId){
		targetDocumentStructure = new dhtmlXTreeObject("targetDocumentStructure","100%","100%","0");
		projectRootPath = document.getElementById("projectRootPath").value;
		targetDocumentStructure.setImagePath(projectRootPath+"/resource/comm/images/dhtmlxTree/imgs/books/");
		getTreeStructure(adapterId);
		targetDocumentStructure.loadXMLString(xmlTarDoc.xml);
		var inType=document.getElementById("inType").value;
		if(inType=='1')
			complementTargetDoucumentStructure();
		targetDocumentStructure.setOnClickHandler(
				function(id){
					targetDoucumentNodeOnClick(id,adapterId);
				})
	}
	
	/**
	 * 刷新目标文档树结构
	 * @return
	 */
	function refreshTargetDoucumentStructure(adapterId){ 
		if(targetDocumentStructure!=null)
			targetDocumentStructure.destructor();
		
		try{
			targetDocumentStructure = new dhtmlXTreeObject("targetDocumentStructure","100%","100%","0");
			projectRootPath = document.getElementById("projectRootPath").value;
			targetDocumentStructure.setImagePath(projectRootPath+"/resource/comm/images/dhtmlxTree/imgs/books/");
			targetDocumentStructure.loadXMLString(xmlTarDoc.xml);
			targetDocumentStructure.setOnClickHandler(
					function(id){
						targetDoucumentNodeOnClick(id,adapterId);
					})			
		}
		catch(e){
			//alert(e);
			$.messager.alert('Prompt',e,'info');
		}
		//initOperateListTableHeader();
	}
	
	/**
	 * 对目标文档树结构进行根据数据库节点配置XML信息进行补充
	 * @return
	 */
	function complementTargetDoucumentStructure(){
		var adapter_Node_ConfigCollectionNodes = xmlAdapterConfigDoc.selectNodes("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION");
		var tempVar =targetDocumentStructure;
		for(var i=0;i<adapter_Node_ConfigCollectionNodes.length;i++){
			var adapter_Node_ConfigCollectionNode = adapter_Node_ConfigCollectionNodes[i];
			var adapter_Node_ConfigNodes = adapter_Node_ConfigCollectionNode.selectNodes("./APAPTER_NODE_CONFIG");
			for(var j=0;j<adapter_Node_ConfigNodes.length;j++){
				var adapter_Node_ConfigNode = adapter_Node_ConfigNodes[j];
				addAdapter_Node_ConfigNodeToTargetDoucument(adapter_Node_ConfigNode);
			}
		}
	}
	
	/**
	 * 将配置文件中的配置信息补充到目标文档树结构
	 * @param node
	 * @return
	 */
	function addAdapter_Node_ConfigNodeToTargetDoucument(node){
		var xml_Path = node.attributes.getNamedItem("xml_path").text;
		var node_Name = node.attributes.getNamedItem("node_name").text;
		//判断当前节点在不在目标文档树结构中
		xml_Path = addBackslashToPath(xml_Path);
		//var targetTreeNode = targetDocumentStructure._globalIdStorageFind(xml_Path);
		var nodeInTarDoc = xmlTarDoc.selectSingleNode("/tree//item/*[@id='"+xml_Path+"']");
		if(nodeInTarDoc==null){	
			//不在则加入目标文档树中
			//先找到父节点然后加入
			var parentIndex = xml_Path.lastIndexOf("/"+name);
			var xml_ParentPath = xml_Path.substring(0,parentIndex);
			//添加到目标文档XML
			var addNodeParentInTarDoc = xmlTarDoc.selectSingleNode("/tree//item/*[@id='"+xml_ParentPath+"']");
			if(addNodeParentInTarDoc!=null){
				/**
				 * 
				 * 
				 *
				 * 
				 */
				var itemNode;
				itemNode=xmlTarDoc.createElement("item");
				itemNode.setAttribute("text",node_Name);
				itemNode.setAttribute("id",xml_Path);
				itemNode.setAttribute("im0",'leaf.gif');
				itemNode.setAttribute("im1",'leaf.gif');
				itemNode.setAttribute("im2",'leaf.gif');
				addNodeParentInTarDoc = addNodeParentInTarDoc.appendChild(itemNode);				
			}

			//targetDocumentStructure.refreshItem(xml_Path);
			/**
			var treeParentNode = targetDocumentStructure._globalIdStorageFind(xml_ParentPath);
			targetDocumentStructure.insertNewItem(xml_ParentPath,xml_Path,node_Name,alert(xml_Path)
					,'leaf.gif','leaf.gif','leaf.gif');*/
		}
	}
	
	
	/**
	 * 将源报文传到后台解析获取树结构
	 * 或直接从后台获取模板的树结构
	 * @return
	 */
	function  getTreeStructure(adapterId){
		var actionUrl = "/adapter/generateTreeStructure.shtml?adapterId="+adapterId;
		var sRet=ajaxInteractive(actionUrl);
		try{
			xmlTarDoc = $.parseXML(sRet);
			if(xmlTarDoc.parseError!=undefined){
				if (xmlTarDoc.parseError.errorCode!=0) {
					/**
					alert("错误信息:Open Model "+xmlTarDoc.parseError.reason);
					alert("XML解析出错!错误信息如下:\n\错误代号:"
							+xmlTarDoc.parseError.errorCode
							+"\n\文件:"+xmlTarDoc.parseError.filePos
							+"\n\行:"+xmlTarDoc.parseError.line
							+"\n\字符:"+xmlTarDoc.parseError.linepos
							+"\n\相关信息:"+xmlTarDoc.parseError.reason
							+"\n\srcText:"+xmlTarDoc.parseError.srcText);
							*/
					$.messager.alert('Prompt','Error info:open model '+xmlTarDoc.parseError.reason,'info');
					$.messager.alert('Prompt',
								'XML parse error!The info :\n\errorcode:'
								+xmlTarDoc.parseError.errorCode
								+'\n\file:'+xmlTarDoc.parseError.filePos
								+'\n\line:'+xmlTarDoc.parseError.line
								+'\n\char:'+xmlTarDoc.parseError.linepos
								+'\n\relation info:'+xmlTarDoc.parseError.reason
								+'\n\srcText:'+xmlTarDoc.parseError.srcText,
							'info');
				 	return;
				}
			}
		}catch(e){
			$.messager.alert('Prompt','occur parse exception:'+e.message,'error');
		}

	}
	
	/**
	 * 获取协议适配ID的相关数据库配置信息
	 * @param adapterId
	 * @return
	 */
	function loadProtocolAdapterConfigInfo(adapterId){
		var actionUrl = "/adapter/getAdapterConfigInfo.shtml?adapterId="+adapterId;
		var sRet=ajaxInteractive(actionUrl);
		try{
			xmlAdapterConfigDoc = $.parseXML(sRet);
			if(xmlAdapterConfigDoc.parseError!=undefined){
				if (xmlAdapterConfigDoc.parseError.errorCode!=0) {
					/**
					alert("错误信息:Open Model "+xmlAdapterConfigDoc.parseError.reason);
					alert("XML解析出错!错误信息如下:\n\错误代号:"
							+xmlAdapterConfigDoc.parseError.errorCode
							+"\n\文件:"+xmlAdapterConfigDoc.parseError.filePos
							+"\n\行:"+xmlAdapterConfigDoc.parseError.line
							+"\n\字符:"+xmlAdapterConfigDoc.parseError.linepos
							+"\n\相关信息:"+xmlAdapterConfigDoc.parseError.reason
							+"\n\srcText:"+xmlAdapterConfigDoc.parseError.srcText);	
					*/		
					$.messager.alert('Prompt','Error info:open model '+xmlAdapterConfigDoc.parseError.reason,'info');
					$.messager.alert('Prompt',
								'XML parse error!The info :\n\errorcode:'
								+xmlAdapterConfigDoc.parseError.errorCode
								+'\n\file:'+xmlAdapterConfigDoc.parseError.filePos
								+'\n\line:'+xmlAdapterConfigDoc.parseError.line
								+'\n\char:'+xmlAdapterConfigDoc.parseError.linepos
								+'\n\relation info:'+xmlAdapterConfigDoc.parseError.reason
								+'\n\srcText:'+xmlAdapterConfigDoc.parseError.srcText,
							'info');		
				 	return;
				}
			}
		}catch(e){
			$.messager.alert('Prompt','occur parse exception:'+e.message,'error');
		}

		
	}
	/**
	 * 树节点单击事件
	 * @param id
	 * @param adapterId
	 * @return
	 */

	function targetDoucumentNodeOnClick(id,adapterId){
		//clearPreNodeInfo(); 
		initOperateListTableHeader();
		showNodeBaseInfo(id);
		showNodeOperatelist(id);
	}
	
	/**
	 * 初始表格的表头信息
	 * @return
	 */
	function initOperateListTableHeader(){
		clearOperateListTable();
		var table = document.getElementById("nodeOperateList");
		//if(table.rows==0){
			var headRow=table.insertRow();
			headRow.height=20;
			newcell=headRow.insertCell();
			newcell.style.cssText="width:20%";
			newcell.innerHTML="<span class='text_font_title'>Operate Type</span>";
			newcell=headRow.insertCell();
			newcell.style.cssText="width:20%";
			newcell.innerHTML="<span class='text_font_title'>Node name</span>";
			newcell=headRow.insertCell();
			newcell.style.cssText="width:20%";
			newcell.innerHTML="<span class='text_font_title'>Adapter method</span>";
			newcell=headRow.insertCell();
			newcell.style.cssText="width:20%";
			newcell.innerHTML="<span class='text_font_title'>Operate</span>";	
		//}
	}	
	
	/**
	 * 清除上次点击节点的信息
	 * @return
	 */
	function clearPreNodeInfo(){
		var table = document.getElementById("nodeOperateList");
		for(var i=table.rows.length-1;i>0;i--)
			table.deleteRow(i);
		
	}
	
	/**
	 * 清除表格
	 * @return
	 */
	function clearOperateListTable(){
		var table = document.getElementById("nodeOperateList");
		for(var i=table.rows.length-1;i>=0;i--)
			table.deleteRow(i);
		
	}	
	
	/**
	 * 显示有关当前节点的基本信息
	 * @param id
	 * @return
	 */
	function showNodeBaseInfo(id){
		var curSelectNodeText = document.getElementById("curSelectNodeText");
		var curSelectNodePath = document.getElementById("curSelectNodePath");
		var text = targetDocumentStructure.getItemText(id);
		var parendId = targetDocumentStructure.getParentId(id);
		curSelectNodeText.innerHTML=text;
		curSelectNodePath.innerHTML=id;
		//界面隐藏信息
		//获取当前节点在xmlAdapterConfigDoc配置信息XML中的数据
		var path = id;
		var parentPath= parendId;
		var pathOther = getPathOtherType(path);	
		var parentPathOther = getPathOtherType(parentPath);	
		var adapterNodeConfigNodes = xmlAdapterConfigDoc.selectNodes("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION/APAPTER_NODE_CONFIG[contains(@xml_path,'"+path
				+"') or contains(@xml_path,'"+pathOther+"')]");	
		var adapterNodeConfigParentNodes = xmlAdapterConfigDoc.selectNodes("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION/APAPTER_NODE_CONFIG[contains(@xml_path,'"+parentPath
				+"') or contains(@xml_path,'"+parentPathOther+"')]");
		if(adapterNodeConfigParentNodes.length>0){
			//父节点在xmlAdapterConfigDoc配置信息XML中有配置信息
			//根据父路径查找的父节点的配置的数据目前只允许有一条
			var adapterNodeConfigParentNode = adapterNodeConfigParentNodes[0];
			var parent_Node_Id = getValueFromNodeConfigXml(adapterNodeConfigParentNode,"node_id");
			$("#currentParentNodeConfigFlag").val("true");
			$("#currentParentNodeId").val(parent_Node_Id);
		}else{
			$("#currentParentNodeConfigFlag").val("false");
			$("#currentParentNodeId").val("");
		}		
		if(adapterNodeConfigNodes.length>0){
			//当前节点在xmlAdapterConfigDoc配置信息XML中有配置信息
			$("#currentNodeConfigFlag").val("true");
		}else{
			$("#currentNodeConfigFlag").val("false");
		}
		$("#currentNodeId").val(id);
	}
	
	/**
	 * 显示有关节点的操作信息
	 * @param id
	 * @return
	 */	
	function showNodeOperatelist(id){
		showNodeOperateListAddSub(id);
		showNodeOperateListModifyCurrent(id);
		showNodeOperateListDeleteCurrent(id);		
	}
	
	/**
	 * 通过ajax与后数据交互获取信息
	 * @param action
	 * @param xml
	 * @return
	 */
	function ajaxInteractive(action,xml){  
		var sRet="";
		var reqUrl = document.getElementById("projectRootPath").value+action;
		try{
			$.ajax({
				url:reqUrl,
				async:false,
				cache: false,
				processData: false,
				contentType:'text/plain; charset=UTF-8',
				data: xml,
				type:"POST",
				dataType:"text",
				success:function(retData){
					sRet = retData;	
				}
			});
		}catch(e){
			$.messager.alert('Prompt','Error Ocurr in ajaxInteractive','info');
		}
		return sRet;
	}	
	
	/**
	 * 通过ajax与后数据交互获取信息,处理较长的参数
	 * @param action
	 * @param xml
	 * @return
	 */
	/**
	function ajaxInteractiveWithLongPara(action,xml){  
		var sRet="";
		var oXMLHTTP=new ActiveXObject("Microsoft.XMLHTTP");
		oXMLHTTP.open("post",document.getElementById("projectRootPath").value+action,false);
		//设置头，模拟form表单提交
		oXMLHTTP.setRequestHeader('Content-Type','application/x-www-form-urlencoded'); 
		try{
			if (para==null)
				oXMLHTTP.send(para);
			else
				oXMLHTTP.send(para);
			sRet=oXMLHTTP.responseText;
			//alert(oXMLHTTP.responseText);
		} 
		catch(e) { 
			alert("Error Ocurr in ajaxInteractive "); 
		}
		return sRet;
	}*/	
	
	/**
	 * 根据不同的类型及传入编码返回指定值
	 * @param type
	 * @param code
	 * @return
	 */
	function getCodeValueByCode(type,code){
		var value="";
		if(type=='content_type'){
			if(code=='1'){
				//value="固定值";
				value="Fix";
			}else if(code=='2'){
				//value="源报文";
				value="Source XML";
			}else if(code=='3'){
				//value="数据库";
				value="Database";
			}else if(code=='4'){
				//value="条件约束";
				value="Conditional";
			}else if(code=='5'){
				//value="扩展方式";
				value="Extend method";
			}			
		}
		return value;
	}
	
	/**
	 * 对于XML路径查询如果原来路径是以/开始的，则返回另一种不以/开始
	 * 对于XML路径查询如果原来路径不是以/开始的，则返回另一种以/开始
	 * @return
	 */
	function getPathOtherType(path){
		var pathOther = "";
		if(path!=null&& path.length>0){
			var start = path.charAt(0);
			if(start=='/'){
				pathOther = path.substr(1,path.length-1);
			}else{
				pathOther = "/"+path;
			}
		}
		return pathOther;
	}
	
	/**
	 * 根据xml_path进行拆分判断是否是子节点
	 * @param xml_path 当前节点的xml_path
	 * @param xml_path 父节点的path
	 * @return
	 */
	function judgeSubNodeOrNot(xml_path,path){
		if (xml_path==null||xml_path=="")
			return "false";
		if (path==null||path=="")
			return "false";	
		var xml_pathStart = xml_path.charAt(0);
		var pathStart = path.charAt(0);
		if(xml_pathStart!="/")
			xml_path="/"+xml_path;
		if(pathStart!="/")
			path="/"+path;		
		var remainStr = xml_path.substring(path.length, xml_path.length);
		/**
		var remainStrStart = path.charAt(0);
		if(remainStrStart=="/")
			remainStr = remainStr.substring(1, remainStr.length);
		*/
		var remainStrArray=remainStr.split("/");
		if(remainStrArray.length==2){
			return "true";
		}else{
			return "false";
		}
	}
	
	/**
	 * 在路径前面加反斜扛
	 * @param xml_path
	 * @return
	 */
	function addBackslashToPath(xml_path){
		if (xml_path==null||xml_path=="")
			return "";		
		var xml_pathStart = xml_path.charAt(0);
		if(xml_pathStart!="/")
			xml_path="/"+xml_path;
		return xml_path;
	}
	
	/**
	 * 修改具体某个配置
	 * @param type  1 表法添加子节中  2 表示修改当前节点  3表示删除当前节点
	 * @param node
	 * @param nodeContentNode
	 * @return
	 */
	function detailConfigInfoModify(type,content_type,node_Id,node_Oper_Id){
		///1,"+node+","+nodeContentNode+"
		if(type=='1'){
			detailConfigInfoModify_AddSubNode(content_type,node_Id,node_Oper_Id);
			$('#currentClickOperate').val('addSubNodeModifyDetailConfig');
		}else if(type=='2'){
			detailConfigInfoModify_ModifyCurrentNode(content_type,node_Id,node_Oper_Id);
			$('#currentClickOperate').val('modifyCurrentNodeModifyDetailConfig');
		}
		var currentNodeId = $('#currentNodeId').val();
		var adapterId = $('#adapterId').val();
		targetDoucumentNodeOnClick(currentNodeId,adapterId);		
	}
	
	/**
	 * 删除具体某个配置
	 * @param type  1 表法添加子节点  2 表示修改当前节点  3表示删除当前节点
	 * @param node
	 * @param nodeContentNode
	 * @return
	 */	
	function detailConfigInfoDelete(type,content_type,node_Id,node_Oper_Id){
		$.messager.confirm('Confirm', 'Delete or not ?', function(result) {
			if (result) {
				if(type=='1'){
					detailConfigInfoDelete_AddSubNode(content_type,node_Id,node_Oper_Id);
				}else if(type=='2'){
					detailConfigInfoDelete_ModifyCurrentNode(content_type,node_Id,node_Oper_Id);
				}else if(type=='3'){			
					detailConfigInfoDelete_DeleteCurrentNode(node_Id,node_Oper_Id);
				} 
			}
		});			
	}
	
	/**
	 * 根据节点名去配置XML中取值
	 * @param node
	 * @param attrName
	 * @return
	 */
	function getValueFromNodeConfigXml(node,attrName){
		var attrValue = node.attributes.getNamedItem(attrName).text;
		if(attrValue==null)
			attrValue="";
		return attrValue;
	}
	
	/**
	 * 节点值生成方式下拉选项的值
	 * @return
	 */
	function content_TypeSelectOption(objectId){
		/**
		selectOptionAdd(objectId, "固定值", "1");
		selectOptionAdd(objectId, "源报文", "2");
		selectOptionAdd(objectId, "数据库", "3");
		selectOptionAdd(objectId, "条件关联", "4");
		selectOptionAdd(objectId, "扩展方式", "5");
		*/
		selectOptionAdd(objectId, adapterNodeTypeFix, "1");
		selectOptionAdd(objectId, adapterNodeTypeSrc, "2");
		selectOptionAdd(objectId, adapterNodeTypeDB, "3");
		selectOptionAdd(objectId, adapterNodeTypeCond, "4");
		selectOptionAdd(objectId, adapterNodeTypeExt, "5");		
	}	
	
	/**
	 * 动态添加select选项
	 * @param objectId
	 * @param sName
	 * @param sValue
	 * @return
	 */
	function selectOptionAdd(objectId, sName, sValue) {
		var oListbox = document.getElementById(objectId);	    
	    var oOption = document.createElement("option");
	    oOption.appendChild(document.createTextNode(sName));
	    if (arguments.length == 3) {
	        oOption.setAttribute("value", sValue);
	    }
	    oListbox.appendChild(oOption);    
	}
	
	/**
	 * 编辑属性时将值保存到对应XML节点中
	 * @param attrName
	 * @param attrVal
	 * @param attrObj
	 * @return
	 */
	function editAttr(attrName,attrVal,node_Id,node_Oper_Id,nodeName,path_Id){
		//addSubNode, modifyCurrentNode,deleteCurrentNode,addSubNodeModifyDetailConfig,modifyCurrentNodeModifyDetailConfig,deleteDetailConfig
		if($('#currentClickOperate').val()=='addSubNodeModifyDetailConfig'||
				$('#currentClickOperate').val()=='modifyCurrentNodeModifyDetailConfig'){
			var nodeContentConfigNode = 
				xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION"
						+"/APAPTER_NODE_CONFIG/NODE_CONTENT_CONFIG_COLLECTION/NODE_CONTENT_CONFIG[@node_id="
						+node_Id+" and @node_oper_id="+node_Oper_Id+"]");
			if (nodeContentConfigNode == null) {
				//alert("无法从XML文件中找到对应节点");
				$.messager.alert('Prompt','Can not find node in XML!','info');
				return;
			}else{
				if(nodeName=="APAPTER_NODE_CONFIG")
					attrNode=nodeContentConfigNode.parentNode.parentNode.attributes.getNamedItem(attrName);
				if(nodeName=="NODE_CONTENT_CONFIG")
					attrNode=nodeContentConfigNode.attributes.getNamedItem(attrName);
				if(nodeName=="NODE_PATH_CONFIG"){
					var nodePathConfigCollectionNode = nodeContentConfigNode.selectSingleNode("./NODE_PATH_CONFIG_COLLECTION");
					var nodePathConfigNode = nodePathConfigCollectionNode.selectSingleNode("./NODE_PATH_CONFIG[@path_id="+path_Id+"]");
					if(nodePathConfigNode!=null)
						attrNode=nodePathConfigNode.attributes.getNamedItem(attrName);
				}
				//angry
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
				if (attrNode!=null&&attrNode.text!=attrVal) {
					attrNode.text=attrVal;
					//alert("attrNode.text="+attrNode.text);
				}			
			}			
		}
	}
	
	/**
	 * 取新的APAPTER_NODE_CONFIG的节点ID
	 * @return
	 */
	function getNewNodeId(){
		var actionUrl = "/adapter/getNewNodeId.shtml?";
		var sRet=ajaxInteractive(actionUrl);
		return sRet;
	}
	
	/**
	 * 取新的APAPTER_NODE_CONFIG的节点ID
	 * @return
	 */
	function getNewNodeOperId(){
		var actionUrl = "/adapter/getNewNodeOperId.shtml?";
		var sRet=ajaxInteractive(actionUrl);
		return sRet;
	}
	
	/**
	 * 取新的NODE_PATH_CONFIG的节点ID
	 * @return
	 */	
	function getNewPathId(){
		var actionUrl = "/adapter/getNewPathId.shtml?";
		var sRet=ajaxInteractive(actionUrl);
		return sRet;
	}	
	
	/**
	 * 保存协议配置数据
	 * @return
	 */
	function saveProcotolAdapter(){
		var actionUrl = "/adapter/saveProcotolAdapter.shtml?";
		var sRet=ajaxInteractive(actionUrl,xmlAdapterConfigDoc.xml);
		var retDoc=new ActiveXObject("Microsoft.XMLDOM");
		retDoc.async=false;
		retDoc.loadXML(sRet);
		if (retDoc.parseError.errorCode!=0) {
			//alert("保存过程出现错误！\n"+retDoc.parseError.errorCode+sRet);
			$.messager.alert('Prompt','Save error！\n'+retDoc.parseError.errorCode+sRet,'info');
			return;
		}
		sRet=retDoc.selectSingleNode("//ERROR").text;
		var adapterId=retDoc.selectSingleNode("//protocolAdapter").text;
		retDoc=null;
		if (sRet=="success") {
			$.messager.alert('Prompt','Save success and refresh page!','info');
			loadProtocolAdapterConfigInfo(adapterId);
			initTargetDoucumentStructure(adapterId);
			refreshTargetDoucumentStructure(adapterId);
			targetDocumentStructure.openItem(document.getElementById("curSelectNodePath").innerHTML);
		}
		else
			$.messager.alert('Prompt','Save error!\n','info');
			//alert("存失败保！");	
		
	}
	
	function deleteXpathConfig(row_Path_Id,deleteType){
		var index=document.getElementById(row_Path_Id).rowIndex;
		var path_IdStartIndex = "";
		var path_Id="";
		var table;
		if(deleteType=='1'){
			path_IdStartIndex = row_Path_Id.indexOf("addSubNodeNodeConfigPathTableRow_");
			path_Id =row_Path_Id.substring(path_IdStartIndex+"addSubNodeNodeConfigPathTableRow_".length,row_Path_Id.length);
			table = document.getElementById("addSubNodeNodeConfigPathTable");
		}else if(deleteType=='2'){
			path_IdStartIndex = row_Path_Id.indexOf("modifyCurrentNodeNodeConfigPathTableRow_");
			path_Id =row_Path_Id.substring(path_IdStartIndex+"modifyCurrentNodeNodeConfigPathTableRow_".length,row_Path_Id.length);
			table = document.getElementById("modifyCurrentNodeNodeConfigPathTable");
		}
		table.deleteRow(index);		
		//删除xmlAdapterConfigDoc中的节点路径
		var nodePathConfigNode = 
			xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION/APAPTER_NODE_CONFIG/"
					+"NODE_CONTENT_CONFIG_COLLECTION/NODE_CONTENT_CONFIG/NODE_PATH_CONFIG_COLLECTION/NODE_PATH_CONFIG"
					+"[@path_id="+path_Id+"]");
		if(nodePathConfigNode!=null)
			nodePathConfigNode.parentNode.removeChild(nodePathConfigNode);
	}
	
	function textXpath(type,path_Id){
		if(type=='1'){
			var value = document.getElementById("addSubNode_Xml_Path_"+path_Id).value;
		}
	}
	
	function setDataSetValue(data_Set_Id){
		var dataSetManagerIframe = document.getElementById("dataSetManagerIframe").contentWindow;
		var query_SQL = dataSetManagerIframe.document.getElementById("cellQuery_SQL_"+data_Set_Id).innerText;
		if($('#currentClickOperate').val()=='addSubNode'){
			$('#addSubNodeDataSetIdDataBase').val(data_Set_Id);
			$('#addSubNodeQuery_SQLDataBase').val(query_SQL);
		}else if($('#currentClickOperate').val()=='modifyCurrentNode'){
			$('#modifyCurrentNodeDataSetIdDataBase').val(data_Set_Id);
		}else if($('#currentClickOperate').val()=='addSubNodeModifyDetailConfig'){
			$('#addSubNodeDataSetIdDataBase').val(data_Set_Id);
			var querySQL = getQuerySQL(data_Set_Id);
			$('#addSubNodeQuery_SQLDataBase').val(querySQL);
			editAttr('data_set_id',data_Set_Id,$('#addNodeId').val(),$('#addNodeOperId').val(),'NODE_CONTENT_CONFIG');
		}else if($('#currentClickOperate').val()=='modifyCurrentNodeModifyDetailConfig'){
			$('#modifyCurrentNodeDataSetIdDataBase').val(data_Set_Id);
		}
		$('#dataSetManagerWin').window('close');
	}
	
	function setExtendValue(method_Id){
		var extendManagerIframe = document.getElementById("extendManagerIframe").contentWindow;
		var segmentRealize = extendManagerIframe.document.getElementById("cellSegmentRealize_"+method_Id).innerText;
		if($('#currentClickOperate').val()=='addSubNode'){
			$('#addSubNodeMethodIdExtend').val(method_Id);
			$('#addSubNodeSegmentRealizeExtend').val(segmentRealize);
		}else if($('#currentClickOperate').val()=='modifyCurrentNode'){
			$('#modifyCurrentNodeMethodIdExtend').val(method_Id);
			$('#modifyCurrentNodeSegmentRealizeExtend').val(segmentRealize);
		}else if($('#currentClickOperate').val()=='addSubNodeModifyDetailConfig'){
			$('#addSubNodeMethodIdExtend').val(method_Id);
			//根据扩展方式ID从后台获取代码片段数据
			var segmentRealize = getSegmentRealize(method_Id);
			$('#addSubNodeSegmentRealizeExtend').val(segmentRealize);
			editAttr('method_id',method_Id,$('#addNodeId').val(),$('#addNodeOperId').val(),'NODE_CONTENT_CONFIG');
		}else if($('#currentClickOperate').val()=='modifyCurrentNodeModifyDetailConfig'){
			$('#modifyCurrentNodeMethodIdExtend').val(method_Id);
			var segmentRealize = getSegmentRealize(method_Id);
			$('#addSubNodeSegmentRealizeExtend').val(segmentRealize);
			editAttr('method_id',method_Id,$('#modifyCurrentNodeNodeId').val(),$('#modifyCurrentNodeOperId').val(),'NODE_CONTENT_CONFIG');			
		}
		$('#extendManagerWin').window('close');
	}	
	
	function getQuerySQL(dataSetId){
		var querySQL;
		var actionUrl = "/adapter/querySomeQuerySQLInfo.shtml?dataSetId="+dataSetId;
		var sRet=ajaxInteractive(actionUrl);
		var xmlQuerySQLInfo;
		if (xmlQuerySQLInfo==null) 
			xmlQuerySQLInfo=new ActiveXObject("Microsoft.XMLDOM");
		xmlQuerySQLInfo.async=false;
		xmlQuerySQLInfo.loadXML(sRet);
		if (xmlQuerySQLInfo.parseError.errorCode!=0) {
			/**
			alert("错误信息:Open Model "+xmlQuerySQLInfo.parseError.reason);
			alert("XML解析出错!错误信息如下:\n\错误代号:"
					+xmlQuerySQLInfo.parseError.errorCode
					+"\n\文件:"+xmlQuerySQLInfo.parseError.filePos
					+"\n\行:"+xmlQuerySQLInfo.parseError.line
					+"\n\字符:"+xmlQuerySQLInfo.parseError.linepos
					+"\n\相关信息:"+xmlQuerySQLInfo.parseError.reason
					+"\n\srcText:"+xmlQuerySQLInfo.parseError.srcText);
			*/
			$.messager.alert('Prompt','Error info:open model '+xmlQuerySQLInfo.parseError.reason,'info');
			$.messager.alert('Prompt',
						'XML parse error!The info :\n\errorcode:'
						+xmlQuerySQLInfo.parseError.errorCode
						+'\n\file:'+xmlQuerySQLInfo.parseError.filePos
						+'\n\line:'+xmlQuerySQLInfo.parseError.line
						+'\n\char:'+xmlQuerySQLInfo.parseError.linepos
						+'\n\relation info:'+xmlQuerySQLInfo.parseError.reason
						+'\n\srcText:'+xmlQuerySQLInfo.parseError.srcText,
					'info');			
		 	return;
		}
		var querySQLNode = xmlQuerySQLInfo.selectSingleNode("/QUERY_SQL[@data_set_id="+dataSetId+"]");
		var querySQL = "";
		if (querySQLNode!=null){
			querySQL = querySQLNode.attributes.getNamedItem("query_sql").text;
		}
		return querySQL;		
	}
	
	function getSegmentRealize(method_Id){
		var segmentRealize;
		var actionUrl = "/adapter/querySomeExtendMethodInfo.shtml?methodId="+method_Id;
		var sRet=ajaxInteractive(actionUrl);
		var xmlExtendInfo;
		if (xmlExtendInfo==null) 
			xmlExtendInfo=new ActiveXObject("Microsoft.XMLDOM");
		xmlExtendInfo.async=false;
		xmlExtendInfo.loadXML(sRet);
		if (xmlExtendInfo.parseError.errorCode!=0) {
			/**
			alert("错误信息:Open Model "+xmlExtendInfo.parseError.reason);
			alert("XML解析出错!错误信息如下:\n\错误代号:"
					+xmlExtendInfo.parseError.errorCode
					+"\n\文件:"+xmlExtendInfo.parseError.filePos
					+"\n\行:"+xmlExtendInfo.parseError.line
					+"\n\字符:"+xmlExtendInfo.parseError.linepos
					+"\n\相关信息:"+xmlExtendInfo.parseError.reason
					+"\n\srcText:"+xmlExtendInfo.parseError.srcText);
			*/
			$.messager.alert('Prompt','Error info:open model '+xmlExtendInfo.parseError.reason,'info');
			$.messager.alert('Prompt',
						'XML parse error!The info :\n\errorcode:'
						+xmlExtendInfo.parseError.errorCode
						+'\n\file:'+xmlExtendInfo.parseError.filePos
						+'\n\line:'+xmlExtendInfo.parseError.line
						+'\n\char:'+xmlExtendInfo.parseError.linepos
						+'\n\relation info:'+xmlExtendInfo.parseError.reason
						+'\n\srcText:'+xmlExtendInfo.parseError.srcText,
					'info');			
		 	return;
		}
		var extendInfoNode = xmlExtendInfo.selectSingleNode("/EXTEND_METHOD[@method_id="+method_Id+"]");
		var segmentRealize = "";
		if (extendInfoNode!=null){
			segmentRealize = extendInfoNode.attributes.getNamedItem("segment_realize").text;
		}
		return segmentRealize;
	}	
	
	/**
	 * 用于测试记录group的页面内容
	 * @return
	 */
	function recordJS(str){
		var array =new Array(2); 
		array[0]= str;
		//alert(array[0]);
		//writeTxt(array);
	}	
