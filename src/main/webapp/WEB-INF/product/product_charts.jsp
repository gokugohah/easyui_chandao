<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="chartsChoose" style="float: left;border: 1px solid #DDD;width:10%;text-align: center;">
	<form action="" method="post">
		<h3>请选择报表类型</h3>
		<input type="checkbox" class="fusioncharts" value="product" name="产品需求数量">产品需求数量<br><br>
		<input type="checkbox" class="fusioncharts" value="model" name="模块需求数量">模块需求数量<br><br>
		<input type="checkbox" class="echarts" value="from" name="需求来源统计">需求来源统计<br><br>
		<input type="checkbox" class="echarts" value="prolevel" name="优先级统计">优先级统计<br><br>
		<input id="showCharts" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" type="button" value="生产报表">
	</form>
</div>
<div id="chartsRegion" style="float: right;border: 1px solid #DDD;;width:88%;">
	<div>
		<div id="chart-container-product" class="chartDiv" style="float: left;"></div>
		<div id="chart2-container-product" class="chartDiv" style="float: right;"></div>
	</div>
	<div>
		<div id="chart-container-model" class="chartDiv" style="float: left;"></div>
		<div id="chart2-container-model" class="chartDiv" style="float: right;"></div>
	</div>
	<div>
		<div id="chart-container-from" class="chartDiv" style="float: left;"></div>
		<div id="chart2-container-from" class="chartDiv" style="float: right;"></div>
	</div>
	<div>
		<div id="chart-container-prolevel" class="chartDiv" style="float: left;"></div>
		<div id="chart2-container-prolevel" class="chartDiv" style="float: right;"></div>
	</div>
</div>
<script type="text/javascript">
	$("#showCharts").click(function(){
		$(".chartDiv").empty();
		//循环所有被选中的复选框，用fusioncharts制作统计图
		$(":checkbox[class='fusioncharts'][checked]").each(function(){
			var chartsPath = $(this).val();
			var chartsName = $(this).attr("name");
			$.post(
				"${pageContext.request.contextPath}/product/charts.do",
				{chart:chartsPath},
				function(msg){
					//饼状图
					FusionCharts.ready(function () {
				    var ageGroupChart = new FusionCharts({
				        type: 'pie3d',
				        renderAt: "chart-container-"+chartsPath,
				        width: '450',
				        height: '300',
				        dataFormat: 'json',
				        dataSource: {
				            "chart": {
				                "caption": chartsName,
				                "subCaption": "Last year",
				                "paletteColors": "#0075c2,#1aaf5d,#f2c500,#f45b00,#8e0000",
				                "bgColor": "#ffffff",
				                "showBorder": "0",
				                "use3DLighting": "0",
				                "showShadow": "0",
				                "enableSmartLabels": "0",
				                "startingAngle": "0",
				                "showPercentValues": "1",
				                "showPercentInTooltip": "0",
				                "decimals": "1",
				                "captionFontSize": "14",
				                "subcaptionFontSize": "14",
				                "subcaptionFontBold": "0",
				                "toolTipColor": "#ffffff",
				                "toolTipBorderThickness": "0",
				                "toolTipBgColor": "#000000",
				                "toolTipBgAlpha": "80",
				                "toolTipBorderRadius": "2",
				                "toolTipPadding": "5",
				                "showHoverEffect":"1",
				                "showLegend": "1",
				                "legendBgColor": "#ffffff",
				                "legendBorderAlpha": '0',
				                "legendShadow": '0',
				                "legendItemFontSize": '10',
				                "legendItemFontColor": '#666666'
				            },
				            "data": msg.list
				        }
				    }).render();
				});
				//柱状图
				FusionCharts.ready(function () {
			    var revenueChart = new FusionCharts({
			        type: 'column3d',
			        renderAt: "chart2-container-"+chartsPath,
			        width: '500',
			        height: '300',
			        dataFormat: 'json',
			        dataSource: {
			            "chart": {
			                "caption": chartsName,
			                "subCaption": "Harry's SuperMart",
			                "xAxisName": "Month",
			                "yAxisName": "Revenues (In USD)",
			                "paletteColors": "#0075c2",
			                "valueFontColor": "#ffffff",
			                "baseFont": "Helvetica Neue,Arial",
			                "captionFontSize": "14",
			                "subcaptionFontSize": "14",
			                "subcaptionFontBold": "0",
			                "placeValuesInside": "1",
			                "rotateValues": "1",
			                "showShadow": "0",
			                "divlineColor": "#999999",               
			                "divLineIsDashed": "1",
			                "divlineThickness": "1",
			                "divLineDashLen": "1",
			                "divLineGapLen": "1",
			                "canvasBgColor": "#ffffff"
			            },
			            "data": msg.list
			        }
			    });
			    revenueChart.render();
			});
				},
				"json"
			);
		});
		//循环所有被选中的复选框，用echarts制作统计图
		$(":checkbox[class='echarts'][checked]").each(function(){
			var chartsPath = $(this).val();
			var chartsName = $(this).attr("name");
			$.post(
				"${pageContext.request.contextPath}/product/charts.do",
				{chart:chartsPath},
				function(msg){
					//饼状图
					var myChart = echarts.init(document.getElementById("chart-container-"+chartsPath));
			        var option = {
					    title : {
					        text: chartsName,
					        x:'center'
					    },
					    tooltip : {
					        trigger: 'item',
					        formatter: "{a} <br/>{b} : {c} ({d}%)"
					    },
					    legend: {
					        orient: 'vertical',
					        left: 'left',
					        data: msg.nameArray
					    },
					    series : [
					        {
					            name: '访问来源',
					            type: 'pie',
					            radius : '55%',
					            center: ['50%', '60%'],
					            data:msg.list,
					            itemStyle: {
					                emphasis: {
					                    shadowBlur: 10,
					                    shadowOffsetX: 0,
					                    shadowColor: 'rgba(0, 0, 0, 0.5)'
					                }
					            }
					        }
					    ]
					};
			        // 使用刚指定的配置项和数据显示图表。
			        myChart.setOption(option);
			        //设置图片的尺寸
			        window.onresize = myChart.resize({
			        	width:500,height:400
			        });
			        //柱状图
					var myChart2 = echarts.init(document.getElementById("chart2-container-"+chartsPath));
			        var option2 = {
					    color: ['#3398DB'],
					    title : {
					        text: chartsName,
					        x:'center'
					    },
					    tooltip : {
					        trigger: 'axis',
					        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
					            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
					        }
					    },
					    grid: {
					        left: '3%',
					        right: '4%',
					        bottom: '3%',
					        containLabel: true
					    },
					    xAxis : [
					        {
					            type : 'category',
					            data : msg.nameArray,
					            axisTick: {
					                alignWithLabel: true
					            }
					        }
					    ],
					    yAxis : [
					        {
					            type : 'value'
					        }
					    ],
					    series : [
					        {
					            name:'直接访问',
					            type:'bar',
					            barWidth: '60%',
					            data:msg.valueArray
					        }
					    ]
					};
			        // 使用刚指定的配置项和数据显示图表。
			        myChart2.setOption(option2);
			        window.onresize = myChart2.resize({
			        	width:500,height:400
			        });
				},
				"json"
			);
		});
	});
	
</script>
</body>
</html>