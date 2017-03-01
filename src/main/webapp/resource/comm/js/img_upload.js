/**
*上传操作初始化控件,一次传多张图片
*chenwei
*/
//全局变量
var img_path = "../fileShare/readImage.shtml";

function initUploadify(){
	jQuery("#uploadify").uploadify({
		//'buttonImg'      : '../resource/common/images/uploadify-browse.gif',
		'uploader'       : '../resource/comm/swf/uploadify.swf',//组件自带的flash，用于打开选取本地文件的按钮 
		'script': '../fileShare/uploadImage.shtml',//处理上传的路径，这里使用Struts2是XXX.action
		'cancelImg'      : '../resource/comm/images/uploadify-cancel.png',//取消上传文件的按钮图片，就是个叉叉
		'folder'         : 'uploads', //上传文件的目录
		'fileDataName'   : 'uploadify',  //和input的name属性值保持一致就好，Struts2就能处理了
		'scriptAccess'   : 'always',// Set to "always" to allow script access across domains
		'method'         : 'POST',
		'queueID'        : 'imageQueue',
		'auto'           : true,//是否选取文件后自动上传    
		'multi'          : true,//是否支持多文件上传
		'queueSizeLimit' : 1,
		'simUploadLimit' : 1,// 允许同时上传的个数 默认值
		'sizeLimit'		 : 1*1024*1024, //控制上传文件的大小，单位byte(1M)
		'wmode'          : 'transparent',
		'hideButton'     :true,
		'width'			 : 90,
		'height'		 : 30,
		'fileExt'		 :  '*.jpg;*.png',	// 设置可以选择的文件的类型，格式如：'*.doc;*.pdf;*.rar' 。
		'fileDesc'		 : 'choose *.jpg/*.png',// 设置文件浏览对话框中的文件类型下拉框的显示文本。
		'onInit'         : function() { 
								setImgContainSize();
							},
		'onError' 		 : function(event, ID, fileObj, errorObj){
								jQuery("#p_allcomplete").html("Upload unsuccessful. Please try again.").show();
								return false;
	    					},
		'onSelect' 		 : function(event, ID, fileObj){
								jQuery("#p_allcomplete").html('');
								jQuery('#photo_size_err').css({display: 'none'});
								//设置上传参数
								//jQuery('#uploadify').uploadifySettings('scriptData',{});
								//上传
								if(fileObj.size > 1024*1024){
							    	jQuery('#photo_size_err').css({display: 'block'});
							    	return false;
							    }
							    var imgList = $("input[name='inp_imgurl']");
							    if(imgList.length>0){//最多加1张图
		    						jQuery("#p_allcomplete").html("You can only upload 1 images.").show();
    								return false; 
							    }
								jQuery('#uploadify').uploadifyUpload();
						   },
	   'onQueueFull'	 : function(event, queueSizeLimit) { //图片选择超限警告					
							return false;
					     },
		'onSelectOnce'	 : function (){
						 },
        'onComplete'     : function(event,ID,fileObj,response,data) { //成功后处理图片显示
        						if(response != ""){	 
        							
									var s_value=window.eval("("+response+")");
									//初次上传成功
									if(s_value.result=='1' || s_value.result=='2'){
										var imgmd5=s_value.c_md5;
										var imgurl=s_value.c_url;
										var imgsize=s_value.c_size;
										//回调
										if ($("#uploadFlg").attr("value")==1) {
											uploadImg(imgurl);
										}
										addImg_upload_queue(imgmd5,imgsize,imgurl,ID);
									}else{
										deleteImgUI(ID);//失败后删除图片框
										jQuery("#p_allcomplete").html('Upload unsuccessful for a system error.').show();
									}
								}
    					   },
    	'onAllComplete'		: function(event,queueId,fileObj,response,data) { //成功后处理图片显示
    					   }
    	});
}

function addImg_upload_queue(imgmd5,imgsize,imgurl,nIndex){	
	   //后期考虑图片是否重复问题
	   //if(!validateIsExist(imgmd5)){					   
	      setImgData_upload(nIndex, imgmd5,imgsize,imgurl); 
		  setUrlValForHidden();
	   //}else{
		//  $("#div_imgcontainer_"+ nIndex ).remove(); //删除UI
	  // }					
	}
	
	function setUrlValForHidden(){
		var imgUrlList = $("input[name='inp_imgurl']");
		var strImgUrl = "";
		if(imgUrlList.length!=0 && imgUrlList[0].value != ""){
			 for (var i = 0; i < imgUrlList.length; i++){
			 	if (imgUrlList.length == 1) {
			 		strImgUrl += imgUrlList[i].value ;
			 	}else {
			 		strImgUrl += imgUrlList[i].value + ";";
			 	}
				$("#imgUrl").val(strImgUrl);
			 }
		}else{
			$("#imgUrl").val("");
		}
	}
	
    function addImgUI_img(nIndex){
		var strImgUI = createImgUI_img(nIndex);
		$("#div_imgcontainer").append(strImgUI);
		//隐藏掉进度条,进度条遮挡住了图片上传下的提示信息
		$("#imgQueue_"+nIndex).hide();
    }

    //修改页面中的回显可上传照片数
    function setImgContainSize(){
        var imgList = $("input[name='inp_imgmd5']");
        var imgListLength = imgList.length;
        var size =0;
        size = 1 - imgListLength;//还可以再添加的图片
        $("#photonum_b").html(size);
    }
	
    function validateIsExist(imgmd5){
        var imgList = $("input[name='inp_imgmd5']");
    	nImgListCount = imgList.length;
    	if( nImgListCount > 0 && nImgListCount<=4){
    		for(var i=0; i<nImgListCount;i++){
    			var oImgMD5Item = imgList[i];
    			if( oImgMD5Item.value == imgmd5){
				    jQuery("#fileQueue").remove();
    				jQuery("#p_allcomplete").html("This file has been uploaded.").show();
        			return true;//已存在
        		}
    		}
    	}
    	return false;
    }

//改造原页面中的回显(来自本地上传中图片)
function setImgData_upload(nIndex, imgmd5,imgsize,imgurl){
   //需要组装该imgUrl
    var strImgPath = img_path+"?fileShare.sFileId="+imgurl;
	//设置数据
	$("#pimg_"+ nIndex).attr("src", strImgPath); //小图url（要显示的路径）
	$("#picurl_"+ nIndex).val(imgurl);	//产品图片数据
	$("#md5_"+ nIndex).val(imgmd5);		//产品图片对应的MD5
	setImgContainSize();
}

function deleteImgUI(nIndex){
	$("#p_allcomplete").html('');
	$("#div_imgcontainer_"+ nIndex ).remove(); //删除UI
	setImgContainSize();   //重新回显可上传照片数
	setUrlValForHidden();  //重新给隐藏域赋值
}

function showCloseImg(nIndex){
	$('#pimg_del_'+nIndex).css("display","block");
}
function hiddenCloseImg(nIndex){
	$('#pimg_del_'+nIndex).css("display","none");
}

function createImgUI_img(nIndex){
	var heightSize = $("#heightSize").attr("value");
	var widthSize = $("#widthSize").attr("value");
	var imagecard = document.getElementById("imagecard");
    imagecard.src="";
    imagecard.height="";
    imagecard.width="";
	var arrHTML = [];
	arrHTML[arrHTML.length] = '<div id="div_imgcontainer_'+ nIndex +'"  class="image-upload-list"  onmouseover="showCloseImg(\''+ nIndex +'\');" onmouseout="hiddenCloseImg(\''+ nIndex +'\');">';
    arrHTML[arrHTML.length] = '<span class="img">';      
	arrHTML[arrHTML.length] = '<img id="pimg_'+ nIndex +'" src="../resource/comm/images/uploadify-nophoto.png" width="' + widthSize + '" height="' + heightSize + '"/>';	
	arrHTML[arrHTML.length] = '</span>';
    arrHTML[arrHTML.length] = '<span id="pimg_del_'+ nIndex +'"  class="proimg-delete"><span><a href="#" onclick="deleteImgUI(\''+ nIndex +'\');return false;" ></a></span></span>';
    arrHTML[arrHTML.length] = '<span id="imgQueue_'+ nIndex + '\"></span>';
	arrHTML[arrHTML.length] = '<input type="hidden" id="picurl_'+ nIndex +'" name="inp_imgurl" value=""/>';
    arrHTML[arrHTML.length] = '<input type="hidden" id="md5_'+ nIndex +'" name="inp_imgmd5"  value=""/>';
    arrHTML[arrHTML.length] = '</span></div>';
    return arrHTML.join("");
}
