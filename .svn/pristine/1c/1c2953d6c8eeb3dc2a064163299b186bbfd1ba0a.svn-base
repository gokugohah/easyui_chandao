/**日期:2016-11-29下午2:10:18
 * 姓名:李黎
 */
package com.baidu.product.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baidu.product.entity.AutoComplete;
import com.baidu.product.entity.ProType;
import com.baidu.product.entity.Product;
import com.baidu.product.entity.ProductFrom;
import com.baidu.product.entity.ProductModel;
import com.baidu.product.entity.ProductPlan;
import com.baidu.product.entity.ProductRequire;
import com.baidu.product.entity.Znotes;
import com.baidu.product.service.ProductService;
import com.baidu.product.util.SimpleMailSender;
import com.baidu.upload.entity.Image;
import com.baidu.user.entity.User;

@Controller
@RequestMapping("product")
public class ProductController {
	@Autowired
	private ProductService productService;
	//跳转到产品列表
	@RequestMapping("toproductPage")
	public String toproductPage(){
		return "product/product_list";
	}
	//部门和员工的zTree页面
	@RequestMapping("toZtree")
	public String toZtree(){
		return "product/ztree";
	}
	//
	@RequestMapping("toUsersZtree")
	public String toUsersZtree(){
		return "product/usersZtree";
	}
	//编辑器页面
	@RequestMapping("toContent")
	public String toContent(){
		return "product/content";
	}
	//添加产品需求
	@RequestMapping("torequire")
	public String torequire(){
		return "product/product_require";
	}
	//产品需求列表
	@RequestMapping("torequirelist")
	public String torequirelist(){
		return "product/require_list";
	}
	//上传附件页面
	@RequestMapping("toUpload")
	public String toUpload(){
		return "product/product_upload";
	}
	//报表页面
	@RequestMapping("toCharts")
	public String toCharts(){
		return "product/product_charts";
	}
	//跳转产品添加页面
	@RequestMapping("toAdd")
	public String toAdd(){
		return "product/product_add";
	}
	//获取产品列表
	@RequestMapping("list")
	@ResponseBody
	public List<Product> list(){
		List<Product> list = this.productService.list();
		return list;
	}
	//添加产品
	@RequestMapping("add")
	@ResponseBody
	public String add(Product product){
		this.productService.add(product);
		return "1";
	}
	//修改产品
	@RequestMapping("update")
	@ResponseBody
	public String update(Product product){
		this.productService.update(product);
		return "1";
	}
	//获取部门和员工的联合列表，zTree用
	@RequestMapping("userList")
	@ResponseBody
	public List<Znotes> userList(){
		List<Znotes> userList = this.productService.userList();
		return userList;
	}
	//自动补全，查询用户
	@RequestMapping("userAll")
	@ResponseBody
	public List<AutoComplete> userAll(String term){
		List<AutoComplete> userAll = this.productService.userAll(term);
		return userAll;
	}
	//产品类型列表
	@RequestMapping("protypeList")
	@ResponseBody
	public List<ProType> protypeList(){
		List<ProType> protypeList = this.productService.protypeList();
		return protypeList;
	}
	//产品模块列表
	@RequestMapping("modelList")
	@ResponseBody
	public List<ProductModel> modelList(ProductModel pm){
		List<ProductModel> modelList = this.productService.modelList(pm);
		return modelList;
	}
	//产品计划列表
	@RequestMapping("planList")
	@ResponseBody
	public List<ProductPlan> planList(ProductPlan pp){
		List<ProductPlan> planList = this.productService.planList(pp);
		return planList;
	}
	//需求来源列表
	@RequestMapping("fromList")
	@ResponseBody
	public List<ProductFrom> fromList(ProductFrom pf){
		List<ProductFrom> fromList = this.productService.fromList(pf);
		return fromList;
	}
	//添加需求
	@RequestMapping("addRequire")
	@ResponseBody
	public Integer addRequire(ProductRequire pr){
		this.productService.addRequire(pr);
		System.out.println("新增的需求id是"+pr.getId());
		return pr.getId();
	}
	//产品需求列表
	@RequestMapping("requireList")
	@ResponseBody
	public List<ProductRequire> requireList(){
		List<ProductRequire> requireList = this.productService.requireList();
		return requireList;
	}
	//发送邮件
    @RequestMapping("sendmail")
    @ResponseBody
    public String sendmail(Integer reqid){
    	String fileUploadDirectory = "D:\\upload\\temp";
    	//把本次需求以邮件的形式发送给“抄送到”
        ProductRequire pr = this.productService.findRequire(reqid);
        List<User> userList = this.productService.findToUsers(pr.getTousers());
        SimpleMailSender ss = new SimpleMailSender();
		List<String> tos = new ArrayList<String>();
		//设置收件人，群发
		for(User user:userList){
			tos.add(user.getMail());
		}
		
		ss.createMail();
		
		ss.setTo(tos);
		
		ss.setSubject(pr.getName());
		
		ss.addContent(pr.getContent());
		
		for(Image image:pr.getImages()){
			ss.addAttach(new File(fileUploadDirectory + "/" + image.getName()));
		}
		ss.sendMail();
		return "1";
    }
    //获取报表数据
    @RequestMapping("charts")
	@ResponseBody
    public Map<String, Object> charts(String chart){
    	Map<String, Object> map = this.productService.charts(chart);
    	return map;
    }
    
}
