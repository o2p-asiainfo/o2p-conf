/**
 * 前台工具类
 * 
 * @class CommonUtils
 * @static
 * @modefiy zhuangyq 增加获取当前年月日的方法getNow()
 */
CommonUtils = {
	/**
	 * 注册命名空间
	 * 
	 * @example
	 * CommonUtils.regNamespace("cust");
	 * CommonUtils.regNamespace("cust","order.custOrder");
	 * @return 名称空间对象
	 */
	regNamespace : function() {
		var args = arguments, o = null, nameSpaces;
		for (var i = 0; i < args.length; i = i + 1) {
			nameSpaces = args[i].split(".");
			o = window;
			for (var j = 0; j < nameSpaces.length; j = j + 1) {
				o[nameSpaces[j]] = o[nameSpaces[j]] || {};
				o = o[nameSpaces[j]];
			}
		}
		return o;
	},
	/**
	 * 生成一个空function
	 * 
	 * @function
	 * @example
	 * var itemPorxy = {
	 *	id : '',
	 *	type : 'grp',
	 *	callback : <b>CommonUtils.emptyFunc</b>,
	 *	data : null
	 *}
	 */
	emptyFunc : function() {
	},
	/**
	 * 判断一个对象是否是{}这样的空对象,忽略加在Object.prototype上的方法、属性
	 * 
	 * @function
	 * @example
	 * @param {object}
	 *            obj
	 * @return {boolean}
	 */
	isEmptyObj : function(obj) {
		return this.objKeys(obj).length == this.objKeys({}).length;
	},
	/**
	 * 返回一个对象的所有属性
	 * 
	 * @function
	 * @param {object}
	 *            obj
	 * @return {array}
	 */
	objKeys : function(obj) {
		var keys = [];
		for (var property in obj)
			keys.push(property);
		return keys;
	},
	/**
	 * @description json 比较分析,递归实现
	 * @function json对象比较
	 * @requires jquery js库文件;Array.prototype.compareTo(array)方法
	 * @author JiPing
	 * @param {object}
	 *            j1 旧的对象
	 * @param {object}
	 *            j2 新的对象
	 * @param {string}
	 *            antePath 从根结点到父节点的路径
	 * @param {array}
	 *            diffResults 比较结果数组,外部调用的时候可以不填,主要是函数内部递归调用时使用
	 * @param {object}
	 *            diffConfig arraykey:arrayItemId 如 busiOrder:"busiOrderInfo.boId"
	 * @return {array} diffResults 形如: [".pas.t[0].t3name[update]",".pas.t[1][new]",".pas.t[2].name[update]"]
	 *         @example
	 * 
	 * <pre>
	 * var obj1 = {
	 * 	name : &quot;linzp&quot;,
	 * 	pas : {
	 * 		pasName : 'tt',
	 * 		paspas : 'pj',
	 * 		t : [{
	 * 					tid : 1,
	 * 					t3name : 'rr',
	 * 					t3pas : 'rree'
	 * 				}, {
	 * 					tid : 2,
	 * 					name : 'sss1',
	 * 					pas : 'asa'
	 * 				}]
	 * 	}
	 * };
	 * var obj2 = {
	 * 	name : &quot;linzp&quot;,
	 * 	pas : {
	 * 		pasName : 'tt',
	 * 		t : [{
	 * 					tid : 1,
	 * 					t3name : 'rrff',
	 * 					t3pas : 'rree'
	 * 				}, {
	 * 					tid : 3,
	 * 					name : 'sss2',
	 * 					pas : 'asa'
	 * 				}, {
	 * 					tid : 2,
	 * 					name : 'sss',
	 * 					pas : 'bsb'
	 * 				}]
	 * 	}
	 * };
	 * var arrIds = {
	 * 	t : 'tid'
	 * };
	 * console.debug(jsonDataHandler.diff(obj1, obj2, '', [], arrIds));
	 * //[&quot;.pas.t[0].t3name[update]&quot;, &quot;.pas.t[1][new]&quot;, &quot;.pas.t[2].name[update]&quot;, &quot;.pas.t[2].pas[update]&quot;, &quot;.pas.t[update]&quot;, &quot;.pas.paspas[delete]&quot;]
	 * </pre>
	 */
	jsonDiff : function(j1, j2, antePath, diffResults, diffArrIds) {
		if (typeof this.diffing === "undefined" || this.diffing === 0) {
			this.diffCyclicCheck = [];
			this.diffing = 0;
		}
		var diffRes = {};
		antePath = antePath || "";
		diffResults = diffResults || [];
		this.diffing += 1;
		if (typeof j1 === "undefined") {
			j1 = {};
		}
		if (typeof j2 === "undefined") {
			j2 = {};
		}
		if (typeof this.diffCyclicCheck === "undefined") {
			this.diffCyclicCheck = [];
		}
		var key, bDiff;
		for (key in j2)
			if (j2.hasOwnProperty(key)) {
				bDiff = false;
				if (typeof j1[key] === "undefined" || typeof j1[key] != typeof j2[key]) {
					diffResults.push(antePath + "." + key + "[new]");
					bDiff = true;
				} else if (j1[key] !== j2[key]) {
					if (typeof j2[key] === "object") {
						if (this.diffCyclicCheck.indexOf(j2[key]) >= 0) {
							break;
						} else if ($.isArray(j2[key])) {
							// 数组对象的简单比较

							if (j1[key].length !== j2[key].length || j1[key] !== j2[key]) {
								if (j2[key].compareTo(j1[key]) === false) {
									bDiff = true;
								}
							}
							var self = this;
							$.each(j2[key], function(i, n) {
								// 在j1[key]里面找n,也就是j2[key][i]
								var nFound = false;
								$.each(j1[key], function(ii, nn) {
									// 根据ID来找
									if (eval("nn." + diffArrIds[key]) == eval("n." + diffArrIds[key])) {
										nFound = true;
										self.jsonDiff(n, nn, antePath + "." + key + "[" + i + "]", diffResults,
											diffArrIds);
										return false;// 结束each循环
									}
								})
								if (!nFound) {
									diffResults.push(antePath + "." + key + "[" + i + "][new]");
								}
							});
						} else if (typeof j1[key] === "object") {
							this.jsonDiff(j1[key], j2[key], antePath + "." + key, diffResults, diffArrIds);
						} else {
							bDiff = true;
						}
						this.diffCyclicCheck.push(j2[key]);
					} else if (j1[key] !== j2[key]) {
						bDiff = true;
					}
				}
				if (bDiff) {
					diffRes[key] = j2[key];
					diffResults.push(antePath + "." + key + "[update]");
				}
			}
		for (key in j1)
			if (j1.hasOwnProperty(key)) {
				bDiff = false;
				if (typeof j2[key] === "undefined") {
					diffRes[key] = j1[key];
					diffResults.push(antePath + "." + key + "[delete]");
				}
			}
		this.diffing -= 1;
		return diffResults;
	},
	/**
	 * @description 首字母大写
	 * @param {string}
	 *            str
	 * @return {string} 单词str的首字母大写
	 */
	upperCapital : function(str) {
		if (!str) {
			return null;
		}
		if (typeof(str) != "string") {
			return str;
		}
		return str.substring(0, 1).toUpperCase() + str.substring(1);
	},
	/**
	 * @description 删除数组中某个元素
	 * @param {array}
	 *            array 待处理的数组
	 * @param {int}
	 *            index 待删除的元素在数组中的索引
	 * @return {array} 处理后的数组
	 */
	removeArrItemAt : function(array, index) {
		delete array[index];
		for (var i = index + 1; i < array.length; i++) {
			array[i - 1] = array[i];
		}
		array.length -= 1;
		return array;
	},
	/**
	 * @description 对象拷贝,用来拷贝json对象
	 * @param {}
	 *            srcObj
	 */
	objClone : function(srcObj) {
		var buf;
		if (srcObj instanceof Array) {
			buf = [];
			var i = srcObj.length;
			while (i--) {
				buf[i] = this.objClone(srcObj[i]);
			}
			return buf;
		} else if (srcObj instanceof Object) {
			buf = {};
			for (var k in srcObj) {
				buf[k] = this.objClone(srcObj[k]);
			}
			return buf;
		} else {
			return srcObj;
		}
	},
	/**
	 * @description 左补齐
	 * @param {string}
	 *            str 要操作的字符串
	 * @param {int}
	 *            padLen 补齐长度
	 * @param {String}
	 *            padChar 填充字符
	 */
	lpad : function(str, padLen, padChar) {
		if (str == null || str == undefined) {
			return str;
		}
		if (str.toString().length < padLen) {
			for (var i = 0; i < padLen - str.toString().length; i++) {
				str += padChar + str;
			}
		}
		return str;
	},
	/**
	 * @description 获取当前年月日
	 * @function getNow
	 * @return 当前年月日，如：20090101
	 */
	getNow : function() {
		var today = new Date();
		//年
		var strYear = today.getYear();
		//月
		if ((today.getMonth() + 1) < 10) {
			var strMonth = "0" + (today.getMonth() + 1);
		} else {
			var strMonth = today.getMonth() + 1;
		}
		//日
		if (today.getDate() < 10) {
			var strDay = "0" + today.getDate();
		} else {
			var strDay = today.getDate();
		}
		return (strYear.toString() + strMonth.toString() + strDay.toString());
	},
	
	copyClip : function(copy) {
		if (window.clipboardData) {
			window.clipboardData.setData("Text", copy);
		} else if (window.netscape) {
			try{
				netscape.security.PrivilegeManager.enablePrivilege('UniversalXPConnect');
			}catch(e){
				alert("被浏览器拒绝！\n请在浏览器地址栏输入'about:config'并回车\n然后将'signed.applets.codebase_principal_support'设置为'true'");
			}
			var clip = Components.classes['@mozilla.org/widget/clipboard;1']
					.createInstance(Components.interfaces.nsIClipboard);
			if (!clip)
				return;
			var trans = Components.classes['@mozilla.org/widget/transferable;1']
					.createInstance(Components.interfaces.nsITransferable);
			if (!trans)
				return;
			trans.addDataFlavor('text/unicode');
			var str = new Object();
			var len = new Object();
			var str = Components.classes["@mozilla.org/supports-string;1"]
					.createInstance(Components.interfaces.nsISupportsString);
			var copytext = copy;
			str.data = copytext;
			trans.setTransferData("text/unicode", str, copytext.length * 2);
			var clipid = Components.interfaces.nsIClipboard;
			if (!clip)
				return false;
			clip.setData(trans, null, clipid.kGlobalClipboard);
		}
		return false;
	},
	/**
	 * add 20101101
	 * @return {}
	 */
	getClipboardText : function() {
		if (window.clipboardData) {
			return (window.clipboardData.getData('text'));
		} else {
			if (window.netscape) {
				try {
					netscape.security.PrivilegeManager
							.enablePrivilege("UniversalXPConnect");
					var clip = Components.classes["@mozilla.org/widget/clipboard;1"]
							.createInstance(Components.interfaces.nsIClipboard);
					if (!clip) {
						return;
					}
					var trans = Components.classes["@mozilla.org/widget/transferable;1"]
							.createInstance(Components.interfaces.nsITransferable);
					if (!trans) {
						return;
					}
					trans.addDataFlavor("text/unicode");
					clip.getData(trans, clip.kGlobalClipboard);
					var str = new Object();
					var len = new Object();
					trans.getTransferData("text/unicode", str, len);
				} catch (e) {
					alert("您的firefox安全限制限制您进行剪贴板操作，请打开'about:config'将signed.applets.codebase_principal_support'设置为true'之后重试，相对路径为firefox根目录/greprefs/all.js");
					return null;
				}
				if (str) {
					if (Components.interfaces.nsISupportsWString) {
						str = str.value
								.QueryInterface(Components.interfaces.nsISupportsWString);
					} else {
						if (Components.interfaces.nsISupportsString) {
							str = str.value
									.QueryInterface(Components.interfaces.nsISupportsString);
						} else {
							str = null;
						}
					}
				}
				if (str) {
					return (str.data.substring(0, len.value / 2));
				}
			}
		}
		return null;
	}
}

jQuery.extend({
	/**
	 * <b>挂在jQuery下</b>,同步加载脚本<br>
	 * 通过设置jquery,ajax 同步异步开关实现<br>
	 * 加载前设置为同步,加载完后立即设为异步<br>
	 * 脚本加载完后不执行回调函数.<br>
	 * 注意加载的脚本如果有window.onload或者$(function(){ ... })是不会被执行的<br>
	 * jquery的load方法是异步的,可以执行回调.<br>
	 * 
	 * @function
	 * @author 翁舒嵘
	 *         @example
	 *         $.getScriptSync("pub-js/third-lib/js-common-lib/jquery/jquery.easing.js");
	 * @param {string}
	 *            url url 是这个脚本所在jsp/html/..页面的相对路径
	 */
	getScriptSync : function(url) {
		jQuery.ajaxSetup({
			async : false
		});
		jQuery.getScript(url);
		jQuery.ajaxSetup({
			async : true
		});

	}
});

Array.prototype.compareTo = function(compareAry) {
	if (this.length === compareAry.length) {
		var i;
		for (i = 0; i < compareAry.length; i += 1) {
			if ($.isArray(this[i]) === true) {
				if (this[i].compareTo(compareAry[i]) === false) {
					return false;
				}
				continue;
			} else if (this[i] !== compareAry[i]) {
				return false;
			}
		}
		return true;
	}
	return false;
};

/**
 * 判断Array中是否已经包含某个值
 * 
 * @param {String}
 *            element
 */
Array.prototype.contains = function(element) {
	for (var i = 0; i < this.length; i++) {
		if (this[i] == element) {
			return true;
		}
	}
	return false;
}

/**
 * @description 摭罩父层
 * @param curDivId
 *            弹出div的ID parentDivId 父div的Id
 */
function coverParent(curDivId, parentDivId, inputHeight, color, opacity) {
	if (color == undefined) {
		color = 'black';
	}
	if (opacity == undefined) {
		opacity = 0.5;
	}
	var curDiv = $('#' + curDivId);
	var parentDiv;
	if (parentDivId != undefined) {
		if(parentDivId =="body"){
			parentDiv=$('body');
		}else{
			parentDiv = $('#' + parentDivId);
		}
	} else {
		parentDiv = curDiv.parent();
	}
	
	
	
	var position = parentDiv.position();
	var width = parentDiv.width();
	var height = parentDiv.height();
	if(parentDivId =="body"){
		width = document.body.clientWidth;
		height = document.body.clientHeight;
	}
	if(height < document.body.clientHeight){
		height = document.body.clientHeight;
	}
	if (parentDiv.find('#' + curDivId).is("div")) {
		position.left = 0;
		position.top = 0;
	}
	
	var coverDivId = "divCover_" + curDivId;
	var url = window.location.href;
	var args = url.split("/");
	var hostUrl = args[0] + "//"+args[2]+"/"+args[3];
	var coverDiv = $('#' + coverDivId);
	if (!coverDiv.is("div")) {
		coverDiv = $('<div id="' + coverDivId
				+ '"></div>');
		if($.browser.msie&&$.browser.version=="6.0"){
//			coverDiv.append('<iframe class="ifrmNone" src="./common/transparent.html" frameborder="0"></iframe>');
			coverDiv.append('<iframe class="ifrmNone" src="' + hostUrl + '/common/transparent.html" frameborder="0"></iframe>');
		}
//		coverDiv.append('<img src="/BizHall/resources/images/ajaxLoader.gif" style="width:80px;height:71px;position:absolute;top:'+eval(height/2-35)+'px;left:'+eval(width/2-40)+'px" />');
		coverDiv.append('<img src="' + hostUrl + '/resources/images/ajaxLoader.gif" style="width:80px;height:71px;position:absolute;top:'+eval(height/2-35)+'px;left:'+eval(width/2-40)+'px" />');

		coverDiv.appendTo(parentDiv);
		coverDiv.attr('isCover', 'true');
		coverDiv.attr('curDivId', curDivId);
		
		if (parentDivId != undefined) {
			coverDiv.attr('parentDivId',parentDivId);
		}else{
			coverDiv.attr('parentDivId', parentDiv.attr('id'));
		}
		coverDiv.attr('inputHeight', inputHeight);
		coverDiv.attr('color', color);
		coverDiv.attr('opacity', opacity);
	} else {
		coverDiv.show();
	}
	//
    var tPostion = position || getCenterPostitionWithDocument();
	coverDiv.css("left", tPostion.left);
	coverDiv.css("top", tPostion.top);
	coverDiv.css("width", width);
	coverDiv.css("height", height);
	coverDiv.css("position", "absolute");
	coverDiv.css("z-index", curDiv.css('z-index') - 1);
	//TODO	if(coverDiv.find('.ifrmNone').contents()!=undefined){
	//		coverDiv.find('.ifrmNone').contents().find('body').css("background-color", color);
	//	}
	coverDiv.css("background-color", color);
	coverDiv.css("opacity", opacity);
	curDiv.css("left", tPostion.left + (width - curDiv.width()) * 0.5 -8);
	curDiv.css("top", (inputHeight != undefined) ? (tPostion.top + inputHeight) : (tPostion.top + (height - curDiv
				.height())
				* 0.5-8));
	curDiv.css("position", "absolute");

}
/**
 * @description 移除所有的摭罩层
 * @param {}
 *            curDivId
 */
function removeAllCovers() {
	var coverDiv = $('div[isCover="true"]');
	coverDiv.hide();
}
/**
 * @description 去掉摭罩层
 * @param curDivId
 *            弹出div的ID
 */
function removeCover(curDivId) {
	var coverDivId = "divCover_" + curDivId;
	var coverDiv = $('#' + coverDivId);
	if (coverDiv.is("div")) {
		coverDiv.hide();
	}
}
/**
 * 刷新摭罩层
 */
function refreshCover() {
	var coverDiv = $('div[isCover="true"]');
	$.each(coverDiv, function(i, tmpDiv) {
		tmpDiv = $(tmpDiv);
		if (tmpDiv.css('display') != 'none') {
			var curDivId = tmpDiv.attr('curDivId');
			var parentDivId = tmpDiv.attr('parentDivId');
			var inputHeight = tmpDiv.attr('inputHeight');
			var color = tmpDiv.attr('color');
			var opacity = tmpDiv.attr('opacity');
			coverParent(curDivId, parentDivId, inputHeight, color, opacity);
		}
	});
}
/**
 * 从数组中移除元素
 * 
 * @param array
 * @param attachId
 * @return
 */
function RemoveArray(array, attachId) {
	for (var i = 0, n = 0; i < array.length; i++) {
		if (array[i] != attachId) {
			array[n++] = array[i]
		}
	}
	array.length -= 1;
}
Array.prototype.remove = function(obj) {
	return RemoveArray(this, obj);
};

// firefox对dom解析的支持 start add by hanl
try {
	XMLDocument.prototype.selectNodes = function(cXPathString, xNode) {
		if (!xNode) {
			xNode = this;
		}
		var oNSResolver = this.createNSResolver(this.documentElement)
		var aItems = this.evaluate(cXPathString, xNode, oNSResolver, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null)
		var aResult = [];
		for (var i = 0; i < aItems.snapshotLength; i++) {
			aResult[i] = aItems.snapshotItem(i);
		}
		return aResult;
	}

	XMLDocument.prototype.selectSingleNode = function(cXPathString, xNode) {
		if (!xNode) {
			xNode = this;
		}
		var xItems = this.selectNodes(cXPathString, xNode);
		if (xItems.length > 0) {
			return xItems[0];
		} else {
			return null;
		}
	}

	Element.prototype.selectSingleNode = function(cXPathString) {
		if (this.ownerDocument.selectSingleNode) {
			return this.ownerDocument.selectSingleNode(cXPathString, this);
		} else {
			throw "For XML Elements Only";
		}
	}

	Element.prototype.selectNodes = function(cXPathString) {
		if (this.ownerDocument.selectNodes) {
			return this.ownerDocument.selectNodes(cXPathString, this);
		} else {
			throw "For XML Elements Only";
		}
	}

	Element.prototype.__defineGetter__("text", function() {
		return this.textContent;
	})

	Element.prototype.__defineSetter__("text", function(sText) {
		this.textContent = sText;
	})
} catch (e) {

}

function f_createDom() {
	var dom = null;
	try {
		dom = new ActiveXObject('Msxml2.DOMDocument.3.0');
	} catch (x) {
	}
	try {
		dom = new ActiveXObject('Microsoft.XMLDOM');
	} catch (x) {
	}
	// firefox
	try {
		dom = document.implementation.createDocument("", "", null);
	} catch (x) {
	}
	if (dom == null) {
		alert('获取DOM失败');
		return null;
	}
	dom.setProperty("SelectionLanguage", "XPath");
	return dom;
}
// firefox对dom解析的支持 end add by hanl

function Map() {
	/** 存放键的数组(遍历用到) */
	this.keys = new Array();
	/** 存放数据 */
	this.data = new Object();

	/**
	 * 放入一个键值对
	 * 
	 * @param {String}
	 *            key
	 * @param {Object}
	 *            value
	 */
	this.put = function(key, value) {
		if (this.data[key] == null) {
			this.keys.push(key);
		}
		this.data[key] = value;
	};

	/**
	 * 获取某键对应的值
	 * 
	 * @param {String}
	 *            key
	 * @return {Object} value
	 */
	this.get = function(key) {
		return this.data[key];
	};

	/**
	 * 删除一个键值对
	 * 
	 * @param {String}
	 *            key
	 */
	this.remove = function(key) {
		this.keys.remove(key);
		this.data[key] = null;
	};

	/**
	 * 遍历Map,执行处理函数
	 * 
	 * @param {Function}
	 *            回调函数 function(key,value,index){..}
	 */
	this.each = function(fn) {
		if (typeof fn != 'function') {
			return;
		}
		var len = this.keys.length;
		for (var i = 0; i < len; i++) {
			var k = this.keys[i];
			fn(k, this.data[k], i);
		}
	};

	/**
	 * 获取键值数组(类似Java的entrySet())
	 * 
	 * @return 键值对象{key,value}的数组
	 */
	this.entrys = function() {
		var len = this.keys.length;
		var entrys = new Array(len);
		for (var i = 0; i < len; i++) {
			entrys[i] = {
				key : this.keys[i],
				value : this.data[i]
			};
		}
		return entrys;
	};

	/**
	 * 判断Map是否为空
	 */
	this.isEmpty = function() {
		return this.keys.length == 0;
	};

	/**
	 * 获取键值对数量
	 */
	this.size = function() {
		return this.keys.length;
	};

	/**
	 * 重写toString
	 */
	this.toString = function() {
		var s = "{";
		for (var i = 0; i < this.keys.length; i++, s += ',') {
			var k = this.keys[i];
			s += k + "=" + this.data[k];
		}
		s += "}";
		return s;
	};
}
/**
 * 删除左右两端的空格 包括全角空格
 */
String.prototype.trim = function() {
	return this.replace(/(^[\s|'　']*)|([\s|'　']*$)/g, '');
}
/**
 * @description 判断是否是数字
 */
function isInteger(num) {
	var patrn = /^[0-9]*[1-9][0-9]*$/;

	if (!patrn.exec(num))
		return false
	else
		return true
}
/**
 * 校验身份证号 Id 的数值,如果校验成功，则返回"" ,否则返回错误信息
 * 
 * @author 李金华
 */
var validatePID = function(idNumber) {
	var idHelp = new personalIDHelper(idNumber);
	return idHelp.errors;
}
/**
 * 关于身份证号 Id的帮助类构造函数
 * 
 * @author 李金华
 * @param idNumber
 *            String 身份证号码
 */
var personalIDHelper = function(idNumber) {
	var areaArray = {
		11 : "北京",
		12 : "天津",
		13 : "河北",
		14 : "山西",
		15 : "内蒙古",
		21 : "辽宁",
		22 : "吉林",
		23 : "黑龙江",
		31 : "上海",
		32 : "江苏",
		33 : "浙江",
		34 : "安徽",
		35 : "福建",
		36 : "江西",
		37 : "山东",
		41 : "河南",
		42 : "湖北",
		43 : "湖南",
		44 : "广东",
		45 : "广西",
		46 : "海南",
		50 : "重庆",
		51 : "四川",
		52 : "贵州",
		53 : "云南",
		54 : "西藏",
		61 : "陕西",
		62 : "甘肃",
		63 : "青海",
		64 : "宁夏",
		65 : "新疆",
		71 : "台湾",
		81 : "香港",
		82 : "澳门",
		91 : "国外"
	};
	this.len = idNumber == null ? 0 : idNumber.length;
	this.baseIdNumber = idNumber;
	this.errors = "";
	var PLIST = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

	var ereg = /^\d{15}(\d{2}[\dXx])?$/;
	if (!ereg.test(idNumber)) {
		this.errors = "身份证号码格式不对,请客户修改。";
	} else {
		this.area = idNumber.substring(0, 6);
		this.birthNum = this.len == 15 ? ("19" + idNumber.substring(6, 12)) : idNumber.substring(6, 14);
		this.seqNum = this.len == 15 ? idNumber.substring(12, 15) : idNumber.substring(14, 17);
		this.checkDigit = this.len == 15 ? " " : idNumber.charAt(17).toUpperCase();
		if (areaArray[parseInt(this.area.substr(0, 2))] == null) {
			this.errors = "身份证地区非法,请客户修改。";
		} else if (this.len == 18 && getCheckDigit18(idNumber) != this.checkDigit) {
			this.errors = "身份证号码校验错误,请客户修改。";
		} else {
			this.errors = validateDate8(this.birthNum);
		}
	}
}
/**
 * 校验日期格式的数值,如果校验成功，则返回"" ,否则返回错误信息
 * 
 * @author 李金华
 */
var validateDate8 = function(date8Num) {
	var PLIST = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	if (!date8Num || date8Num.length < 8)
		return personalIDHelper.errors = "无效的日期格式,请客户修改。";
	var iyear = parseInt(date8Num.substring(0, 4), 10);
	var iMonth = parseInt(date8Num.substring(4, 6), 10);
	var iDate = parseInt(date8Num.substring(6, 8), 10);
	if (iyear < 1800) {
		return "年份数必须大于1800 ,请客户修改。";
	} else if (iMonth < 1 || iMonth > 12) {
		return "月份必须在01到12之间,请客户修改。";
	} else {
		var p = PLIST[iMonth - 1];
		// 闰年二月
		if (iMonth == 2 && (iyear % 400 == 0 || (iyear % 4 == 0 && iyear % 100 != 0))) {
			p = 29;
		}
		if (iDate < 1 || iDate > p)
			return "日数必须在1到" + p + "之间，请客户修改。";
	}
	return "";
}

/**
 * 从18位/17位身份证号算出校验位
 * 
 * @param idCardNO
 * @return string
 */
var getCheckDigit18 = function(idCardNO) {
	// 权重值
	var VERIFY18RIGHTS = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1);
	var VERIFY18_CHECKDIGIT = "10X98765432";
	var sum = 0;
	for (var i = 0; i <= 16; i++) {
		sum += parseInt(idCardNO.charAt(i)) * VERIFY18RIGHTS[i];
	}
	// 对权重值取模
	return VERIFY18_CHECKDIGIT.charAt(sum % 11);
}
/**
 * 取得窗口高度
 * @return
 */
function getTotalHeight() {
	if ($.browser.msie) {
		return document.compatMode == "CSS1Compat" ? document.documentElement.clientHeight : document.body.clientHeight;
	} else {
		return self.innerHeight;
	}
}
/**
 * 取得窗口宽度
 * @return
 */
function getTotalWidth() {
	if ($.browser.msie) {
		return document.compatMode == "CSS1Compat" ? document.documentElement.clientWidth : document.body.clientWidth;
	} else {
		return self.innerWidth;
	}
}
/**
 * 取得窗口居中时的top跟left
 * @param width 窗口宽度
 * @param height 窗口高度
 * @return {top,left}
 */
var getCenterPostition = function(width,height){
	var screenWidth = window.screen.availWidth;
	var screenHeight = window.screen.availHeight;
	return {
		top:(screenHeight-height-95)/2, //95是窗口的标题栏，地址栏，状态栏的高度之和
		left:(screenWidth-width)/2
	}
}
var getCenterPostitionWithDocument = function(){
	return {
		top:(window.screen.availHeight-700)/2, //95是窗口的标题栏，地址栏，状态栏的高度之和
		left: window.screen.availWidth/2
	}
}
/**
 * 定时Div滚动函数
 * @author 李金华
 * @param {} id divId
 * @param {} opt 滚动的时间设置
 * @param {} callback 回调函数
 */
function divScrollTimer(id,opt,callback){
//	alert('divScrollTimer');
    var  divId = $('#'+id);
        //参数初始化
        if(!opt) var opt={};
        var _this=divId.eq(0).find("ul:first");
        var  lineH=_this.find("li:first").height(); //获取行高
        var line=opt.line?parseInt(opt.line,10):parseInt(divId.height()/lineH,10);//每次滚动的行数，默认为一屏，即父容器高度
        var speed=opt.speed?parseInt(opt.speed,10):500; //卷动速度，数值越大，速度越慢（毫秒）
        var timer=opt.timer?parseInt(opt.timer,10):300000; //滚动的时间间隔（毫秒）
        if(line==0) line=1;
        var upHeight=0-line*lineH;
        //滚动函数
        scrollUp=function(){
                _this.animate({
                        marginTop:upHeight
                },speed,function(){
                        for(i=1;i<=line;i++){
                                _this.find("li:first").appendTo(_this);
                        }
                        _this.css({marginTop:0});
                });
        }
        //鼠标事件绑定
        _this.hover(function(){
                clearInterval(timerID);
        },function(){
                timerID=setInterval("scrollUp()",timer);
        }).mouseout();
}

/*
 * 把null或undefined值转换成空字符串
 */
function nullToStr(str) {
	if(str == undefined || str == null) {
		return "";
	}
	else {
		return str;
	}
}
//信息隐藏开关
var CONST_INFO_HIDDEN_IS_OPEN = 'Y';
//信息隐藏方式如身份证、军官证等证件需隐藏。根据证件类型来配置隐藏方式，证件类型和隐藏方式以及替代符号用":"隔开
//多种证件类型用不同隐藏方式用","隔开
var CONST_HIDE_METHOD = '-1:-1:*,1:1:*';
/**
 * 获取隐藏处理后的信息
 */
function getInfoAfterHide(infoBeforeHide, typeCd) {
	//判断信息隐藏开关是否打开
	if(CONST_INFO_HIDDEN_IS_OPEN == 'N') {
		return infoBeforeHide;
	}
	if(nullToStr(infoBeforeHide) == "") {
		return "";
	}
	var replaceText = "*";
	var hideMethod = "-1";
	var isFound = false;
	hideMethodArr = CONST_HIDE_METHOD.split(",");
	//根据类型获取隐藏方式和替代符号
	for(var i = 0; i < hideMethodArr.length; i++) {
		tempHideMethod = hideMethodArr[i].split(":");
		if(typeCd == tempHideMethod[0]) {
			isFound = true;
			hideMethod =  tempHideMethod[1];
			if(tempHideMethod[2] != undefined) {
				replaceText = tempHideMethod[2];
			}
			break;
		}
	}	
	//如果没找到该证件类型的隐藏方式则采用默认隐藏方式处理
	if(!isFound) {
		for(var i = 0; i < hideMethodArr.length; i++) {
			tempHideMethod = hideMethodArr[i].split(":");
			if("-1" == tempHideMethod[0]) {
				hideMethod =  tempHideMethod[1];
				if(tempHideMethod[2] != undefined) {
					replaceText = tempHideMethod[2];
				}
				break;
			}
		}	
	}
	return dealInfoOfNeedHide(infoBeforeHide, hideMethod, replaceText);
}

/**
 * 隐藏处理，目前隐藏方式有如下4种：
 * "1" : 显示前6位，后面全部用"*"替代显示如身份证350124************
 * "2" : 显示前6位和末尾4位，其它用"*"替代显示如身份证350124*******5465
 * "3" : 显示末尾4位其它用用"*"替代显示如身份证*************5465
 * "-1" : 默认全部用*号替代显示如身份证****************
 */
function dealInfoOfNeedHide(infoBeforeHide, hideMethod, replaceText) {
	var rqExp = /./g;
	var tempStrArr = [];
	if(hideMethod == '1' && infoBeforeHide.length > 6) {   
	   tempStrArr[0] = infoBeforeHide.substr(0, 6);
	   tempStrArr[1] = infoBeforeHide.substr(6, infoBeforeHide.length - 6).replace(rqExp, replaceText);
	   return tempStrArr.join("");	   
	}
	else if(hideMethod == '2' && infoBeforeHide.length > 10) {
	   tempStrArr[0] = infoBeforeHide.substr(0, 6);
	   tempStrArr[1] = infoBeforeHide.substr(6, infoBeforeHide.length - 10).replace(rqExp, replaceText);
	   tempStrArr[2] = infoBeforeHide.substr(infoBeforeHide.length - 4, 4);
	   return tempStrArr.join("");	
	}
	else if(hideMethod == '3' && infoBeforeHide.length > 4){
	   tempStrArr[0] = infoBeforeHide.substr(0, infoBeforeHide.length - 4).replace(rqExp, replaceText);
	   tempStrArr[1] = infoBeforeHide.substr(infoBeforeHide.length - 4, 4);
	   return tempStrArr.join("");	
	}
	else {
		return infoBeforeHide.replace(rqExp, replaceText);
	}
}

/**
 * 获取字符串的长度
 * @param {} str
 * @return {}
 */
function getStringLength(str){
	return  str.replace(/[^\x00-\xff]/g,"xx").length;
}
/**
 * 方便正则表达式匹配，对输入字符是正则特殊字符的转义
 * 遍历如果是特殊，就加上\
 * @param {} str
 * @author  李金华
 */
function trimSpecialChar(str){
	var specilCharArray =['.','$','^','{','[','(', '|',')', '*','+','?','\\'];
	var retnStr = "";
	for(var i = 0 ; i < str.length ;i++){
		var charStr =str.charAt(i);
		if(isExistInArr(charStr,specilCharArray)){
			retnStr += ('\\'+ charStr);
		}else{
			retnStr += charStr ;
		}
	}
	return retnStr;
}
/**
 * 是否存在数组中
 * @param {} obj
 * @param {} arr
 * @return {Boolean}
 *  @author  李金华
 */
function isExistInArr( obj ,arr ){
	for(var i = 0 ; i < arr.length ; i++ ){
		if(arr[i] == obj ){
			return true;
		}
	}
	return false;	
}
