/**日期:2016-11-29下午4:21:02
 * 姓名:李黎
 */
package com.baidu.menu.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baidu.menu.entity.Menu;
import com.baidu.menu.service.MenuService;

@Controller
@RequestMapping("menu")
public class MenuController {
	@Autowired
	private MenuService menuService;
	@RequestMapping("tomenuPage")
	public String tomenuPage(){
		return "menu/menu_list";
	}
	@RequestMapping("list")
	@ResponseBody
	public List<Menu> list(){
		List<Menu> list = this.menuService.list();
		return list;
	}
	@RequestMapping("listAll")
	@ResponseBody
	public Map<String, Object> listAll(Integer page,Integer rows){
		Map<String, Object> map = this.menuService.listAll(page,rows);
		return map;
	}
	@RequestMapping("iconList")
	@ResponseBody
	public List<Menu> iconList(){
		List<Menu> iconList = this.menuService.iconList();
		return iconList;
	}
	@RequestMapping("add")
	@ResponseBody
	public String add(Menu menu){
		if(menu.getPid()==null){
			menu.setPid(0);
		}
		this.menuService.add(menu);
		return "1";
	}
	@RequestMapping("update")
	@ResponseBody
	public String update(Menu menu){
		this.menuService.update(menu);
		return "1";
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(String ids){
		this.menuService.delete(ids);
		return "1";
	}
}
