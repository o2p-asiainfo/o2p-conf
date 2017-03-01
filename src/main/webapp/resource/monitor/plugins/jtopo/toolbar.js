// 页面工具栏
function showJTopoToobar(stage){
	var toobarDiv = $('<div class="jtopo_toolbar clearfix">').html(''
		
		+'<div class="pull-left"><input type="button" class="btn blue" id="centerButton" value="'+getLang('center')+'"/>&nbsp;'
		+'<input type="button" id="fullScreenButton" class="btn blue" value="'+getLang('fullscreen')+'"/>&nbsp;'
		+'<input type="button" id="zoomOutButton" class="btn blue" value="'+getLang('zoomIn')+'" />&nbsp;'
		+'<input type="button" id="zoomInButton" class="btn blue" value="'+getLang('zoomOut')+'" /></div>'		
		+'<div class="pull-right"><input type="checkbox" name="modeRadio" value="drag" id="r3"/><label for="r3">&nbsp;'+getLang('drag')+'</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="zoomCheckbox"/><label for="zoomCheckbox">&nbsp;'+getLang('zoom')+'</label>&nbsp;&nbsp;&nbsp;&nbsp;'
		+'<input type="text" id="findText" value="" class="form-control" placeholder="'+getLang('keywords')+'" style="width:200px; display:inline-block!important;vertical-align:middle;" onkeydown="findButton.click()">&nbsp;'
		+'<input type="button" id="findButton" class="btn green" value="'+getLang('search')+'"></div>');
		
		
	$('#jtopo-toolbar').html(toobarDiv);

	// 工具栏按钮处理
	$("input[name='modeRadio']").click(function(){			
		if($(this).is(":checked")){
			stage.mode = $(this).val();
		}
		else {
			stage.mode = 'normal';
		}
	});

	$('#centerButton').click(function(){
		stage.centerAndZoom(); //缩放并居中显示
	});
	$('#zoomOutButton').click(function(){
		stage.zoomOut();
	});
	$('#zoomInButton').click(function(){
		stage.zoomIn();
	});
	$('#exportButton').click(function(){
		stage.saveImageInfo();
	});
	$('#zoomCheckbox').click(function(){
		if($('#zoomCheckbox').attr('checked')){
			stage.wheelZoom = 0.85; // 设置鼠标缩放比例
		}else{
			stage.wheelZoom = null; // 取消鼠标缩放比例
		}
	});
	$('#fullScreenButton').click(function(){
		runPrefixMethod(stage.canvas, "RequestFullScreen")
	});

	// 查询
	$('#findButton').click(function(){
		var text = $('#findText').val().trim();
		var nodes = stage.find('node[text="'+text+'"]');
		if(nodes.length > 0){
			var node = nodes[0];
			node.selected = true;
			var location = node.getCenterLocation();
			// 查询到的节点居中显示
			stage.setCenter(location.x, location.y);
			
			function nodeFlash(node, n){
				if(n == 0) {
					node.selected = false;
					return;
				};
				node.selected = !node.selected;
				setTimeout(function(){
					nodeFlash(node, n-1);
				}, 300);
			}
			
			// 闪烁几下
			nodeFlash(node, 60);
		}
	});
}

var runPrefixMethod = function(element, method) {
	var usablePrefixMethod;
	["webkit", "moz", "ms", "o", ""].forEach(function(prefix) {
		if (usablePrefixMethod) return;
		if (prefix === "") {
			// 无前缀，方法首字母小写
			method = method.slice(0,1).toLowerCase() + method.slice(1);
		}
		var typePrefixMethod = typeof element[prefix + method];
		if (typePrefixMethod + "" !== "undefined") {
			if (typePrefixMethod === "function") {
				usablePrefixMethod = element[prefix + method]();
			} else {
				usablePrefixMethod = element[prefix + method];
			}
		}
	}
);

return usablePrefixMethod;
};
/*
runPrefixMethod(this, "RequestFullScreen");
if (typeof window.screenX === "number") {
var eleFull = canvas;
eleFull.addEventListener("click", function() {
	if (runPrefixMethod(document, "FullScreen") || runPrefixMethod(document, "IsFullScreen")) {
		runPrefixMethod(document, "CancelFullScreen");
		this.title = this.title.replace("退出", "");
	} else if (runPrefixMethod(this, "RequestFullScreen")) {
		this.title = this.title.replace("点击", "点击退出");
	}
});
} else {
alert("浏览器不支持");
}*/
