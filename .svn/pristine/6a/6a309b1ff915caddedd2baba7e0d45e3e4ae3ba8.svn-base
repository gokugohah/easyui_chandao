/**日期:2016-12-9下午8:26:03
 * 姓名:李黎
 */
package com.baidu.upload.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baidu.upload.dao.ImageDAO;
import com.baidu.upload.entity.Image;
@Service
public class ImageServiceImpl implements ImageService {
	@Autowired
	private ImageDAO imageDAO;
	
	@Override
	public List<Image> list() {
		return this.imageDAO.list();
	}

	@Override
	public Image create(Image image) {
		this.imageDAO.create(image);
		System.out.println(image);
		return image;
	}

	@Override
	public Image get(int id) {
		return this.imageDAO.get(id);
	}

	@Override
	public void delete(int id) {
		this.imageDAO.delete(id);
	}

	@Override
	public int findId() {
		return this.imageDAO.findId();
	}

}
