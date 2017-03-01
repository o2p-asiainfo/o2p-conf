function loadDocs(addPar){
	$.getJSON(addPar,{random:Math.random()},function(data,status){
		$("#group_one").html("");
		$.each(data.pageParList, function(idx,item){
			var state = item.STATE;
			if(state=='A')
				state = $("#onUse").val();
			else
				state = $("#unUse").val();
			if(idx%2==0){
				$("#group_one").append("<tr class='tr1'><td><input type='radio' name='delId' value="+item.CONTRACTDOCID+"></td><td>"+item.DOCNAME+"</td><td>"+item.DOCVERSION+"</td><td>"+item.DOCCREATETIME+"</td><td>"+state+"</td><td>"+item.LASTESTTIME+"</td></tr>");
			} else {
				$("#group_one").append("<tr class='tr2'><td><input type='radio' name='delId' value="+item.CONTRACTDOCID+"></td><td>"+item.DOCNAME+"</td><td>"+item.DOCVERSION+"</td><td>"+item.DOCCREATETIME+"</td><td>"+state+"</td><td>"+item.LASTESTTIME+"</td></tr>");
			}
	    }); 
		pageTab();
	});
}	
function pageTab(){
	var tFirst = $("#first").val();
	var tLast = $("#last").val();
	var tPre = $("#pre").val();
	var tNext = $("#next").val();
	$("div.holder").jPages({
		  containerID : "group_one",
		  first: tFirst,		
		  last: tLast,
		  previous : tPre,
		  next : tNext,
		  perPage : 6,
		  delay : 30
	});
}
$(function(){
	loadDocs("getDocs.shtml");
});
function validateAddDoc(){
	var docName = $("#docName").val();
	var docVersion = $("#docVersion").val();
	if(docName==""){
		$("#alertMsg")[0].innerHTML=$("#docNameNull").val();
	} else if(docVersion==""){
		$("#alertMsg")[0].innerHTML=$("#docVersionNull").val();
	} else if($("#file").val()==""){
		$("#alertMsg")[0].innerHTML=$("#selUpFile").val();
	} else {
		$("#alertMsg")[0].innerHTML="";
		ajaxFileUpload(docName,docVersion);	
		setTimeout(function(){ 
			loadDocs("getDocs.shtml");                  
        },1000); 
	}
}
function ajaxFileUpload(docName,docVersion)
{
    
    $("#loadingDiv")
    .ajaxStart(function(){
        $(this).show();
    })//开始上传文件时显示一个图片
    .ajaxComplete(function(){
		$(this).hide();
    });//文件上传完成将图片隐藏起来
    
    $.ajaxFileUpload
    (
        {
            url:'fileUploadJson.shtml?contractDoc.docName='+docName+'&contractDoc.docVersion='+docVersion,//用于文件上传的服务器端请求地址
            secureuri:false,
            fileElementId:'file',//文件上传空间的id属性  <input type="file" id="file" name="file" />
            dataType: 'json',//返回值类型 一般设置为json
            success: function (data, status)  //服务器成功响应处理函数
            {
                //alert(data.message);//从服务器返回的json中取出message中的数据,其中message为在struts2中action中定义的成员变量
            	$("#alertMsg")[0].innerHTML=data.message;
                if(typeof(data.error) != 'undefined')
                {
                    if(data.error != '')
                    {
                        alert(data.error);
                    }else
                    {
                        alert(data.message);
                    }
                }
                setTimeout(function(){ 
                	$("#alertMsg")[0].innerHTML="";                    
                },2000); 

            },
            error: function (data, status, e)//服务器响应失败处理函数
            {
                alert(e);
            }
        }
    )  
    return false;
}
function delDoc(){
	var msg = $("#confirmDel").val();
	var delDocId = $("input[name='delId']:checked").val();
	if(confirm(msg)==true){
		loadDocs("delDoc.shtml?delDocId="+delDocId);
	} else {
		return false;
	}
}
function closeChild(){
	$.getJSON("getDocs.shtml",{random:Math.random()},function(data,status){
		var rt = "<option value ='all'>---select---</option>";
		$.each(data.pageParList, function(idx,item){
			rt += "<option value ='"+item.CONTRACTDOCID+"'>"+item.DOCNAME+"</option>";
	    }); 
		window.returnValue = rt;
		window.close(); 
	});  
}