var SyncProduct = function() {
    var oTable,
        $searchBtn, // button()副本   
        form;
    var handleDatePickers = function() {
        if (jQuery().datepicker) {
            $('.date-picker').datepicker({
                autoclose: true
            });
            $('body').removeClass("modal-open"); // fix bug when inline picker is used in modal
        }
    }
    var handleSelect2 = function() {
        $(".select2").select2({
            placeholder: App.i18n('CNF00000027'),
        });
    }
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
                productName: {
                    invalidString: 'productName'
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
    }
    var queryProduct = function(event) {
        if (!form.valid()) {
            return
        }
        $searchBtn = $(this).button('loading');
        //校验通过，根据seach按钮上的init属性判定是否初始化过datatable
        if (!$.fn.DataTable.isDataTable('#dt')) {
            oTable = $('#dt').dataTable({
                "processing": true,
                "ajax": {
                    "url": App.urls.product,
                    "data": function(d) {
                        return $('#searchBarForm').serialize();
                    },
                    "dataSrc": function(data) {
                        if (!App.checker(data.health)) {
                            return []
                        } else {
                            return data.data;
                        }
                    },
                    "type": "POST"
                },
                "searching": false,
                "pagingType": "bootstrap_full_number",
                "lengthChange": false,
                "ordering": false,
                "autoWidth": false,
                "columns": [{
                    "orderable": false,
                    "data": null
                }, {
                    "data": "orgName"
                }, {
                    "data": "productName"
                }, {
                    "data": "productCode"
                }, {
                    "data": "systemName"
                }, {
                    "data": "createTime"
                }, {
                    "data": "platformSuccess"
                }, {
                    "data": "platformFail"
                }],
                "columnDefs": [{
                    "width": "36px",
                    "targets": 0,
                    render: function(data, type, full, meta) {
                        var html = '<input type="checkbox" value="' + full.productId + '" class="checkboxes" name="productId"/>';
                        return html;
                    }
                }, {
                    "targets": 2,
                    render: function(data, type, full, meta) {
                        var html = '<a onclick="App.modal({width:\'container\',remote:App.urls.productDetail,data:\'' + full.productId + '\'})" href="javascript:;">' + full.productName + '</a>';
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
                productId: $('body').data('productId').join(','),
                localId: arr.join(','),
                objType: 'PRODUCT'
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
    }
    return {
        init: function() {
            handleDatePickers();
            validForm();
            //加载system list
            App.template(App.urls.systemList, 'tmpl-system-list', 'system-list', handleSelect2);
            $('body').on('click', '#search', queryProduct);
            queryProduct();
            //每次datatable 完成ajax请求时的回调函数定义
            $('#dt').on('xhr.dt', function(e, settings, processing) {
                $searchBtn.button('reset');
            });
            $('body').on('change', '#dt input[type="checkbox"]', recorder);
            $('#btn-select-platform').bind('click', function() {
                var name = $('#dt .group-checkable').attr('name'),
                    data = $('body').data(name);
                if (data == undefined || data.length == 0) {
                    toastr.error(App.i18n('CNF00000017')); //Select at least one!
                } else if (data.length > 0) {
                    App.modal({
                        width: 'w700',
                        remote: App.urls.platformList
                    })
                }
            });
            $('body').on('click', '#btn-start-sync', doSync);
        }
    }
}()
