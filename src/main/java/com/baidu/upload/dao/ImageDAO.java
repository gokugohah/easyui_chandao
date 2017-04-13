/**日期:2016-12-10上午8:05:55
 * 姓名:李黎
 */
package com.baidu.upload.dao;

import java.util.List;

import com.baidu.upload.entity.Image;

public interface ImageDAO {

	List<Image> list();

	void create(Image image);

	int findId();

	Image get(int id);

	void delete(int id);

}
