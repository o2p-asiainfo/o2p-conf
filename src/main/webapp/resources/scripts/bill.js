var Bill = function() {

    var handlePie = function() {
        // 路径配置
        require.config({
            paths: {
                echarts: APP_PATH+'/resources/plugins/echarts-2.2.6'
            }
        });

        // 使用
        require(
            [
                'echarts',
                'echarts/chart/pie' // 使用柱状图就加载bar模块，按需加载
            ],
            function(ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('pie'));

                var option = {
                    tooltip: {
                        trigger: 'item',
                        formatter: "{a} <br/>{b} : $ {c} ({d}%)"
                    },
                    legend: {                       
                        x: 'right',
                        data: ['SuperMusic', 'SMS', 'MMS', 'CSAutomaton']
                    },
                    calculable: true,
                    series: [{
                        name: 'Consumption amount',
                        type: 'pie',
                        radius: '55%',
                        center: ['50%', '50%'],
                        data: [{
                            value: 335,
                            name: 'SuperMusic'
                        }, {
                            value: 310,
                            name: 'SMS'
                        }, {
                            value: 234,
                            name: 'MMS'
                        }, {
                            value: 135,
                            name: 'CSAutomaton'
                        }]
                    }]
                };

                // 为echarts对象加载数据 
                myChart.setOption(option);
            }
        );
    }

    var handleLine = function() {
        // 路径配置
        require.config({
            paths: {
                echarts: APP_PATH+'/resources/plugins/echarts-2.2.6'
            }
        });

        // 使用
        require(
            [
                'echarts',
                'echarts/chart/line' // 使用柱状图就加载bar模块，按需加载
            ],
            function(ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('line'));

                var option = {                    
                    tooltip: {
                        trigger: 'axis'
                    },
                    legend: {
                        x: 'right',
                        data: ['Consumption amount']
                    },
                    calculable: true,
                    xAxis: [{
                        type: 'category',
                        boundaryGap: false,
                        data: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun']
                    }],
                    yAxis: [{
                        type: 'value',
                        axisLabel: {
                            formatter: '{value} $'
                        }
                    }],
                    series: [{
                        name: 'Consumption amount',
                        type: 'line',
                        data: [11, 11, 15, 13, 12, 13],
                        markPoint: {
                            data: [{
                                type: 'max',
                                name: 'Maximum value'
                            }, {
                                type: 'min',
                                name: 'Minimum value'
                            }]
                        },
                        markLine: {
                            data: [{
                                type: 'average',
                                name: 'Average value'
                            }]
                        }
                    }]
                };

                // 为echarts对象加载数据 
                myChart.setOption(option);
            }
        );
    }

    var handleDataTable = function() {
        $('#dt').dataTable({
            "searching": false,
            "lengthMenu": [5, 10, 15, "All"],

            "ordering": false,
            "aoColumnDefs": [{
                //设置第一列不排序
                "bSortable": false,
                "aTargets": [0]
            }],
            "initComplete": function() {
                App.initUniform();
            }
        });

        jQuery('#dt_wrapper .dataTables_length select').closest('.row').remove(); // modify table per page dropdown 

    }

    var handleDatePickers = function(model) {
        var options = {
            autoclose: true,
            minViewMode: 'months',
            format: 'mm/yyyy'
        }
        if (jQuery().datepicker) {
            $('.date-picker').datepicker(options);
        }
    }

    return {
        init: function() {
            handleDataTable();
            handleDatePickers();
            handlePie();
            handleLine();
        }
    }
}()
