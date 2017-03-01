
function validateAddDoc(){
	/*var docName = $("#docName").val();
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
	}
	*/
}
function ajaxFileUpload(docName,docVersion,fileId)
{
   var sstate =1;
    $("#loadingDiv")
    .ajaxStart(function(){
        $(this).show();
    })
    .ajaxComplete(function(){
		$(this).hide();
    });
    
    $.ajaxFileUpload
    (
        {
            url:'fileUploadJson.shtml?contractDoc.docName='+docName+'&contractDoc.docVersion='+docVersion+'&contractDoc.docPath='+fileId,
            secureuri:false,
            fileElementId:'uploadify',//Come in jsp page  <input type="file" id="file" name="file" />
            dataType: 'json',
            data:{a:1},   
            success: function (data)  
            {
                if(typeof(data.error) != 'undefined')
                {
                    if(data.error != '')
                    {
                        alert(data.error);
                    }else
                    {
                        //alert(data.message);
                    }
                }
                setTimeout(function(){ 
                	//$("#alertMsg")[0].innerHTML="";                    
                },2000); 
            },
            error: function ()//鏈嶅姟鍣ㄥ搷搴斿け璐ュ鐞嗗嚱鏁�
            {
               // alert("0000000000000000");
                sstate = 0;
            }
        }
    )  
    return sstate;
}