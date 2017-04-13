/**日期:2016-11-29下午2:10:18
 * 姓名:李黎
 */
package com.baidu.dept.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baidu.dept.entity.Dept;
import com.baidu.dept.service.DeptService;

@Controller
@RequestMapping("dept")
public class DeptController {
	@Autowired
	private DeptService deptService;
	@RequestMapping("todeptPage")
	public String todeptPage(){
		return "dept/dept_list";
	}
	@RequestMapping("list")
	@ResponseBody
	public List<Dept> list(){
		List<Dept> list = this.deptService.list();
		return list;
	}
	@RequestMapping("findChildren")
	@ResponseBody
	public List<Dept> findChildren(Integer id){
		List<Dept> childList = this.deptService.findChildren(id);
		return childList;
	}
}
