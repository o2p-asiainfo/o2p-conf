var Main = function() {
    var setModalSize = function() {
        $('.modal-body').css({
            'width': $(window).width() * 0.9 - 2,
            'height': $(window).height() - 120
        });
    }

    var handleTaskLists = function() {
        var url = $(this).attr("data-url");
        //$(this).closest('.portlet').find('.portlet-body').html('<table class="table table-striped table-bordered table-hover" id="taskListsDataTable"><thead><tr><th>'+taskListTitle[0]+'</th><th>'+taskListTitle[1]+'</th><th>'+taskListTitle[2]+'</th> <th>'+taskListTitle[3]+'</th><th>'+taskListTitle[4]+'</th></tr></thead></table>');
        $(this).closest('.portlet').find('.portlet-body').html('<table class="table table-striped table-bordered table-hover" id="taskListsDataTable"><thead><tr><th>'+taskListTitle[1]+'</th><th>'+taskListTitle[2]+'</th><th style="text-align:center;">'+taskListTitle[4]+'</th></tr></thead></table>');
        if (!jQuery().dataTable) {
            return;
        }
        $('#taskListsDataTable').dataTable({
            "processing": true,
            "serverSide": true,
            "lengthMenu": [5, 10, 15],
            "ordering":false,
            "pagingType": "bootstrap_full_number",
            "ajax": {
            	"url": url,
            	"type":"POST"
            }
        });
        jQuery('#taskListsDataTable_wrapper .dataTables_filter input').addClass("form-control input-small input-inline"); // modify table search input
        jQuery('#taskListsDataTable_wrapper .dataTables_length select').addClass("form-control input-xsmall"); // modify table per page dropdown 

        jQuery('#taskListsDataTable_paginate .pagination').css("padding","0px");
        jQuery('#taskListsDataTable_paginate .pagination').css("margin","0px");
        jQuery('#taskListsDataTable_info').css("top","5px");
        
        //handle fullscreen view
        $('#cloneDataTable').bind('click', function() {
            //$('#myModal .modal-body').html('<table class="table table-striped table-bordered table-hover" id="dataTableClone"><thead><tr><th>'+taskListTitle[0]+'</th><th>'+taskListTitle[1]+'</th><th>'+taskListTitle[2]+'</th><th>'+taskListTitle[3]+'</th><th>'+taskListTitle[4]+'</th></tr></thead></table>');
            $('#myModal .modal-body').html('<table class="table table-striped table-bordered table-hover" id="dataTableClone"><thead><tr><th>'+taskListTitle[1]+'</th><th>'+taskListTitle[2]+'</th><th style="text-align:center;">'+taskListTitle[4]+'</th></tr></thead></table>');
            setModalSize();
            if (!jQuery().dataTable) {
                return;
            }
            $('#dataTableClone').dataTable({
                "processing": true,
                "serverSide": true,
                "lengthMenu": [5, 10, 15],
                "ajax": {
                	"url": url,
                	"type":"POST"
                }
            });
            jQuery('#dataTableClone_wrapper .dataTables_filter input').addClass("form-control input-small input-inline"); // modify table search input
            jQuery('#dataTableClone_wrapper .dataTables_length select').addClass("form-control input-xsmall"); // modify table per page dropdown  
        });
    }

    var handleGaugeChart = function() {
        var el = jQuery(this).closest(".portlet").children(".portlet-body");
        var url = jQuery(this).attr("data-url");
        var target = jQuery(this).attr('data-target');
        App.blockUI({
            target: el,
            iconOnly: true
        });
        $.ajax({
            type: 'Get',
            cache: false,
            url: url,
            success: function(response, status, xhr) {
                App.unblockUI(el);
                var obj = eval('(' + response + ')');
                try {
                    if (obj.status == 0) {

                        require.config({
                            paths: {
                                'echarts': 'resource/plugins/echarts/echarts',
                                'echarts/chart/gauge': 'resource/plugins/echarts/echarts'
                            }
                        });

                        require(
                            [
                                'echarts',
                                'echarts/chart/gauge'
                            ],
                            function(ec) {

                                var chart = ec;
                                var myChart = ec.init(document.getElementById(target));

                                var labelBottom = {
                                    normal: {
                                        label: {
                                            show: false,
                                            position: 'bottom',
                                            textStyle: {
                                                baseline: 'bottom'
                                            }
                                        },
                                        labelLine: {
                                            show: false
                                        }
                                    }
                                };

                                var option = {
                                    tooltip: {
                                        formatter: "{a} <br/>{c} ms"
                                    },
                                    toolbox: {
                                        show: false
                                    },
                                    series: [{
                                        name: 'Total Performance',	//整体平均性	
                                        type: 'gauge',
                                        center: ['50%', '60%'], // 默认全局居中
                                        min: 0,
                                        max: 30,			//最大刻度值
                                        splitNumber: 15,
                                        axisLine: { // 坐标轴线
                                            lineStyle: { // 属性lineStyle控制线条样式
                                            color: [			//min: 0~60, orange:60~120, red:120~300
                                                    [0.2, '#228b22'],
                                                    [0.4, '#48b'],
                                                    [1, '#ff4500']
                                                ],
                                                width: 10
                                            }
                                        },
                                        axisTick: { // 坐标轴小标记
                                            length: 15, // 属性length控制线长
                                            lineStyle: { // 属性lineStyle控制线条样式
                                                color: 'auto'
                                            }
                                        },
                                        splitLine: { // 分隔线
                                            length: 20, // 属性length控制线长
                                            lineStyle: { // 属性lineStyle（详见lineStyle）控制线条样式
                                                color: 'auto'
                                            }
                                        },
                                        title: {
                                            textStyle: { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                                                fontWeight: 'bolder',
                                                fontSize: 20,
                                                fontStyle: 'italic'
                                            },
                                            offsetCenter: [0, '-125%'] // x, y，单位px
                                        },
                                        detail: {
                                            textStyle: { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                                                fontWeight: 'bolder'
                                            },
                                            formatter: '{value}s'
                                        },
                                        data: [{
                                            value: obj.data.gauge2.value,
                                            name: obj.data.gauge2.name
                                        }]
                                    }, {
                                        name: 'SP Performance',		//服务提供方平均性能
                                        type: 'gauge',
                                        center: ['15%', '65%'], // 默认全局居中
                                        radius: '50%',
                                        min: 0,
                                        max: 30,				//min: 0~3, orange:3~6, red:6~15
                                        endAngle: 45,
                                        splitNumber: 15,
                                        axisLine: { // 坐标轴线
                                            lineStyle: { // 属性lineStyle控制线条样式
                                            color: [				//min: 0~3, orange:3~6, red:6~15
                                                    [0.2, '#228b22'],
                                                    [0.4, '#48b'],
                                                    [1, '#ff4500']
                                                ],
                                                width: 8
                                            }
                                        },
                                        axisTick: { // 坐标轴小标记
                                            length: 12, // 属性length控制线长
                                            lineStyle: { // 属性lineStyle控制线条样式
                                                color: 'auto'
                                            }
                                        },
                                        splitLine: { // 分隔线
                                            length: 20, // 属性length控制线长
                                            lineStyle: { // 属性lineStyle（详见lineStyle）控制线条样式
                                                color: 'auto'
                                            }
                                        },
                                        pointer: {
                                            width: 5
                                        },
                                        title: {
                                            offsetCenter: [0, '-135%'] // x, y，单位px
                                        },
                                        detail: {
                                            textStyle: { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                                                fontWeight: 'bolder'
                                            },
                                            formatter: '{value}s'
                                        },
                                        axisLabel: {
                                            formatter: function(v) {
                                                switch (v + '') {
                                                    case '0':
                                                        return '0';
                                                    case '50':
                                                        return '50';
                                                    case '100':
                                                        return '100';
                                                }
                                            }
                                        },
                                        data: [{
                                            value: obj.data.gauge1.value,
                                            name: obj.data.gauge1.name
                                        }]
                                    }, {
                                        name: 'O2P Performance',		//CSB性能
                                        type: 'gauge',
                                        center: ['85%', '65%'], // 默认全局居中
                                        radius: '50%',
                                        min: 0,
                                        max:200,						//min: 0~3, orange:3~6, red:6~15
                                        startAngle: 135,
                                        endAngle: -45,
                                        splitNumber:15,
                                        axisLine: { // 坐标轴线
                                            lineStyle: { // 属性lineStyle控制线条样式
                                                color: [					//min: 0~3, orange:3~6, red:6~15
                                                    [0.2, '#228b22'],
                                                    [0.4, '#48b'],
                                                    [1, '#ff4500']
                                                ],
                                                width: 8
                                            }
                                        },
                                        axisTick: { // 坐标轴小标记
                                            splitNumber: 3,
                                            length: 12, // 属性length控制线长
                                            lineStyle: { // 属性lineStyle控制线条样式
                                                color: 'auto'
                                            }
                                        },
                                        axisLabel: {
                                            formatter: function(v) {
                                                switch (v + '') {
                                                    case '0':
                                                        return '0';
                                                    case '50':
                                                        return '50';
                                                    case '100':
                                                        return '100';
                                                }
                                            }
                                        },
                                        splitLine: { // 分隔线
                                            length: 20, // 属性length控制线长
                                            lineStyle: { // 属性lineStyle（详见lineStyle）控制线条样式
                                                color: 'auto'
                                            }
                                        },
                                        pointer: {
                                            width: 5
                                        },
                                        title: {
                                            offsetCenter: [0, '-135%'] // x, y，单位px
                                        },
                                        detail: {
                                            textStyle: { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                                                fontWeight: 'bolder'
                                            },
                                            formatter: '{value}ms'
                                        },
                                        data: [{
                                            value: obj.data.gauge3.value,
                                            name: obj.data.gauge3.name
                                        }]
                                    }]
                                };
                                myChart.clear();
                                myChart.setOption(option);
                                $('#' + target).closest('.portlet').find('.portlet-title .tools .s-fullscreen').bind('click', function() {
                                    $('#myModalLabel').html(obj.data.name);
                                    var fullChart = chart.init(document.getElementById('fullChart'));
                                    setModalSize();
                                    fullChart.clear();
                                    fullChart.setOption(option, true);
                                })
                                $('body').bind('click', function() {
                                    setTimeout(function() {
                                        myChart.resize && myChart.resize();
                                    }, 1)
                                })
                            }
                        );

                    } else {
                        el.html(obj.msg);
                    }
                } catch (err) {

                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                App.showAjaxErrorMask();
            }
        });
	}
    	  

    var handleLineChart = function() {
        var el = jQuery(this).closest(".portlet").children(".portlet-body");
        var url = jQuery(this).attr("data-url");
        var target = jQuery(this).attr('data-target');
        App.blockUI({
            target: el,
            iconOnly: true
        });
        $.ajax({
            type: 'Get',
            cache: false,
            url: url,
            success: function(response, status, xhr) {
                App.unblockUI(el);
                var obj = eval('(' + response + ')');
                try {
                    if (obj.status == 0) {

                        require.config({
                            paths: {
                                'echarts': 						contextPath+'/resource/monitor/plugins/echarts/echarts',
                                'echarts/chart/line': 	contextPath+'/resource/monitor/plugins/echarts/echarts'
                                ///'echarts/chart/bar': 	contextPath+'/resource/monitor/plugins/echarts/echarts',
                            }
                        });

                        require(
                            [
                                'echarts',
                                'echarts/chart/line'
                                ///'echarts/chart/bar',
                            ],
                            function(ec) {
                                var chart = ec;
                                var myChart = ec.init(document.getElementById(target));

                                var option = {
                                    tooltip: {
                                        trigger: 'axis',
                                        formatter: '{a}:{b}'
                                    },
                                    legend: {
                                        data: [obj.data.yAxisNameA, obj.data.yAxisNameB, obj.data.yAxisNameC]
                                    },
                                    color: ['#ff7f50', '#87cefa', '#da70d6'],
                                    dataZoom: {
                                        show: true,
                                        realtime: true,
                                        start: 50,
                                        end: 100
                                    },
                                    grid: {
                                        x: 40,
                                        y: 50,
                                        x2: 40,
                                        y2: 60
                                    },
                                    xAxis: [{
                                        type: 'category',
                                        splitLine: {
                                            show: false
                                        },
                                        data: obj.data.xAxis
                                    }],
                                    yAxis: [{
                                        type: 'value',
                                        name: obj.data.yAxisUnitLeft,
                                        position: 'left',
                                        //min: 0,
                                        //max: 6000,
                                        //splitNumber: 5,
                                    },
                                    {
                                        type: 'value',
                                        name: obj.data.yAxisUnitRight,
                                        position: 'right',
                                        //max:'200',
                                        //min: 0,
                                        //splitNumber: 5,
                                    }],
                                    series: [
                                    {
                                        name: obj.data.yAxisNameC,
                                        //yAxisIndex:1,
                                        type: 'line',		// bar / line
                                        tooltip: {
                                            trigger: 'item',
                                            formatter: '{a}<br>[{b}] {c}'
                                        },
                                        //stack: 'Service',
                                        data: obj.data.yAxisC
                                    },
                                    {
                                        name: obj.data.yAxisNameB,
                                        type: 'line',		// bar / line
                                        tooltip: {
                                            trigger: 'item',
                                            formatter: '{a}<br>[{b}] {c}'
                                        },
                                        data: obj.data.yAxisB
                                    }, 
                                    {
                                        name: obj.data.yAxisNameA,
                                        type: 'line',		// bar / line
                                        tooltip: {
                                            trigger: 'item',
                                            formatter: '{a}<br>[{b}] {c}'
                                        },
                                        data: obj.data.yAxisA
                                    }]
                                };
                                myChart.clear();                                
                                myChart.setOption(option);
                                $('#' + target).closest('.portlet').find('.portlet-title .tools .s-fullscreen').bind('click', function() {
                                    $('#myModalLabel').html(obj.data.chartName);
                                    var fullChart = chart.init(document.getElementById('fullChart'));
                                    setModalSize();
                                    fullChart.clear();
                                    fullChart.setOption(option, true);
                                })
                                $('body').bind('click', function() {
                                    setTimeout(function() {
                                        myChart.resize && myChart.resize();
                                    }, 1)
                                })
                            }
                        );

                    } else {
                        el.html(obj.msg);
                    }
                } catch (err) {

                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                App.showAjaxErrorMask();
            }
        });
    }
    
    

    var handleLineChart_mainBiz = function() {
        var el = jQuery(this).closest(".portlet").children(".portlet-body");
        var url = jQuery(this).attr("data-url");
        var target = jQuery(this).attr('data-target');
        App.blockUI({
            target: el,
            iconOnly: true
        });
        $.ajax({
            type: 'Get',
            cache: false,
            url: url,
            success: function(response, status, xhr) {
                App.unblockUI(el);
                var obj = eval('(' + response + ')');
                try {
                    if (obj.status == 0) {

                        require.config({
                            paths: {
                                'echarts': 						contextPath+'/resource/monitor/plugins/echarts/echarts',
                                'echarts/chart/line': 	contextPath+'/resource/monitor/plugins/echarts/echarts'
                                ///'echarts/chart/bar': 	contextPath+'/resource/monitor/plugins/echarts/echarts',
                            }
                        });

                        require(
                            [
                                'echarts',
                                'echarts/chart/line'
                                ///'echarts/chart/bar',
                            ],
                            function(ec) {
                                var chart = ec;
                                var myChart = ec.init(document.getElementById(target));

                                var option = {
                                    tooltip: {
                                        trigger: 'axis',
                                        formatter: '{a}:{b}'
                                    },
                                    legend: {
                                        data: [obj.data.yAxisNameA, obj.data.yAxisNameB, obj.data.yAxisNameC]
                                    },
                                    color: ['#ff7f50', '#87cefa', '#da70d6'],
                                    dataZoom: {
                                        show: true,
                                        realtime: true,
                                        start: 50,
                                        end: 100
                                    },
                                    grid: {
                                        x: 40,
                                        y: 50,
                                        x2: 40,
                                        y2: 60
                                    },
                                    xAxis: [{
                                        type: 'category',
                                        splitLine: {
                                            show: false
                                        },
                                        data: obj.data.xAxis
                                    }],
                                    yAxis: [{
                                        type: 'value',
                                        name: obj.data.yAxisUnitLeft,
                                        position: 'left',
                                        //min: 0,
                                        //max: 6000,
                                        //splitNumber: 5,
                                    },
                                    {
                                        type: 'value',
                                        name: obj.data.yAxisUnitRight,
                                        position: 'right',
                                        //max:'200',
                                        //min: 0,
                                        //splitNumber: 5,
                                    }],
                                    series: [
                                    {
                                        name: obj.data.yAxisNameC,
                                        //yAxisIndex:1,
                                        type: 'line',		// bar / line
                                        tooltip: {
                                            trigger: 'item',
                                            formatter: '{a}<br>[{b}] {c}'
                                        },
                                        //stack: 'Service',
                                        data: obj.data.yAxisC
                                    },
                                    {
                                        name: obj.data.yAxisNameB,
                                        type: 'line',		// bar / line
                                        tooltip: {
                                            trigger: 'item',
                                            formatter: '{a}<br>[{b}] {c}'
                                        },
                                        data: obj.data.yAxisB
                                    }, 
                                    {
                                        name: obj.data.yAxisNameA,
                                        type: 'line',		// bar / line
                                        tooltip: {
                                            trigger: 'item',
                                            formatter: '{a}<br>[{b}] {c}'
                                        },
                                        data: obj.data.yAxisA
                                    }]
                                };
                                myChart.clear();                                
                                myChart.setOption(option);
                                $('#' + target).closest('.portlet').find('.portlet-title .tools .s-fullscreen').bind('click', function() {
                                    $('#myModalLabel').html(obj.data.chartName);
                                    var fullChart = chart.init(document.getElementById('fullChart'));
                                    setModalSize();
                                    fullChart.clear();
                                    fullChart.setOption(option, true);
                                })
                                $('body').bind('click', function() {
                                    setTimeout(function() {
                                        myChart.resize && myChart.resize();
                                    }, 1)
                                })
                            }
                        );

                    } else {
                        el.html(obj.msg);
                    }
                } catch (err) {

                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                App.showAjaxErrorMask();
            }
        });
    }


    var handleDropMenu = function() {
        $('body').on('click', '.portlet-title .dropdown-menu > li > a', function() {
            var txt = $(this).text();
            var url = $(this).attr('data-url');
            $(this).closest('.portlet-title').find('a.reload').attr('data-url', url)
            $(this).closest('.dropdown-menu').prev('a').html(txt + '<span class="caret"></span>');
            $(this).closest('.portlet-title').find('.tools a.reload').trigger('click');
        })
    }

    return {
        //main function to initiate the page 
        init: function() {
            $('#reloadDataTable').bind('click', handleTaskLists).click();
            $('#three').closest('.portlet').find('.portlet-title > .tools > a.reload').bind('click', handleGaugeChart).click();
            $('#businessAnalysisEchart').closest('.portlet').find('.portlet-title > .tools > a.reload').bind('click', handleLineChart).click();;
            $('#systemPerformanceEchart').closest('.portlet').find('.portlet-title > .tools > a.reload').bind('click', handleLineChart).click();
            $('#operatorInformationPortEchart').closest('.portlet').find('.portlet-title > .tools > a.reload').bind('click', handleLineChart).click();
            handleDropMenu();
            setModalSize();
        },
        init_tableListEchart: function(objId) {
        	$('#'+objId).bind('click', handleTaskLists).click();
            handleDropMenu();
            setModalSize();
        },
        init_lineEchart: function(objId) {
            $('#'+objId).closest('.portlet').find('.portlet-title > .tools > a.reload').bind('click', handleLineChart).click();
            handleDropMenu();
            setModalSize();
        },
        init_lineEchart_mainBiz: function(objId) {
            $('#'+objId).closest('.portlet').find('.portlet-title > .tools > a.reload').bind('click', handleLineChart_mainBiz).click();
            handleDropMenu();
            setModalSize();
        },
        init_gaugeEchart: function(objId) {
        	$('#'+objId).closest('.portlet').find('.portlet-title > .tools > a.reload').bind('click', handleGaugeChart).click();
            handleDropMenu();
            setModalSize();
        },
        fnBody : function(){
            $('body').trigger('click');            
        }
    }

}();
