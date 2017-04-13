/*
 * The MIT License
 *
 * Copyright 2013 jdmr.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package com.baidu.upload.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.baidu.upload.entity.Image;
import com.baidu.upload.service.ImageService;

@Controller
@RequestMapping("img")
public class ImageController {

    private static final Logger log = LoggerFactory.getLogger(ImageController.class);
    
    @Autowired
    private ImageService imageService;
    //设置上传文件的路径
    //@Value("${file.upload.directory}")
    private String fileUploadDirectory = "D:\\upload\\temp";
    //默认加载上传文件的列表
    /*@RequestMapping(value = "/upload", method = RequestMethod.GET)
    public @ResponseBody Map<String, Object> list() {
    	log.debug("uploadGet called");
    	//获取上传文件的集合
        List<Image> list = imageService.list();
        for(Image image : list) {
        	//url路径为后台路径，通过方法获取对应的图片路径
            image.setUrl("../img/picture/"+image.getId()+".do");
            //thumbnailurl路径为后台路径，通过方法获取对应的缩略图片路径
            image.setThumbnailUrl("../img/thumbnail/"+image.getId()+".do");
            //deleteUrl为后台路径，通过方法删除图片
            image.setDeleteUrl("../img/delete/"+image.getId()+".do");
            image.setDeleteType("DELETE");
        }
        Map<String, Object> files = new HashMap<String, Object>();
        files.put("files", list);
        return files;
    }*/
    //上传图片
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> upload(MultipartHttpServletRequest request, HttpServletResponse response, Integer reqid) {
    	log.debug("uploadPost called");
    	System.out.println("请求id是"+reqid);
    	//获取上传的文件名集合
    	Iterator<String> itr = request.getFileNames();
        MultipartFile mpf;
        List<Image> list = new LinkedList<Image>();
        
        InputStream is = null;
        List<File> newfiles = new ArrayList<File>();
        while (itr.hasNext()) {
            mpf = request.getFile(itr.next());
            //新生成一个uuid的名字
            String newFilenameBase = UUID.randomUUID().toString();
            //获取上传的文件后缀名
            String originalFileExtension = mpf.getOriginalFilename().substring(mpf.getOriginalFilename().lastIndexOf("."));
            //组合出新的文件名
            String newFilename = newFilenameBase + originalFileExtension;
            //获取上传文件的路径
            //String storageDirectory = request.getSession().getServletContext().getRealPath("/")+"pic";
            //fileUploadDirectory = storageDirectory;
            String storageDirectory = fileUploadDirectory;
            String contentType = mpf.getContentType();
            //在上传路径新建一个空文件
            File newFile = new File(storageDirectory + "/" + newFilename);
            try {
            	//读取文件流       
            	is = mpf.getInputStream();        
            	byte[] bytes = FileCopyUtils.copyToByteArray(is); 
            	//将上传的文件传输到新建的空文件
                mpf.transferTo(newFile);
                //设置缩略图的宽度
                BufferedImage thumbnail = Scalr.resize(ImageIO.read(newFile), 290);
                //设置缩略图的名字，uuid-thumbnail.png
                String thumbnailFilename = newFilenameBase + "-thumbnail.png";
                //设置缩略图的路径
                File thumbnailFile = new File(storageDirectory + "/" + thumbnailFilename);
                ImageIO.write(thumbnail, "png", thumbnailFile);
                //新建一个image对象，给对象赋值
                Image image = new Image();
                //保存blob
                image.setImgblob(bytes);
                //image.setName(mpf.getOriginalFilename());
                image.setName(newFilename);
                image.setThumbnailFilename(thumbnailFilename);
                image.setNewFilename(newFilename);
                image.setContentType(contentType);
                image.setSize(mpf.getSize());
                image.setThumbnailSize(thumbnailFile.length());
                //获取给新添加图片设置的id
                int id = this.imageService.findId();
                image.setId(id);
                //设置url
                image.setUrl("../img/picture/"+image.getId()+".do");
                image.setThumbnailUrl("../img/thumbnail/"+image.getId()+".do");
                image.setDeleteUrl("../img/delete/"+image.getId()+".do");
                image.setDeleteType("DELETE");
                //添加到数据库
                image.setReqid(reqid);
                image = imageService.create(image);
                
                newfiles.add(newFile);
                //在页面下面追加显示
                list.add(image);
                
            } catch(IOException e) {
            	log.error("Could not upload file "+mpf.getOriginalFilename(), e);
            } finally { 
                IOUtils.closeQuietly(is); 
            }
            
        }
        
        Map<String, Object> files = new HashMap<String, Object>();
        files.put("files", list);
        return files;
    }
    
    //页面显示原图片
    @RequestMapping(value = "/picture/{id}", method = RequestMethod.GET)
    public void picture(HttpServletResponse response, @PathVariable int id) {
        Image image = imageService.get(id);
        File imageFile = new File(fileUploadDirectory+"/"+image.getName());
//        response.setContentType(image.getContentType());
//        response.setContentLength(image.getSize().intValue());
        try {
            InputStream is = new FileInputStream(imageFile);
            IOUtils.copy(is, response.getOutputStream());
            is.close();//关流，否则会出现删除时图片被程序占用而无法删除的情况
        } catch(IOException e) {
        	log.error("Could not show picture "+id, e);
        }
    }
    //页面显示缩略图
    @RequestMapping(value = "/thumbnail/{id}", method = RequestMethod.GET)
    public void thumbnail(HttpServletResponse response, @PathVariable int id) {
    	System.out.println(fileUploadDirectory);
        Image image = imageService.get(id);
        String string = image.getName().substring(0,image.getName().lastIndexOf("."));
        File imageFile = new File(fileUploadDirectory+"/"+string+"-thumbnail.png");
//        response.setContentType(image.getContentType());
//        response.setContentLength(image.getThumbnailSize().intValue());
        try {
            InputStream is = new FileInputStream(imageFile);
            IOUtils.copy(is, response.getOutputStream());
            is.close();//关流，否则会出现删除时图片被程序占用而无法删除的情况
        } catch(IOException e) {
        	log.error("Could not show thumbnail "+id, e);
        }
        
    }
    //删除图片
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.DELETE)
    public @ResponseBody List<Map<String, Object>> delete(@PathVariable int id) {
    	System.out.println(fileUploadDirectory);
        Image image = imageService.get(id);
        System.out.println("删除原图片地址："+fileUploadDirectory+"\\"+image.getName());
        File imageFile = new File(fileUploadDirectory+"\\"+image.getName());
        imageFile.delete();
        String string = image.getName().substring(0,image.getName().lastIndexOf("."));
        System.out.println("删除缩略图片地址："+fileUploadDirectory+"\\"+string+"-thumbnail.png");
        File thumbnailFile = new File(fileUploadDirectory+"\\"+string+"-thumbnail.png");
        thumbnailFile.delete();
        imageService.delete(id);
        List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
        Map<String, Object> success = new HashMap<String, Object>();
        success.put("success", true);
        results.add(success);
        return results;
    }
    //需求列表下载附件
    @RequestMapping("downloadImg")
    public void downloadImg(Integer id,HttpServletRequest request, HttpServletResponse response){
    	Image image = imageService.get(id);
    	String imgname = image.getName();
    	ServletOutputStream out = null;
    	try {
    		response.reset();
    		String userAgent = request.getHeader("User-Agent");
    		byte[] bytes = userAgent.contains("MSIE") ? imgname.getBytes() : imgname.getBytes("UTF-8"); 
    		// fileName.getBytes("UTF-8")处理safari的乱码问题
    		String fileName = new String(bytes, "ISO-8859-1");
    		System.out.println(fileName);
    		// 设置输出的格式
    		response.setContentType("multipart/form-data");
    		response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode(imgname,  "UTF-8"));
    		//获取blob字段
    		byte[] contents = image.getImgblob();
    		out = response.getOutputStream();
    		//写到输出流
    		out.write(contents);
    		out.flush();
    		} catch (IOException e) {
    			e.printStackTrace();
    			} 
    	}
    	
}
