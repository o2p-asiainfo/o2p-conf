    <iframe id="iframecommon"  style="display:none" ></iframe>
    <script type="text/javascript">
       
       var vCustomHeight;
       function changeTopScrollHeight(vHeight){
       	     var ssoHeight;
       	     
       		 if(vHeight != undefined){
       		 	 vCustomHeight = vHeight;
       		 }        		 
       		 if (vCustomHeight!= undefined) {
       		 	ssoHeight = vCustomHeight;
       		 }else {
	       		ssoHeight = document.body.scrollHeight;
             }
             //alert("ssoHeight:"+ssoHeight+"vCustomHeight:"+vCustomHeight+"vHeight:"+vHeight);
//              var ssoIframecommon = document.getElementById('iframecommon');	
             //ssoHeight =ssoHeight+200;      
//              var baseuri = top.location.href;
//              var hostUrl = baseuri.substring(0,baseuri.indexOf("/eaap"));
// 	         ssoIframecommon.src= hostUrl + "/EAAP_SSO/main/proxy.html?random="+(Math.random()*100000000)+"#" + ssoHeight;
			if(window.top.document.getElementById('iframe1') != null){
				window.top.document.getElementById('iframe1').height = ssoHeight + "px";
			}
       } 
       
       $(function() {
       	 changeTopScrollHeight();
	   });
	   
	   $(window).resize(function () {
            changeTopScrollHeight();
       });
       
       
       //document.body.onresize = function(){alert('hehe');changeTopScrollHeight();};
        
       
     </script>
  