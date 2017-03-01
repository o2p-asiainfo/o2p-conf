var UserInfo = function() {

    var handleEditable = function() {
        //global settings 
        $.fn.editable.defaults.inputclass = 's-form-group';
        //$.fn.editable.defaults.url = 'edit.jsp';

        $('a[data-name="name"]').editable({
            url: '', //url to server-side script to process submitted value (/post, post.php etc)    
            type: 'text',
            pk: 1,
            name: 'name',
            title: 'Enter a new name',
            inputclass: 'form-control input-small',
            validate: function(value) {
                if ($.trim(value) == '') {
                    return 'This field is required';
                }
                if (value.length > 60) {
                    return 'Please enter a value less than or equal to 60';
                }
            }
        })
         $('a[data-name="address"]').editable({
            url: '',     
            type: 'text',
            pk: 1,
            name: 'address',
            title: 'Enter a new Address',
            inputclass: 'form-control input-medium',
            validate: function(value) {
                if (value.length > 255) {
                    return 'Please enter a value less than or equal to 255';
                }
            }
        })
        $('a[data-name="introduction"]').editable({
            url: '',
            prepend: "Select Type",
            type: 'textarea',
            pk: 1,
            name: 'introduction',
            title: 'Introduction',
            inputclass: 'form-control',
            validate: function(value) {
                if (value.length > 500) {
                    return 'Please enter a value less than or equal to 500';
                }
            }
        })
        $('a[data-name="email"]').editable({
            url: '', //url to server-side script to process submitted value (/post, post.php etc)    
            type: 'text',
            pk: 1,
            name: 'name',
            title: 'Enter a new Email',
            inputclass: 'form-control input-medium',
            validate: function(value) {
                if ($.trim(value) == '') {
                    return 'This field is required';
                }
                if(!emailCheck(value)){
                	return 'Please enter a valid email address.eg:xx@xx.com';
                }
                if (value.length > 30) {
                    return 'Please enter a value less than or equal to 30';
                }
            }
        })
        $('a[data-name="mobilePhone"]').editable({
            url: '', //url to server-side script to process submitted value (/post, post.php etc)    
            type: 'text',
            pk: 1,
            name: 'name',
            title: 'Enter a new Phone',
            inputclass: 'form-control input-medium',
            validate: function(value) {
                if ($.trim(value) == '') {
                    return 'This field is required';
                }
                if(!/^\d+$/.test(value)){
                	return 'Please fill in your correct phone number';
                }
                if (value.length > 30) {
                    return 'Please enter a value less than or equal to 20';
                }
            }
        })
        $('a[data-name="certNum"]').editable({
            url: '', //url to server-side script to process submitted value (/post, post.php etc)    
            type: 'text',
            pk: 1,
            name: 'certNum',
            title: 'Enter a new ID Number',
            inputclass: 'form-control input-medium',
            validate: function(value) {
                if ($.trim(value) == '') {
                    return 'This field is required';
                }
            }
        })

        var typeList = $("#orgTypeList").val();
        $('a[data-name="orgType"]').editable({
            url: '',
            type: 'select',
            pk: 1,
            name: 'orgType',
            title: 'Select User Type',
            source: typeList,
            validate: function(value) {
                if ($.trim(value) == '') {
                    return 'This field is required';
                }else{
                	$("#orgTypeCode").val(value);
                	changeCertType(value);
                }
            }
        })
        
        /*
        var cTypeList = $("#certTypeList").val();
        $('a[data-name="certType"]').editable({
            url: '',
            type: 'select',
            pk: 1,
            name: 'certType',
            title: 'Select ID Type',
            source: cTypeList,
            validate: function(value) {
                if ($.trim(value) == '') {
                    return 'This field is required';
                }else{
                	$("#certTypeCode").val(value);
                }
            }
        })
        */
        
        var changeCertType = function(orgType){
        	if(orgType==1){
        		$("#nameType").html('<font style="color:#FF0000;">*</font> ' +_enterpriseName); 
        	}else{
        		$("#nameType").html('<font style="color:#FF0000;">*</font> ' +_personalName); 
        	}
        	if(orgType != _orgTypeCode){
            	_orgTypeCode = orgType;
            	$("#certType").html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"); 
            	$("#certTypeCode").val("");
        	}

        	$.ajax({
        		  async : false,
        		  type : "POST",
        		  url :  "../org/getCertTypeList.shtml",
        		  data : {
        			  orgType : orgType
        		  },
        		  dataType : "json",
        		  success : function(data) {
        			  if(data){
        				  var typeListStr = "";
        				  var certTypeList = data.certTypeList;
        				  //$("#cardType").empty();
        				  for(var i = 0; i < certTypeList.length; i++){
        					  //var option = $("<option>").val(certTypeList[i].certCode).text(certTypeList[i].certName);
        					  //$("#cardType").append(option);
        					  if(i==0){
        						  typeListStr +="{value:'"+certTypeList[i].certCode+"',text:'"+certTypeList[i].certName+"'}";
        					  }else{
        						  typeListStr +=",{value:'"+certTypeList[i].certCode+"',text:'"+certTypeList[i].certName+"'}";
        					  }
        				  }
        				  typeListStr = "["+typeListStr+"]";
        				  $("#certTypeList").val(typeListStr); 
        				  
        				  //从新初始化 ID Type：
        				  $("#certType").prop('outerHTML', '<a href="#" data-name="certType" id="certType">'+$("#certType").text()+'</a>');
        				  $('a[data-name="certType"]').editable({
        			            url: '',
        			            type: 'select',
        			            pk: 1,
        			            name: 'certType',
        			            title: 'Select ID Type',
        			            source: $("#certTypeList").val(),
        			            validate: function(value) {
        			                if ($.trim(value) == '') {
        			                    return 'This field is required';
        			                }else{
        			                	$("#certTypeCode").val(value);
        			                }
        			            }
        			       })
        			  }
        		  }
        	 });
        };
        
    }
    
    var emailCheck = function (value) {   
        var pattern = /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/i; 
        if (!pattern.test(value)) {  
            return false;  
        }  
        return true;  
    }  

    var closeEidtable = function() {
        $('.editable').editable('toggleDisabled');
    }

    var handleBindCapability = function() {
        $('#myModal').on('show.bs.modal', function(e) {
            $('#dt').dataTable({
                "processing": true,
                "serverSide": true,
                //"lengthMenu": [5, 10, 15, "All"],
                "ajax": "dataTable.jsp",
                "order": [],
                "autoWidth": false,
                "columnDefs": [{
                    "orderable": false,
                    "width": "36px",
                    "targets": 0
                }, {
                    "orderable": false,
                    "targets": 3
                }],
                "initComplete": function() {
                    App.initUniform();
                }
            });
            jQuery('#dt_wrapper .dataTables_filter input').addClass("form-control input-small input-inline"); // modify table search input
            jQuery('#dt_wrapper .dataTables_length select').addClass("form-control input-small"); // modify table per page dropdown
        })
    }

    var handleBtnOnline = function() {
        $('#online').bind('click', function() {
            bootbox.confirm("Are you sure to take it online?", function(result) {
                alert("Confirm result: " + result);
            });
        });
    }

    var handleBtnUpgrade = function() {
        $('#upgrade').bind('click', function() {
            bootbox.confirm("Are you sure to upgrade it?", function(result) {
                alert("Confirm result: " + result);
            });
        });
    }

    var handleBtnDelete = function() {
        $('#delete').bind('click', function() {
            bootbox.confirm("Are you sure to delete it?", function(result) {
                alert("Confirm result: " + result);
            });
        });
    }

    var handleBtnOffline = function() {
        $('#offline').bind('click', function() {
            bootbox.confirm("Are you sure to take it offline?", function(result) {
                alert("Confirm result: " + result);
            });
        });
    }
    return {
        init: function() {
            handleEditable();
            handleBindCapability();
            handleBtnOffline();
            handleBtnDelete();
            handleBtnUpgrade();
            handleBtnOnline();
        }
    }
}()
