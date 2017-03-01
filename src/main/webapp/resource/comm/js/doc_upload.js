/**异步上传操作控件(可上传excel,word,pdf等)*/

function initUploadify(){
	jQuery("#uploadify").uploadify({
		//'buttonImg'      : '../resource/common/images/uploadify-browse.gif',
		'uploader'       : '../resource/comm/swf/uploadify.swf',//组件自带的flash，用于打开选取本地文件的按钮 
		'script': '../fileShare/uploadFile.shtml',//处理上传的路径，这里使用Struts2是XXX.action
		'cancelImg'      : '../resource/comm/images/uploadify-cancel.png',//取消上传文件的按钮图片，就是个叉叉
		'folder'         : 'uploads', //上传文件的目录
		'fileDataName'   : 'uploadify',  //和input的name属性值保持一致就好，Struts2就能处理了
		'scriptAccess'   : 'always',// Set to "always" to allow script access across domains
		'method'         : 'POST',
		'queueID'        : 'fileQueue',
		'auto'           : false,//是否选取文件后自动上传    
		'multi'          : true,//是否支持多文件上传
		'queueSizeLimit' : 4,
		'simUploadLimit' : 4,// 允许同时上传的个数 默认值
		'sizeLimit'		 : 3*1024*1024, //控制上传文件的大小，单位byte(3M)
		'wmode'          : 'transparent',
		'hideButton'     :true,
		'width'			 : 90,
		'height'		 : 30,
		'fileExt'		 :  '*.doc;*.docx;*.wsdl',	// 设置可以选择的文件的类型，格式如：'*.doc;*.pdf;*.rar' 。
		'fileDesc'		 : 'choose *.doc/*.docx;*.wsdl',// 设置文件浏览对话框中的文件类型下拉框的显示文本。
		'onInit'         : function() { 
							},
		'onError' 		 : function(event, ID, fileObj, errorObj){
								jQuery("#p_allcomplete").html("Upload unsuccessful. Please try again.").show();
								return false;
	    					},
		'onSelect' 		 : function(event, ID, fileObj){
								jQuery("#p_allcomplete").html('');
								//jQuery('#file_size_err').css({display: 'none'});
								//设置上传参数
								//jQuery('#uploadify').uploadifySettings('scriptData',{});
								/*
								if(fileObj.size > 3*1024*1024){
							    	jQuery('#file_size_err').css({display: 'block'});
							    	return false;
							    }
								*/
						   },
	   'onQueueFull'	 : function(event, queueSizeLimit) { //文档选择超限警告					
							return false;
					     },
		'onSelectOnce'	 : function (){
						 },
        'onComplete'     : function(event,ID,fileObj,response,data) { //成功后处理图片显示
        						if(response != ""){	 
									var s_value=window.eval("("+response+")");
									//初次上传成功
									if(s_value.result=='1' || s_value.result=='2'){
										var fileMd5=s_value.c_md5;
										var fileId=s_value.c_url;
										var fileSize=s_value.c_size;
										//回调
										addFile_upload_queue(fileMd5,fileSize,fileId,ID,fileObj);
										$('#file_after_name').val(fileObj.name);
									}else{
										deleteFileUI(ID);//失败后删除图片框
										jQuery("#p_allcomplete").html('Upload unsuccessful for a system error.').show();
									}
								}
    					   },
    	'onAllComplete'		: function(event,queueId,fileObj,response,data) {
    					   }
    	});
}

 function addFileUI(nIndex){
	var strImgUI = createFileUI(nIndex);
	$("#div_filecontainer").append(strImgUI);
 }
 
 function addFile_upload_queue(fileMd5,fileSize,fileId,nIndex,fileObj){	
	//后期考虑文档是否重复问题
	//显示已上传的文件
	showUploadedFile(fileId,fileObj,nIndex);
	//将fileId回填到隐藏域 
	setUrlValForHidden(fileId);
 }
 
 function setUrlValForHidden(fileId){
 	var imgUrlList = $("input[name='inp_imgurl']");
	var strImgUrl = "";
	if(imgUrlList.length!=0 && imgUrlList[0].value != ""){
			 for (var i = 0; i < imgUrlList.length; i++){
			 	if (imgUrlList.length == 1) {
			 		strImgUrl += imgUrlList[i].value ;
			 	}else {
			 		strImgUrl += imgUrlList[i].value + ";";
			 	}
				$("#attach_id1").val(strImgUrl);
			 }
	}else{
		$("#attach_id1").val("");
	}
 }
 
 function showUploadedFile(fileId,fileObj,nIndex){
    $("#picurl_"+ nIndex).val(fileId);
 	//$("#showResult").append("<a href=\"../fileShare/downloadFile.shtml?contentType=doc&fileShare.sFileId="+fileId+"\">"+fileObj.name+"</a>&nbsp;&nbsp;&nbsp;&nbsp;");
 	var downStr = "../fileShare/downloadFile.shtml?contentType=doc&fileShare.sFileId="+fileId;
 	var aText = fileObj.name;
	//设置数据
	$("#pimg_"+ nIndex).attr("href", downStr);
	$("#pimg_"+ nIndex).text(aText);
 }
 
 function deleteFileUI(nIndex){
	$("#p_allcomplete").html('');
	$("#div_filecontainer_"+ nIndex ).remove(); //删除UI
	setUrlValForHidden();  //重新给隐藏域赋值
}

function showCloseImg(nIndex){
	$('#pimg_del_'+nIndex).css("display","block");
}
function hiddenCloseImg(nIndex){
	$('#pimg_del_'+nIndex).css("display","none");
}

 function createFileUI(nIndex){
	var arrHTML = [];
	arrHTML[arrHTML.length] = '<div id="div_filecontainer_'+ nIndex +'"  class="image-upload-list"  onmouseover="showCloseImg(\''+ nIndex +'\');" onmouseout="hiddenCloseImg(\''+ nIndex +'\');">';
	arrHTML[arrHTML.length] = '<a id="pimg_'+ nIndex +'" href="" width="180" height="20"></a>';
    arrHTML[arrHTML.length] = '<span id="pimg_del_'+ nIndex +'"  class="proimg-delete"><span><a href="#" onclick="deleteFileUI(\''+ nIndex +'\');return false;" ></a></span></span>';
	arrHTML[arrHTML.length] = '<input type="hidden" id="picurl_'+ nIndex +'" name="inp_imgurl" value=""/>';
    arrHTML[arrHTML.length] = '</span></div>';
    return arrHTML.join("");
}
 