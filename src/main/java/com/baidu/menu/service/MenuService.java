/**日期:2016-11-29下午4:22:54
 * 姓名:李黎
 */
package com.baidu.menu.service;

import java.util.List;
import java.util.Map;

import com.baidu.menu.entity.Menu;

public interface MenuService {
	
	List<Menu> list();

	Map<String, Object> listAll(Integer page, Integer rows);

	void add(Menu menu);

	List<Menu> iconList();

	void update(Menu menu);

	void delete(String ids);

}
