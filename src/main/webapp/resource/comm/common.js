/**
 * ǰ̨������
 * 
 * @class CommonUtils
 * @static
 * @modefiy zhuangyq ���ӻ�ȡ��ǰ�����յķ���getNow()
 */
CommonUtils = {
	/**
	 * ע�������ռ�
	 * 
	 * @example
	 * CommonUtils.regNamespace("cust");
	 * CommonUtils.regNamespace("cust","order.custOrder");
	 * @return ���ƿռ����
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
	 * ����һ����function
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
	 * �ж�һ�������Ƿ���{}�����Ŀն���,���Լ���Object.prototype�ϵķ���������
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
	 * ����һ���������������
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
	 * @description json �ȽϷ���,�ݹ�ʵ��
	 * @function json����Ƚ�
	 * @requires jquery js���ļ�;Array.prototype.compareTo(array)����
	 * @author JiPing
	 * @param {object}
	 *            j1 �ɵĶ���
	 * @param {object}
	 *            j2 �µĶ���
	 * @param {string}
	 *            antePath �Ӹ���㵽���ڵ��·��
	 * @param {array}
	 *            diffResults �ȽϽ������,�ⲿ���õ�ʱ����Բ���,��Ҫ�Ǻ����ڲ��ݹ����ʱʹ��
	 * @param {object}
	 *            diffConfig arraykey:arrayItemId �� busiOrder:"busiOrderInfo.boId"
	 * @return {array} diffResults ����: [".pas.t[0].t3name[update]",".pas.t[1][new]",".pas.t[2].name[update]"]
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
							// �������ļ򵥱Ƚ�

							if (j1[key].length !== j2[key].length || j1[key] !== j2[key]) {
								if (j2[key].compareTo(j1[key]) === false) {
									bDiff = true;
								}
							}
							var self = this;
							$.each(j2[key], function(i, n) {
								// ��j1[key]������n,Ҳ����j2[key][i]
								var nFound = false;
								$.each(j1[key], function(ii, nn) {
									// ����ID����
									if (eval("nn." + diffArrIds[key]) == eval("n." + diffArrIds[key])) {
										nFound = true;
										self.jsonDiff(n, nn, antePath + "." + key + "[" + i + "]", diffResults,
											diffArrIds);
										return false;// ����eachѭ��
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
	 * @description ����ĸ��д
	 * @param {string}
	 *            str
	 * @return {string} ����str������ĸ��д
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
	 * @description ɾ��������ĳ��Ԫ��
	 * @param {array}
	 *            array �����������
	 * @param {int}
	 *            index ��ɾ����Ԫ���������е�����
	 * @return {array} ����������
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
	 * @description ���󿽱�,��������json����
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
	 * @description ����
	 * @param {string}
	 *            str Ҫ�������ַ���
	 * @param {int}
	 *            padLen ���볤��
	 * @param {String}
	 *            padChar ����ַ�
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
	 * @description ��ȡ��ǰ������
	 * @function getNow
	 * @return ��ǰ�����գ��磺20090101
	 */
	getNow : function() {
		var today = new Date();
		//��
		var strYear = today.getYear();
		//��
		if ((today.getMonth() + 1) < 10) {
			var strMonth = "0" + (today.getMonth() + 1);
		} else {
			var strMonth = today.getMonth() + 1;
		}
		//��
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
				alert("��������ܾ���\n�����������ַ������'about:config'���س�\nȻ��'signed.applets.codebase_principal_support'����Ϊ'true'");
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
					alert("����firefox��ȫ�������������м�������������'about:config'��signed.applets.codebase_principal_support'����Ϊtrue'֮�����ԣ����·��Ϊfirefox��Ŀ¼/greprefs/all.js");
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
	 * <b>����jQuery��</b>,ͬ�����ؽű�<br>
	 * ͨ������jquery,ajax ͬ���첽����ʵ��<br>
	 * ����ǰ����Ϊͬ��,�������������Ϊ�첽<br>
	 * �ű��������ִ�лص�����.<br>
	 * ע����صĽű������window.onload����$(function(){ ... })�ǲ��ᱻִ�е�<br>
	 * jquery��load�������첽��,����ִ�лص�.<br>
	 * 
	 * @function
	 * @author ������
	 *         @example
	 *         $.getScriptSync("pub-js/third-lib/js-common-lib/jquery/jquery.easing.js");
	 * @param {string}
	 *            url url ������ű�����jsp/html/..ҳ������·��
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
 * �ж�Array���Ƿ��Ѿ�����ĳ��ֵ
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
 * @description ���ָ���
 * @param curDivId
 *            ����div��ID parentDivId ��div��Id
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
 * @description �Ƴ����е����ֲ�
 * @param {}
 *            curDivId
 */
function removeAllCovers() {
	var coverDiv = $('div[isCover="true"]');
	coverDiv.hide();
}
/**
 * @description ȥ�����ֲ�
 * @param curDivId
 *            ����div��ID
 */
function removeCover(curDivId) {
	var coverDivId = "divCover_" + curDivId;
	var coverDiv = $('#' + coverDivId);
	if (coverDiv.is("div")) {
		coverDiv.hide();
	}
}
/**
 * ˢ�����ֲ�
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
 * ���������Ƴ�Ԫ��
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

// firefox��dom������֧�� start add by hanl
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
		alert('��ȡDOMʧ��');
		return null;
	}
	dom.setProperty("SelectionLanguage", "XPath");
	return dom;
}
// firefox��dom������֧�� end add by hanl

function Map() {
	/** ��ż�������(�����õ�) */
	this.keys = new Array();
	/** ������� */
	this.data = new Object();

	/**
	 * ����һ����ֵ��
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
	 * ��ȡĳ����Ӧ��ֵ
	 * 
	 * @param {String}
	 *            key
	 * @return {Object} value
	 */
	this.get = function(key) {
		return this.data[key];
	};

	/**
	 * ɾ��һ����ֵ��
	 * 
	 * @param {String}
	 *            key
	 */
	this.remove = function(key) {
		this.keys.remove(key);
		this.data[key] = null;
	};

	/**
	 * ����Map,ִ�д�����
	 * 
	 * @param {Function}
	 *            �ص����� function(key,value,index){..}
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
	 * ��ȡ��ֵ����(����Java��entrySet())
	 * 
	 * @return ��ֵ����{key,value}������
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
	 * �ж�Map�Ƿ�Ϊ��
	 */
	this.isEmpty = function() {
		return this.keys.length == 0;
	};

	/**
	 * ��ȡ��ֵ������
	 */
	this.size = function() {
		return this.keys.length;
	};

	/**
	 * ��дtoString
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
 * ɾ���������˵Ŀո� ����ȫ�ǿո�
 */
String.prototype.trim = function() {
	return this.replace(/(^[\s|'��']*)|([\s|'��']*$)/g, '');
}
/**
 * @description �ж��Ƿ�������
 */
function isInteger(num) {
	var patrn = /^[0-9]*[1-9][0-9]*$/;

	if (!patrn.exec(num))
		return false
	else
		return true
}
/**
 * У�����֤�� Id ����ֵ,���У��ɹ����򷵻�"" ,���򷵻ش�����Ϣ
 * 
 * @author ���
 */
var validatePID = function(idNumber) {
	var idHelp = new personalIDHelper(idNumber);
	return idHelp.errors;
}
/**
 * �������֤�� Id�İ����๹�캯��
 * 
 * @author ���
 * @param idNumber
 *            String ���֤����
 */
var personalIDHelper = function(idNumber) {
	var areaArray = {
		11 : "����",
		12 : "���",
		13 : "�ӱ�",
		14 : "ɽ��",
		15 : "���ɹ�",
		21 : "����",
		22 : "����",
		23 : "������",
		31 : "�Ϻ�",
		32 : "����",
		33 : "�㽭",
		34 : "����",
		35 : "����",
		36 : "����",
		37 : "ɽ��",
		41 : "����",
		42 : "����",
		43 : "����",
		44 : "�㶫",
		45 : "����",
		46 : "����",
		50 : "����",
		51 : "�Ĵ�",
		52 : "����",
		53 : "����",
		54 : "����",
		61 : "����",
		62 : "����",
		63 : "�ຣ",
		64 : "����",
		65 : "�½�",
		71 : "̨��",
		81 : "���",
		82 : "����",
		91 : "����"
	};
	this.len = idNumber == null ? 0 : idNumber.length;
	this.baseIdNumber = idNumber;
	this.errors = "";
	var PLIST = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

	var ereg = /^\d{15}(\d{2}[\dXx])?$/;
	if (!ereg.test(idNumber)) {
		this.errors = "���֤�����ʽ����,��ͻ��޸ġ�";
	} else {
		this.area = idNumber.substring(0, 6);
		this.birthNum = this.len == 15 ? ("19" + idNumber.substring(6, 12)) : idNumber.substring(6, 14);
		this.seqNum = this.len == 15 ? idNumber.substring(12, 15) : idNumber.substring(14, 17);
		this.checkDigit = this.len == 15 ? " " : idNumber.charAt(17).toUpperCase();
		if (areaArray[parseInt(this.area.substr(0, 2))] == null) {
			this.errors = "���֤�����Ƿ�,��ͻ��޸ġ�";
		} else if (this.len == 18 && getCheckDigit18(idNumber) != this.checkDigit) {
			this.errors = "���֤����У�����,��ͻ��޸ġ�";
		} else {
			this.errors = validateDate8(this.birthNum);
		}
	}
}
/**
 * У�����ڸ�ʽ����ֵ,���У��ɹ����򷵻�"" ,���򷵻ش�����Ϣ
 * 
 * @author ���
 */
var validateDate8 = function(date8Num) {
	var PLIST = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	if (!date8Num || date8Num.length < 8)
		return personalIDHelper.errors = "��Ч�����ڸ�ʽ,��ͻ��޸ġ�";
	var iyear = parseInt(date8Num.substring(0, 4), 10);
	var iMonth = parseInt(date8Num.substring(4, 6), 10);
	var iDate = parseInt(date8Num.substring(6, 8), 10);
	if (iyear < 1800) {
		return "������������1800 ,��ͻ��޸ġ�";
	} else if (iMonth < 1 || iMonth > 12) {
		return "�·ݱ�����01��12֮��,��ͻ��޸ġ�";
	} else {
		var p = PLIST[iMonth - 1];
		// �������
		if (iMonth == 2 && (iyear % 400 == 0 || (iyear % 4 == 0 && iyear % 100 != 0))) {
			p = 29;
		}
		if (iDate < 1 || iDate > p)
			return "����������1��" + p + "֮�䣬��ͻ��޸ġ�";
	}
	return "";
}

/**
 * ��18λ/17λ���֤�����У��λ
 * 
 * @param idCardNO
 * @return string
 */
var getCheckDigit18 = function(idCardNO) {
	// Ȩ��ֵ
	var VERIFY18RIGHTS = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1);
	var VERIFY18_CHECKDIGIT = "10X98765432";
	var sum = 0;
	for (var i = 0; i <= 16; i++) {
		sum += parseInt(idCardNO.charAt(i)) * VERIFY18RIGHTS[i];
	}
	// ��Ȩ��ֵȡģ
	return VERIFY18_CHECKDIGIT.charAt(sum % 11);
}
/**
 * ȡ�ô��ڸ߶�
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
 * ȡ�ô��ڿ��
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
 * ȡ�ô��ھ���ʱ��top��left
 * @param width ���ڿ��
 * @param height ���ڸ߶�
 * @return {top,left}
 */
var getCenterPostition = function(width,height){
	var screenWidth = window.screen.availWidth;
	var screenHeight = window.screen.availHeight;
	return {
		top:(screenHeight-height-95)/2, //95�Ǵ��ڵı���������ַ����״̬���ĸ߶�֮��
		left:(screenWidth-width)/2
	}
}
var getCenterPostitionWithDocument = function(){
	return {
		top:(window.screen.availHeight-700)/2, //95�Ǵ��ڵı���������ַ����״̬���ĸ߶�֮��
		left: window.screen.availWidth/2
	}
}
/**
 * ��ʱDiv��������
 * @author ���
 * @param {} id divId
 * @param {} opt ������ʱ������
 * @param {} callback �ص�����
 */
function divScrollTimer(id,opt,callback){
//	alert('divScrollTimer');
    var  divId = $('#'+id);
        //������ʼ��
        if(!opt) var opt={};
        var _this=divId.eq(0).find("ul:first");
        var  lineH=_this.find("li:first").height(); //��ȡ�и�
        var line=opt.line?parseInt(opt.line,10):parseInt(divId.height()/lineH,10);//ÿ�ι�����������Ĭ��Ϊһ�������������߶�
        var speed=opt.speed?parseInt(opt.speed,10):500; //���ٶȣ���ֵԽ���ٶ�Խ�������룩
        var timer=opt.timer?parseInt(opt.timer,10):300000; //������ʱ���������룩
        if(line==0) line=1;
        var upHeight=0-line*lineH;
        //��������
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
        //����¼���
        _this.hover(function(){
                clearInterval(timerID);
        },function(){
                timerID=setInterval("scrollUp()",timer);
        }).mouseout();
}

/*
 * ��null��undefinedֵת���ɿ��ַ���
 */
function nullToStr(str) {
	if(str == undefined || str == null) {
		return "";
	}
	else {
		return str;
	}
}
//��Ϣ���ؿ���
var CONST_INFO_HIDDEN_IS_OPEN = 'Y';
//��Ϣ���ط�ʽ�����֤������֤��֤�������ء�����֤���������������ط�ʽ��֤�����ͺ����ط�ʽ�Լ����������":"����
//����֤�������ò�ͬ���ط�ʽ��","����
var CONST_HIDE_METHOD = '-1:-1:*,1:1:*';
/**
 * ��ȡ���ش�������Ϣ
 */
function getInfoAfterHide(infoBeforeHide, typeCd) {
	//�ж���Ϣ���ؿ����Ƿ��
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
	//�������ͻ�ȡ���ط�ʽ���������
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
	//���û�ҵ���֤�����͵����ط�ʽ�����Ĭ�����ط�ʽ����
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
 * ���ش���Ŀǰ���ط�ʽ������4�֣�
 * "1" : ��ʾǰ6λ������ȫ����"*"�����ʾ�����֤350124************
 * "2" : ��ʾǰ6λ��ĩβ4λ��������"*"�����ʾ�����֤350124*******5465
 * "3" : ��ʾĩβ4λ��������"*"�����ʾ�����֤*************5465
 * "-1" : Ĭ��ȫ����*�������ʾ�����֤****************
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
 * ��ȡ�ַ����ĳ���
 * @param {} str
 * @return {}
 */
function getStringLength(str){
	return  str.replace(/[^\x00-\xff]/g,"xx").length;
}
/**
 * ����������ʽƥ�䣬�������ַ������������ַ���ת��
 * ������������⣬�ͼ���\
 * @param {} str
 * @author  ���
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
 * �Ƿ����������
 * @param {} obj
 * @param {} arr
 * @return {Boolean}
 *  @author  ���
 */
function isExistInArr( obj ,arr ){
	for(var i = 0 ; i < arr.length ; i++ ){
		if(arr[i] == obj ){
			return true;
		}
	}
	return false;	
}
