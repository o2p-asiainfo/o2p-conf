var PardOfferUpdate = function() {
	var productCurrIndex = 0;
	var offerCurrIndex = 0;
	var exclusionOfferCurrIndex = 0;
	 var handleProductModal = function() {
        //弹窗展现前从后台加载表格数据
        $('#productModal').on('show.bs.modal', function(e) {
            $('#productDt').dataTable({
                "processing": true,
                "serverSide": true,
                "ajax": contextPath+"/pardProduct/winList.shtml",
                "order": [],
                "autoWidth": false,
                "columnDefs": [{
                    "orderable": false,
                    "targets": 0,
                    "width": "36px"
                }/*, {
                	 "targets": 5,
                     "bVisible": false
                }, {
	               	 "targets": 6,
	                 "bVisible": false
	            }, {
	           	 "targets": 7,
	           	 "bSearchable": true,
	           	 "bVisible":true
	            }*/],
                "initComplete": function() {
                    App.ajaxInit();
                    /*$('#productModal tbody').find('input[type="checkbox"]:checked').each(function(i,objCk) {
                    	$('#productTB tr').each(function(j,objPTr) {
          	  				if(objPTr.id==objCk.id){
          	  					$(this).closest('tr').addClass('active');
          	  					return;
          	  				}
            		  	})
                    })*/
                }
            });
            jQuery('#productDt_wrapper .dataTables_filter input').addClass("form-control input-small input-inline"); // modify table search input
            jQuery('#productDt_wrapper .dataTables_length select').addClass("form-control input-small"); // modify table per page dropdown
        });
        
      //选择确认后，复制选择项到对应位置（modal上th的顺序，需要和目标位置上的TH对应，否则会错乱）
        $('.btn.theme-btn.productModal.ok').bind('click', function() {
              $("#productModal tbody tr input[type='checkbox']:checked").each(function(i,objCk) {
            	  	var objTr=$(this).closest('tr');
        		  	if(productCurrIndex==0){
      	  				$("#productTB tr").eq(0).remove();
      	  				addTr(objTr,objCk.id);
          	  		}else{
          	  			//查重
          	  			var _pass=true;
          	  			$('#productTB tr').each(function(j,objPTr) {
          	  				if(objPTr.id==objCk.id){
          	  					_pass=false;
          	  					return;
          	  				}
            		  	})
            		  	if(_pass){
      	  					addTr(objTr,objCk.id);
      	  				}
          	  		}
              });
        });
        var addTr=function(objTr,pId){
        	productCurrIndex++;
	  		var tr=[];
	  		tr.push("<td>"+productCurrIndex+"</td>");
	  		tr.push("<td>"+$(objTr).children('td').eq(1).html()+"</td>");
	  		tr.push("<td>"+$(objTr).children('td').eq(2).html()+"</td>");
	  		tr.push("<td>"+$(objTr).children('td').eq(3).html()+"</td>");
	  		tr.push("<td><input type='text' class='form-control input-medium' style='width:30px'/></td>");
	  		tr.push("<td><input type='text' class='form-control input-medium' style='width:30px'/></td>");
	  		tr.push('<td><a href="#" class="btn default btn-sm black btn-del"> <i class="fa fa-trash-o"></i> Delete </a></td>');
	  		var trStr="<tr id='"+pId+"'>"+tr.join("")+"</tr>";
    		$("#productTB").append(trStr);
        }
        $('#productTB').on('click', 'td .btn-del', function(e) {
            e.preventDefault();
            if (productCurrIndex >0) {
            	productCurrIndex--;
                $tbody = $(this).closest('tbody');
                $(this).closest('tr').remove();
                $tbody.find('tr>td:first-child').each(function(i) {
                    $(this).html(i + 1);
                })
            }
            if (productCurrIndex ==0) {
            	$("#productTB").append('<tr> <td colspan="7">None</td> </tr>');
            }
        })
	 }
	 var handleOfferModal = function() {
	        //弹窗展现前从后台加载表格数据
	        $('#offerModal').on('show.bs.modal', function(e) {
	            $('#offerDt').dataTable({
	                "processing": true,
	                "serverSide": true,
	                "ajax": contextPath+"/pardOffer/winList.shtml",
	                "order": [],
	                "autoWidth": false,
	                "columnDefs": [{
	                    "orderable": false,
	                    "targets": 0,
	                    "width": "36px"
	                }/*, {
	                	 "targets": 5,
	                     "bVisible": false
	                }, {
		               	 "targets": 6,
		                 "bVisible": false
		            }, {
		           	 "targets": 7,
		           	 "bSearchable": true,
		           	 "bVisible":true
		            }*/],
	                "initComplete": function() {
	                    App.ajaxInit();
	                    /*$('#offerModal tbody').find('input[type="checkbox"]:checked').each(function(i,objCk) {
	                    	$('#offerTB tr').each(function(j,objPTr) {
	          	  				if(objPTr.id==objCk.id){
	          	  					$(this).closest('tr').addClass('active');
	          	  					return;
	          	  				}
	            		  	})
	                    })*/
	                }
	            });
	            jQuery('#offerDt_wrapper .dataTables_filter input').addClass("form-control input-small input-inline"); // modify table search input
	            jQuery('#offerDt_wrapper .dataTables_length select').addClass("form-control input-small"); // modify table per page dropdown
	        });
	        
	      //选择确认后，复制选择项到对应位置（modal上th的顺序，需要和目标位置上的TH对应，否则会错乱）
	        $('.btn.theme-btn.offerModal.ok').bind('click', function() {
	              $("#offerModal tbody tr input[type='checkbox']:checked").each(function(i,objCk) {
	            	  	var objTr=$(this).closest('tr');
	        		  	if(offerCurrIndex==0){
	      	  				$("#offerTB tr").eq(0).remove();
	      	  				addTr(objTr,objCk.id);
	          	  		}else{
	          	  			//查重
	          	  			var _pass=true;
	          	  			$('#offerTB tr').each(function(j,objPTr) {
	          	  				if(objPTr.id==objCk.id){
	          	  					_pass=false;
	          	  					return;
	          	  				}
	            		  	})
	            		  	if(_pass){
	      	  					addTr(objTr,objCk.id);
	      	  				}
	          	  		}
	              });
	        });
	        var addTr=function(objTr,pId){
	        	offerCurrIndex++;
		  		var tr=[];
		  		tr.push("<td>"+offerCurrIndex+"</td>");
		  		//tr.push("<td>"+$(objTr).children('td').eq(1).html()+"</td>");
		  		tr.push("<td>"+$(objTr).children('td').eq(2).html()+"</td>");
		  		tr.push("<td>"+$(objTr).children('td').eq(3).html()+"</td>");
		  		tr.push("<td><input type='text' class='form-control input-medium' style='width:30px'/></td>");
		  		tr.push("<td><input type='text' class='form-control input-medium' style='width:30px'/></td>");
		  		tr.push('<td><a href="#" class="btn default btn-sm black btn-del"> <i class="fa fa-trash-o"></i> Delete </a></td>');
		  		var trStr="<tr id='"+pId+"'>"+tr.join("")+"</tr>";
	    		$("#offerTB").append(trStr);
	        }
	        $('#offerTB').on('click', 'td .btn-del', function(e) {
	            e.preventDefault();
	            if (offerCurrIndex >0) {
	            	offerCurrIndex--;
	                $tbody = $(this).closest('tbody');
	                $(this).closest('tr').remove();
	                $tbody.find('tr>td:first-child').each(function(i) {
	                    $(this).html(i + 1);
	                })
	            }
	            if (offerCurrIndex ==0) {
	            	$("#offerTB").append('<tr> <td colspan="7">None</td> </tr>');
	            }
	        })
		 }
	 var handleExclusionOfferModal = function() {
	        //弹窗展现前从后台加载表格数据
	        $('#exclusionOfferModal').on('show.bs.modal', function(e) {
	            $('#exclusionOfferDt').dataTable({
	                "processing": true,
	                "serverSide": true,
	                "ajax": contextPath+"/pardOffer/winList.shtml",
	                "order": [],
	                "autoWidth": false,
	                "columnDefs": [{
	                    "orderable": false,
	                    "targets": 0,
	                    "width": "36px"
	                }/*, {
	                	 "targets": 5,
	                     "bVisible": false
	                }, {
		               	 "targets": 6,
		                 "bVisible": false
		            }, {
		           	 "targets": 7,
		           	 "bSearchable": true,
		           	 "bVisible":true
		            }*/],
	                "initComplete": function() {
	                    App.ajaxInit();
	                    /*$('#exclusionOfferModal tbody').find('input[type="checkbox"]:checked').each(function(i,objCk) {
	                    	$('#exclusionOfferTB tr').each(function(j,objPTr) {
	          	  				if(objPTr.id==objCk.id){
	          	  					$(this).closest('tr').addClass('active');
	          	  					return;
	          	  				}
	            		  	})
	                    })*/
	                }
	            });
	            jQuery('#exclusionOfferDt_wrapper .dataTables_filter input').addClass("form-control input-small input-inline"); // modify table search input
	            jQuery('#exclusionOfferDt_wrapper .dataTables_length select').addClass("form-control input-small"); // modify table per page dropdown
	        });
	        
	      //选择确认后，复制选择项到对应位置（modal上th的顺序，需要和目标位置上的TH对应，否则会错乱）
	        $('.btn.theme-btn.exclusionOfferModal.ok').bind('click', function() {
	              $("#exclusionOfferModal tbody tr input[type='checkbox']:checked").each(function(i,objCk) {
	            	  	var objTr=$(this).closest('tr');
	        		  	if(exclusionOfferCurrIndex==0){
	      	  				$("#exclusionOfferTB tr").eq(0).remove();
	      	  				addTr(objTr,objCk.id);
	          	  		}else{
	          	  			//查重
	          	  			var _pass=true;
	          	  			$('#exclusionOfferTB tr').each(function(j,objPTr) {
	          	  				if(objPTr.id==objCk.id){
	          	  					_pass=false;
	          	  					return;
	          	  				}
	            		  	})
	            		  	if(_pass){
	      	  					addTr(objTr,objCk.id);
	      	  				}
	          	  		}
	              });
	        });
	        var addTr=function(objTr,pId){
	        	exclusionOfferCurrIndex++;
		  		var tr=[];
		  		tr.push("<td>"+exclusionOfferCurrIndex+"</td>");
		  		//tr.push("<td>"+$(objTr).children('td').eq(1).html()+"</td>");
		  		tr.push("<td>"+$(objTr).children('td').eq(2).html()+"</td>");
		  		tr.push("<td>"+$(objTr).children('td').eq(3).html()+"</td>");
		  		tr.push('<td><a href="#" class="btn default btn-sm black btn-del"> <i class="fa fa-trash-o"></i> Delete </a></td>');
		  		var trStr="<tr id='"+pId+"'>"+tr.join("")+"</tr>";
	    		$("#exclusionOfferTB").append(trStr);
	        }
	        $('#exclusionOfferTB').on('click', 'td .btn-del', function(e) {
	            e.preventDefault();
	            if (exclusionOfferCurrIndex >0) {
	            	exclusionOfferCurrIndex--;
	                $tbody = $(this).closest('tbody');
	                $(this).closest('tr').remove();
	                $tbody.find('tr>td:first-child').each(function(i) {
	                    $(this).html(i + 1);
	                })
	            }
	            if (exclusionOfferCurrIndex ==0) {
	            	$("#exclusionOfferTB").append('<tr> <td colspan="7">None</td> </tr>');
	            }
	        })
		 }
	 var handleDatePickers = function(selector, model) {
	        var options = {};
	        if (model == 'daily') {
	            options = {
	                autoclose: true,
	                minViewMode: 'year',
	                format: 'mm/dd/yyyy'
	            }
	        } else if (model == 'monthly') {
	            options = {
	                autoclose: true,
	                minViewMode: 'months',
	                format: 'mm/yyyy'
	            }
	        } else {
	            options = {
	                autoclose: true,
	                minViewMode: 'year',
	                format: 'mm/dd/yyyy'
	            }
	        }
	        if (jQuery().datepicker) {
	            $(selector).datepicker(options);
	        }
	    } 
	 var handleJstree = function(selector) {
		 $.ajax({
				async : false,
				type : "POST",
				url :  contextPath+"/pardOffer/getPardChanneTree.shtml",
				data : {
					idvalue:$("#offerChannelStr").val()
				},
				success : function(data) {
					if (data.code == "0000") {
						 $(selector).jstree({
				            'plugins': ["checkbox", "types"],
				            'core': {
				                'data': data.desc
				            },
				            "types": {
				                "default": {
				                    "icon": "fa fa-folder icon-warning icon-lg"
				                },
				                "file": {
				                    "icon": "fa fa-file icon-warning icon-lg"
				                }
				            }
				        });
						 $(selector).on('changed.jstree', function (e, data) {
							 var checkTextAry=[];
							 var checkIdAry=[];
							 for(i = 0, j = data.selected.length; i < j; i++) {
								 checkTextAry.push(data.instance.get_node(data.selected[i]).text);
								 checkIdAry.push(data.instance.get_node(data.selected[i]).id);
							 }
							 $("#jstreeText").val(checkTextAry.join(","));
							 $("#offerChannelStr").val(checkIdAry.join(","));
							 /*
							 var nodes=$(selector).jstree("get_checked"); //使用get_checked方法
				           	 $.each(nodes, function(i, n) { alert($(n).attr("id"));
				           		checkStr.push($(selector).jstree("get_json",n,"id")); 
				           	 });*/
						  });
					} else {
						alert(data.desc);
					}
				},
				dataType : "json",
	            error: function(xhr, textStatus, errorThrown) {
	            	//called when there is an error
	            }
			});
	        /*$(selector).jstree({
	        	 "plugins": ["themes", "json_data", "ui"],
	        	 'core': {
	        		    'data': {
	        		        'url': contextPath+"/pardOffer/getPardChanneTree.shtml",
	        		        'data': function(node) {
	        		            return {
	        		                'id': node.id,
	        		                'text': node.text
	        		            };
	        		        }
	        		    },
	        		}
	        });*/
	    };
	  //控制offset tyep 选择为offset时 显示输入框
	    var handleOffsetType = function(selector) {
	            var $offsetType = $(selector).find('.offsetType');
	            $(selector).on('change', '.offsetType', function() {
	                if ($offsetType.val() == 2) {
	                    $('.offset').show();
	                } else if ($offsetType.val() == 1) {
	                    $('.offset').hide();
	                }
	            })
	            if ($offsetType.val() == 2) {
	                $('.offset').show();
	            } else if ($offsetType.val() == 1) {
	                $('.offset').hide();
	            }
	        }
	        //控制 EFFECTIVE TIME 当单位选择为fixed expiry date时 input变为日期控件
	    var handleEffectiveTime = function(selector) {
	            var $unit = $(selector).find('.unit');
	            var $effectiveTime1 = $(selector).find('.effectiveTime1');
	            var $effectiveTime2 = $(selector).find('.effectiveTime2');

	            $(selector).on('change', '.unit', function() {
	                if ($unit.val() == 10) {
	                    $effectiveTime1.hide();
	                    $effectiveTime2.show();
	                } else {
	                    $effectiveTime1.show();
	                    $effectiveTime2.hide();
	                }
	            })
	            if ($unit.val() == 10) {
	                $effectiveTime1.hide();
	                $effectiveTime2.show();
	            } else {
	                $effectiveTime1.show();
	                $effectiveTime2.hide();
	            }
	        }
	        //控制 Charge Information中basic tariff面板内的charge表格的联动效果
	    var handleChargeTable = function(selector) {
	        $(selector).on('change', '.chargingUnit', function() {
	            var unit = $(this).find('option:selected').text();
	            $(selector + ' .unitArea').html(unit);
	        })
	        $(selector + ' input[name="chargingUnitValue"]').focusout(function() {
	            var chargingValue = $(this).val();
	            $(selector + ' .numArea').html(chargingValue);
	        })
	        $(selector).on('click', 'input[name="ChargeType"]', function() {
	            var chargeType = $(this).val();
	            if (chargeType == 1) {
	                $(selector + ' .simple').show();
	                $(selector + ' .ladder').hide();
	            } else if (chargeType == 2) {
	                $(selector + ' .simple').hide();
	                $(selector + ' .ladder').show();
	            }
	        })
	        $(selector).on('change', '.currency', function() {
	            var currency = $(this).find('option:selected').text();
	            $('.currencyArea').html(currency);
	        })

	        //初始化
	        $(selector + ' .unitArea').html($(selector + ' .chargingUnit').find('option:selected').text());
	        $(selector + ' .currencyArea').html($(selector + ' .currency').find('option:selected').text());
	        $(selector + ' .numArea').html($(selector + ' input[name="chargingUnitValue"]').val() ? $(selector + ' input[name="chargingUnitValue"]').val() : 1);
	        var chargeType = $(selector + ' input[name="ChargeType"]:checked').val();

	        if (chargeType == 1) {
	            $(selector + ' .simple').show();
	            $(selector + ' .ladder').hide();
	        } else if (chargeType == 2) {
	            $(selector + ' .simple').hide();
	            $(selector + ' .ladder').show();
	        }
	    }

	    /////////////////////////////////  

	    var addTabMenu = function(selector) {
	        var tpl = '<ul class="nav nav-tabs fix tabs-content-ajax"></ul> <div class="tab-content"></div>';

	        $(selector).on('click', 'a[data-action="addTabMenu"]', function() {
	                //防止多次添加模板
	                var addTpl = $(selector + ' .tabsArea').attr('data-addtpl');
	                if (addTpl == 'false') {
	                    $(selector + ' .tabsArea').html(tpl).attr('data-addtpl', 'true');
	                }
	                var $this = $(this);
	                var target = $this.data('target');
	                var type = $this.data('type');
	                var draw = $this.attr('data-draw'); //数字表示重复添加的次数，如果是undefined表示不允许重复添加同一个
	                var title = $this.text();
	                var url = $this.data('url');
	                var datakey = $this.attr('data-key');
	                var container = $this.data('container');
	                var $container = $(selector + ' ' + container);
	                //有设置改属性的，表明只能添加一次
	                if ($this.attr('data-unique') == 'true' && draw == '1') {
	                    toastr.error("这个属性已经添加过了");
	                    return
	                }
	                //添加一个tabMenu
	                $container.find('.nav li').removeClass('active');
	                //创建一个a标签,先判断是否允许重复添加 
	                if (draw != undefined) {
	                    target = target + '_' + draw;
	                    draw = parseInt(draw) + 1;
	                    $this.attr({
	                        'data-draw': draw
	                    });
	                }
	                var a = $('<a data-toggle="tab">').attr({
	                    'data-url': url,
	                    'data-key': datakey,
	                    'href': target
	                }).html(title);
	                var li = $('<li class="active">').append(a); //创建一个li标签
	                li.append('<input type="checkbox" value="' + target + '" name="select">');
	                //根据data-url上的值加载html
	                a.one('click', function(event) {
	                    var $this = $(this);
	                    var requestURL = $(this).data('url');
	                    if (!requestURL) {
	                        return
	                    }
	                    var id = $(this).attr('href');
	                    $(id).load(requestURL, function() {
	                        //针对basic tariff                    
	                        if (type == 1) {
	                            handleJstree(id + ' .jstree');
	                            handleChargeTable(id);
	                            handleDatePickers(id + ' .date-picker');
	                        }
	                        App.ajaxInit();
	                    })
	                });
	                $container.find('.nav').append(li);
	                //添加一个tab-content
	                $container.find('.tab-pane').removeClass('active');
	                var div = $('<div class="tab-pane active">').attr('id', target.substring(1)).html('<img src="resources/img/input-spinner.gif" alt="">')
	                $container.find('.tab-content').append(div);
	                a.click();
	            })
	            //控制选择按钮
	        $(selector).on('click', '.btn-select', function() {
	                var $this = $(this);
	                $this.closest('.portlet').find('.nav-tabs').toggleClass('select');
	            })
	            //控制删除按钮
	        $(selector).on('click', '.btn-delete', function() {
	            var $this = $(this);
	            var $selected = $this.closest('.portlet').find('.nav-tabs input[type="checkbox"]:checked');
	            var selected = $selected.size();
	            var total = $this.closest('.portlet').find('.nav-tabs input').size();

	            if (total == selected && selected != 0) {
	                $this.closest('.portlet').find('.portlet-body').html('<div class="well">您还未填写Charge Information,请点击右上方的添加按钮</div>');
	                $this.closest('.dropdown').find('.dropdown-menu li a').each(function() {
	                    $(this).attr('data-draw', '0');
	                })
	                $this.closest('.portlet').children('.portlet-body').attr('data-addtpl', 'false');
	            } else if (selected != 0) {
	                $selected.each(function() {
	                    var $$this = $(this);
	                    var target = $$this.val();
	                    var length = target.length;
	                    var index = target.charAt(length - 3);
	                    var $a = $this.closest('.dropdown').find('.dropdown-menu li').eq(index).children('a');
	                    $a.attr('data-draw', parseInt($a.attr('data-draw')) - 1);
	                    $(target).remove();
	                    $$this.closest('li').remove();
	                });
	                $this.closest('.portlet').find('.nav-tabs li:first a').click();
	            }

	        })

	    }
	 var onSubmit=function(){
    	
		 //submit_form.action=contextPath+"/pardOffer/add.shtml";
		 //submit_form.method="post"; 
		 //submit_form.submit();
		 $.ajax({
			async : false,
			type : "POST",
			url :  contextPath+"/pardOffer/update.shtml",
			data : $('#submit_form').serialize(),
			beforeSend:function(){
				
			},success : function(data) {
				if (data.code == "0000") {
					var offerId=data.desc;	  
					
				} else {
					alert(data.desc);
				}
			},
			dataType : "json",
            error: function(xhr, textStatus, errorThrown) {
            	//called when there is an error
            }
		});
	 };
    return {
        //main function to initiate the module
        init: function() {
        	if (!jQuery().bootstrapWizard) {
                return;
            }
        	$('#detailLink').on('click', function() {
        		showProdForm.action=contextPath+"/pardOffer/toDetail.shtml";
        		showProdForm.submit();
            })
        	var form = $('#submit_form');
            var error = $('.alert-danger', form);
            var success = $('.alert-success', form);
            form.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-block', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                rules: {
                	"prodOffer.prodOfferName": {
                        required: true,
                        minlength: 4
                    },
                    "prodOffer.extProdOfferId": {
                        required: true,
                    },
                    "prodOffer.formatEffDate": {
                        required: true,
                    },
                    "prodOffer.formatExpDate": {
                        required: true,
                    }
                },
                messages: {
                	"prodOffer.prodOfferName": {
                        required: "Username is required.",
                        minlength: jQuery.format("Please select  at least {0} types of Channel")
                    },
                    "prodOffer.formatEffDate": {
                        required: "Start time is required."
                    },
                    "prodOffer.formatExpDate": {
                        required: "End time is required."
                    }
                },
                invalidHandler: function(event, validator) { //display error alert on form submit                       
                    App.scrollTop();
                },

                highlight: function(element) { // hightlight error inputs
                    $(element).closest('.form-group').addClass('has-error'); // set error class to the control group 
                },

                success: function(label) {
                    label.closest('.form-group').removeClass('has-error');
                    label.remove();
                },
                errorPlacement: function(error, element) {
                    // error.insertAfter(element.closest('.input-icon'));
                    if (element.parents('.input-group').size() > 0) {
                        error.appendTo(element.parents('.input-group').attr("data-error-container"));
                    } else if (element.parents('.checkbox-list').size() > 0) {
                        error.appendTo(element.parents('.checkbox-list').attr("data-error-container"));
                    } else {
                        error.insertAfter(element); // for other inputs, just perform default behavior
                    }
                },
                submitHandler: function(form) {
                    Fun(); // form validation success, call ajax form submit
                }
            });

            var handleTitle = function(tab, navigation, index) {
                var total = navigation.find('li').length;
                var current = index + 1;
                // set wizard title
                $('.step-title').text('Step ' + (index + 1) + ' of ' + total);
                // set done steps
                jQuery('li', $('#submit_form')).removeClass("done");
                var li_list = navigation.find('li');
                for (var i = 0; i < index; i++) {
                    jQuery(li_list[i]).addClass("done");
                }

                if (current == 1) {
                    $('#submit_form').find('.button-previous').hide();
                } else {
                    $('#submit_form').find('.button-previous').show();
                }

                if (current >= total) {
                    $('#submit_form').find('.button-next').hide();
                    $('#submit_form').find('.button-submit').show();
                    //displayConfirm();
                } else {
                    $('#submit_form').find('.button-next').show();
                    $('#submit_form').find('.button-submit').hide();
                }
                App.scrollTo($('.page-title'));
            }

            // default form wizard
            $('#submit_form').bootstrapWizard({
                'nextSelector': '.button-next',
                'previousSelector': '.button-previous',
                onTabClick: function(tab, navigation, index, clickedIndex) {
                    success.hide();
                    error.hide();
                    if (form.valid() == false) {
                        return false;
                    }
                    handleTitle(tab, navigation, clickedIndex);
                },
                onNext: function(tab, navigation, index) {
                    success.hide();
                    error.hide();

                    if (form.valid() == false) {
                        return false;
                    }
                    onSubmit();
                   // handleTitle(tab, navigation, index);
                },
                onPrevious: function(tab, navigation, index) {
                    success.hide();
                    error.hide();

                    handleTitle(tab, navigation, index);
                },
                onTabShow: function(tab, navigation, index) {
                    var total = navigation.find('li').length;
                    var current = index + 1;
                    var $percent = (current / total) * 100;
                    $('#submit_form').find('.progress-bar').css({
                        width: $percent + '%'
                    });
                    if (index == 1 && tab.attr('data-visit') == 'false') { //step2
                        var tpl = '<ul class="nav nav-tabs "> </ul> <div class="tab-content tab2-content "> </div>';

                        $('#tab2_addTab').bind('click', function() {
                            var $this = $(this);
                            var addTpl = $this.attr('data-addtpl');
                            if (addTpl == 'false') {
                                $('.createArea').html(tpl);
                                $this.attr('data-addtpl', 'true');
                            }
                            var target = $this.data('target');
                            var draw = $this.attr('data-draw'); //数字表示重复添加的次数，如果是undefined表示不允许重复添加同一个           
                            var url = $this.data('url');
                            var container = $this.data('container');

                            $(target).find('.createArea .nav li').removeClass('active');
                            target = target + '_' + draw;
                            var a = $('<a data-toggle="tab">').attr({
                                'data-url': url,
                                'href': target
                            }).html('Form' + (parseInt(draw) + 1));
                            var li = $('<li class="active">').append(a); //创建一个li标签 
                            li.append('<input type="checkbox" value="' + target + '" name="select">');
                            //根据data-url上的值加载html
                            a.one('click', function(event) {
                                var $this = $(this);
                                var requestURL = $(this).data('url');
                                if (!requestURL) {
                                    return
                                }
                                var id = $(this).attr('href');
                                $(id).load(requestURL, function() { //加载完配置单后 执行的渲染动作
                                    handleJstree(id + ' .jstree');
                                    addTabMenu(id);
                                    handleOffsetType(id) //控制offset type显示和隐藏
                                    handleEffectiveTime(id);
                                    App.ajaxInit();
                                    handleDatePickers(id + ' .date-picker');
                                    $(id + ' ul[data-set="addTarget"]').find('a').each(function(index) {
                                        $(this).attr('data-target', id + '_' + index);
                                    })
                                })
                            });

                            $this.closest('.tab-pane').find('.createArea .nav').append(li);
                            //添加一个tab-content
                            $(container + '>.tab-pane').removeClass('active');
                            var div = $('<div class="tab-pane active">').attr('id', target.substring(1)).html('<img src="resources/img/input-spinner.gif" alt="">')
                            $(container).append(div);
                            a.click();

                            draw = parseInt(draw) + 1;
                            $this.attr({
                                'data-draw': draw
                            });
                        });
                        //step2 控制选择按钮
                        $('#tab2-tools').on('click', '.btn-select', function() {
                                $('#tab2 .createArea').children('.nav-tabs').toggleClass('select');
                            })
                            //step2 控制删除按钮
                        $('#tab2-tools').on('click', '.btn-delete', function() {
                            var $this = $(this);
                            var $selected = $('#tab2 .createArea').children('.nav-tabs').find('input[type="checkbox"]:checked');
                            var selected = $selected.size();
                            var total = $('#tab2 .createArea').children('.nav-tabs').find('input').size();
                            if (selected != 0 && selected == total) {
                                $('#tab2 .createArea').html('<div class="well">您还未填写Charge Information,请点击右上方的添加按钮</div>');
                                $('#tab2-tools .btn-add').attr({
                                    'data-addtpl': 'false',
                                    'data-draw': '0'
                                });

                            } else if (selected != 0) {
                                $selected.each(function() {
                                    var $$this = $(this);
                                    var target = $$this.val();
                                    var $a = $('#tab2-tools').find('.btn-add');
                                    $a.attr('data-draw', parseInt($a.attr('data-draw')) - 1);

                                    $(target).remove();
                                    $$this.closest('li').remove();
                                });
                                $('#tab2 .createArea').children('.nav-tabs').find('li:first a').click();
                            }

                        })
                    } else if (index == 2 && tab.attr('data-visit') == 'false') { //step3
                        //控制copy 显示
                        $('body').on('click', 'input[name="type"]', function() {
                            var type = $(this).val();
                            if (type == 1) {
                                $('#settlementRule').addClass('display-none');
                            } else if (type == 2) {
                                $('#settlementRule').removeClass('display-none');
                            }
                        })
                        var type = $('input[name="type"]:checked').val(); //选择的模板类型                        
                        if (type == 1) {
                            $('#settlementRule').addClass('display-none');
                        } else if (type == 2) {
                            $('#settlementRule').removeClass('display-none');

                        }
                        //
                        var tpl = '<ul class="nav nav-tabs "></ul><div class="tab-content tab3-content"></div>';
                        $('#addSettlement').bind('click', function() {
                            var $this = $(this);
                            var addTpl = $this.attr('data-addtpl');
                            var type = $('input[name="type"]:checked').val();
                            var obj = $('[name="settlementObject"] option:selected').val(); //选择的对象   
                            var rule = $('#settlementRule option:selected').val(); //选择的对象   
                            var valid = false;
                            //添加模板                         
                            if (addTpl == 'false' && type == 1 && obj != '') {
                                $('.createArea2').html(tpl);
                                $this.attr('data-addtpl', 'true');
                                addTpl = 'true';
                            } else if (addTpl == 'false' && type == 2 && obj != '' && rule != '') {
                                $('.createArea2').html(tpl);
                                $this.attr('data-addtpl', 'true');
                                addTpl = 'true'
                            }
                            if (type == 1 && obj != '') {
                                valid = true;
                            } else if (type == 2 && obj != '' && rule != '') {
                                valid = true;
                            } else {
                                toastr.error("请选择正确的属性");
                            }
                            //模板创建完毕
                            if (addTpl == 'true' && valid == true) {
                                var target = $this.data('target');
                                var draw = $this.attr('data-draw'); //数字表示重复添加的次数，如果是undefined表示不允许重复添加同一个
                                var url;
                                switch (type) {
                                    case 1:
                                        url = contextPath+'/pardOfferSettlement/toSettlement.shtml?actionType=add';
                                        break;
                                    default:
                                        url = contextPath+'/pardOfferSettlement/toSettlement.shtml?actionType=add';
                                        break;
                                }
                                var container = $this.data('container');
                                var $container = $(container);

                                $('.createArea2 > .nav').find('li').removeClass('active');
                                target = target + '_' + draw;
                                var a = $('<a data-toggle="tab">').attr({
                                    'data-url': url,
                                    'href': target
                                }).html('Form' + (parseInt(draw) + 1));
                                var li = $('<li class="active">').append(a); //创建一个li标签 
                                li.append('<input type="checkbox" value="' + target + '" name="select">');
                                //根据data-url上的值加载html
                                a.one('click', function(event) {
                                    var $this = $(this);
                                    var requestURL = $(this).data('url');
                                    if (!requestURL) {
                                        return
                                    }
                                    var id = $(this).attr('href');
                                    $(id).load(requestURL+"&formNum="+(parseInt(draw) + 1), function() { //加载完配置单后 执行的渲染动作                                        
                                        addTabMenu(id);
                                        handleDatePickers(id + ' .date-picker');
                                        App.ajaxInit();
                                        //分配 dropdown-menu里面data-target的值
                                        $(id + ' ul[data-set="addTarget"]').find('a').each(function(index) {
                                            $(this).attr('data-target', id + '_' + index);
                                        })
                                    })
                                });

                                $('.createArea2 > .nav').append(li);
                                //添加一个tab-content
                                $(container + '>.tab-pane').removeClass('active');
                                var div = $('<div class="tab-pane active">').attr('id', target.substring(1)).html('<img src="resources/img/input-spinner.gif" alt="">')
                                $(container).append(div);
                                a.click();

                                draw = parseInt(draw) + 1;
                                $this.attr({
                                    'data-draw': draw
                                });
                            }
                        })
                        //step3 控制选择按钮
                        $('#tab3-tools').on('click', '.btn-select', function() {
                                $('#tab3 .createArea2').children('.nav-tabs').toggleClass('select');
                            })
                        //step3 控制删除按钮
                        $('#tab3-tools').on('click', '.btn-delete', function() {
                            var $this = $(this);
                            var $selected = $('#tab3 .createArea2').children('.nav-tabs').find('input[type="checkbox"]:checked');
                            var selected = $selected.size();
                            var total = $('#tab3 .createArea2').children('.nav-tabs').find('input').size();                            
                           if(selected !=0 && selected == total){
                            $('#tab3 .createArea2').html('<div class="well">您还未填写Charge Information,请点击右上方的添加按钮</div>');
                            $('#tab3-tools .btn-add').attr({'data-addtpl':'false','data-draw':'0'});
                            
                           }
                           else if (selected != 0) {
                                $selected.each(function() {
                                    var $$this = $(this);
                                    var target = $$this.val();                                    
                                    var $a = $('#tab2-tools').find('.btn-add');
                                    $a.attr('data-draw', parseInt($a.attr('data-draw')) - 1);
                                    
                                    $(target).remove();
                                    $$this.closest('li').remove();
                                });
                                $('#tab3 .createArea2').children('.nav-tabs').find('li:first a').click();
                            }

                        })
                    }
                    tab.attr('data-visit', true);
                }
            });
            $('#submit_form').find('.button-previous').hide();
            $('#submit_form .button-submit').click(function() {
            	//alert($('#submit_form').serialize());
            	var size=$('#addSettlement').attr('data-draw');
            	for(var i=0;i<size;i++){
            		var id='#tab3_'+i;
            		$(id).find(".portlet").find('.nav-tabs').find('li a').each(function(){
            			alert($(this).attr("data-key"));
            		})
            	}
            	//$("a[name='addSettlementRule']").each(function(i,n){
            	//	alert($(this).innerHTML)
            	//})
            }).hide();
            //$('#submit_form .button-next').click(function() {
            	
            //});
        	handleProductModal();
        	handleOfferModal();
        	handleExclusionOfferModal();
        	handleDatePickers('#tab1 .date-picker');
        	handleJstree('#tab1 .jstree');
        }
    };
}();

