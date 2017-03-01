var View1 = function() {
    var eChart = function() {
        var domMain = $("[md='main']");
        var myChart = [];
        var tmp1 = {
            tooltip: {
                trigger: 'axis',
                axisPointer: { // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data: ['API/产品供应收入', '销售佣金收入', 'API使用费支出', '产品推广费支出']
            },
            toolbox: {
                show: true,
                orient: 'vertical',
                x: 'right',
                y: 'center',
                feature: {
                    mark: {
                        show: true
                    },
                    dataView: {
                        show: true,
                        readOnly: false
                    },
                    magicType: {
                        show: true,
                        type: ['line', 'bar', 'stack', 'tiled']
                    },
                    restore: {
                        show: true
                    },
                    saveAsImage: {
                        show: true
                    }
                }
            },
            calculable: true,
            xAxis: [{
                type: 'category',
                data: ['Jan.', 'Feb.', 'Mar.', 'Apr.', 'May.', 'Jun.', 'Jul.']
            }],
            yAxis: [{
                type: 'value'
            }],
            series: [{
                name: 'API/产品供应收入',
                type: 'bar',
                stack: '收入',
                data: [862, 1018, 964, 1026, 1679, 1600, 1570]
            }, {
                name: '销售佣金收入',
                type: 'bar',
                stack: '收入',
                data: [620, 732, 701, 734, 1090, 1130, 1120]
            }, {
                name: 'API使用费支出',
                type: 'bar',
                stack: '支出',
                data: [120, 132, 101, 134, 90, 230, 210]               
            }, {
                name: '产品推广费支出',
                type: 'bar',
                stack: '支出',
                data: [220, 182, 191, 234, 290, 330, 310]
            }]
        };
        var echarts, option1, option2, option3, option4, obj;
        require.config({
            paths: {
                echarts: '/portal/resources/plugins/echarts-2.2.6'
            }
        });
        require(['echarts', 'echarts/chart/line', 'echarts/chart/bar'], requireCallback);

        function requireCallback(ec) {
            var myChart1 = ec.init(document.getElementById('echart1'), {
                noDataLoadingOption: {
                    text: "No Data"
                }
            });
            myChart1.showLoading({
                text: 'Loading'
            });
            // $.ajax({
            //     type: 'POST',
            //     cache: false,
            //     // url: 'dashboard-data.jsp',
            //     url: contextPath4JS + '/main/selectDashboardInfo.shtml',
            //     success: function(response, status, xhr) {
            //         var obj = response;
            //         option1 = tmp1;
            //         option1.title.text = obj.pie1[0].chartName;
            //         option1.legend.data = obj.pie1[0].legend;
            //         option1.series[0].data = obj.pie1[0].data;
            //         myChart1.hideLoading();
            //         myChart1.setOption(option1, true);
            //     },
            //     error: function(xhr, ajaxOptions, thrownError) {
            //         App.showAjaxErrorMask();
            //     }
            // });
            myChart1.hideLoading();
            myChart1.setOption(tmp1, true);
            window.onresize = function() {
                myChart1.resize && myChart1.resize();
            };
        }
    }
    return {
        init: function() {
            eChart();
        }
    }
}()
