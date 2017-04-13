/**日期:2016-11-29下午4:22:59
 * 姓名:李黎
 */
package com.baidu.menu.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baidu.menu.dao.MenuDAO;
import com.baidu.menu.entity.Menu;
@Service
public class MenuServiceImpl implements MenuService {
	@Autowired
	private MenuDAO menuDAO;
	@Override
	public List<Menu> list() {
		return this.menuDAO.list();
	}
	@Override
	public Map<String, Object> listAll(Integer page, Integer rows) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", (page-1)*rows+1);
		map.put("end", page*rows);
		int total = this.menuDAO.total();
		List<Menu> list = this.menuDAO.listAll(map);
		map.clear();
		map.put("total", total);
		map.put("rows", list);
		return map;
	}
	@Override
	public void add(Menu menu) {
		this.menuDAO.add(menu);
	}
	@Override
	public List<Menu> iconList() {
		return this.menuDAO.iconList();
	}
	@Override
	public void update(Menu menu) {
		this.menuDAO.update(menu);
	}
	@Override
	public void delete(String ids) {
		this.menuDAO.delete(ids);
	}

}
