/**日期:2016-12-17上午11:26:56
 * 姓名:李黎
 */
package com.baidu.product.util;

import java.awt.Font;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.labels.StandardPieSectionLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PiePlot;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;

import com.baidu.product.entity.Charts;

public class JFreeChartJob {
	//生成柱状图
	@SuppressWarnings("unchecked")
	public static String createCategoryChart(Map<String, Object> map,String title) {
		try {
		Font font = new Font("宋体", Font.BOLD, 20);
		DefaultCategoryDataset dcd = new DefaultCategoryDataset();
		List<Charts> list = (List<Charts>) map.get("list");
		for (Charts c : list) {
			dcd.setValue(c.getValue(), c.getName(), "");
		}
		JFreeChart chart = ChartFactory.createBarChart(title+"统计表", "名称", "数量", dcd);
		//设置整个图片的标题字体
        chart.getTitle().setFont(font);

        //设置提示条字体
        font = new Font("宋体", Font.BOLD, 15);
        chart.getLegend().setItemFont(font);
        
        CategoryPlot plot = (CategoryPlot) chart.getPlot();
        //得到绘图区的域轴(横轴),设置标签的字体
        plot.getDomainAxis().setLabelFont(font);

        //设置横轴标签项字体
        plot.getDomainAxis().setTickLabelFont(font);

        //设置范围轴(纵轴)字体
        plot.getRangeAxis().setLabelFont(font);
        
        String chartName = UUID.randomUUID().toString();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-hh-mm-ss");
        String thisdate = sdf.format(new Date());
        chartName = thisdate +"-"+ chartName + ".jpg";
		ChartUtilities.saveChartAsJPEG(new File("D:\\upload\\temp\\"+chartName), chart, 600, 400);
		
		return chartName;
		} catch (IOException e) {
			e.printStackTrace();
			return "";
		}
	}
	//生成饼状图
	@SuppressWarnings("unchecked")
	public static String createPieChart(Map<String, Object> map,String title){
		 try {
            //如果不使用Font,中文将显示不出来
            Font font = new Font("宋体", Font.BOLD, 15);
 
            DefaultPieDataset pds = new DefaultPieDataset();
            List<Charts> list = (List<Charts>) map.get("list");
            for (Charts c : list) {
				pds.setValue(c.getName(), c.getValue());
			}
            /**
             * 生成一个饼图的图表
             * 
             * 分别是:显示图表的标题、需要提供对应图表的DateSet对象、是否显示图例、是否生成贴士以及是否生成URL链接
             */
            JFreeChart chart = ChartFactory.createPieChart(title+"统计表", pds, true, false, true);
            //设置图片标题的字体
            chart.getTitle().setFont(font);
 
            //得到图块,准备设置标签的字体
            PiePlot plot = (PiePlot) chart.getPlot();
 
            //设置分裂效果,需要指定分裂出去的key
           // plot.setExplodePercent("oracle", 0.3);
 
            //设置标签字体
            plot.setLabelFont(font);
 
            //设置图例项目字体
            chart.getLegend().setItemFont(font);
 
            /**
             * 设置开始角度(弧度计算)
             * 
             * 度    0°    30°        45°        60°        90°        120°    135°    150°    180°    270°    360°
             * 弧度    0    π/6        π/4        π/3        π/2        2π/3    3π/4    5π/6    π        3π/2    2π
             */
            plot.setStartAngle(new Float(3.14f / 2f));
 
            //设置背景图片,设置最大的背景
            //Image img = ImageIO.read(new File("d:/sunset.jpg"));
            //chart.setBackgroundImage(img);
 
            //设置plot的背景图片
            //img = ImageIO.read(new File("d:/Water.jpg"));
            //plot.setBackgroundImage(img);
 
            //设置plot的前景色透明度
            plot.setForegroundAlpha(0.7f);
 
            //设置plot的背景色透明度
            plot.setBackgroundAlpha(0.0f);
 
            //设置标签生成器(默认{0})
            //{0}:key {1}:value {2}:百分比 {3}:sum
            plot.setLabelGenerator(new StandardPieSectionLabelGenerator("{0}({1})/{2}"));
            
            String chartName = UUID.randomUUID().toString();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-hh-mm-ss");
            String thisdate = sdf.format(new Date());
            chartName = thisdate +"-"+ chartName + ".jpg";
            
            //将内存中的图片写到本地硬盘
            ChartUtilities.saveChartAsJPEG(new File("D:\\upload\\temp\\"+chartName), chart, 600, 300);
            return chartName;
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
	}
}
