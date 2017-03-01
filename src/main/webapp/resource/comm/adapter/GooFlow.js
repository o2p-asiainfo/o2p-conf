//定义一个区域图类：
function GooFlow(bgDiv,property){
	if (navigator.userAgent.indexOf("MSIE 8.0")>0||navigator.userAgent.indexOf("MSIE 7.0")>0||navigator.userAgent.indexOf("MSIE 6.0")>0)
		GooFlow.prototype.useSVG="";
	else	GooFlow.prototype.useSVG="1";
//初始化区域图的对象
	this.$id=bgDiv.attr("id");
	this.$bgDiv=bgDiv;//最父框架的DIV
	this.$bgDiv.addClass("GooFlow");
	var width=property.width;
	var height=property.height;
	this.$bgDiv.css({width:width+"px",height:height+"px"});
	this.$tool=null;//左侧工具栏对象
	this.$head=null;//顶部标签及工具栏按钮
	this.$title="newFlow_1";//流程图的名称
	this.$nodeRemark={};//每一种结点或按钮的说明文字,JSON格式,key为类名,value为用户自定义文字说明
	this.$nowType="";    //"cursor";//当前要绘制的对象类型
	this.$nodeLeft=5;       //左节点的left用来判断是左边的表格还是右边的表格
	this.$nodeRight=400;   //左节点的left用来判断是左边的表格还是右边的表格
	this.$flag=0;  //右边表格的拖动的开关
	this.$lineData={};
	this.$lineCount=0;
	this.$nodeData={};
	this.$nodeCount=0;
	this.$areaData={};
	this.$areaCount=0;
	this.$lineDom={};
	this.$nodeDom={};
	this.$areaDom={};
	this.$max=property.initNum||1;//计算默认ID值的起始SEQUENCE
	this.$focus="";//当前被选定的结点/转换线ID,如果没选中或者工作区被清空,则为""
	this.$focusnode="";
	this.$innerLine={};
	this.$cursor="default";//鼠标指针在工作区内的样式
	this.$editable=false;//工作区是否可编辑
	this.$deletedItem={};//在流程图的编辑操作中被删除掉的元素ID集合,元素ID为KEY,元素类型(node,line.area)为VALUE
	var headHeight=0;
	this.$tabCou = 0;
	this.isRepeat = false;
	this.repeadId;
	this.$isIEflag=false;
	this.$addRecordflag=false;
	//=============================
	this.mark;
	this.width = 270;
	this.height = 25;
	this.top = 1;
	this.left = 0;
	this.type = "complex mix";
	this.alt = true;
	this.lintype;
	this.linID={};
	
	var tmp="";
	
	var toolWidth=0;
	if(property.haveTool){
		//style='display: none;'
		this.$bgDiv.append("<div  style='display: none;'  class='GooFlow_tool'"+(property.haveHead? "":" style='margin-top:3px'")+"><div style='height:"+(height-headHeight-(property.haveHead? 7:10))+"px' class='GooFlow_tool_div'></div></div>");
		this.$tool=this.$bgDiv.find(".GooFlow_tool div");
		//未加代码：加入绘图工具按钮
		this.$tool.append("<a href='javascript:void(0)' type='cursor' class='GooFlow_tool_btn' id='"+this.$id+"_btn_cursor'><b class='ico_cursor'/></a>");
		this.$tool.append("<a href='javascript:void(0)' type='direct' class='GooFlow_tool_btndown' id='"+this.$id+"_btn_direct'><b class='ico_direct'/></a>");
		if(property.toolBtns&&property.toolBtns.length>0){
			tmp="<span/>";
			for(var i=0;i<property.toolBtns.length;++i){
				tmp+="<a href='javascript:void(0)' type='"+property.toolBtns[i]+"' id='"+this.$id+"_btn_"+property.toolBtns[i].split(" ")[0]+"' class='GooFlow_tool_btn'><b class='ico_"+property.toolBtns[i]+"'/></a>";//加入自定义按钮
			}
			this.$tool.append(tmp);
		}
		//加入区域划分框工具开关按钮
		if(property.haveGroup)
			this.$tool.append("<span/><a href='javascript:void(0)' type='group' class='GooFlow_tool_btndown' id='"+this.$id+"_btn_group'><b class='ico_group'/></a>");
		toolWidth=31;
		this.$nowType="direct";
		//绑定各个按钮的点击事件
		this.$tool.on("click",{inthis:this},function(e){
			if(!e)e=window.event;
			var tar;
			switch(e.target.tagName){
				case "SPAN":return false;
				case "DIV":return false;
				case "B":	tar=e.target.parentNode;break;
				case "A":	tar=e.target;
			};
			var type=$(tar).attr("type");
			e.data.inthis.switchToolBtn(type);
			return false;
		});
		this.$editable=true;//只有具有工具栏时可编辑
	}

	this.$bgDiv.append("<div class='GooFlow_work' style='width:"+(width)+"px;height:"+(height)+"px;'></div>");
	this.$workArea=$("<div class='GooFlow_work_inner' style='width:"+width+"px;height:"+(height+700)+"px'></div>")
		.attr({"unselectable":"on","onselectstart":'return false',"onselect":'document.selection.empty()'});
	this.$bgDiv.children(".GooFlow_work").append(this.$workArea);
	//判断是否需要初始化画区
	if(this.$id!="UniversalAdapterDemo"){
		return;
	}
	this.$draw=null;//画矢量线条的容器
	height = height>1000?height:(height+700);
	this.initDraw("draw_"+this.$id,(width),(height));
	this.$group=null;
	//if(property.haveGroup)
	//	this.initGroup(width,height);
	if(this.$editable){
		
	  this.$workArea.on("click",{inthis:this},function(e){
		var This=e.data.inthis;
		if(This.$isIEflag){This.$isIEflag=false;return;}
		if(!e)e=window.event;
		if(!e.data.inthis.$editable)return;
		var type=e.data.inthis.$nowType;
		if(type=="direct"){
			var t=$(e.target);
			var n=t.prop("tagName");
			if(n=="svg"||(n=="DIV"&&t.prop("class").indexOf("GooFlow_work")>-1)||n=="LABEL"){
				//
//				if(!e.data.inthis.isRepeat){
//					//e.data.inthis.delLine(e.data.inthis.$focus);
//		  			if(this.lintype == 'R' && e.data.inthis.$focusNode.indexOf('UniversalAdapterDemo_line') < 0){
//			  			$("#"+e.data.inthis.$focusNode).remove();
//			  			e.data.inthis.$focusNode = null;
//			  		} else if (e.data.inthis.$focusNode.indexOf('UniversalAdapterDemo_line') > -1) {
//			  			var controlInsertStr="";
//			  			$.each($('input[id=controlInsertId]'),function(i,val){
//			  				controlInsertStr += val.value + ',';
//			  			});
//			  			$.each($('polyline'),function(i,val){
//			  				if (!(controlInsertStr.indexOf(val.id) > -1)) {
//			  					This.delLine(val.id);
//			  				}
//			  			});
//			  		}
//				}else{
					if (GooFlow.prototype.useSVG=="") {
						if(!e.data.inthis.isRepeat && this.lintype != null && this.lintype == 'R' && e.data.inthis.$focusNode != null && e.data.inthis.$focusNode.indexOf('my_') > -1){
				  			var controlInsertStr="";
							$.each($('input[id=controlInsertId]'),function(i,val){
								controlInsertStr += val.value + ',';
							});
							var currentId = this.id;
							$.each($('div[id^=my_R]'),function(i,val){
								if (!(controlInsertStr.indexOf(val.id) > -1) && currentId != val.id.replace('my_','')) {
									$("#"+val.id).remove();
								}
							});
				  		}
					} else {
						if(!e.data.inthis.isRepeat && this.lintype != null && (this.lintype == 'l' || this.lintype == 'R') && e.data.inthis.$focusNode != null && e.data.inthis.$focusNode.indexOf('my_') > -1){
							var controlInsertStr="";
							$.each($('input[id=controlInsertId]'),function(i,val){
								controlInsertStr += val.value + ',';
							});
							var currentId = this.id;
							$.each($('div[id^=my_R]'),function(i,val){
								if (!(controlInsertStr.indexOf(val.id) > -1) && currentId != val.id.replace('my_','')) {
									$("#"+val.id).remove();
								}
							});
				  		}
						
					}
					e.data.inthis.blurItem();
		  			
		  			if(!e.data.inthis.isRepeat){
			  			var controlInsertStr="";
			  			$.each($('input[id=controlInsertId]'),function(i,val){
			  				controlInsertStr += val.value + ',';
			  			});
			  			
			  			if (GooFlow.prototype.useSVG=="") {
			  				$.each($('polyline'),function(i,val){
				  				if (!(controlInsertStr.indexOf(val.id) > -1)) {
				  					This.delLine(val.id);
				  				}
				  			});
			  			} else {
			  				$.each($('g'),function(i,val){
				  				if (!(controlInsertStr.indexOf(val.id) > -1)) {
				  					This.delLine(val.id);
				  				}
				  			});
			  			}
		  			}
//				}
				this.lintype = 'R';
				//e.data.inthis.$focusNode = null;
				//e.data.inthis.isRepeat = false;
			}
			return;
		}
		else if(type=="direct"||type=="group")return;
		var X,Y;
		var ev=mousePosition(e),t=getElCoordinate(this);
		X=ev.x-t.left+this.parentNode.scrollLeft-1;
		Y=ev.y-t.top+this.parentNode.scrollTop-1;
		e.data.inthis.$max++;
	  });
	  //划线时用的绑定
	  this.$workArea.mousemove({inthis:this},function(e){

		if(e.data.inthis.$nowType!="direct")	return;
		var lineStart=$(this).data("lineStart");
		if(!lineStart)return;
		var ev=mousePosition(e),t=getElCoordinate(this);
		var X,Y;
		X=ev.x-t.left+this.parentNode.scrollLeft;
		Y=ev.y-t.top+this.parentNode.scrollTop;
		var line=document.getElementById("GooFlow_tmp_line");
		if(GooFlow.prototype.useSVG!=""){
			line.childNodes[0].setAttribute("d","M "+lineStart.x+" "+lineStart.y+" L "+X+" "+Y);
			line.childNodes[1].setAttribute("d","M "+lineStart.x+" "+lineStart.y+" L "+X+" "+Y);
			if(line.childNodes[1].getAttribute("marker-end")=="url(\"#arrow2\")")
				line.childNodes[1].setAttribute("marker-end","url(#arrow3)");
			else	line.childNodes[1].setAttribute("marker-end","url(#arrow2)");
		}
		else	line.points.value=lineStart.x+","+lineStart.y+" "+X+","+Y;
	  });
	  this.$workArea.mouseup({inthis:this},function(e){
	  	var This=e.data.inthis;
	  	var lineStart=This.$workArea.data("lineStart");
	  	var flag = true;
	  	if(This.$innerLine[This.$focusNode]){
	  		This.isRepeat = true;
	  	}
	  	if(lineStart && This.$lineData){
	  		for(var i in This.$lineData){
				if(lineStart.id==This.$lineData[i].to ){
					//alert("gai jie dian yi jing bei shi yong ....")
					flag = false;
					break;
				}
	  		}
	  	}
	  	if(lineStart && lineStart.x >400 && flag && This.$flag==1){
	  		divName="my_"+lineStart.id;
	  		if(This.$focusNode){
	  			if(This.$innerLine[This.$focusNode]){
		  			//$("#"+This.$focusNode).hide();
		  		}else{
		  			$("#"+This.$focusNode).remove();
		  		}
	  		}
	  		if($('#'+divName).length>0){
	  			//alert("已存在");
	  		}else {
					var n1=$('#'+lineStart.id);
					n1.append("<div class='GooFlow_line_oper_new' style='top:1px;z-index:10' id="+divName+" ><b class='b_l7' title='" + gooFlow_assign + "'></b><b class='b_l9' title='" + gooFlow_other + "'></b><b class='b_xx' title='" + gooFlow_move + "'  onmouseover='this.style.backgroundColor=\"#FFFFFF\"' onmouseout='this.style.backgroundColor=\"\"'></b></div>");//选定线时显示的操作框
					
					This.$focusNode = divName;
					this.lintype = 'l';
					$('#'+divName).on("click",{nodeId:lineStart.id,inthis:e.data.inthis},function(e){
						This=e.data.inthis;
						if(!e)e=window.event;
						if(e.target.tagName!="B")	return;
						var nodeId=e.data.nodeId;
						switch($(e.target).attr("class")){
							case "b_xx":
								This.mySetRightLine(nodeId,"4");
								$('#my_'+nodeId).remove();
								This.$nodeData['my_'+nodeId]=null;
								break;
							case "b_l7":
								This.$innerLine['my_'+nodeId]=This.$nodeData[nodeId];
								This.mySetRightLine(nodeId,"5");
								break;
							case "b_l9":
								This.$innerLine['my_'+nodeId]=This.$nodeData[nodeId];
								This.mySetRightLine(nodeId,"6");
								break;
						}
					});
					This.myAddLineRight(divName,lineStart.id);
			}
	  }
	  				
		if(e.data.inthis.$nowType!="direct")	return;
		$(this).css("cursor","auto").removeData("lineStart");
		var tmp=document.getElementById("GooFlow_tmp_line");
		if(tmp)This.$draw.removeChild(tmp);
	  });
	  //为了结点而增加的一些集体delegate绑定
	  this.initWorkForNode();
	  //对结点进行移动或者RESIZE时用来显示的遮罩层
	  this.$ghost=$("<div class='rs_ghost'></div>").attr({"unselectable":"on","onselectstart":'return false',"onselect":'document.selection.empty()'});
	  this.$bgDiv.append(this.$ghost);
	  this.$textArea=$("<textarea></textarea>");
	  this.$bgDiv.append(this.$textArea);
	  this.$lineMove=$("<div class='GooFlow_line_move' style='display:none'></div>");//操作折线时的移动框
	  this.$workArea.append(this.$lineMove);
 
	  this.$lineOper=$("<div class='GooFlow_line_oper' style='display:none'><b class='b_l1' onmouseover='this.style.backgroundColor=\"#FFFFFF\"' onmouseout='this.style.backgroundColor=\"\"'></b><b class='b_l3' onmouseover='this.style.backgroundColor=\"#FFFFFF\"' onmouseout='this.style.backgroundColor=\"\"'></b><b class='b_x' onmouseover='this.style.backgroundColor=\"#FFFFFF\"' onmouseout='this.style.backgroundColor=\"\"'></b><b class='b_l4' onmouseover='this.style.backgroundColor=\"#FFFFFF\"' onmouseout='this.style.backgroundColor=\"\"'></b><b class='b_l5' onmouseover='this.style.backgroundColor=\"#FFFFFF\"' onmouseout='this.style.backgroundColor=\"\"'></b></div>");//选定线时显示的操作框
	  this.$workArea.append(this.$lineOper);
	  this.$lineOper.on("click",{inthis:this},function(e){
	 	if(!e)e=window.event;
		if(e.target.tagName!="B")	return;
		var This=e.data.inthis;
		var id=$(this).data("tid");
		switch($(e.target).attr("class")){
			case "b_x":	
			This.mySetLine(id,"0");
			This.delLine(id);
			this.style.display="none";break;
			case "b_l1":
			This.setLineType(id,"lr");break;
			case "b_l2":
			This.setLineType(id,"tb");break;
			case "b_l3":
			This.setLineType(id,"sl");break;
			case "b_l4":
			This.mySetLine(id,"1");break;
			case "b_l5":
			This.mySetLine(id,"2");break;
			case "b_l6":
			//This.mySetLine(id,"3");break;
		}
	  });
	  //定义备注 
	  this.setNodeRemarksNew();
	  //下面绑定当结点/线/分组块的一些操作事件,这些事件可直接通过this访问对象本身
	  //当操作某个单元（结点/线/分组块）被添加时，触发的方法，返回FALSE可阻止添加事件的发生
	  //格式function(id，type,json)：id是单元的唯一标识ID,type是单元的种类,有"node","line","area"三种取值,json即addNode,addLine或addArea方法的第二个传参json.
	  this.onItemAdd=null;
	  //当操作某个单元（结点/线/分组块）被删除时，触发的方法，返回FALSE可阻止删除事件的发生
	  //格式function(id，type)：id是单元的唯一标识ID,type是单元的种类,有"node","line","area"三种取值
	  this.onItemDel=null;
	  //当操作某个单元（结点/分组块）被移动时，触发的方法，返回FALSE可阻止移动事件的发生
	  //格式function(id，type,left,top)：id是单元的唯一标识ID,type是单元的种类,有"node","area"两种取值，线line不支持移动,left是新的左边距坐标，top是新的顶边距坐标
	  this.onItemMove=null;
	  //当操作某个单元（结点/线/分组块）被重命名时，触发的方法，返回FALSE可阻止重命名事件的发生
	  //格式function(id,name,type)：id是单元的唯一标识ID,type是单元的种类,有"node","line","area"三种取值,name是新的名称
	  this.onItemRename=null;
	  //当操作某个单元（结点/线）被由不选中变成选中时，触发的方法，返回FALSE可阻止选中事件的发生
	  //格式function(id,type)：id是单元的唯一标识ID,type是单元的种类,有"node","line"两种取值,"area"不支持被选中
	  this.onItemFocus=null;
	  //当操作某个单元（结点/线）被由选中变成不选中时，触发的方法，返回FALSE可阻止取消选中事件的发生
	  //格式function(id，type)：id是单元的唯一标识ID,type是单元的种类,有"node","line"两种取值,"area"不支持被取消选中
	  this.onItemBlur=null;
	  //当操作某个单元（结点/分组块）被重定义大小或造型时，触发的方法，返回FALSE可阻止重定大小/造型事件的发生
	  //格式function(id，type,width,height)：id是单元的唯一标识ID,type是单元的种类,有"node","line","area"三种取值;width是新的宽度,height是新的高度
	  this.onItemResize=null;
	  //当移动某条折线中段的位置，触发的方法，返回FALSE可阻止重定大小/造型事件的发生
	  //格式function(id，M)：id是单元的唯一标识ID,M是中段的新X(或Y)的坐标
	  this.onLineMove=null;
	  //当变换某条连接线的类型，触发的方法，返回FALSE可阻止重定大小/造型事件的发生
	  //格式function(id，type)：id是单元的唯一标识ID,type是连接线的新类型,"sl":直线,"lr":中段可左右移动的折线,"tb":中段可上下移动的折线
	  this.onLineSetType=null;
	  //当用重色标注某个结点/转换线时触发的方法，返回FALSE可阻止重定大小/造型事件的发生
	  //格式function(id，type，mark)：id是单元的唯一标识ID,type是单元类型（"node"结点,"line"转换线），mark为布尔值,表示是要标注TRUE还是取消标注FALSE
	  this.onItemMark=null;
	  
	  if(property.useOperStack&&this.$editable){//如果要使用堆栈记录操作并提供“撤销/重做”的功能,只在编辑状态下有效
		this.$undoStack=[];
		this.$redoStack=[];
		this.$isUndo=0;
		///////////////以下是构造撤销操作/重做操作的方法
	
		//将外部的方法加入到GooFlow对象的事务操作堆栈中,在过后的undo/redo操作中可以进行控制，一般用于对流程图以外的附加信息进行编辑的事务撤销/重做控制；
		//传参func为要执行方法对象,jsonPara为外部方法仅有的一个面向字面的JSON传参,由JSON对象带入所有要传的信息；
		//提示:为了让外部方法能够被UNDO/REDO,需要在编写这些外部方法实现时,加入对该方法执行后效果回退的另一个执行方法的pushExternalOper


 
	  }
	}
}
GooFlow.prototype={
	
	useSVG:"",
	getSvgMarker:function(id,color){
		var m=document.createElementNS("http://www.w3.org/2000/svg","marker");
		m.setAttribute("id",id);
		m.setAttribute("viewBox","0 0 6 6");
		m.setAttribute("refX",5);
		m.setAttribute("refY",3);
		m.setAttribute("markerUnits","strokeWidth");
		m.setAttribute("markerWidth",6);
		m.setAttribute("markerHeight",6);
		m.setAttribute("orient","auto");
		var path=document.createElementNS("http://www.w3.org/2000/svg","path");
		path.setAttribute("d","M 0 0 L 6 3 L 0 6 z");
		path.setAttribute("fill",color);
		path.setAttribute("stroke-width",0);
		m.appendChild(path);
		return m;
	},
	initDraw:function(id,width,height){
		var elem;
		if(GooFlow.prototype.useSVG!=""){
			this.$draw=document.createElementNS("http://www.w3.org/2000/svg","svg");//可创建带有指定命名空间的元素节点
			this.$workArea.prepend(this.$draw);
			var defs=document.createElementNS("http://www.w3.org/2000/svg","defs");
			this.$draw.appendChild(defs);
			defs.appendChild(GooFlow.prototype.getSvgMarker("arrow1","#15428B"));
			defs.appendChild(GooFlow.prototype.getSvgMarker("arrow2","#ff3300"));
			defs.appendChild(GooFlow.prototype.getSvgMarker("arrow3","#ff3300"));
		}
		else{
			this.$draw = document.createElement("v:group");
			this.$draw.coordsize = width+","+height;
			this.$workArea.prepend("<div class='GooFlow_work_vml' style='position:relative;width:"+width+"px;height:"+(height+700)+"px'></div>");
			this.$workArea.children("div")[0].insertBefore(this.$draw,null);
		}
		this.$draw.id = id;
		this.$draw.style.width = width + "px";
		this.$draw.style.height = +height + "px";
		//绑定连线的点击选中以及双击编辑事件
		var tmpClk=null;
		if(GooFlow.prototype.useSVG!="")  tmpClk="g";
		else  tmpClk="PolyLine";
		if(this.$editable){
		$(this.$draw).delegate(tmpClk,"click",{inthis:this},function(e){
			e.data.inthis.focusItem(this.id,true);
		});
		}
	},

 
	//切换左边工具栏按钮,传参TYPE表示切换成哪种类型的按钮
	switchToolBtn:function(type){
		this.$tool.children("#"+this.$id+"_btn_"+this.$nowType.split(" ")[0]).attr("class","GooFlow_tool_btn");
		if(this.$nowType=="group"){
			this.$workArea.prepend(this.$group);
			for(var key in this.$areaDom)	this.$areaDom[key].addClass("lock").children("div:eq(1)").css("display","none");
		}
		this.$nowType="direct";
		this.$tool.children("#"+this.$id+"_btn_"+type.split(" ")[0]).attr("class","GooFlow_tool_btndown");
		if(this.$nowType=="group"){
			this.blurItem();
			this.$workArea.append(this.$group);
			for(var key in this.$areaDom)	this.$areaDom[key].removeClass("lock").children("div:eq(1)").css("display","");
		}
		if(this.$textArea.css("display")=="none")	this.$textArea.removeData("id").val("").hide();
	},
		//增加一个流程结点,传参为一个JSON,有id,name,top,left,width,height,type(结点类型)等属性
	addNodeNew:function(id,json){
		if(this.onItemAdd!=null&&!this.onItemAdd(id,"node",json))return;
		this.mark = json.mark? " item_mark":"";
		
		if(id.indexOf('L')>=0){
			this.left = 5;
		}
		else{
			this.left = 600;
		}
		
		var pleft=0;
        if(json.dept==1) pleft=5;
        else pleft=15*json.dept;
        if(this.type.indexOf(" round")<0){
			//if(!this.width||this.width<86)this.width=86;
			//if(!json.height||json.height<24)json.height=24;
			//if(!json.top||json.top<0)json.top=0;
			//if(!json.left||json.left<0)json.left=0;
			var hack=0;
			if(navigator.userAgent.indexOf("8.0")!=-1)	hack=2;
			var len = (this.width-pleft)/8;
			var text = json.name+" "+json.nodeNum+" "+json.nodeType;
			//if((json.name.length+json.nodeNum.length+json.nodeType.length+9)>len)
				//text = text.substring(0, Math.floor(len) - 3) + "...";
				
			if(this.left<400){
//				var spanA = '100';
//				if (this.width - pleft < 100) {
//					spanA = this.width - pleft;
//				}
//				var spanB = '0';
//				if (this.width - pleft - spanA - 50 < 0) {
//					spanB = '0';
//				} else {
//					spanB = this.width - pleft - spanA - 50;
//				}
				this.$nodeDom[id]=
					$("<div class='GooFlow_item"+this.mark+"' title='"+text+"' id='"+id+"' width='"+(this.width+80)+"px' style='top:"+this.top+"px;left:"+this.left+"px;'><table cellspacing='1' style='width:"+(this.width+80)+"px;height:"+(this.height+1)+"px'><tr><td style='padding-left:"+pleft+"px;'><span style='width:100px; display:block;float:left;text-align:left;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'>"+json.name+"</span><span style='padding-left:10px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'>"+json.nodeNum+"&nbsp;&nbsp;"+json.nodeType+"</span></td></tr></table></div>");
			}else{
				this.$nodeDom[id]=
					$("<div class='GooFlow_item"+this.mark+"' title='"+text+"' id='"+id+"' width='"+(this.width+80)+"px' style='top:"+this.top+"px;left:"+this.left+"px;'><table cellspacing='1' style='width:"+(this.width+80)+"px;height:"+(this.height+1)+"px'><tr><td style='padding-left:"+(pleft+60)+"px;'><span style='width:100px; display:block;float:left;text-align:left;'>"+json.name+"</span><span style='padding-left:50px;'>"+json.nodeNum+" &nbsp;&nbsp;"+json.nodeType+"</span></td></tr></table></div>");
			}
			if(this.type.indexOf(" mix")>-1)	this.$nodeDom[id].addClass("item_mix");
		}
		else{
			json.width=24;json.height=24;
			this.$nodeDom[id]=
				$("<div class='GooFlow_item item_round"+mark+"' id='"+id+"' style='top:"+json.top+"px;left:"+json.left+"px'><table cellspacing='0'><tr><td class='ico'><b class='ico_"+json.type+"'></b></td></tr></table><div  style='display:none'><div class='rs_close'></div></div><div class='span' style='padding-left:"+pleft+"px;'>"+text+"</div></div>");
		}
		var ua=navigator.userAgent.toLowerCase();
		if(ua.indexOf('msie')!=-1 && ua.indexOf('8.0')!=-1)
			this.$nodeDom[id].css("filter","progid:DXImageTransform.Microsoft.Shadow(color=#94AAC2,direction=135,strength=2)");
		this.$workArea.append(this.$nodeDom[id]);
		json.left = this.left;
		json.top = this.top;
		json.type = this.type;
		json.width = this.width + 80;
		json.height = this.height;
		this.$nodeData[id]=json;
		++this.$nodeCount;
		this.top += this.height;
		if(this.$editable){
			this.$nodeData[id].alt=true;
			if(this.$deletedItem[id])	delete this.$deletedItem[id];//在回退删除操作时,去掉该元素的删除记录
		}
	},
	initWorkForNode:function(){
			 
		//绑定点击事件
		this.$workArea.delegate(".GooFlow_item","click",{inthis:this},function(e){
			//e.data.inthis.focusItem(this.id,true);
			$(this).removeClass("item_mark");
		});
		if(!this.$editable)	return;
		//绑定鼠标覆盖/移出事件
		this.$workArea.delegate(".GooFlow_item","mouseenter",{inthis:this},function(e){
			if(e.data.inthis.$nowType!="direct")	return;
			var This=e.data.inthis;
			var nodeLeft=This.$nodeLeft;
			var lineStart=This.$workArea.data("lineStart");
			if(!lineStart ||(lineStart && this.offsetLeft.x!=nodeLeft && lineStart.x <this.offsetLeft) ){
				$(this).addClass("item_mark");
			}
			var id = $(this).attr("id");
			var text = $("#"+id).attr("title");
			var d = "<div id='detail'>"+text+"</div>";
			$(this).append(d);
		});
		this.$workArea.delegate(".GooFlow_item","mouseleave",{inthis:this},function(e){
			if(e.data.inthis.$nowType!="direct")	return;
			$(this).removeClass("item_mark");
			e.data.inthis.$flag=1;
			var id = $(this).attr("id");
			$("#"+id+">#detail").remove();
		});
		//绑定连线时确定初始点
		this.$workArea.delegate(".GooFlow_item","mousedown",{inthis:this},function(e){
			if(e.button==2)return false;
			var This=e.data.inthis;
			if(!This.isRepeat){
				
				var controlInsertStr="";
	  			$.each($('input[id=controlInsertId]'),function(i,val){
	  				controlInsertStr += val.value + ',';
	  			});
	  			
	  			if (GooFlow.prototype.useSVG=="") {
	  				$.each($('polyline'),function(i,val){
		  				if (!(controlInsertStr.indexOf(val.id) > -1)) {
		  					This.delLine(val.id);
		  				}
		  			});
	  			} else {
	  				$.each($('g'),function(i,val){
		  				if (!(controlInsertStr.indexOf(val.id) > -1)) {
		  					This.delLine(val.id);
		  				}
		  			});
	  			}
				
			//	This.delLine(This.$focus);
			/*	if(This.$focusNode){
		  			if(This.$innerLine[This.$focusNode]){
			  			//$("#"+This.$focusNode).hide();
			  		}else{
			  			$("#"+This.$focusNode).remove();
			  			This.$focusNode = null;
		  		}*/
				This.$focusNode = null;
				//$("#"+e.data.inthis.$focusNode).hide();
				/*if(e.data.inthis.$focusNode){
		  			if(e.data.inthis.$innerLine[This.$focusNode]){
			  			$("#"+e.data.inthis.$focusNode).hide();
			  		}else{
			  			$("#"+e.data.inthis.$focusNode).remove();
			  		}
		  		}
				This.$focusNode = null;*/
				//$(e.data.inthis.$focusNode).remove();
				var controlInsertStr="";
				$.each($('input[id=controlInsertId]'),function(i,val){
					controlInsertStr += val.value + ',';
				});
				var currentId = this.id;
				$.each($('div[id^=my_R]'),function(i,val){
					if (!(controlInsertStr.indexOf(val.id) > -1) && currentId != val.id.replace('my_','')) {
						$("#"+val.id).remove();
					}
				});
				
				
			}else{
				//This.blurItem();
				This.isRepeat = false;
			}
			//This.isRepeat = false;
			
			/*
			 var trList = $('.datagrid-view2>.datagrid-body>.datagrid-btable>tbody>tr');
			var lid ;
			var flag = false;
			for(var i=0;i<trList.length;i++){
				lid = $(".datagrid-view2>.datagrid-body>.datagrid-btable>tbody>tr:eq("+i+")").attr('id');
				if(lid ==this.$focus){
					flag = true;
					break;
				}
			}
			if(!flag){
				This.delLine(This.$focus);
			}*/
			
			if(This.$nowType!="direct")	return;
			var ev=mousePosition(e),t=getElCoordinate(This.$workArea[0]);
			var X,Y;
			X=ev.x-t.left+This.$workArea[0].parentNode.scrollLeft;
			Y=ev.y-t.top+This.$workArea[0].parentNode.scrollTop;
			This.$workArea.data("lineStart",{"x":X,"y":Y,"id":this.id}).css("cursor","crosshair");
			var line=GooFlow.prototype.drawLine("GooFlow_tmp_line",[X,Y],[X,Y],true,true);
			This.$draw.appendChild(line);
			This.$flag=0;
			
		});
		//绑定连线时确定结束点
		this.$workArea.delegate(".GooFlow_item","mouseup",{inthis:this},function(e){
			var This=e.data.inthis;
			if ((navigator.userAgent.indexOf('Firefox') < 0))This.$isIEflag=true;
			if(This.$nowType!="direct")	return;
			var lineStart=This.$workArea.data("lineStart");
			var nodeLeft=This.$nodeLeft;
			if(lineStart)	{
				This.$flag=0;
				if (this.offsetLeft.x==nodeLeft || lineStart.x >=this.offsetLeft)return;  //cc
				var lineName=This.$id+"_line_"+(This.$max);
				This.addLineNew(lineName,{from:lineStart.id,to:this.id,name:""});
				This.$max++;
				This.focusItem(lineName,true);
				This.myAddLineLeft(lineName,{from:lineStart.id,to:this.id,name:""});
			}
		});

	},
	//取消所有结点/连线被选定的状态
	blurItem:function(){	
		if(this.$focus!=""){
			var jq=$("#"+this.$focus);
			//移除操作按钮
			//if(!this.isRepeat)$("#operate_"+this.$focus).remove();
			var trList = $('.datagrid-view2>.datagrid-body>.datagrid-btable>tbody>tr');
			var lid ;
			var flag = false;
			for(var i=0;i<trList.length;i++){
				lid = $(".datagrid-view2>.datagrid-body>.datagrid-btable>tbody>tr:eq("+i+")").attr('id');
				if(lid ==this.$focus){
					flag = true;
					break;
				}
			}
			if(!flag){
				$("#operate_"+this.$focus).remove();
			}
			 
			if(jq.prop("tagName")=="DIV"){
				if(this.onItemBlur!=null&&!this.onItemBlur(id,"node"))	return false;
				jq.removeClass("item_focus").children("div:eq(0)").css("display","none");
			}
			else{
				if(this.onItemBlur!=null&&!this.onItemBlur(id,"line"))	return false;
				if(GooFlow.prototype.useSVG!=""){
					if(!this.$lineData[this.$focus].marked){
						jq[0].childNodes[1].setAttribute("stroke","#5068AE");
						jq[0].childNodes[1].setAttribute("marker-end","url(#arrow1)");
					}
				}
				else{
					if(!this.$lineData[this.$focus].marked)	jq[0].strokeColor="#5068AE";
				}
				this.$lineMove.hide().removeData("type").removeData("tid");
				if(this.$editable)	this.$lineOper.hide().removeData("tid");
			}
		}
		this.$focus="";
		this.repeadId = "";
		this.isRepeat = false;
		return true;
	},
	//选定某个结点/转换线 bool:TRUE决定了要触发选中事件，FALSE则不触发选中事件，多用在程序内部调用。
	focusItem:function(id,bool){
		var jq=$("#"+id);
		if(jq.length==0)	return;
		if(!this.blurItem())	return;//先执行"取消选中",如果返回FLASE,则也会阻止选定事件继续进行.
		if(jq.prop("tagName")=="DIV"){
			if(bool&&this.onItemFocus!=null&&!this.onItemFocus(id,"node"))	return;
			jq.addClass("item_focus");
			if(this.$editable)jq.children("div:eq(0)").css("display","block");
			this.$workArea.append(jq);
		}
		else{//如果是连接线
			if(this.onItemFocus!=null&&!this.onItemFocus(id,"line"))	return;
			if(GooFlow.prototype.useSVG!=""){
				jq[0].childNodes[1].setAttribute("stroke","#ff3300");
				jq[0].childNodes[1].setAttribute("marker-end","url(#arrow2)");
			}
			else	jq[0].strokeColor="#ff3300";
			if(!this.$editable)	return;
			var x,y,from,to;
			if(GooFlow.prototype.useSVG!=""){
				from=jq.attr("from").split(",");
				to=jq.attr("to").split(",");
			}else{
				var n=jq[0].getAttribute("fromTo").split(",");
				from=[n[0],n[1]];
				to=[n[2],n[3]];
			}
			from[0]=parseInt(from[0],10);
			from[1]=parseInt(from[1],10);
			to[0]=parseInt(to[0],10);
			to[1]=parseInt(to[1],10);
			if(this.$lineData[id].type=="lr"){
				from[0]=this.$lineData[id].M;
				to[0]=from[0];
				
				this.$lineMove.css({
					width:"5px",height:(to[1]-from[1])*(to[1]>from[1]? 1:-1)+"px",
					left:from[0]-3+"px",
					top:(to[1]>from[1]? from[1]:to[1])+1+"px",
					cursor:"e-resize",display:"block"
				}).data({"type":"lr","tid":id});
			}
			else if(this.$lineData[id].type=="tb"){
				from[1]=this.$lineData[id].M;
				to[1]=from[1];
				this.$lineMove.css({
					width:(to[0]-from[0])*(to[0]>from[0]? 1:-1)+"px",height:"5px",
					left:(to[0]>from[0]? from[0]:to[0])+1+"px",
					top:from[1]-3+"px",
					cursor:"s-resize",display:"block"
				}).data({"type":"tb","tid":id});
			}
			x=(from[0]+to[0])/2-35;
			y=(from[1]+to[1])/2+6;
			this.$lineOper.css({display:"block",left:x+"px",top:y+"px"}).data("tid",id);
		}
		this.$focus=id;
		this.switchToolBtn("cursor");

		var li = $(".datagrid-btable>tbody>tr");
		for(var i=0;i<li.length;i++){
			if(li[i].id==this.$focus){
				this.isRepeat = true;
				this.repeadId = this.$focus;
				break;
			}
		}
		//
		var l = $('.datagrid-btable>tbody>tr');
		for(var i =0; i < l.length; i++){
			if(id == $('.datagrid-btable>tbody>tr:eq('+i+')').attr('id')){
				this.changeRowColor();
				$("tr[id=" + id + "]").attr('class','datagrid-row datagrid-row-selected');
				return;
			}
		}
		
	},

	//载入一组数据
	loadData:function(data){
		var t=this.$editable;
		this.$editable=false;
		if(data.title)	this.setTitle(data.title);
		if(data.initNum)	this.$max=data.initNum+1;
		var maxTop=470; 
		this.top = 1;
		for(var i in data.nodes){
			this.addNodeNew(i,data.nodes[i]);
			if(data.nodes[i].top>maxTop)maxTop=data.nodes[i].top;
		}
		//如果最大的表格高于画布，画布高度自动增高
		if((maxTop+30)>$(".GooFlow_work_inner").height() ){
			$(".GooFlow_work_inner").height(maxTop+30);
			$("#draw_demo").height(maxTop+30);
		}
		
		for(var j in data.lines)
			this.addLineNew(j,data.lines[j]);
		this.$editable=t;
		this.$deletedItem={};
	},
	//用AJAX方式，远程读取一组数据
	//参数para为JSON结构，与JQUERY中$.ajax()方法的传参一样
	loadDataAjax:function(para){
		var This=this;
		$.ajax({
			type:para.type,
			url:para.url,
			dataType:"json",
			data:para.data,
			success: function(msg){
				if(para.dataFilter)	para.dataFilter(msg,"json");
     			This.loadData(msg);
				if(para.success)	para.success(msg);
   			},
			error: function(XMLHttpRequest, textStatus, errorThrown){
				if(para.error)	para.error(textStatus,errorThrown);
			}
		});
	},
	//把画好的整个流程图导出到一个变量中(其实也可以直接访问GooFlow对象的$nodeData,$lineData,$areaData这三个JSON属性)
	exportData:function(){
		var ret={title:this.$title,nodes:this.$nodeData,lines:this.$lineData,areas:this.$areaData,initNum:this.$max};
		for(var k1 in ret.nodes){
			if(!ret.nodes[k1].marked){
				delete ret.nodes[k1]["marked"];
			}
		}
		for(var k2 in ret.lines){
			if(!ret.lines[k2].marked){
				delete ret.lines[k2]["marked"];
			}
		}
		return ret;
	},
///////////以下为有关画线的方法
	//绘制一条箭头线，并返回线的DOM
	drawLine:function(id,sp,ep,mark,dash){
		var line;
		if(GooFlow.prototype.useSVG!=""){
			line=document.createElementNS("http://www.w3.org/2000/svg","g");
			var hi=document.createElementNS("http://www.w3.org/2000/svg","path");
			var path=document.createElementNS("http://www.w3.org/2000/svg","path");

			if(id!="")	line.setAttribute("id",id);
			line.setAttribute("from",sp[0]+","+sp[1]);
			line.setAttribute("to",ep[0]+","+ep[1]);
			hi.setAttribute("visibility","hidden");
			hi.setAttribute("stroke-width",9);
			hi.setAttribute("fill","none");
			hi.setAttribute("stroke","white");
			hi.setAttribute("d","M "+sp[0]+" "+sp[1]+" L "+ep[0]+" "+ep[1]);
			hi.setAttribute("pointer-events","stroke");
			path.setAttribute("d","M "+sp[0]+" "+sp[1]+" L "+ep[0]+" "+ep[1]);
			path.setAttribute("stroke-width",1.4);
			path.setAttribute("stroke-linecap","round");
			path.setAttribute("fill","none");
			if(dash)	path.setAttribute("style", "stroke-dasharray:6,5");
			if(mark){
				path.setAttribute("stroke","#ff3300");
				path.setAttribute("marker-end","url(#arrow2)");
			}
			else{
				path.setAttribute("stroke","#5068AE");
				path.setAttribute("marker-end","url(#arrow1)");
			}
			line.appendChild(hi);
			line.appendChild(path);
			line.style.cursor="crosshair";
			if(id!=""&&id!="GooFlow_tmp_line"){
				var text=document.createElementNS("http://www.w3.org/2000/svg","text");
				//text.textContent=id;
				line.appendChild(text);
				var x=(ep[0]+sp[0])/2;
				var y=(ep[1]+sp[1])/2;
				text.setAttribute("text-anchor","middle");
				text.setAttribute("x",x);
				text.setAttribute("y",y);
				line.style.cursor="pointer";
				text.style.cursor="text";
			}
		}else{
			line=document.createElement("v:polyline");
			if(id!="")	line.id=id;
			//line.style.position="absolute";
			line.points.value=sp[0]+","+sp[1]+" "+ep[0]+","+ep[1];
			line.setAttribute("fromTo",sp[0]+","+sp[1]+","+ep[0]+","+ep[1]);
			line.strokeWeight="1.2";
			line.stroke.EndArrow="Block";
			line.style.cursor="crosshair";
			if(id!=""&&id!="GooFlow_tmp_line"){
				var text=document.createElement("div");
				//text.innerHTML=id;
				line.appendChild(text);
				var x=(ep[0]-sp[0])/2;
				var y=(ep[1]-sp[1])/2;
				if(x<0) x=x*-1;
				if(y<0) y=y*-1;
				text.style.left=x+"px";
				text.style.top=y-6+"px";
				line.style.cursor="pointer";
			}
			if(dash)	line.stroke.dashstyle="Dash";
			if(mark)	line.strokeColor="#ff3300";
			else	line.strokeColor="#5068AE";
		}
		return line;
	},
	//对直线增加操作按钮.
	actionOperateNew:function(lineid,type){
		var from = "";
		var sname = "";
		var spath = "";
		var to = "";
		var tpath = "";
		var toid = "";
		if(type=="1"){
			toid = lineid;
			from = this.$lineData[lineid].from;
			sname = this.$nodeData[from].name;
			spath = this.$nodeData[from].path;
			to = this.$lineData[lineid].to;
			tpath = this.$nodeData[to].path;
		}else if("2"==type){
			tpath = this.$nodeData[lineid].path;
			toid = lineid;
			if(this.isRepeat){
				lineid = this.repeadId;
			}else{
				lineid = this.$id+"_line_"+(this.$max-1);
			}
		}else if("3"==type){
			toid = lineid;
			return operate = "<div class='GooFlow_line_operator' style='top:1px;z-index:10'  id='operate_"+toid+"'><b class='b_l5' title='gooFlow_operation_move'></b></div>";
		}
		return operate = "<div class='GooFlow_line_operator' style='top:1px;z-index:10'  id='operate_"+toid+"' onclick=\"openOperate('"+sname+"','"+spath+"','"+tpath+"','"+lineid+"');\"  onmouseover='this.style.backgroundColor=\"#FFFFFF\"' onmouseout='this.style.backgroundColor=\"\"'><b class='b_l8' title='gooFlow_operation'></b></div>";//" + gooFlow_operation + "
		//return operate = "<span class='operateLine' id='operate_"+toid+"' style='top:2px;left:1px'><b class='b_l8' title='" + gooFlow_assign + "'><a  class=\"GooFlow_line_operator\" onclick=\"openOperate('"+sname+"','"+spath+"','"+tpath+"','"+lineid+"');\"></a></b></span>"
	},
	//画一条只有两个中点的折线
	drawPoly:function(id,sp,m1,m2,ep,mark){
		var poly,strPath;
		if(GooFlow.prototype.useSVG!=""){
			poly=document.createElementNS("http://www.w3.org/2000/svg","g");
			var hi=document.createElementNS("http://www.w3.org/2000/svg","path");
			var path=document.createElementNS("http://www.w3.org/2000/svg","path");
			if(id!="")	poly.setAttribute("id",id);
			poly.setAttribute("from",sp[0]+","+sp[1]);
			poly.setAttribute("to",ep[0]+","+ep[1]);
			hi.setAttribute("visibility","hidden");
			hi.setAttribute("stroke-width",9);
			hi.setAttribute("fill","none");
			hi.setAttribute("stroke","white");
			strPath="M "+sp[0]+" "+sp[1];
			if(m1[0]!=sp[0]||m1[1]!=sp[1])
				strPath+=" L "+m1[0]+" "+m1[1];
			if(m2[0]!=ep[0]||m2[1]!=ep[1])
				strPath+=" L "+m2[0]+" "+m2[1];
			strPath+=" L "+ep[0]+" "+ep[1];
			hi.setAttribute("d",strPath);
			hi.setAttribute("pointer-events","stroke");
			path.setAttribute("d",strPath);
			path.setAttribute("stroke-width",1.4);
			path.setAttribute("stroke-linecap","round");
			path.setAttribute("fill","none");
			if(mark){
				path.setAttribute("stroke","#ff3300");
				path.setAttribute("marker-end","url(#arrow2)");
			}
			else{
				path.setAttribute("stroke","#5068AE");
				path.setAttribute("marker-end","url(#arrow1)");
			}
			poly.appendChild(hi);
			poly.appendChild(path);
			var text=document.createElementNS("http://www.w3.org/2000/svg","text");
			//text.textContent=id;
			poly.appendChild(text);
			var x=(m2[0]+m1[0])/2;
			var y=(m2[1]+m1[1])/2;
			text.setAttribute("text-anchor","middle");
			text.setAttribute("x",x);
			text.setAttribute("y",y);
			text.style.cursor="text";
			poly.style.cursor="pointer";
		}
		else{
			poly=document.createElement("v:Polyline");
			if(id!="")	poly.id=id;
			poly.filled="false";
			strPath=sp[0]+","+sp[1];
			if(m1[0]!=sp[0]||m1[1]!=sp[1])
				strPath+=" "+m1[0]+","+m1[1];
			if(m2[0]!=ep[0]||m2[1]!=ep[1])
				strPath+=" "+m2[0]+","+m2[1];
			strPath+=" "+ep[0]+","+ep[1];
			poly.points.value=strPath;
			poly.setAttribute("fromTo",sp[0]+","+sp[1]+","+ep[0]+","+ep[1]);
			poly.strokeWeight="1.2";
			poly.stroke.EndArrow="Block";
			var text=document.createElement("div");
			//text.innerHTML=id;
			poly.appendChild(text);
			var x=(m2[0]-m1[0])/2;
			var y=(m2[1]-m1[1])/2;
			if(x<0) x=x*-1;
			if(y<0) y=y*-1;
			text.style.left=x+"px";
			text.style.top=y-4+"px";
			poly.style.cursor="pointer";
			if(mark)	poly.strokeColor="#ff3300";
			else	poly.strokeColor="#5068AE";
		}
		return poly;
	},
		//计算两个结点间要连直线的话，连线的开始坐标和结束坐标
	calcStartEndNew:function(n1,n2){
		var X_1,Y_1,X_2,Y_2;
		
		if(n1.left<n2.left){//n1左边，都是左边指向右边
			X_1=n1.left+n1.width;
			Y_1=n1.top+(n1.height/2);
			X_2=n2.left;
			Y_2=n2.top+(n2.height/2);
		}else{
			X_1=n2.left+n2.width;
			Y_1=n2.top+(n2.height/2);
			X_2=n1.left;
			Y_2=n1.top+(n1.height/2);
		}
		return {"start":[X_1,Y_1],"end":[X_2,Y_2]};
	},
	//计算两个结点间要连折线的话，连线的所有坐标
	calcPolyPoints:function(n1,n2,type,M){

		//开始/结束两个结点的中心
		var SP={x:n1.left+n1.width/2,y:n1.top+n1.height/2};
		var EP={x:n2.left+n2.width/2,y:n2.top+n2.height/2};
		var sp=[],m1=[],m2=[],ep=[];
		//如果是允许中段可左右移动的折线,则参数M为可移动中段线的X坐标
		//粗略计算起始点
		sp=[SP.x,SP.y];
		ep=[EP.x,EP.y];
		if(type=="lr"){
			//粗略计算2个中点
			m1=[M,SP.y];
			m2=[M,EP.y];
			//再具体分析修改开始点和中点1
			if(m1[0]>n1.left&&m1[0]<n1.left+n1.width){
				m1[1]=(SP.y>EP.y? n1.top:n1.top+n1.height);
				sp[0]=m1[0];sp[1]=m1[1];
			}
			else{
				sp[0]=(m1[0]<n1.left? n1.left:n1.left+n1.width);
			}
			//再具体分析中点2和结束点
			if(m2[0]>n2.left&&m2[0]<n2.left+n2.width){
				m2[1]=(SP.y>EP.y? n2.top+n2.height:n2.top);
				ep[0]=m2[0];ep[1]=m2[1];
			}
			else{
				ep[0]=(m2[0]<n2.left? n2.left:n2.left+n2.width);
			}
		}
		//如果是允许中段可上下移动的折线,则参数M为可移动中段线的Y坐标
		else if(type=="tb"){
			//粗略计算2个中点
			m1=[SP.x,M];
			m2=[EP.x,M];
			//再具体分析修改开始点和中点1
			if(m1[1]>n1.top&&m1[1]<n1.top+n1.height){
				m1[0]=(SP.x>EP.x? n1.left:n1.left+n1.width);
				sp[0]=m1[0];sp[1]=m1[1];
			}
			else{
				sp[1]=(m1[1]<n1.top? n1.top:n1.top+n1.height);
			}
			//再具体分析中点2和结束点
			if(m2[1]>n2.top&&m2[1]<n2.top+n2.height){
				m2[0]=(SP.x>EP.x? n2.left+n2.width:n2.left);
				ep[0]=m2[0];ep[1]=m2[1];
			}
			else{
				ep[1]=(m2[1]<n2.top? n2.top:n2.top+n2.height);
			}
		}
		return {start:sp,m1:m1,m2:m2,end:ep};
	},
	//初始化折线中段的X/Y坐标,mType='rb'时为X坐标,mType='tb'时为Y坐标
	getMValue:function(n1,n2,mType){

		if(mType=="lr"){
			return (n1.left+n1.width/2+n2.left+n2.width/2)/2;
		}
		else if(mType=="tb"){
			return (n1.top+n1.height/2+n2.top+n2.height/2)/2;
		}
	},
		//增加一条线
	addLineNew:function(id,json){
		if(this.onItemAdd!=null&&!this.onItemAdd(id,"line",json))return;

		var n1=null,n2=null;//获取开始/结束结点的数据
		if(json.from==json.to)	return;
		//避免两个节点间不能有一条以上同向接连线与连接同一个端点
		for(var k in this.$lineData){
			if((json.to==this.$lineData[k].to)){
				alert(gooFlow_nodeUse);
				return;
			}
				
		}
		var n1=this.$nodeData[json.from],n2=this.$nodeData[json.to];//获取开始/结束结点的数据
		if($("#my_"+json.to)[0]){
			//alert("gai jie shu dian yi jing bei shi yong......");
			return;
		}
		if(!n1||!n2)	return;
		var res;
		if(json.type&&json.type!="sl"){
			res=GooFlow.prototype.calcPolyPoints(n1,n2,json.type,json.M);
		}else{
			res=GooFlow.prototype.calcStartEndNew(n1,n2);
		}
		if(!res)	return;
		this.$lineData[id]={};
		if(json.type){
			this.$lineData[id].type=json.type;
			this.$lineData[id].M=json.M;
		}
		else	this.$lineData[id].type="sl";//默认为直线
		this.$lineData[id].from=json.from;
		this.$lineData[id].to=json.to;
		this.$lineData[id].name=json.name;
		if(json.mark)	this.$lineData[id].marked=json.mark;
		else	this.$lineData[id].marked=false;
		if(this.$lineData[id].type=="sl")
			this.$lineDom[id]=GooFlow.prototype.drawLine(id,res.start,res.end,json.mark);
		else
			this.$lineDom[id]=GooFlow.prototype.drawPoly(id,res.start,res.m1,res.m2,res.end,json.mark);
		this.$draw.appendChild(this.$lineDom[id]);
		if(GooFlow.prototype.useSVG==""){
			this.$lineDom[id].childNodes[1].innerHTML=json.name;
			if(this.$lineData[id].type!="sl"){
				var Min=(res.start[0]>res.end[0]? res.end[0]:res.start[0]);
				if(Min>res.m2[0])	Min=res.m2[0];
				if(Min>res.m1[0])	Min=res.m1[0];
				this.$lineDom[id].childNodes[1].style.left = (res.m2[0]+res.m1[0])/2-Min-this.$lineDom[id].childNodes[1].offsetWidth/2+4;
				Min=(res.start[1]>res.end[1]? res.end[1]:res.start[1]);
				if(Min>res.m2[1])	Min=res.m2[1];
				if(Min>res.m1[1])	Min=res.m1[1];
				this.$lineDom[id].childNodes[1].style.top = (res.m2[1]+res.m1[1])/2-Min-this.$lineDom[id].childNodes[1].offsetHeight/2;
			}else
				this.$lineDom[id].childNodes[1].style.left=
				((res.end[0]-res.start[0])*(res.end[0]>res.start[0]? 1:-1)-this.$lineDom[id].childNodes[1].offsetWidth)/2+4;
		}
		else	this.$lineDom[id].childNodes[2].textContent=json.name;
		++this.$lineCount;
		if(this.$editable){
			
			this.$lineData[id].alt=true;
			if(this.$deletedItem[id])	delete this.$deletedItem[id];//在回退删除操作时,去掉该元素的删除记录
		}
	},
	//重新设置连线的样式 newType= "sl":直线, "lr":中段可左右移动型折线, "tb":中段可上下移动型折线
	setLineType:function(id,newType){
		if(!newType||newType==null||newType==""||newType==this.$lineData[id].type)	return false;
		if(this.onLineSetType!=null&&!this.onLineSetType(id,newType))	return;
		if(this.$undoStack){
			var paras=[id,this.$lineData[id].type];
			//this.pushOper("setLineType",paras);
			if(this.$lineData[id].type!="sl"){
				var para2=[id,this.$lineData[id].M];
			//	this.pushOper("setLineM",para2);
			}
		}
		var from=this.$lineData[id].from;
		var to=this.$lineData[id].to;
		this.$lineData[id].type=newType;
		var res;
		//如果是变成折线
		if(newType!="sl"){
		  var res=GooFlow.prototype.calcPolyPoints(this.$nodeData[from],this.$nodeData[to],this.$lineData[id].type,this.$lineData[id].M);
		  this.setLineM(id,this.getMValue(this.$nodeData[from],this.$nodeData[to],newType),true);
		}
		//如果是变回直线
		else{
		  delete this.$lineData[id].M;
		  this.$lineMove.hide().removeData("type").removeData("tid");
		  res=GooFlow.prototype.calcStartEndNew(this.$nodeData[from],this.$nodeData[to]);

		  if(!res)	return;
		  this.$draw.removeChild(this.$lineDom[id]);
		  this.$lineDom[id]=GooFlow.prototype.drawLine(id,res.start,res.end,this.$lineData[id].marked||this.$focus==id);
		  this.$draw.appendChild(this.$lineDom[id]);
		  if(GooFlow.prototype.useSVG==""){
		  	this.$lineDom[id].childNodes[1].innerHTML=this.$lineData[id].name;
			this.$lineDom[id].childNodes[1].style.left=
			((res.end[0]-res.start[0])*(res.end[0]>res.start[0]? 1:-1)-this.$lineDom[id].childNodes[1].offsetWidth)/2+4;
		  }
		  else
			this.$lineDom[id].childNodes[2].textContent=this.$lineData[id].name;
		}
		if(this.$focus==id){
			this.focusItem(id);
		}
		if(this.$editable){
			this.$lineData[id].alt=true;
		}
	},
	//设置折线中段的X坐标值（可左右移动时）或Y坐标值（可上下移动时）
	setLineM:function(id,M,noStack){
		if(!this.$lineData[id]||M<0||!this.$lineData[id].type||this.$lineData[id].type=="sl")	return false;
		if(this.onLineMove!=null&&!this.onLineMove(id,M))	return false;
		if(this.$undoStack&&!noStack){
			var paras=[id,this.$lineData[id].M];
		//	this.pushOper("setLineM",paras);
		}
		var from=this.$lineData[id].from;
		var to=this.$lineData[id].to;
		this.$lineData[id].M=M;
		var ps=GooFlow.prototype.calcPolyPoints(this.$nodeData[from],this.$nodeData[to],this.$lineData[id].type,this.$lineData[id].M);
		this.$draw.removeChild(this.$lineDom[id]);
		this.$lineDom[id]=GooFlow.prototype.drawPoly(id,ps.start,ps.m1,ps.m2,ps.end,this.$lineData[id].marked||this.$focus==id);
		this.$draw.appendChild(this.$lineDom[id]);
		if(GooFlow.prototype.useSVG==""){
			this.$lineDom[id].childNodes[1].innerHTML=this.$lineData[id].name;
			var Min=(ps.start[0]>ps.end[0]? ps.end[0]:ps.start[0]);
			if(Min>ps.m2[0])	Min=ps.m2[0];
			if(Min>ps.m1[0])	Min=ps.m1[0];
			this.$lineDom[id].childNodes[1].style.left = (ps.m2[0]+ps.m1[0])/2-Min-this.$lineDom[id].childNodes[1].offsetWidth/2+4;
			Min=(ps.start[1]>ps.end[1]? ps.end[1]:ps.start[1]);
			if(Min>ps.m2[1])	Min=ps.m2[1];
			if(Min>ps.m1[1])	Min=ps.m1[1];
			this.$lineDom[id].childNodes[1].style.top = (ps.m2[1]+ps.m1[1])/2-Min-this.$lineDom[id].childNodes[1].offsetHeight/2-4;
		}
		else	this.$lineDom[id].childNodes[2].textContent=this.$lineData[id].name;
		if(this.$editable){
			this.$lineData[id].alt=true;
		}
	},
	//删除转换线
	delLine:function(id){
		if(!this.$lineData[id])	return;
		if(this.onItemDel!=null&&!this.onItemDel(id,"node"))	return;
		if(this.$undoStack){
			var paras=[id,this.$lineData[id]];
		//	this.pushOper("addLine",paras);
		}
		this.$draw.removeChild(this.$lineDom[id]);
		delete this.$lineData[id];
		delete this.$lineDom[id];
		if(this.$focus==id)	this.$focus="";
		--this.$lineCount;
		if(this.$editable){
			//在回退新增操作时,如果节点ID以this.$id+"_line_"开头,则表示为本次编辑时新加入的节点,这些节点的删除不用加入到$deletedItem中
			if(id.indexOf(this.$id+"_line_")<0)
			this.$deletedItem[id]="line";
		}
		this.$lineOper.hide();
	},
 
	//线上的说明文字
	setNodeRemarksNew:function(){
		var remark={	b_l1:gooFlow_turnLine,b_l3:gooFlow_line,	b_l4:gooFlow_update,	b_l5:gooFlow_move,	b_l6:gooFlow_assign,	b_x:gooFlow_remove};
		this.$lineOper.children("b").each(function(){
			this.title=remark[$(this).attr("class")];
		});
	},
	//增加一行记录
	addRecod:function(did,from,to,action,dec){
		var fromval = "";
		var toval = "";
		var sid = "";
		var tid = this.$nodeData[to].nodeDescId;
		var spath = "";
		var tpath = this.$nodeData[to].path;
		var type = "";
		var id = "";
		var rowNum;
		var index = (this.$max-1);
		var temp;
		if("Move"==action){
			type = 'M';
		}else if("Assign"==action){
			type = 'A';
		}else if("Other"==action){
			type = 'R';
		}else if("Update"){
			type = 'U';
		}
		
		var isR = false;
		if(this.isRepeat){
			//对序列重新排序
//			var rowIndex = $("tr[id=" + this.repeadId + "]").attr('datagrid-row-index');
//			$('.datagrid-body-inner>.datagrid-btable>tbody>#datagrid-row-r1-1-' + rowIndex).remove();
//			var tempRowNumber = 1;
//			$.each($('.datagrid-cell-rownumber'), function () {
//				$(this).text(tempRowNumber++);
//			});
			
			$("tr[id=" + this.repeadId + "]").remove();
			
			/*
			id = "" != did?did:this.$id+"_line_"+(this.$max);
			temp = this.$lineData[this.repeadId];
			this.$lineData[id] = temp;
			delete this.$lineData[this.repeadId];
			temp = this.$lineDom[this.repeadId];
			this.$lineDom[id] = temp;
			delete this.$lineDom[this.repeadId];
			temp = null;
			$("#"+this.$focus).attr('id',id);
			this.$focus = id;
			this.$max++;)*/
			//this.$lineDom[this,repedId].id
			id = this.repeadId;
			index = id.replace("UniversalAdapterDemo_line_","");
			this.blurItem();
			if(""==this.linID[to]&&null==this.linID[to]){
				$("#my_"+to).hide();
			}
		}else{
			id = "" != did?did:this.$id+"_line_"+(this.$max-1);
			rowNum = "" != did?did.replace("UniversalAdapterDemo_line_",""):(this.$max-1);
		}
		if(from!="" && from!=null  && from!="null"){
			fromval = this.$nodeData[from].name;
			sid = this.$nodeData[from].nodeDescId;
			spath = this.$nodeData[from].path;
			isR = true;
		}
		if(to!="")	
			toval = this.$nodeData[to].name;
		
		this.changeRowColor();
		if(("Assign"==action || "Other" == action) && !this.linID[to]){
			this.linID[to] = id;
		}
		
		var actionName = "";
		if ("Assign"==action) {
			actionName = gooFlow_assign;
		} else if ("Update"==action) {
			actionName = gooFlow_update;
		} else if ("Move"==action) {
			actionName = gooFlow_move;
		} else if ("Other"==action) {
			actionName = gooFlow_other;
		} else {
			actionName = action;
		}
		
		var controlInsert="";
		if (isR) {
			controlInsert="<input type='hidden' name='controlInsertId' id='controlInsertId' value='" + id + "'/>";
		} else {
			controlInsert="<input type='hidden' name='controlInsertId' id='controlInsertId' value='my_" + to + "'/>";
		} 
		
		var newTR = "<tr id='"+id+"' style='height: 26px;' class='datagrid-row-selected' onclick='clickRow(this,"+to+","+isR+")' datagrid-row-index='"+rowNum+"'>" +
				"<td field='sPath' id='sPath'><div class='datagrid-cell datagrid-cell-c2-sPath' style='text-align:center;height:auto;'>"+fromval+"</div>" +
				"<input type='hidden' name='sid' value='"+sid+"' id='sid"+("" != did?did.replace("UniversalAdapterDemo_line_",""):index)+"'/><input type='hidden' name='tid' value='"+tid+"' id='tid"+("" != did?did.replace("UniversalAdapterDemo_line_",""):index)+"'/><input type='hidden' name='type' value='"+type+"' id='type"+("" != did?did.replace("UniversalAdapterDemo_line_",""):index)+"'/><input type='hidden' name='way' id='way"+("" != did?did.replace("UniversalAdapterDemo_line_",""):index)+"' value=''/>" +
				"<input type='hidden' name='assignVal' id='assignVal"+("" != did?did.replace("UniversalAdapterDemo_line_",""):index)+"' value=''/><input type='hidden' name='assignCondition' id='assignConditionValue"+("" != did?did.replace("UniversalAdapterDemo_line_",""):index)+"' value=''/>" +
				controlInsert +
				"<td field='tPath' id='tPath'><div class='datagrid-cell datagrid-cell-c2-tPath' style='text-align:center;height:auto;'>"+toval+"</div></td>" +
				"<td field='action' id='action'><div class='datagrid-cell datagrid-cell-c2-action' style='text-align:center;height:auto;'>"+actionName+"</div></td>"; 
		if(action=="Move" || action == "Other"){
			newTR ="<tr id='"+id+"' style='height: 26px;' class='datagrid-row-selected' onclick='clickRow(this,"+to+","+isR+")' datagrid-row-index='"+rowNum+"'>" +
				"<td field='sPath' id='sPath'><div class='datagrid-cell datagrid-cell-c2-sPath' style='text-align:center;height:auto;'>"+fromval+"</div>" +
				"<input type='hidden' name='sid' value='"+sid+"'/><input type='hidden' name='tid' value='"+tid+"'/><input type='hidden' name='type' value='"+type+"'/><input type='hidden' name='way' id='way"+("" != did?did.replace("UniversalAdapterDemo_line_",""):index)+"' value='1'/>" +
				"<input type='hidden' name='assignVal' id='assignVal"+("" != did?did.replace("UniversalAdapterDemo_line_",""):index)+"' value=''/><input type='hidden' name='assignCondition' id='assignConditionValue"+("" != did?did.replace("UniversalAdapterDemo_line_",""):index)+"' value=''/></td>" + 
				controlInsert +
				"<td field='tPath' id='tPath'><div class='datagrid-cell datagrid-cell-c2-tPath' style='text-align:center;height:auto;'>"+toval+"</div></td>" +
				"<td field='action' id='action'><div class='datagrid-cell datagrid-cell-c2-action' style='text-align:center;height:auto;'>"+actionName+"</div></td>" +
				"<td field='cz' id='cz'><div class='datagrid-cell datagrid-cell-c2-cz' style='text-align:center;height:auto;'></div></td></tr>" ;
		}else{
			newTR += "<td field='cz' id='cz'><div class='datagrid-cell datagrid-cell-c2-cz' style='text-align:center;height:auto;'><a  onclick=\"openWind('"+spath+"','"+fromval+"','"+tpath+"','"+id+"');\"><span class=\"button-text\">" + gooFlow_operation + "<\span></a></div></td></tr>" ;
		}
		
		var rowNumberTR = "<tr id='" + "datagrid-row-r1-1-" + rowNum + "' class='datagrid-row' style='height: 26px;'><td class='datagrid-td-rownumber'><div class='datagrid-cell-rownumber'></div></td></tr>";
		$('.datagrid-body-inner>.datagrid-btable>tbody').append(rowNumberTR);
		
		$('.datagrid-body>.datagrid-btable>tbody').append(newTR);
		this.repeadId = id;
		this.blurItem();
		//$("#my_"+to).hide();
		
		var tempRowNumber = 1;
		$.each($('.datagrid-cell-rownumber'), function () {
			$(this).text(tempRowNumber++);
		});
		
		this.$addRecordflag=true;
	},
	//改变行的样式
	changeRowColor:function(){
		$(".datagrid-body>.datagrid-btable>tbody>tr").each(function(){
			$(this).attr('class','datagrid-row');
		});
	},
	//左节点拉出来的线修改、平移、赋值操作
	mySetLine:function(id,newType){
		var from=this.$lineData[id].from;//左节点ID
		var to=this.$lineData[id].to;//右节点ID
		if(newType=="0"){
			//alert(id+"删除,左节点ID:"+from+",右节点ID:"+to);
			//this.addRecod("datagrid-btable",from,to,"Move","");
			//this.isRepeat = false;
			if(!this.isRepeat)return;
			 $.ajax({
					type: "POST",
					async:false,
				    url: "${contextPath}/adapter/delNodeDescMap.shtml",
				    dataType:'json',
				    data:{sid:this.$nodeData[from].nodeDescId,tid:this.$nodeData[to].nodeDescId,nodeValAdapterReqId:$('#'+this.repeadId+">td[field=sPath]>input[name=assignVal]").val()},
					success:function(msg){
		           }
		      });
			 
			var rowIndex = $("tr[id=" + this.repeadId + "]").attr('datagrid-row-index');
			$('.datagrid-body-inner>.datagrid-btable>tbody>#datagrid-row-r1-1-' + rowIndex).remove();
			var tempRowNumber = 1;
			$.each($('.datagrid-cell-rownumber'), function () {
				$(this).text(tempRowNumber++);
			});
			 
			$("#operate_"+id).remove();
			$("tr[id=" + this.repeadId + "]").remove();
		}else if(newType=="1"){
			//alert(id+"修改,左节点ID:"+from+",右节点ID:"+to);
			if(this.isRepeat){
				this.mySetLine(id,"0");
			}
			
			$.ajax({
				type: "POST",
				async:true,
			    url: "${contextPath}/adapter/saveNodeDescMap.shtml",
			    dataType:'json',
			    data:{sid:this.$nodeData[from].nodeDescId,tid:this.$nodeData[to].nodeDescId,type:'U'},
				success:function(msg){
	           }
	      });
			this.addRecod("",from,to,"Update","");
			//增加操作按钮
			this.$nodeDom[to].append(this.actionOperateNew(id,"1"));
			
			//添加上级节点
			demo.autoAddParentNode(to);
			//this.$lineDom[this.$id+"_line_"+(this.$max-1)].setAttribute("stroke","#5068AE");
		}else if(newType=="2"){
			//alert(id+"平移,左节点ID:"+from+",右节点ID:"+to);
			if(this.isRepeat){
				this.mySetLine(id,"0");
			}
			
			$.ajax({
				type: "POST",
				async:true,
			    url: "${contextPath}/adapter/saveNodeDescMap.shtml",
			    dataType:'json',
			    data:{sid:this.$nodeData[from].nodeDescId,tid:this.$nodeData[to].nodeDescId,type:'M'},
				success:function(msg){
	           }
	      });
			this.addRecod("",from,to,"Move","");
			this.$nodeDom[to].append(this.actionOperateNew(id,"3"));
			
			//添加上级节点
			demo.autoAddParentNode(to);
			
		}else if(newType=="3"){
			//alert(id+"赋值,左节点ID:"+from+",右节点ID:"+to);
			
		}
	},
		//右节点的赋值,删除操作
	mySetRightLine:function(id,newType){
		if(newType=="4"){
			//alert("删除,右节点ID的赋值:"+id);
			this.isRepeat = false;
			 $.ajax({
					type: "POST",
					async:true,
				    url: "${contextPath}/adapter/delNodeDescMap.shtml",
				    dataType:'json',
				    data:{sid:null,tid:this.$nodeData[id].nodeDescId,nodeValAdapterReqId:$('#'+this.linID[id]+">td[field=sPath]>input[name=assignVal]").val()},
					success:function(msg){
		           }
		      });
			
			//对序列重新排序
			var rowIndex = $(".datagrid-body>.datagrid-btable>tbody>#"+this.linID[id]).attr('datagrid-row-index');
			$('.datagrid-body-inner>.datagrid-btable>tbody>#datagrid-row-r1-1-' + rowIndex).remove();
			var tempRowNumber = 1;
			$.each($('.datagrid-cell-rownumber'), function () {
				$(this).text(tempRowNumber++);
			});
			 
			$(".datagrid-body>.datagrid-btable>tbody>#"+this.linID[id]).remove();
			this.linID[id]="";
			
		}else if(newType=="5"){
			//alert("赋值,右节点ID:"+id);
			
			var rowIndex = $(".datagrid-body>.datagrid-btable>tbody>#"+this.linID[id]).attr('datagrid-row-index');
			if(""!=this.linID[id]&&null!=this.linID[id] && $("#type" + rowIndex).val() == "A"){
				//$("#my_"+id).hide();
				//this.$nodeDom[id].append(this.actionOperateNew(id,"2"));
				openWind("","",this.$nodeData[id].path,this.linID[id]);
				return;
			}
			
			//添加上级节点
			demo.autoAddParentNode(id);
			
			//类型特写
			$('#my_' + id + '>b[class=b_l7]').css('background-color','orange');
			$('#my_' + id + '>b[class=b_l9]').css('background-color','');
			
			//对序列重新排序
			$('.datagrid-body-inner>.datagrid-btable>tbody>#datagrid-row-r1-1-' + rowIndex).remove();
			var tempRowNumber = 1;
			$.each($('.datagrid-cell-rownumber'), function () {
				$(this).text(tempRowNumber++);
			});
			 
			$(".datagrid-body>.datagrid-btable>tbody>#"+this.linID[id]).remove();
			
			this.$max++;
			$.ajax({
				type: "POST",
				async:true,
			    url: "${contextPath}/adapter/saveNodeDescMap.shtml",
			    dataType:'json',
			    data:{sid:null,tid:this.$nodeData[id].nodeDescId,type:'A'},
				success:function(msg){
	           }
	      });
			//增加操作按钮this.$id+"_line_"+(this.$max-1)
			//this.$nodeDom[id].append(this.actionOperateNew(id,"2"));
			this.linID[id] = "";
			this.addRecod("","",id,"Assign","");
			openWind("","",this.$nodeData[id].path,this.$id+"_line_"+(this.$max-1));
		}else if(newType=="6"){
			//alert("赋值,右节点ID:"+id);
			
			//添加上级节点
			demo.autoAddParentNode(id);
			//类型特写
			$('#my_' + id + '>b[class=b_l7]').css('background-color','');
			$('#my_' + id + '>b[class=b_l9]').css('background-color','orange');
			//对序列重新排序
			var rowIndex = $(".datagrid-body>.datagrid-btable>tbody>#"+this.linID[id]).attr('datagrid-row-index');
			$('.datagrid-body-inner>.datagrid-btable>tbody>#datagrid-row-r1-1-' + rowIndex).remove();
			var tempRowNumber = 1;
			$.each($('.datagrid-cell-rownumber'), function () {
				$(this).text(tempRowNumber++);
			});
			 
			$(".datagrid-body>.datagrid-btable>tbody>#"+this.linID[id]).remove();
			
			this.$max++;
			$.ajax({
				type: "POST",
				async:true,
			    url: "${contextPath}/adapter/saveNodeDescMap.shtml",
			    dataType:'json',
			    data:{sid:null,tid:this.$nodeData[id].nodeDescId,type:'R'},
				success:function(msg){
	           }
	      });
			//增加操作按钮this.$id+"_line_"+(this.$max-1)
			//this.$nodeDom[id].append(this.actionOperateNew(id,"2"));
			this.linID[id] = "";
			this.addRecod("","",id,"Other","");
			// openWind("","",this.$nodeData[id].path,this.$id+"_line_"+(this.$max-1));
		}
	},
	//左节点拉出来的线增加一条线后的处理
	myAddLineLeft:function(id,json){
		//alert("myAddLineLeft,线的ID:"+id+"左节点ID:"+json.from+",右节点ID:"+json.to);
		//alert(this.$id+"_line_"+(this.$max-1));
		//console.info(this.$lineDom[this.$id+"_line_"+(this.$max-1)]);
	},
		//右节点拉出来的对象
	myAddLineRight:function(id,nodeId){
		//alert("myAddLineRight.对象ID:"+id+",右节点ID:"+nodeId);
		
	},
	
	autoAddParentNode:function(currentId){
		var nodeDescIdPath = demo.$nodeData[currentId].nodeDescIdPath;
		var nodeDescIdArray = nodeDescIdPath.split('/');
		var rightReg = new RegExp("^R[0-9]*$");
		var existNodeDescId = '';
		$.each($('input[name=tid]'),function(){
			existNodeDescId += this.value + ';';
		});
		
		for (var i=1;i<nodeDescIdArray.length - 1;i++) {
			if (nodeDescIdArray[i] != "" &&  existNodeDescId.indexOf(nodeDescIdArray[i]) == -1) {
				$.each(demo.$nodeData, function (key, value) {
					  if (rightReg.test(key) && value.nodeDescId == nodeDescIdArray[i]) {
						  
						  //添加上级节点的操作框
						  	var divName = 'my_' + key;
						    var lineStartId = key;
						    var n1=$('#'+lineStartId);
							n1.append("<div class='GooFlow_line_oper_new' style='top:1px;z-index:10' id="+divName+" ><b class='b_l7' title='" + gooFlow_assign + "'></b><b class='b_l9' title='" + gooFlow_other + "'></b><b class='b_xx' title='" + gooFlow_move + "'  onmouseover='this.style.backgroundColor=\"#FFFFFF\"' onmouseout='this.style.backgroundColor=\"\"'></b></div>");//选定线时显示的操作框
							//demo.$focusNode = divName;
							//添加上级节点的操作框添加事件
							$('#'+divName).on("click",{nodeId:lineStartId,inthis:demo},function(e){
								This=demo;
								if(!e)e=window.event;
								if(e.target.tagName!="B")	return;
								var nodeId=e.data.nodeId;
								switch($(e.target).attr("class")){
									case "b_xx":
										This.mySetRightLine(nodeId,"4");
										$('#my_'+nodeId).remove();
										This.$nodeData['my_'+nodeId]=null;
										break;
									case "b_l7":
										This.$innerLine['my_'+nodeId]=This.$nodeData[nodeId];
										This.mySetRightLine(nodeId,"5");
										break;
									case "b_l9":
										This.$innerLine['my_'+nodeId]=This.$nodeData[nodeId];
										This.mySetRightLine(nodeId,"6");
										break;
								}
							});
						  
							//添加上级节点的R操作数据
						    var id = key;
							$('#my_' + id + '>b[class=b_l7]').css('background-color','');
							$('#my_' + id + '>b[class=b_l9]').css('background-color','orange');
							
							demo.$max++;
							$.ajax({
								type: "POST",
								async:true,
							    url: "${contextPath}/adapter/saveNodeDescMap.shtml",
							    dataType:'json',
							    data:{sid:null,tid:nodeDescIdArray[i],type:'R'},
								success:function(msg){
					           }
							});
							
							//添加上级节点的列表记录
							demo.addRecod("","",id,"Other","");
					  }
				});
			}
		}
	}
}
//将此类的构造函数加入至JQUERY对象中
jQuery.extend({
	createGooFlow:function(bgDiv,property){
		return new GooFlow(bgDiv,property);
		
	}
}); 