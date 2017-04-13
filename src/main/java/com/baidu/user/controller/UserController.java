/**日期:2016-11-29下午2:10:18
 * 姓名:李黎
 */
package com.baidu.user.controller;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baidu.user.entity.User;
import com.baidu.user.service.UserService;

@Controller
@RequestMapping("user")
public class UserController {
	@Autowired
	private UserService userService;
	@RequestMapping("touserPage")
	public String touserPage(){
		return "user/user_list";
	}
	@RequestMapping("login")
	@ResponseBody
	public String login(User user){
		String i = this.userService.login(user);
		return i;
	}
	@RequestMapping("list")
	@ResponseBody
	public List<User> list(){
		List<User> list = this.userService.list();
		return list;
	}
	@RequestMapping("addAll")
	@ResponseBody
	public String addAll(String json){
		//从前台接到的是json字符串，需要先转成jsonarray，定义一个空的user数组用于存放jsonarray
		JSONArray ja = JSONArray.fromObject(json);
		List<User> userList = new ArrayList<User>();
		for(int i=0;i<ja.size();i++){
			JSONObject jo = ja.getJSONObject(i);
			User user = (User) JSONObject.toBean(jo,User.class);
			user.setDeptId(Integer.parseInt(user.getDeptName()));
			userList.add(user);
		}
		this.userService.addAll(userList);
		return "1";
	}
	@RequestMapping("updateAll")
	@ResponseBody
	public String updateAll(String json){
		//从前台接到的是json字符串，需要先转成jsonarray，定义一个空的user数组用于存放jsonarray
		JSONArray ja = JSONArray.fromObject(json);
		List<User> userList = new ArrayList<User>();
		for(int i=0;i<ja.size();i++){
			JSONObject jo = ja.getJSONObject(i);
			User user = (User) JSONObject.toBean(jo,User.class);
			try {
				user.setDeptId(Integer.parseInt(user.getDeptName()));
				System.out.println("部门修改了");
			} catch (Exception e) {
				System.out.println("部门未修改");
			}
			
			userList.add(user);
		}
		this.userService.updateAll(userList);
		return "1";
	}
}
