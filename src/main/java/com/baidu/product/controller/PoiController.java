/**日期:2016-12-26上午11:05:09
 * 姓名:李黎
 */
package com.baidu.product.controller;

import java.awt.Color;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.baidu.product.entity.TableHead;
import com.baidu.product.service.ProductService;
import com.baidu.product.util.FileUtil;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.rtf.RtfWriter2;

@Controller
@RequestMapping("poi")
public class PoiController {
	@Resource
	private ProductService productService;
	@RequestMapping("productPoi")
	public void productPoi(HttpServletRequest request,HttpServletResponse response) throws IOException, DocumentException{
		FileOutputStream fos = null;
		//获取前台传过来的文件名和文件类型
		String filename = request.getParameter("filename");
		String filetype = request.getParameter("filetype");
		//查找需求表的字段名和备注名，以集合的形式保存，在表头依次填入备注名
		List<TableHead> headlist = this.productService.findTableHead();
		//获取需求列表集合，里面用map集合的形式保存每条数据（字段名----值）
		List<Map<String,Object>> reqlist = this.productService.findTable();
		if(".xls".equals(filetype)){
		//*********************************excel*************************************
			//生成excel文件
			HSSFWorkbook workbook = new HSSFWorkbook();
			HSSFSheet sheet = workbook.createSheet("需求列表");
			//设计标题单元格的样式
			HSSFCellStyle cellStyle1 = workbook.createCellStyle();
			HSSFFont font1 = workbook.createFont();
			font1.setFontName("楷体");
			font1.setFontHeightInPoints((short) 20);
			font1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			cellStyle1.setFont(font1);
			cellStyle1.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			cellStyle1.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			
			//设计表头单元格的样式
			HSSFCellStyle cellStyle = workbook.createCellStyle();
			HSSFFont font = workbook.createFont();
			font.setFontName("黑体");
			font.setFontHeightInPoints((short) 16);
			//font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			cellStyle.setFont(font);
			cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			
			//设计标题
			CellRangeAddress cra = new CellRangeAddress(0, 0, 0, headlist.size()-1);
			sheet.addMergedRegion(cra);
			HSSFRow titlerow = sheet.createRow(0);
			titlerow.setHeight((short) 750);
			HSSFCell titlecell = titlerow.createCell(0);
			titlecell.setCellStyle(cellStyle1);
			titlecell.setCellValue("产品需求列表");
			sheet.setDefaultColumnWidth(18);
			//生成表格头
			HSSFRow headrow = sheet.createRow(1);
			//查找需求表的字段名和备注名，以集合的形式保存，在表头依次填入备注名
			for (int i=0;i<headlist.size();i++) {
				HSSFCell headcell = headrow.createCell(i);
				headcell.setCellValue(headlist.get(i).getComments());
				headcell.setCellStyle(cellStyle);
				//sheet.autoSizeColumn(i);//设置所有列的宽度自适应
			}
			
			//循环遍历列表集合，为每条数据生成一个行
			for (int j = 0; j < reqlist.size(); j++) {
				HSSFRow datarow = sheet.createRow(j+2);
				//以表头集合的数量循环每一行，并在当前行生成对应的单元格的数据
				for (int i = 0; i < headlist.size(); i++) {
					HSSFCell datacell = datarow.createCell(i);
					//获取当前单元格对应表头的备注名的字段名
					String column_name = headlist.get(i).getColumn_name();
					String datacellValue = reqlist.get(j).get(column_name)==null?"":reqlist.get(j).get(column_name).toString();
					//通过map的键值对（字段名---值）设置单元格的值
					datacell.setCellValue(datacellValue);
				}
			}
			try {
				//下载文件
				fos = new FileOutputStream("D:\\"+filename+filetype);
				workbook.write(fos);
			} catch (IOException e) {
				e.printStackTrace();
			} finally{
				try {
					fos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}else if(".doc".equals(filetype)){
		//*****************************word*************************************************
			/*
			//************POI生成WORD文件*****************
			XWPFDocument doc = new XWPFDocument();
			XWPFParagraph para = doc.createParagraph();
			para.setAlignment(ParagraphAlignment.CENTER);
			para.setVerticalAlignment(TextAlignment.TOP);
			XWPFRun run1 = para.createRun();
			run1.setFontFamily("楷体");
			run1.setText("产品需求列表");
			run1.setBold(true);
			run1.setColor("FF00FF");
			run1.setFontSize(20);
			run1.setTextPosition(10);
			
			XWPFTable table = doc.createTable(reqlist.size()+1, headlist.size());
			table.setCellMargins(10, 10, 10, 10);
			List<XWPFTableCell> tableheadCells = table.getRow(0).getTableCells();
			for(int i=0;i<headlist.size();i++){
				tableheadCells.get(i).setText(headlist.get(i).getComments());
			}
			
			for(int j=0;j<reqlist.size();j++){
				List<XWPFTableCell> cells = table.getRow(j+1).getTableCells();
				for(int i=0;i<headlist.size();i++){
					String column_name = headlist.get(i).getColumn_name();
					cells.get(i).setText(reqlist.get(j).get(column_name).toString());
				}
			}
			
			//设置表格样式
			//CTTblBorders borders = table.getCTTbl().getTblPr().addNewTblBorders();
			
			
			try {
				//下载文件
				fos = new FileOutputStream("D:\\"+filename+filetype);
				doc.write(fos);
			} catch (IOException e) {
				e.printStackTrace();
			} finally{
				try {
					fos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}*/
			//************ITEXT生成WORD文件*****************
			//设置纸张大小 
			Document document = new Document(PageSize.A4);
			
			try {
				//建立一个书写器，与document对象关联
				RtfWriter2 writer2 = RtfWriter2.getInstance(document, new FileOutputStream("D:\\"+filename+filetype));
				
				document.open();
				
				Paragraph ph = new Paragraph("产品需求列表",new Font(Font.NORMAL,20,Font.BOLDITALIC,new Color(0,0,0)));
				ph.setAlignment(1);
				document.add(ph);
				//设置中文字体
				BaseFont bfChinese = BaseFont.createFont("STSong-Light","UniGB-UCS2-H",BaseFont.NOT_EMBEDDED);
				Font font = new Font(bfChinese,10,Font.BOLD);
				
				Table table = new Table(headlist.size());    
			    /*   
			     * 添加表头的元素   
			     */   
				for(int i=0;i<headlist.size();i++){
					table.addCell(new Paragraph(headlist.get(i).getComments(),font));    
				}
			    table.endHeaders();// 表头结束    
			   
			    // 表格的主体    
			    for(int j=0;j<reqlist.size();j++){
			    	for(int i=0;i<headlist.size();i++){
			    		String column_name = headlist.get(i).getColumn_name();
			    		String cellValue = reqlist.get(j).get(column_name)==null?"":reqlist.get(j).get(column_name).toString();
			    		table.addCell(new Paragraph(cellValue,font));    
			    	}
			    	
			    }
			    
			    document.add(table);
			    document.close();
			    writer2.close();
				
				
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
			
		}else if(".pdf".equals(filetype)){
			//*****************************pdf*************************************************
			BaseFont bfChinese = BaseFont.createFont("STSong-Light","UniGB-UCS2-H",BaseFont.NOT_EMBEDDED);
			Font font = new Font(bfChinese,10,Font.BOLD);
			
			Document document = new Document(PageSize.A4,20,20,20,20);
			OutputStream os = new FileOutputStream("D:\\"+filename+filetype);
			
			PdfWriter.getInstance(document, os);
			
			document.open();
			
			PdfPTable table = new PdfPTable(headlist.size());
			
			table.setHeaderRows(2);
			//设计标题
			PdfPCell cell = new PdfPCell(new Paragraph("产品需求列表",font));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setColspan(headlist.size());
			table.addCell(cell);
			
			for(int i=0;i<headlist.size();i++){
				PdfPCell cell1 = new PdfPCell(new Paragraph(headlist.get(i).getComments(),font));
				cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(cell1);
			}
			for(int j=0;j<reqlist.size();j++){
				for(int i=0;i<headlist.size();i++){
					String column_name = headlist.get(i).getColumn_name();
					String cellValue = reqlist.get(j).get(column_name)==null?"":reqlist.get(j).get(column_name).toString();
					PdfPCell cell2 = new PdfPCell(new Paragraph(cellValue,font));
					cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
					table.addCell(cell2);
				}
			}
			document.add(table);
			document.close();
			os.close();
		}
		//下载文件
		FileUtil.downloadFile(request, response, "D:\\"+filename+filetype, filename+filetype);
		System.out.println("需求列表导出完毕");
	}
}
