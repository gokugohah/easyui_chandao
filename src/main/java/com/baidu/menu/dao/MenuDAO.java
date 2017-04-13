/**日期:2016-11-29下午4:25:33
 * 姓名:李黎
 */
package com.baidu.menu.dao;

import java.util.List;
import java.util.Map;

import com.baidu.menu.entity.Menu;

public interface MenuDAO {
	
	List<Menu> list();
	
	int total();

	List<Menu> listAll(Map<String, Object> map);

	void add(Menu menu);

	List<Menu> iconList();

	void update(Menu menu);

	void delete(String ids);

}
