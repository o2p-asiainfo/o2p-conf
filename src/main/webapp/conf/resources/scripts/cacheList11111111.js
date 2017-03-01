var cacheList = function() {
    var oTable,
        $searchBtn, // button()副本   
        form;
    var handleSelect2 = function() {
        $(".select2").select2({
            placeholder: App.i18n('CNF00000027'),
        })
    };
	//增加缓存
	var cacheAdd = function() {
		$("#cacheListpage").html("").load("cacheObjList.jsp",function(){setInstall.init(""); });
		};
	//删除缓存
	var cacheDel = function() {
		var keyarray=[];
		$("#dt tbody tr").has(":checked").each(function(index, element) {
            keyarray.push($(this).find(":checked").attr("id"));
			$(this).remove();
        });
		$.ajax({
            url: App.urls.cacheDelById,
            data: keyarray,
            type: "post",
            success: function(backdata) {
                if (backdata == 200) {
                    oTable.api().ajax.reload();
                    $('#dt_processing').hide();
                    //toastr.success('删除成功');
                } else if (backdata == 500) {
                   toastr.error('删除失败');
                }
            },
            error: function(error) {
                toastr.error('删除失败');
            }
        });
		};
	//修改缓存
	var cacheEdit = function() {
		var id=$("#dt tbody tr").find(":checked").attr("id")
		$("#cacheListpage").html("").load("cacheObjList.jsp",function(){setInstall.init(id); });
		};
    //校验搜索栏的表单
	
    var validForm = function() {
        form = $('#searchBarForm');
        /*
         *自定义校验规则
         *parma: method name,function,messages
         *调用方法 放在rules里面，类似required:true( domain:'#username'),#username为对象ID
         */
        //可以不填，但是填了必须2个都填
        jQuery.validator.addMethod("dateRange", function(value, element, params) {
            var startTime = $('#startTime').val(),
                endTime = $('#endTime').val();
            if (startTime == '' && endTime != '' || startTime != '' && endTime == "") {
                return false
            } else {
                return true
            }
        }, App.i18n('CNF00000025'));
        jQuery.validator.addMethod("invalidString", function(value, element) {
            return value == '' || !/[`~!@#\$%\^\&\*\(\)_\+<>\?:"\{\},\.\\\/;'\[\]]/im.test(value);
        }, App.i18n('CNF00000026'));
        form.validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            rules: {
                offerName: {
                    invalidString: 'offerName'
                },
                startTime: {
                    dateRange: '#startTime'
                },
                endTime: {
                    dateRange: '#endTime'
                },
            },
            messages: {},
            invalidHandler: function(event, validator) { //display error alert on form submit   
                // $('.alert-danger', $('.login-form')).show();
            },
            highlight: function(element) { // hightlight error inputs
                $(element).closest('.form-group').addClass('has-error'); // set error class to the control group
            },
            success: function(label) {
                label.closest('.form-group').removeClass('has-error');
                label.remove();
            },
            // http://jqueryvalidation.org/validate/#groups
            groups: {
                dateRange: "startTime endTime"
            },
            errorPlacement: function(error, element) {
                if (element.attr("name") == "startTime" || element.attr("name") == "endTime") {
                    error.appendTo("#error-container");
                } else {
                    error.appendTo(element.closest('.form-group'));
                }
            },
            submitHandler: function(form) {
                // form.submit(); // form validation success, call ajax form submit
            },
        });
    };
    var queryOffer = function(event) {
        //表单格式校验
        //if (!form.valid()) {
            //return
        //}
        //$searchBtn = $(this).button('loading');
        //校验通过，根据seach按钮上的init属性判定是否初始化过datatable
        if (!$.fn.DataTable.isDataTable('#dt')) {
            oTable = $('#dt').dataTable({
                //"processing": true,
                //serverSide": true,
                "ajax": {
                   "url": App.urls.cacheList,
                   "data":$("#CacheStrategyName").val(),
                   "dataSrc": function(data) {
                        if (!App.checker(data.health)) {
                            return []
                        } else {
                            return data.data;
                        }
                    },
                    "type": "GET"
                },
                "searching": false,
                "pagingType": "bootstrap_full_number",
                //"lengthChange": false,
                "ordering": false,
                //"autoWidth": true,
                "columns": [{
                    "data": "ID"
                },{
                    "data": "NAME"
                }, {
                    "data": "CACHE_TYPE"
                }, {
                    "data": "FORCE_REFRESH"
                }, {
                    "data": "EXPIRE_TIME"
                }],
                "columnDefs": [{
                    "targets": 0,
                    render: function(data, type, full, meta) {
                        var html = '<input type="checkbox" id="'+data+'"></input>';
                        return html;
                    }
                }],
                "drawCallback": function() {
                    App.initUniform();
                    App.handlePopover();
                }
            });
        } else {
            oTable.api().ajax.reload();
        }
    };
    /**
     * 绑定在checkbox上,记录checkbox的值
     * 以name:[value1,value2]形式保存在body上，name为checkbox的name
     * 一组table里面的所有checkbox的name必须一致，包括全选按钮的name
     * @return {[type]} [description]
     */
    var recorder = function() {
        var $this = $(this), //当前点击的checkbox
            name = $this.prop('name'),
            $$this,
            arr = $('body').data(name) || [],
            _saveVal = function($this) {
                if (_.indexOf(arr, $this.val()) == -1) {
                    arr.push(parseInt($this.val()));
                    $('body').data(name, arr);
                }
            },
            _delVal = function($this) {
                if (_.indexOf(arr, $this.val()) > -1) {
                    _.remove(arr, parseInt($this.val()));
                    $('body').data(name, arr);
                }
            };
        if (!$this.hasClass('group-checkable')) { //不是点全选按钮               
            $this.is(':checked') ? _saveVal($this) : _delVal($this);
        } else { //点的是全选按钮
            if ($this.is(':checked')) {
                console.log('全选');
                $this.closest('table').find('tbody input[type="checkbox"]:enabled').each(function(index, el) {
                    $$this = $(this);
                    _saveVal($$this);
                })
            } else {
                console.log('全取消');
                $this.closest('table').find('tbody input[type="checkbox"]:enabled').each(function(index, el) {
                    $$this = $(this);
                    _delVal($$this)
                })
            }
        }
        console.log(name + ': ' + $('body').data(name))
    };
    var doSync = function() {
        if ($('.multiple-select-box .select').size() <= 0) {
            toastr.error(App.i18n('CNF00000017')); //Select at least one!
            return
        }
        var $btn = $(this).button('loading');
        var arr = [];
        $('.multiple-select-box').find('a.select').each(function(index, el) {
            arr[index] = $(el).attr('sdata');
        });
        $.ajax({
            url: App.urls.sync,
            type: 'post',
            data: {
                offerId: $('body').data('productOfferId').join(','),
                localId: arr.join(','),
                objType: 'OFFER'
            },
            success: function(data) {
                $btn.button('reset');
                var data = jQuery.parseJSON(data);
                if (!App.checker(data.health)) {
                    return
                }
                if (parseInt(data.data.code) == 1) {
                    toastr.success(App.i18n('CNF00000008'));
                    $('body').data('product', []);
                    $('.modal').modal('hide');
                    oTable.api().ajax.reload();
                } else if (parseInt(data.data.code) == 2) {
                    toastr.success(data.data.message);
                    $('body').data('product', []);
                    $('.modal').modal('hide');
                    oTable.api().ajax.reload();
                } else {
                    toastr.error(data.data.message);
                };
            }
        })
    };
    return {
        init: function() {
            $('body').on('click', '#search', queryOffer);
            queryOffer();
			$("#btn-add").bind("click",function(){
				cacheAdd();
				})
			$("#btn-edit").bind("click",function(){
				cacheEdit();
				})
			$("#btn-del").bind("click",function(){
				cacheDel();
				})
            //每次datatable 完成ajax请求时的回调函数定义
            /*$('#dt').on('xhr.dt', function(e, settings, processing) {
                $searchBtn.button('reset');
            });
            $('body').on('change', '#dt input[type="checkbox"]', recorder);*/
        }
    }
}()
