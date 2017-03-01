function receiveTypeChange(rtValue){
    if(rtValue=="1"){
      //  $('').show();
       // $('#pathToTrTable').hide();
    }else if(rtValue=="2"){
       // $('#pathToTrTable').hide();
    }else if(rtValue=="3"){
        $('#pathToTrText').show();
    }else if(rtValue=="4"){
        $('#pathToTrText').hide();
    }

}
function receiveLinkChange(rtValue){
    if(rtValue=="5"){
       // $('').show();
        $('#isconfigurationTr').hide();
        $('#autoTr').hide();
        $('#invokeApiTr').hide();
        $('#invokeScriptTr').hide();
    }else if(rtValue=="6"){
        $('#isconfigurationTr').show();
        $('#autoTr').show();
        $('#invokeApiTr').show();
        $('#invokeScriptTr').show();
    }

}
function receiveAutoChange(rtValue){
    if(rtValue=="7"){
       // $('').show();
        $('#invokeApiTr').show();
        $('#invokeScriptTr').hide();
    }else if(rtValue=="8"){
        $('#invokeScriptTr').show();
        $('#invokeApiTr').hide();
    }

}