/**日期:2016-12-28上午10:48:45
 * 姓名:李黎
 */
package com.baidu.product.controller;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.baidu.product.entity.Product;
import com.baidu.product.entity.ProductFrom;
import com.baidu.product.entity.ProductModel;
import com.baidu.product.entity.ProductPlan;
import com.baidu.product.entity.ProductRequire;
import com.baidu.product.entity.TableHead;
import com.baidu.product.service.ProductService;
import com.baidu.user.entity.User;

@Controller
@RequestMapping("import")
public class ImportController {
	@Resource
	private ProductService productService;
	@RequestMapping("requireImport2")
	@ResponseBody
	public String requireImport2(MultipartFile file) throws IOException, NumberFormatException, IllegalArgumentException, IllegalAccessException, InvocationTargetException{
		
		InputStream inputStream = file.getInputStream();
		//接收上传的文件
			//将上传的文件流导入workbook
			try {
				HSSFWorkbook workbook = new HSSFWorkbook(inputStream);
				//获取Excel文件的sheet数量
				int sheetnum = workbook.getNumberOfSheets();
				
				//循环每一个sheet
				for(int i=0;i<sheetnum;i++){
					//获取表头的信息集合（字段名---中文名）
					List<TableHead> headlist = this.productService.findTableHead();
					
					//存放所有的有效数据
					List<ProductRequire> reqlist = new ArrayList<ProductRequire>();
					HSSFSheet sheet = workbook.getSheetAt(i);
					//获取每个sheet有多少有效的行
					int rownum = sheet.getPhysicalNumberOfRows();
					//循环每一行（第一行固定为标题，第二行固定为表头）
					if(rownum>2){
						//循环所有有数据的行
						for(int j=2;j<rownum;j++){
							ProductRequire req = new ProductRequire();
							HSSFRow row = sheet.getRow(j);
							int cellnum = row.getPhysicalNumberOfCells();
							//循环每一行的所有单元格
							for(int k=0;k<cellnum;k++){
								HSSFCell cell = row.getCell(k);
								String cellValue = cell.getStringCellValue();
								String column_name = headlist.get(k).getColumn_name();
								if("PROID".equals(column_name)){
									List<Product> prolist = this.productService.findProductMap();
									for(Product pro:prolist){
										if(pro.getName().equals(cellValue)){
											cellValue =  pro.getId().toString();
										}
									}
								}
								if("MODELID".equals(column_name)){
									List<ProductModel> modellist =  this.productService.findModelMap();
									for(ProductModel model:modellist){
										if(model.getName().equals(cellValue)){
											cellValue =  model.getId().toString();
										}
									}
								}
								if("PLANID".equals(column_name)){
									List<ProductPlan> planlist =  this.productService.findPlanMap();
									for(ProductPlan plan:planlist){
										if(plan.getName().equals(cellValue)){
											cellValue =  plan.getId().toString();
										}
									}
								}
								if("FROMID".equals(column_name)){
									List<ProductFrom> fromlist =  this.productService.findFromMap();
									for(ProductFrom fr:fromlist){
										if(fr.getName().equals(cellValue)){
											cellValue =  fr.getId().toString();
										}
									}
								}
								if("TOUSERS".equals(column_name)){
									List<User> userlist =  this.productService.findUserMap();
									String[] split = cellValue.split(",");
									String ids = "";
									for (int s = 0; s < split.length; s++) {
										for(User user:userlist){
											if(user.getName().equals(split[s])){
												ids += ","+ user.getId();
											}
										}
									}
									ids = ids==""?"":ids.substring(1);
									cellValue =  ids;
								}
								//通过反射获取req对象里面的属性和方法
								//Field field = ProductRequire.class.getDeclaredField(column_name.toLowerCase());
								Method[] methods = ProductRequire.class.getDeclaredMethods();
								for (int m = 0; m < methods.length; m++) {
									String methodName = methods[m].getName();
									if(("set"+column_name).toUpperCase().equals(methodName.toUpperCase())){
										//获取方法所传参数的类型的数组
										Type[] types = methods[m].getGenericParameterTypes();
										//type的格式是class java.lang.Integer
										String tt = types[0].toString().substring(types[0].toString().lastIndexOf(".")+1);
										//判断参数类型，并对cellvalue进行转换
										if("Integer".equals(tt)){
											methods[m].invoke(req, Integer.parseInt(cellValue));
										}else{
											methods[m].invoke(req, cellValue);
										}
									}
								}
							}
							reqlist.add(req);
						}
					}
					
					//处理reqlist，将里面联表显示的name换成对应的id
					this.productService.addOrUpdateRequire(reqlist);
				}
				System.out.println("导入报表成功");
				return "1";
			} catch (IOException e) {
				e.printStackTrace();
				return null;
			}
	}
	@RequestMapping("requireImport1")
	@ResponseBody
	public String requireImport1(MultipartFile file) throws IOException{
		
		InputStream inputStream = file.getInputStream();
		//接收上传的文件
		//将上传的文件流导入workbook
		try {
			HSSFWorkbook workbook = new HSSFWorkbook(inputStream);
			//获取Excel文件的sheet数量
			int sheetnum = workbook.getNumberOfSheets();
			
			//循环每一个sheet
			for(int i=0;i<sheetnum;i++){
				//获取表头的信息集合（字段名---中文名）
				List<TableHead> headlist = this.productService.findTableHead();
				
				//存放所有的有效数据
				List<Map<String, Object>> reqlist = new ArrayList<Map<String, Object>>();
				HSSFSheet sheet = workbook.getSheetAt(i);
				//获取每个sheet有多少有效的行
				int rownum = sheet.getPhysicalNumberOfRows();
				//循环每一行（第一行固定为标题，第二行固定为表头）
				if(rownum>2){
					//通过表头的中文名找到对应的字段名
					/*HSSFRow headrow = sheet.getRow(1);
						int headcellnum = headrow.getPhysicalNumberOfCells();
						for(int h=0;h<headcellnum;h++){
							HSSFCell headcell = headrow.getCell(h);
							String headcellValue = headcell.getStringCellValue();
							
						}*/
					//循环所有有数据的行
					for(int j=2;j<rownum;j++){
						Map<String, Object> map = new HashMap<String, Object>();
						HSSFRow row = sheet.getRow(j);
						int cellnum = row.getPhysicalNumberOfCells();
						//循环每一行的所有单元格
						for(int k=0;k<cellnum;k++){
							HSSFCell cell = row.getCell(k);
							String cellValue = cell.getStringCellValue();
							map.put(headlist.get(k).getColumn_name().toLowerCase(), cellValue);
						}
						reqlist.add(map);
					}
				}
				//处理reqlist，将里面联表显示的name换成对应的id
				reqlist = this.productService.changeName(reqlist);
				this.productService.addOrUpdateRequire(reqlist);
			}
			System.out.println("导入报表成功");
			return "1";
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}
}
