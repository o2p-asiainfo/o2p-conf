/**
 * 此js存放一些国际化消息
 * @return
 */

var messageInternationalMap = new Map();
//加载国际化信息
function loadJSInternationalMessage(){
	//debugger;
	var messageInternationalDoc;
	var cc="";
	if (!!window.ActiveXObject || "ActiveXObject" in window){
		messageInternationalDoc=new ActiveXObject("Microsoft.XMLDOM");
		//messageInternationalDoc.async=false; 
		messageInternationalDoc.loadXML(ajaxInteractive("/loadJSInternationalMessage.shtml?",null));
		}
	else{
		parser=new DOMParser();
    	messageInternationalDoc=parser.parseFromString(ajaxInteractive("/loadJSInternationalMessage.shtml?",null),"text/xml");
		}
	
	var messageInternationalNodes=messageInternationalDoc.getElementsByTagName("message");
	//服务端返回的字符串有问题，<?xml version='1.0' encoding='UTF-8'?>多了一个
	//服务端返回的字符串有问题，<?xml version='1.0' encoding='UTF-8'?>多了一个
	//服务端返回的字符串有问题，<?xml version='1.0' encoding='UTF-8'?>多了一个
	//服务端返回的字符串有问题，<?xml version='1.0' encoding='UTF-8'?>多了一个
	//服务端返回的字符串有问题，<?xml version='1.0' encoding='UTF-8'?>多了一个
	//服务端返回的字符串有问题，<?xml version='1.0' encoding='UTF-8'?>多了一个
	for (var i=0;i<messageInternationalNodes.length;i++) {
			//alert(messageInternationalNodes.length)
			var messageName = messageInternationalNodes[i].getAttribute("name");
			var messageValue = messageInternationalNodes[i].getAttribute("value");
			messageInternationalMap.put(messageName, messageValue);
			}
}
function getInternationalMessage(key){
	var message = messageInternationalMap.get(key);
	if(message==null)
		message="";
	return message;
}


function Map() {
	/** 存放键的数组(遍历用到) */
	this.keys = new Array();
	/** 存放数据 */
	this.data = new Object();
	
	/**
	 * 放入一个键值对
	 * @param {String} key
	 * @param {Object} value
	 */
	this.put = function(key, value) {
		if(this.data[key] == null){
			this.keys.push(key);
		}
		this.data[key] = value;
	};
	
	/**
	 * 获取某键对应的值
	 * @param {String} key
	 * @return {Object} value
	 */
	this.get = function(key) {
		return this.data[key];
	};
	
	/**
	 * 删除一个键值对
	 * @param {String} key
	 */
	this.remove = function(key) {
		this.keys.remove(key);
		this.data[key] = null;
	};
	
	/**
	 * 遍历Map,执行处理函数
	 * 
	 * @param {Function} 回调函数 function(key,value,index){..}
	 */
	this.each = function(fn){
		if(typeof fn != 'function'){
			return;
		}
		var len = this.keys.length;
		for(var i=0;i<len;i++){
			var k = this.keys[i];
			fn(k,this.data[k],i);
		}
	};
	
	/**
	 * 获取键值数组(类似Java的entrySet())
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
	this.size = function(){
		return this.keys.length;
	};
	
	/**
	 * 重写toString 
	 */
	this.toString = function(){
		var s = "{";
		for(var i=0;i<this.keys.length;i++,s+=','){
			var k = this.keys[i];
			s += k+"="+this.data[k];
		}
		s+="}";
		return s;
	};
}
