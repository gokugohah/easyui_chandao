/**日期:2016-11-29下午2:10:18
 * 姓名:李黎
 */
package com.baidu.power.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baidu.power.entity.Power;
import com.baidu.power.service.PowerService;

@Controller
@RequestMapping("power")
public class PowerController {
	@Autowired
	private PowerService powerService;
	@RequestMapping("topowerPage")
	public String topowerPage(){
		return "power/power_list";
	}
	@RequestMapping("list")
	@ResponseBody
	public List<Power> list(){
		List<Power> list = this.powerService.list();
		return list;
	}
}
