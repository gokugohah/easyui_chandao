/**日期:2016-12-28下午6:07:33
 * 姓名:李黎
 */
package test;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.baidu.product.entity.ProductRequire;
import com.baidu.product.entity.TableHead;

public class ImportPoi {
	public static void main(String[] args) throws IOException, SecurityException, NoSuchFieldException, NumberFormatException, IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		InputStream inputStream = new FileInputStream("D:/test.xls");
		//接收上传的文件
		//将上传的文件流导入workbook
		try {
			HSSFWorkbook workbook = new HSSFWorkbook(inputStream);
			//获取Excel文件的sheet数量
			int sheetnum = workbook.getNumberOfSheets();
			
			//循环每一个sheet
			for(int i=0;i<sheetnum;i++){
				//获取表头的信息集合（字段名---中文名）
				List<TableHead> headlist = new ArrayList<TableHead>();
				headlist.add(new TableHead("ID","需求编号"));
				headlist.add(new TableHead("NAME","需求名称"));
				headlist.add(new TableHead("EXAMUSER","评审人员"));
				headlist.add(new TableHead("PROLEVEL","优先级"));
				headlist.add(new TableHead("CONTENT","备注"));
				headlist.add(new TableHead("PROID","所属产品"));
				headlist.add(new TableHead("MODELID","所属模块"));
				headlist.add(new TableHead("PLANID","所属计划"));
				headlist.add(new TableHead("FROMID","需求来源"));
				headlist.add(new TableHead("TOUSERS","抄送人"));
				
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
								cellValue = "4";
							}
							if("MODELID".equals(column_name)){
								cellValue = "6";
							}
							if("PLANID".equals(column_name)){
								cellValue = "7";
							}
							if("FROMID".equals(column_name)){
								cellValue = "1";
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
						System.out.println(req);
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
