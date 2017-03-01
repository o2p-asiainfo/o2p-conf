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
	this.$nodeLeftData={};//左边节点数据
	this.$nodeRightData={};//右边节点数据
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
	this.$editable=true;//工作区是否可编辑
	this.$deletedItem={};//在流程图的编辑操作中被删除掉的元素ID集合,元素ID为KEY,元素类型(node,line.area)为VALUE
	var headHeight=0;
	this.$tabCou = 0;
	this.isRepeat = false;
	this.repeadId;
	this.$isIEflag=false;
	this.$addRecordflag=false;
	this.$leftIndex=-1;
	this.$leftId="";
	this.$rightIndex=-1;
	this.$rightId="";
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
	this.$nowType="direct";
	this.$bgDiv.append("<div class='GooFlow_work'  style='width:auto;height:"+(height)+"px;'><div class='GooFlow_work_inner clearfix'><div class='GooFlow_line_move' style='display:none;'></div><ul class='l'></ul><ul class='r'></ul></div></div>");
	this.$workArea=$(".GooFlow_work_inner");
	this.$draw=null;//画矢量线条的容器
	height = height>1000?height:(height+700);
	this.initDraw("draw_"+this.$id,(width),(height));
	this.$group=null;
	//if(property.haveGroup)
	//	this.initGroup(width,height);
	if(this.$editable){		
	  //划线时用的绑定
	  this.$workArea.mousemove({inthis:this},function(e){
		var This=e.data.inthis;
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
			else line.childNodes[1].setAttribute("marker-end","url(#arrow2)");
		}
		else line.points.value=lineStart.x+","+lineStart.y+" "+X+","+Y;
	  });
	  this.$workArea.mouseup({inthis:this},function(e){
	  	var This=e.data.inthis;
		if(This.$rightIndex!=-1){
			var nstr;
			if($("#"+This.$rightId).hasClass("par"))nstr='';
			else nstr='<dd class="assign">Assign</dd>';
			$('<div class="operate  single-opline"><div class="op-select"><div class="por"><div class="sl"></div><span>Operate</span><dl><dd class="remove">Remove</dd><dd class="other">Other</dd>'+nstr+'</dl></div></div></div>').prependTo(This.$workArea).css("top",(This.$rightIndex*31+9)+"px").attr({"id":"op"+This.$rightId,"to":This.$rightId,"from":""}).css("z-index","201").siblings(".operate").css("z-index","197");
			}
		else{} 
		This.$rightIndex=-1;
		This.$rightId="";
	  	var lineStart=This.$workArea.data("lineStart");
		$(this).css("cursor","auto").removeData("lineStart");
		var tmp=document.getElementById("GooFlow_tmp_line");
		if(tmp)This.$draw.removeChild(tmp);
	  });
	  //为了结点而增加的一些集体delegate绑定
	  this.initWorkForNode();
	}
}
////////////////全局变量区域
var repeadJson={};//存放重复操作的记录




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
	initWorkForNode:function(){
		this.$workArea.delegate("ul li","click",{inthis:this},function(e){
			$(this).addClass("act").siblings().removeClass("act");	
		});
		this.$workArea.delegate("ul li","mouseenter",{inthis:this},function(e){
			$(this).css("z-index","5");	
		});
		this.$workArea.delegate("ul li","mouseleave",{inthis:this},function(e){
			$(this).css("z-index","1");	
		});
		this.$workArea.delegate("ul.r li","click",{inthis:this},function(e){
			var This=e.data.inthis;
			if($(this).hasClass("checked")){
			var rid=$(this).attr("id");
			lineRelation(rid);
			nodeChecked(lid,mid,rid);
			}
			else if(This.$rightIndex!=-1){$("ul.l li.act").removeClass("act")}
		});
		this.$workArea.delegate("ul li","mousedown",{inthis:this},function(e){
			var This=e.data.inthis;
			This.$workArea.find(".operate").each(function(){
				if(!$(this).hasClass("relation")){$(this).remove()}
				else{$(this).addClass("fade-model")}
				})
			This.$rightIndex=-1;
			$("ul.r li.act").removeClass("act");
			$(this).addClass("act").siblings().removeClass("act");	
			if($(this).attr("id").indexOf('L')>-1){This.$leftIndex=$(this).index();This.$leftId=$(this).attr("id");}
			else{
				if($(this).hasClass("checked")){This.$rightIndex=-1}
				else{This.$rightIndex=$(this).index();This.$rightId=$(this).attr("id");}}
			var ev=mousePosition(e),t=getElCoordinate(This.$workArea[0]);
			var X,Y;
			X=ev.x-t.left+This.$workArea[0].parentNode.scrollLeft;
			Y=ev.y-t.top+This.$workArea[0].parentNode.scrollTop;
			This.$workArea.data("lineStart",{"x":X,"y":Y,"id":this.id}).css("cursor","crosshair");
			var line=GooFlow.prototype.drawLine("GooFlow_tmp_line",[X,Y],[X,Y],true,true);
			This.$draw.appendChild(line);
			This.$flag=0;				
		});
		this.$workArea.delegate("div.operate dd","click",function(){
			var prevOperate=$(this).parent().prev().html();
			var curCss=$(this).attr("class");
			var curId=$(this).closest('.operate').attr("id");
			var leftnodeId=$("#"+curId).attr("from");
			var rightnodeId=$("#"+curId).attr("to");
			$("#"+leftnodeId).removeClass("act");
			$("#"+rightnodeId).removeClass("act");
			if($("#"+curId).attr("from")==""){leftnodeId=""}
			if($("#"+curId).hasClass("relation")){
				if(curCss=="remove"){
					remove(leftnodeId,curId,rightnodeId,prevOperate);
				}
				else{
					if(curCss=="move"){move(leftnodeId,curId,rightnodeId);}
					else if(curCss=="update"){update(leftnodeId,curId,rightnodeId);}
					else if(curCss=="other"){other(leftnodeId,curId,rightnodeId);}
					else if(curCss=="assign"){assign(leftnodeId,curId,rightnodeId);}
				}
			}
			else{
				$(this).parent().prev().html($(this).html());
				if(curCss=="remove"){
					$("#"+leftnodeId).removeClass("checked");
					$("#"+rightnodeId).removeClass("checked");
					$("#"+curId).remove();
				}
				else{
					$("#"+curId).addClass("relation fade-model")
					$("#"+rightnodeId).addClass("checked");	
					$("#"+leftnodeId).addClass("checked");	
					if(curCss=="move"){move(leftnodeId,curId,rightnodeId);}
					else if(curCss=="update"){update(leftnodeId,curId,rightnodeId);}
					else if(curCss=="other"){other(leftnodeId,curId,rightnodeId);}
					else if(curCss=="assign"){assign(leftnodeId,curId,rightnodeId);}
				}
			}
			
			});

		//绑定连线时确定结束点
		this.$workArea.delegate("ul.r li","mouseup",{inthis:this},function(e){		
			var This=e.data.inthis;
			if(This.$leftIndex!="-1"){
			$(this).addClass("act").siblings().removeClass("act");	
			if($(this).hasClass("checked")){alert("this has been used");This.$leftIndex="-1";This.$leftId="";return;}
			This.$rightIndex=$(this).index();
			This.$rightId=$(this).attr("id");
			var newid="R"+(This.$rightIndex+1)+"L"+(This.$leftIndex+1);
			var n=Math.abs(This.$rightIndex-This.$leftIndex);
			var newop=$('<div class="operate connect-line"><div class="t-b" style="height:'+n*31+'px"><div class="left"  style="height:'+n*31+'px"><div class="right"></div><div class="op-select"><div class="por"><span>operate</span><dl><dd class="remove">Remove</dd><dd class="update">Update</dd><dd class="move">Move</dd></dl></div></div></div></div></div>').css({"height":n*31+"px","z-index":"201"}).attr({"id":newid,"from":This.$leftId,"to":This.$rightId});
			This.$workArea.append(newop);
			if(This.$leftIndex>=This.$rightIndex)newop.find(".t-b").attr("class","b-t").css({"top":(This.$rightIndex*31-20)+"px"});
			else{newop.css({"top":(This.$leftIndex*31+19)+"px"})}
			This.$leftIndex="-1";
			This.$rightIndex="-1";
			}
			var tmp=document.getElementById("GooFlow_tmp_line");
			if(tmp)This.$draw.removeChild(tmp);
			reSize();
			e.stopPropagation();
		});
	},
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
			if(dash)line.stroke.dashstyle="Dash";
			if(mark)line.strokeColor="#ff3300";
			else	line.strokeColor="#5068AE";
		}
		return line;
	}
};
function getElCoordinate(dom) {
  var t = dom.offsetTop;
  var l = dom.offsetLeft;
  dom=dom.offsetParent;
  while (dom) {
    t += dom.offsetTop;
    l += dom.offsetLeft;
	dom=dom.offsetParent;
  }; return {
    top: t,
    left: l
  };
}
function mousePosition(ev){
	if(!ev) ev=window.event;
    if(ev.pageX || ev.pageY){
        return {x:ev.pageX, y:ev.pageY};
    }
    return {
        x:ev.clientX + document.documentElement.scrollLeft - document.body.clientLeft,
        y:ev.clientY + document.documentElement.scrollTop  - document.body.clientTop
    };
}
	function reSize(){
	var opsnumber=$(".GooFlow_work .connect-line").length;
	$(".GooFlow_work .connect-line").each(function(index){
		$(this).find(".left").width((20+parseInt(120/opsnumber*(index+1)))+"px");
		$(this).find(".right").width((222-parseInt(120/opsnumber*(index+1)))+"px");
		$(this).find(".right").css("right","-"+(222-parseInt(120/opsnumber*(index+1)))+"px");
		if($(this).hasClass("fade-model")){$(this).css("z-index",200-index)}
		else{$(this).css("z-index",201)}
		})
	$(".GooFlow_work .single-opline").css("z-index","199")
	}
	function clearStatus(){
		$(".GooFlow_work_inner .operate:not(.fade-model)").addClass("fade-model").css("z-index",189);
		}
	function lineRelation(e){
		clearStatus();
	    var rid=e;
		var lid="";
		var mid="";
		$(".GooFlow_work_inner .fade-model").each(function(index){
			if($(this).attr('to')==rid&&$(this).attr('from')!=""){
				lid=$(this).attr('from');
				$("#"+lid).addClass("act").siblings().removeClass("act");
				$(this).removeClass("fade-model").css("z-index","201");
				mid=$(this).attr("id");
				}
			else if($(this).attr('id')=="op"+rid){
				$(this).removeClass("fade-model").css("z-index","201");
				mid=$(this).attr("id");
				$("ul.l li").removeClass("act")
				}
			})
			$("#"+lid).addClass("act").siblings().removeClass("act");
			$("#"+rid).addClass("act").siblings().removeClass("act");
			nodeChecked(lid,mid,rid);
	}
	//字符过长溢出处理
	function resizeStr(){
		$(".GooFlow_work ul em").each(function(){
		if($(this).html().length>=25){
			$(this).html($(this).html().substring(0,25)+"…");
			}
		})
		}
	//删除节点节接口，三个参数分别是左节点ID， 中间操作项id，右节点,左节点存在null情况。
	function remove(lid,mud,rid,prevop){
		if(confirm(title[5])){
			$("#"+lid).removeClass("checked");
			$("#"+rid).removeClass("checked");
			$("#"+mud).remove();//删除线操作
			var srcId = null;
			if("Move" == prevop || "Update" == prevop){
				if("" != lid){
					srcId = $nodeLeftData[lid].nodeDescId;//左节点ID
				}
			}
			var tarId = $nodeRightData[rid].nodeDescId;//右节点ID
			var key = lid+rid;
			delete repeadJson[key]; //删除线操作记录,以免重复操作
			var trId = "UniversalAdapterDemo_line_"+mud;
			$("#"+trId).remove();//清空表格记录
			$('.datagrid-body-inner>.datagrid-btable>tbody>#datagrid-row-r1-1-' + mud).remove();//清空行记录
			//重新排列行号
			var tempRowNumber = 1;
			$.each($('.datagrid-cell-rownumber'), function () {
				$(this).text(tempRowNumber++);
			});
			var nodeValAdapterReqId = $("#"+trId).find("input[name=assignVal]").val();
			//清空数据
			delLineToDate(srcId,tarId,nodeValAdapterReqId);
		}
	}
	//move操作节点
	function move(lid,mud,rid){
		var srcId = $nodeLeftData[lid].nodeDescId;//左节点ID
		var tarId = $nodeRightData[rid].nodeDescId;//右节点ID
		var state = isExitLine(lid,rid,"Move");
		if("EXIT" == state){
			alert(title[6]);
		}else if("DF_STATE" == state){
			if(confirm(title[7])){
				$("#"+mud).addClass("relation fade-model").find("span").html("Move");
				$("#"+rid).addClass("checked");	
				$("#"+lid).addClass("checked");
				//修改线的数据
				addLineToDate(srcId,tarId,"M");
				changeRow(mud,lid,rid,"Move");
			}
		}else if("NO_DATE" == state){
			//添加线的数据
			addLineToDate(srcId,tarId,"M");
			//添加表格记录
			addRecod(mud,lid,rid,"Move","");
			//添加上级节点
			autoAddParentNode(mud,rid);
		}
	}
	//更新节点操作接口mm
	function update(lid,mid,rid){
		var srcId = $nodeLeftData[lid].nodeDescId;//左节点ID
		var tarId = $nodeRightData[rid].nodeDescId;//右节点ID
		var fromval = $nodeLeftData[lid].name;//源节点名称
		var tpath = $nodeRightData[rid].path;//目标节点path
		var spath = $nodeLeftData[lid].path;//源节点path
		var trId = "UniversalAdapterDemo_line_"+mid;//表格行ID
		var state = isExitLine(lid,rid,"Update");
		if("EXIT" == state){
			if(confirm(title[8])){
				$("#"+mid).addClass("relation fade-model").find("span").html("Update");
				$("#"+rid).addClass("checked");	
				$("#"+lid).addClass("checked");
				//修改线的数据
				addLineToDate(srcId,tarId,"U");
				//打开操作窗口
				openWind(spath,fromval,tpath,trId);
			}
		}else if("DF_STATE" == state){
			if(confirm(title[9])){
				$("#"+mid).addClass("relation fade-model").find("span").html("Update");
				$("#"+rid).addClass("checked");	
				$("#"+lid).addClass("checked");
				//修改线的数据
				addLineToDate(srcId,tarId,"U");
				changeRow(mid,lid,rid,"Update");
				//打开操作窗口
				openWind(spath,fromval,tpath,trId);
			}
		}else if("NO_DATE" == state){
			//修改线的数据
			addLineToDate(srcId,tarId,"U");
			//添加表格记录
			addRecod(mid,lid,rid,"Update","");
			//添加上级节点
			autoAddParentNode(mid,rid);
			//打开操作窗口
			openWind(spath,fromval,tpath,trId);
		}
	}
	//
	function other(lid,mid,rid){
		var tarId = $nodeRightData[rid].nodeDescId;//右节点ID
		var state = isExitLine(lid,rid,"Other");
		if("EXIT" == state){
			alert(title[10]);
		}else if("DF_STATE" == state){
			if(confirm(title[11])){
				$("#"+mid).addClass("relation fade-model").find("span").html("Other");
				$("#"+rid).addClass("checked");	
				$("#"+lid).addClass("checked");
				//添加线记录
				addLineToDate(null,tarId,"R");
				changeRow(mid,lid,rid,"Other");
			}
		}else if("NO_DATE" == state){
			//添加线记录
			addLineToDate(null,tarId,"R");
			//添加表格记录
			addRecod(mid,lid,rid,"Other","");
			//添加上级节点
			autoAddParentNode(mid,rid);
		}
	}
	
	function assign(lid,mid,rid){
		var tarId = $nodeRightData[rid].nodeDescId;//右节点ID
		var tpath = $nodeRightData[rid].path;//目标节点path
		var trId = "UniversalAdapterDemo_line_"+mid;//表格行ID
		var state = isExitLine(lid,rid,"Assign");
		if("EXIT" == state){
			alert(title[12]);
		}else if("DF_STATE" == state){
			if(confirm(title[13])){
				$("#"+mid).addClass("relation fade-model").find("span").html("Assign");
				$("#"+rid).addClass("checked");	
				$("#"+lid).addClass("checked");
				//添加线记录
				addLineToDate(null,tarId,"A");
				changeRow(mid,lid,rid,"Assign");
				//打开操作窗口
				openAssignWind("","",tpath,trId);
			}
		}else if("NO_DATE" == state){
			//添加线记录
			addLineToDate(null,tarId,"A");
			addRecod(mid,lid,rid,"Assign","");
			//添加上级节点
			autoAddParentNode(mid,rid);
			//打开操作窗口
			openAssignWind("","",tpath,trId);
		}
	}
	//节点树选中
	function nodeChecked(lid,mud,rid){
		var trId = "UniversalAdapterDemo_line_"+mud;
		changeRowColor();//改变表格行样式
		$('#'+trId).attr("class","datagrid-row-selected");//设置表格选中
	}
	//判断线是否存在
	function isExitLine(lid,rid,operator){
		var flag = true;
		var keyValue = lid+rid;//记录的Key值
		var value = operator;//记录的value值
		for(var key in repeadJson){
			if(key ==  keyValue){//说明有这两条线的操作
				var jsonValue = repeadJson[key];
				if(value == jsonValue){//说明是同一个操作
					flag = false;
					return "EXIT";
				}else{//说明是不同的操作,但是线已经存在
					//清除之前表格记录,重新加载一条move记录
					repeadJson[keyValue] = value;//修改记录
					return "DF_STATE";
				}
			}
		}
		if(flag){
			repeadJson[keyValue] = value;//添加一条线操作记录,以免重复操作
			return "NO_DATE";
		}
	}
	//加载节点
	function loadData(datasource,value){
		if("L" ==  value){
			this.$nodeLeftData=datasource;
			$(".GooFlow_work ul.l").show();
		}else if("R" == value){
			this.$nodeRightData=datasource;
			$(".GooFlow_work ul.r").show();
		}
		var josnobj=datasource;
		$.each(josnobj,function(key,val){//生成节点
			var ns=val.childCount>0?"par":"child";
			var lli='<li id="'+key+'" class="'+ns+'"><span class="d-t"><em style="margin-left:'+val.dept*5+"px"+'" >'+val.name+'</em></span><span class="d-s"><b>'+val.nodeNum+'</b>'+val.nodeType+'</span><div class="tips">'+val.name+'</div></li>';
			if(key.indexOf("L")>-1){
			$("ul.l").append(lli);
			}
		else if(key.indexOf("R")>-1){
			$("ul.r").append(lli);
			}
		});
		var i=$("ul.l li").length;
		var j=$("ul.r li").length;
		var nm=i>j?i:j;
		$(".GooFlow_work_inner").height(nm*31+300+"px");
		//限制字符长度
		resizeStr();
	}
	//加载线linelist:线的json数据
	function loadLine(linelist){
		$.each(linelist,function(key,val){
			if(val.from==""){
				var nstr;
				if($("#"+val.to).hasClass("par"))nstr='';
			    else nstr='<dd class="assign">Assign</dd>'
				$('<div class="operate single-opline relation fade-model"><div class="op-select"><div class="por"><div class="sl"></div><span>'+val.operate+'</span><dl><dd class="remove">Remove</dd><dd class="other">Other</dd>'+nstr+'</dl></div></div></div>').prependTo($(".GooFlow_work_inner")).css("top",(val.to.substring(1)*31+9-31)+"px").attr({"id":key,"to":val.to,"from":""});
				$("#"+val.to).addClass("checked");
				}
			else{
				var lindex=parseInt(val.from.substring(1));
				var rindex=parseInt(val.to.substring(1));
				var n=Math.abs(lindex-rindex);
				var dclass="t-b";
				var dtop=lindex*31-10;
				if(lindex>rindex){dclass="b-t";dtop=rindex*31-10};
				$('<div class="operate connect-line relation fade-model"><div class="'+dclass+'"  style="height:'+n*31+'px"><div class="left"  style="height:'+n*31+'px"><div class="right"></div><div class="op-select"><div class="por"><span>'+val.operate+'</span><dl><dd class="remove">Remove</dd><dd class="logic">Logic</dd><dd class="move">Move</dd></dl></div></div></div></div></div>').prependTo($(".GooFlow_work_inner")).css({"height":n*31+"px","top":dtop+"px"}).attr({"id":key,"from":val.from,"to":val.to});
				$("#"+val.from).addClass("checked");	
				$("#"+val.to).addClass("checked");	
				}
			})
		reSize();
	}
	//增加一行记录,mud:线ID,from:源节点key值,to:目标节点key值,action:操作
	function  addRecod(mud,from,to,action,dec){
		var fromval = "";//源节点名
		var toval = "";//目标节点名
		var sid = "";//源节点ID
		var tid = $nodeRightData[to].nodeDescId;//目标节点ID
		var spath = "";//源节点path
		var tpath = $nodeRightData[to].path;//目标节点path
		var type = "";
		var id = "";
		var rowNum;
		var index = (this.$max-1);
		var trId = "UniversalAdapterDemo_line_"+mud;
		if("Move"==action){
			type = 'M';
		}else if("Assign"==action){
			type = 'A';
		}else if("Other"==action){
			type = 'R';
		}else if("Update"){
			type = 'U';
		}
		if(from!="" && from!=null  && from!="null"){
			fromval = $nodeLeftData[from].name;
			sid = $nodeLeftData[from].nodeDescId;
			spath = $nodeLeftData[from].path;
		}
		if(to!="")	
			toval = $nodeRightData[to].name;
		
		changeRowColor();//改变表格行样式
		
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
		var newTR = "<tr id='"+trId+"' style='height: 26px;' class='datagrid-row-selected' onclick=\"clickRow('"+to+"','"+trId+"')\" datagrid-row-index='"+rowNum+"'>" +
				"<td field='sPath' id='sPath'><div class='datagrid-cell datagrid-cell-c2-sPath' style='text-align:center;height:auto;'>"+fromval+"</div>" +
				"<input type='hidden' name='tid' value='"+tid+"'/>"+
				"<input type='hidden' name='way' id='way' value=''/>" +
				"<input type='hidden' name='assignVal' id='assignVal' value=''/>" +
				"<input type='hidden' name='assignCondition' id='assignConditionValue' value=''/>" +
				"<td field='tPath' id='tPath'><div class='datagrid-cell datagrid-cell-c2-tPath' style='text-align:center;height:auto;'>"+toval+"</div></td>" +
				"<td field='action' id='action'><div class='datagrid-cell datagrid-cell-c2-action' style='text-align:center;height:auto;'>"+actionName+"</div></td>"; 
		if(action=="Move" || action == "Other"){
			newTR ="<tr id='"+trId+"' style='height: 26px;' class='datagrid-row-selected' onclick=\"clickRow('"+to+"','"+trId+"')\" datagrid-row-index='"+rowNum+"'>" +
				"<td field='sPath' id='sPath'><div class='datagrid-cell datagrid-cell-c2-sPath' style='text-align:center;height:auto;'>"+fromval+"</div>" +
				"<input type='hidden' name='tid' value='"+tid+"'/>"+
				"<input type='hidden' name='way' id='way' value=''/>" +
				"<input type='hidden' name='assignVal' id='assignVal' value=''/>" +
				"<input type='hidden' name='assignCondition' id='assignConditionValue' value=''/>" +
				"<td field='tPath' id='tPath'><div class='datagrid-cell datagrid-cell-c2-tPath' style='text-align:center;height:auto;'>"+toval+"</div></td>" +
				"<td field='action' id='action'><div class='datagrid-cell datagrid-cell-c2-action' style='text-align:center;height:auto;'>"+actionName+"</div></td>" +
				"<td field='cz' id='cz'><div class='datagrid-cell datagrid-cell-c2-cz' style='text-align:center;height:auto;'></div></td></tr>" ;
		}else if(action=="Assign"){
			newTR += "<td field='cz' id='cz'><div class='datagrid-cell datagrid-cell-c2-cz' style='text-align:center;height:auto;'><a  onclick=\"openAssignWind('','','"+tpath+"','"+trId+"');\"><span class=\"button-text\">" + gooFlow_operation + "<\span></a></div></td></tr>" ;
		}else{
			newTR += "<td field='cz' id='cz'><div class='datagrid-cell datagrid-cell-c2-cz' style='text-align:center;height:auto;'><a  onclick=\"openWind('"+spath+"','"+fromval+"','"+tpath+"','"+trId+"');\"><span class=\"button-text\">" + gooFlow_operation + "<\span></a></div></td></tr>" ;
		}
		
		var rowNumberTR = "<tr id='" + "datagrid-row-r1-1-" + mud + "' class='datagrid-row' style='height: 26px;'><td class='datagrid-td-rownumber'><div class='datagrid-cell-rownumber'></div></td></tr>";
		$('.datagrid-body-inner>.datagrid-btable>tbody').append(rowNumberTR);
		
		$('.datagrid-body>.datagrid-btable>tbody').append(newTR);
		
		var tempRowNumber = 1;
		//填充行号
		$.each($('.datagrid-cell-rownumber'), function () {
			$(this).text(tempRowNumber++);
		});
	}
	//改变操作  mud:线ID,from:源节点key值,to:目标节点key值,action:操作
	function changeRow(mud,from,to,action){
		var fromval = "";//源节点名
		var toval = "";//目标节点名
		var sid = "";//源节点ID
		var tid = $nodeRightData[to].nodeDescId;//目标节点ID
		var spath = "";//源节点path
		var tpath = $nodeRightData[to].path;//目标节点path
		var type = "";
		var id = "";
		var rowNum;
		var index = (this.$max-1);
		var trId = "UniversalAdapterDemo_line_"+mud;
		if("Move"==action){
			type = 'M';
		}else if("Assign"==action){
			type = 'A';
		}else if("Other"==action){
			type = 'R';
		}else if("Update"){
			type = 'U';
		}
		if(from!="" && from!=null  && from!="null"){
			fromval = $nodeLeftData[from].name;
			sid = $nodeLeftData[from].nodeDescId;
			spath = $nodeLeftData[from].path;
		}
		if(to!="")	
			toval = $nodeRightData[to].name;
		
		changeRowColor();//改变表格行样式
		
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
		var newTR = "<tr id='"+trId+"' style='height: 26px;' class='datagrid-row-selected' onclick=\"clickRow('"+to+"','"+trId+"')\" datagrid-row-index='"+rowNum+"'>" +
				"<td field='sPath' id='sPath'><div class='datagrid-cell datagrid-cell-c2-sPath' style='text-align:center;height:auto;'>"+fromval+"</div>" +
				"<input type='hidden' name='tid' value='"+tid+"'/>"+
				"<input type='hidden' name='way' id='way' value=''/>" +
				"<input type='hidden' name='assignVal' id='assignVal' value=''/>" +
				"<input type='hidden' name='assignCondition' id='assignConditionValue' value=''/>" +
				"<td field='tPath' id='tPath'><div class='datagrid-cell datagrid-cell-c2-tPath' style='text-align:center;height:auto;'>"+toval+"</div></td>" +
				"<td field='action' id='action'><div class='datagrid-cell datagrid-cell-c2-action' style='text-align:center;height:auto;'>"+actionName+"</div></td>"; 
		if(action=="Move" || action == "Other"){
			newTR ="<tr id='"+trId+"' style='height: 26px;' class='datagrid-row-selected' onclick=\"clickRow('"+to+"','"+trId+"')\" datagrid-row-index='"+rowNum+"'>" +
				"<td field='sPath' id='sPath'><div class='datagrid-cell datagrid-cell-c2-sPath' style='text-align:center;height:auto;'>"+fromval+"</div>" +
				"<input type='hidden' name='tid' value='"+tid+"'/>"+
				"<input type='hidden' name='way' id='way' value=''/>" +
				"<input type='hidden' name='assignVal' id='assignVal' value=''/>" +
				"<input type='hidden' name='assignCondition' id='assignConditionValue' value=''/>" +
				"<td field='tPath' id='tPath'><div class='datagrid-cell datagrid-cell-c2-tPath' style='text-align:center;height:auto;'>"+toval+"</div></td>" +
				"<td field='action' id='action'><div class='datagrid-cell datagrid-cell-c2-action' style='text-align:center;height:auto;'>"+actionName+"</div></td>" +
				"<td field='cz' id='cz'><div class='datagrid-cell datagrid-cell-c2-cz' style='text-align:center;height:auto;'></div></td></tr>" ;
		}else if(action=="Assign"){
			newTR += "<td field='cz' id='cz'><div class='datagrid-cell datagrid-cell-c2-cz' style='text-align:center;height:auto;'><a  onclick=\"openAssignWind('','','"+tpath+"','"+trId+"');\"><span class=\"button-text\">" + gooFlow_operation + "<\span></a></div></td></tr>" ;
		}else{
			newTR += "<td field='cz' id='cz'><div class='datagrid-cell datagrid-cell-c2-cz' style='text-align:center;height:auto;'><a  onclick=\"openWind('"+spath+"','"+fromval+"','"+tpath+"','"+trId+"');\"><span class=\"button-text\">" + gooFlow_operation + "<\span></a></div></td></tr>" ;
		}
		$("#"+trId).replaceWith(newTR);
	}
	//改变行的样式
	function changeRowColor(){
		$(".datagrid-body>.datagrid-btable>tbody>tr").each(function(){
			$(this).attr('class','datagrid-row');
		});
	}
	/**
	 * 表格单行选中
	 * @param obj
	 * @param to
	 * @param trId
	 */
	function clickRow(to,trId){
		changeRowColor();//改变表格行样式
		$('#'+trId).attr("class","datagrid-row-selected");//设置表格选中
		lineRelation(to);//设置树节点选中
	}
	/**
	 * 设置节点为选中状态
	 * @param e:目标节点的名称
	 */
	function addParentnode(e){
		var objectid=e;
		var curid="op"+e;
		$('<div class="operate single-opline relation fade-model"><div class="op-select"><div class="por"><div class="sl"></div><span>Other</span><dl><dd class="remove">Remove</dd><dd class="other">Other</dd></dl></div></div></div>').prependTo($(".GooFlow_work_inner")).css("top",(objectid.substring(1)*31+9-31)+"px").attr({"id":curid,"to":objectid,"from":""});$("#"+objectid).addClass("checked");
		}
	/**
	 * 自动添加父节点
	 * @param currentId:目标节点ID
	 */
	function autoAddParentNode(mud,currentId){
		var nodeDescIdPath = $nodeRightData[currentId].nodeDescIdPath;
		var nodeDescIdArray = nodeDescIdPath.split('/');
		var rightReg = new RegExp("^R[0-9]*$");
		var existNodeDescId = '';
		$.each($('input[name=tid]'),function(){
			existNodeDescId += this.value + ';';
		});
		
		for (var i=1;i<nodeDescIdArray.length - 1;i++) {
			if (nodeDescIdArray[i] != "" &&  existNodeDescId.indexOf(nodeDescIdArray[i]) == -1) {
				$.each($nodeRightData, function (key, value) {
					  if (rightReg.test(key) && value.nodeDescId == nodeDescIdArray[i]) {
						  addParentnode(key);//添加父节点的线操作
						  repeadJson[key] = "OT";//添加操作记录
						  //添加线记录
						  addLineToDate(null,nodeDescIdArray[i],"R");
						  //添加上级节点的列表记录
						  addRecod("op"+key,"",key,"Other","");
					  }
				});
			}
		}
		nodeChecked("",mud,currentId);//设置当前操作记录选中
	}
    //添加线到数据库srcId:源节点ID,tarId:目标节点ID,typeV:节点操作类型
	function addLineToDate(srcId,tarId,typeV){
		$.ajax({
			type: "POST",
			async:true,
		    url: "${contextPath}/adapter/saveNodeDescMap.shtml",
		    dataType:'json',
		    data:{sid:srcId,tid:tarId,type:typeV},
			success:function(msg){
           }
      });
	}
	//删除线数据库srcId:源节点ID,tarId:目标节点ID,nodeValAdapterReqId:节点取值要求ID
	function delLineToDate(srcId,tarId,nodeValAdapterReqId){
		 $.ajax({
				type: "POST",
				async:false,
			    url: "${contextPath}/adapter/delNodeDescMap.shtml",
			    dataType:'json',
			    data:{sid:srcId,tid:tarId,nodeValAdapterReqId:nodeValAdapterReqId},
				success:function(msg){
	           }
	      });
	}
	//判断能不能提交返回
	function isSureAbleSubmit(){
		var tableNum = 0;//表格记录数
		var tarNodeNum = 0;//目标节点个数
		$.each($('.datagrid-cell-rownumber'), function () {
			tableNum++;
		});
		if(0 != tableNum){
			$.each(this.$nodeRightData,function(key,value){
				tarNodeNum++;
			});
			if(tarNodeNum == tableNum){
			   return true;//说明线全部拉完了
			}
		}
		return false;
	}