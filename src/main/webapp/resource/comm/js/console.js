try{
	window.top.document.getElementById("progress").style.display="none";
}catch(e){}
function closeIt(){

    try{
	    $("form input:button").each(function(i,o){o.disabled=true;});
	    window.top.document.getElementById("progress").style.display="";
    }catch(e){
        try{
	    	Ext.each( Ext.query('input[type="button"],button'),function(o){o.disabled=1;},this);
	    	window.top.document.getElementById("progress").style.display="";
	    }catch(e){}
    }
}
function closeProgress(){
	try{
		window.top.document.getElementById("progress").style.display="none";
	}catch(e){}
	
	$("form input:button").each(function(i,o){o.disabled=false;});
}

function SetCookie(name,value)
{

    var Days = 360; 
    var exp  = new Date();   
    exp.setTime(exp.getTime() + Days*24*60*60*1000);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}

function getCookie(name)    
{
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
     if(arr != null) return unescape(arr[2]); return null;

}

function delCookie(name)
{
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval=getCookie(name);
    if(cval!=null) document.cookie= name + "="+cval+";expires="+exp.toGMTString();
}


function  toppage(extHeight,extWidth){ 
  var extH = 0;
  var extW = 0;
  if(extHeight != undefined)
  	extH = extHeight;
  
  if(extWidth != undefined)
  	extW = extWidth;
  	

  if  (self.location!=top.location ){
    try{  
      if( parent.document.all(self.name) != null) {
        try{ parent.document.all(self.name).height=document.body.scrollHeight +extH ; }catch(e){}  
        if(extWidth != undefined){
        	try{ parent.document.all(self.name).width=document.body.scrollWidth +extW ; }catch(e){}  
        }
      }
    }catch(e){
       if(parent.document.getElementById(self.name) != null) { 
    	 try{ parent.document.getElementById(self.name).height=document.body.scrollHeight +extH ; }catch(e){}
    	 if(extWidth != undefined){
    	 	try{ parent.document.getElementById(self.name).width=document.body.scrollWidth +extW ; }catch(e){}   
    	 }
    	}
    }  
  }   
} 

$(function() {
	try{  
    toppage(0,0);  
  }catch(e){}  
}); 
