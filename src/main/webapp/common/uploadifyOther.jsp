<style>
<!--
.error-informOther{margin-top:3px;font-size:11px;color:#f00;}
.fill-remind{font-size:11px;}
.browse-files{margin-bottom:5px;}
.browse-files *{vertical-align:middle;}
.browse-files .n-grey-button{width:109px;height:27px;}
#photonum_b{font-weight:700;color:#e71}
#uploadifyOtherUploader{visibility:hidden;width:95px;height:30px;background:url(../resource/comm/images/uploadify-browse.gif) no-repeat 0 0;background-position:center;border:0;}
uploadifyProgress{ background-color: #FFFFFF; border-color: #808080 #C5C5C5 #C5C5C5 #808080;border-style: solid;border-width: 1px; margin-top: 4px;width: 100%;}
.uploadifyProgressBar_img{width:1px;height:6px; background-color:#39be55;}
.uploadifyQueueItem_img{display:inline-block;width:70px;height:37px;}
.browse-files .browsebtn-warp{margin:0 15px 15px -7px;height:30px;line-height:30px;_height:32px;_line-height:32px;}
.browse-files .browsebtn-warp *{vertical-align:middle;}
.image-upload-list{position:relative;zoom:1;float:left;margin-right:15px;border:1px solid #f1f1f1;}
.image-upload-list:hover{border:1px solid #ff8000;} 
.image-upload-list .proimg-delete{display:none;position:absolute;top:-5px;right:-5px;}
.image-upload-list .proimg-delete a{display:block;overflow:hidden;height:16px;width:16px;background:url(../resource/comm/images/uploadify-close.png) no-repeat -81px -46px;}
-->
</style>
<script type="text/javascript">
var img_path = "../fileShare/readImage.shtml";

function initUploadifyOther(){
	jQuery("#uploadifyOther").uploadify({
		//'buttonImg'      : '../resource/common/images/uploadify-browse.gif',
		'uploader'       : '../resource/comm/swf/uploadify.swf',
		'script'         : '../fileShare/twiceUploadImage.shtml',
		'cancelImg'      : '../resource/comm/images/uploadify-cancel.png',
		'folder'         : 'uploads', 
		'fileDataName'   : 'uploadifyOther',  
		'scriptAccess'   : 'always',// Set to "always" to allow script access across domains
		'method'         : 'POST',
		'queueID'        : 'imageQueueOther',
		'auto'           : true,
		'multi'          : true,
		'queueSizeLimit' : 1,
		'simUploadLimit' : 1,
		'sizeLimit'		 : 1*1024*1024, 
		'wmode'          : 'transparent',
		'hideButton'     :true,
		'width'			 : 90,
		'height'		 : 30,
		'fileExt'		 :  '*.jpg;*.png',	
		'fileDesc'		 : 'choose *.jpg/*.png',
		'onInit'         : function() { 
								setImgContainSizeOther();
							},
		'onError' 		 : function(event, ID, fileObj, errorObj){
								jQuery("#p_allcompleteOther").html("Upload unsuccessful. Please try again.").show();
								return false;
	    					},
		'onSelect' 		 : function(event, ID, fileObj){
								jQuery("#p_allcompleteOther").html('');
								jQuery('#photo_size_errOther').css({display: 'none'});
								//jQuery('#uploadify').uploadifySettings('scriptData',{});
								if(fileObj.size > 1024*1024){
							    	jQuery('#photo_size_errOther').css({display: 'block'});
							    	return false;
							    }
							    var imgList = $("input[name='inp_imgurlOther']");
							    if(imgList.length>0){
		    						jQuery("#p_allcompleteOther").html("You can only upload 1 images.").show();
    								return false; 
							    }
								jQuery('#uploadifyOther').uploadifyUpload();
						   },
	   'onQueueFull'	 : function(event, queueSizeLimit) { 				
							return false;
					     },
		'onSelectOnce'	 : function (){
						 },
        'onComplete'     : function(event,ID,fileObj,response,data) {
        						if(response != ""){	 
									var s_value=window.eval("("+response+")");
									
									if(s_value.result=='1' || s_value.result=='2'){
										var imgmd5=s_value.c_md5;
										var imgurl=s_value.c_url;
										var imgsize=s_value.c_size;
										
										addImg_upload_queueOther(imgmd5,imgsize,imgurl,ID);
									}else{
										deleteImgUIOther(ID);
										jQuery("#p_allcompleteOther").html('Upload unsuccessful for a system error.').show();
									}
								}
    					   },
    	'onAllComplete'		: function(event,queueId,fileObj,response,data) {
    					   }
    	});
}

function addImg_upload_queueOther(imgmd5,imgsize,imgurl,nIndex){	
	   //if(!validateIsExist(imgmd5)){		
	      setImgData_uploadOther(nIndex, imgmd5,imgsize,imgurl); 
		  setUrlValForHiddenOther();
	   //}else{
		//  $("#div_imgcontainer_"+ nIndex ).remove();
	  // }					
	}
	
	function setUrlValForHiddenOther(){
		var imgUrlList = $("input[name='inp_imgurlOther']");
		var strImgUrl = "";
		if(imgUrlList.length!=0 && imgUrlList[0].value != ""){
			 for (var i = 0; i < imgUrlList.length; i++){
			 	if (imgUrlList.length == 1) {
			 		strImgUrl += imgUrlList[i].value ;
			 	}else {
			 		strImgUrl += imgUrlList[i].value + ";";
			 	}
				$("#imgUrlOther").val(strImgUrl);
			 }
		}else{
			$("#imgUrlOther").val("");
		}
	}
	
    function addImgUI_imgOther(nIndex){
		var strImgUI = createImgUI_imgOther(nIndex);
		$("#div_imgcontainerOther").append(strImgUI);
		$("#imgQueue_"+nIndex).hide();
    }

    function setImgContainSizeOther(){
        var imgList = $("input[name='inp_imgmd5Other']");
        var imgListLength = imgList.length;
        var size =0;
        size = 1 - imgListLength;
        $("#photonum_b").html(size);
    }
	
    function validateIsExistOther(imgmd5){
        var imgList = $("input[name='inp_imgmd5Other']");
    	nImgListCount = imgList.length;
    	if( nImgListCount > 0 && nImgListCount<=4){
    		for(var i=0; i<nImgListCount;i++){
    			var oImgMD5Item = imgList[i];
    			if( oImgMD5Item.value == imgmd5){
				    jQuery("#fileQueue").remove();
    				jQuery("#p_allcompleteOther").html("This file has been uploaded.").show();
        			return true;
        		}
    		}
    	}
    	return false;
    }

function setImgData_uploadOther(nIndex, imgmd5,imgsize,imgurl){
    var strImgPath = img_path+"?fileShare.sFileId="+imgurl;
	$("#pimg_"+ nIndex).attr("src", strImgPath); 
	$("#picurl_"+ nIndex).val(imgurl);	
	$("#md5_"+ nIndex).val(imgmd5);		
	setImgContainSizeOther();
}

function deleteImgUIOther(nIndex){
	$("#p_allcompleteOther").html('');
	$("#div_imgcontainerOther_"+ nIndex ).remove(); 
	setImgContainSizeOther();   
	setUrlValForHiddenOther();  
}

function showCloseImgOther(nIndex){
	$('#pimg_del_'+nIndex).css("display","block");
}
function hiddenCloseImgOther(nIndex){
	$('#pimg_del_'+nIndex).css("display","none");
}

function createImgUI_imgOther(nIndex){
	var heightSize = $("#heightOtherSize").attr("value");
	var widthSize = $("#widthOtherSize").attr("value");
	var imagecard = document.getElementById("imagecardOther");
    imagecard.src="";
    imagecard.height="";
    imagecard.width="";
	var arrHTML = [];
	arrHTML[arrHTML.length] = '<div id="div_imgcontainerOther_'+ nIndex +'"  class="image-upload-list"  onmouseover="showCloseImgOther(\''+ nIndex +'\');" onmouseout="hiddenCloseImgOther(\''+ nIndex +'\');">';
    arrHTML[arrHTML.length] = '<span class="img">';      
	arrHTML[arrHTML.length] = '<img id="pimg_'+ nIndex +'" src="../resource/comm/images/uploadify-nophoto.png" width="' + widthSize + '" height="' + heightSize + '"/>';
	arrHTML[arrHTML.length] = '</span>';
    arrHTML[arrHTML.length] = '<span id="pimg_del_'+ nIndex +'"  class="proimg-delete"><span><a href="#" onclick="deleteImgUIOther(\''+ nIndex +'\');return false;" ></a></span></span>';
    arrHTML[arrHTML.length] = '<span id="imgQueue_'+ nIndex + '\"></span>';
	arrHTML[arrHTML.length] = '<input type="hidden" id="picurl_'+ nIndex +'" name="inp_imgurlOther" value=""/>';
    arrHTML[arrHTML.length] = '<input type="hidden" id="md5_'+ nIndex +'" name="inp_imgmd5Other"  value=""/>';
    arrHTML[arrHTML.length] = '</span></div>';
    return arrHTML.join("");
}
</script>
