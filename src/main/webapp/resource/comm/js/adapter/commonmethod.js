/**
 * 此js代码提供公共的一些方法
 * @return
 */
/*function $(obj){
	return document.getElementById(obj);
}
*/

//获取系统时间
function getSystemTimeString(){
	var now= new Date();
	var year=now.getYear();
	var month=now.getMonth()+1;
	var day=now.getDate();
	var hour=now.getHours();
	var minute=now.getMinutes();
	var second=now.getSeconds();
	var timeString=""+year+month+day+hour+":"+minute+":"+second;
	return timeString;
}

//写入曰志调试时用
function writeTxt(array)
{ 
    var length=array.length;	
    var fso, tf; 
    fso = new ActiveXObject("Scripting.FileSystemObject");  
    if(fso.FileExists("C:/javascriptLogFileNew.txt") == 0) {
    	fso.CreateFolder("C:/javascriptLogFileNew.txt"); 
    }
    	 
    tf = fso.OpenTextFile("C:/javascriptLogFileNew.txt",8,true); 
    var systemTime=getSystemTimeString();
	for (var i=0;i<=length-1;i++) 
	{ 
		tf.WriteLine("["+systemTime+"]"+"array "+i+"="+array[i]) ;
	}
	tf.WriteLine("-----------------------------------------------");
    tf.Close(); 
}

//js获取项目根路径，如： http://localhost:8083/uimcardprj
function getRootPath(){
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath=window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName=window.document.location.pathname;
    var pos=curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPaht=curWwwPath.substring(0,pos);
    //获取带"/"的项目名，如：/uimcardprj
    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
    return(localhostPaht+projectName);
}

//去除前后空白
function trim(str){ 
	str = str.replace(/^(\s|\u00A0)+/,''); 
	for(var i=str.length-1; i>=0; i--){ 
		if(/\S/.test(str.charAt(i))){ 
			str = str.substring(0, i+1); 
			break; 
		} 
	} 
	return str; 
}