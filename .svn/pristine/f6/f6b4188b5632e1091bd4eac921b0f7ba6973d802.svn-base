/**日期:2016-12-17上午11:05:28
 * 姓名:李黎
 */
package com.baidu.product.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.baidu.product.service.ProductService;
import com.baidu.product.util.JFreeChartJob;
import com.baidu.product.util.SimpleMailSender;
//设置定时器
public class QuartzJob {
	@Autowired
	private ProductService productService;
	
	public void run(){
		//生成产品统计图
		Map<String, Object> promap = this.productService.charts("product");
		String proname = JFreeChartJob.createCategoryChart(promap,"产品需求");
		System.out.println("生成产品柱状图...................");
		String proname2 = JFreeChartJob.createPieChart(promap,"产品需求");
		System.out.println("生成产品饼状图...................");
		//生成模块统计图
		Map<String, Object> modelmap = this.productService.charts("model");
		String modelname = JFreeChartJob.createCategoryChart(modelmap,"模块需求");
		System.out.println("生成模块柱状图...................");
		String modelname2 = JFreeChartJob.createPieChart(modelmap,"模块需求");
		System.out.println("生成模块饼状图...................");
		//生成来源统计图
		Map<String, Object> frommap = this.productService.charts("from");
		String fromname = JFreeChartJob.createCategoryChart(frommap,"需求来源");
		System.out.println("生成来源柱状图...................");
		String fromname2 = JFreeChartJob.createPieChart(frommap,"需求来源");
		System.out.println("生成来源饼状图...................");
		//生成优先级统计图
		Map<String, Object> levelmap = this.productService.charts("prolevel");
		String levelname = JFreeChartJob.createCategoryChart(levelmap,"需求优先级");
		System.out.println("生成优先级柱状图...................");
		String levelname2 = JFreeChartJob.createPieChart(levelmap,"需求优先级");
		System.out.println("生成优先级饼状图...................");
		
		String fileUploadDirectory = "D:\\upload\\temp";
    	//把本次需求以邮件的形式发送给“抄送到”
        SimpleMailSender ss = new SimpleMailSender();
		List<String> tos = new ArrayList<String>();
		//设置收件人，群发
		tos.add("649755137@qq.com");
		//tos.add("247673287@qq.com");
		tos.add("3326874510@qq.com");
		tos.add("1270628084@qq.com");
		
		ss.createMail();
		
		ss.setTo(tos);
		
		ss.setSubject("统计表");
		
		ss.addContent("今天的统计表");
		
		ss.addAttach(new File(fileUploadDirectory + "/" + proname));
		ss.addAttach(new File(fileUploadDirectory + "/" + proname2));
		ss.addAttach(new File(fileUploadDirectory + "/" + modelname));
		ss.addAttach(new File(fileUploadDirectory + "/" + modelname2));
		ss.addAttach(new File(fileUploadDirectory + "/" + fromname));
		ss.addAttach(new File(fileUploadDirectory + "/" + fromname2));
		ss.addAttach(new File(fileUploadDirectory + "/" + levelname));
		ss.addAttach(new File(fileUploadDirectory + "/" + levelname2));
		
		ss.sendMail();
	}
}
