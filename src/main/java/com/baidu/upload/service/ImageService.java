/**日期:2016-12-9下午8:26:03
 * 姓名:李黎
 */
package com.baidu.upload.service;

import java.util.List;

import com.baidu.upload.entity.Image;

public interface ImageService {

	List<Image> list();

	Image create(Image image);

	Image get(int id);

	void delete(int id);

	int findId();

}
