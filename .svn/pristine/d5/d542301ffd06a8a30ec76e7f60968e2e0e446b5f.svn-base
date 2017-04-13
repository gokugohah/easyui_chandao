/**日期:2016-11-30下午3:51:04
 * 姓名:李黎
 */
package com.baidu.power.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baidu.power.dao.PowerDAO;
import com.baidu.power.entity.Power;
@Service
public class PowerServiceImpl implements PowerService {
	@Autowired
	public PowerDAO powerDAO;
	
	@Override
	public List<Power> list() {
		List<Power> list = this.powerDAO.list();
		return list;//使用syUtil.js
//		return findChildren(list);//使用递归
	}
	//使用递归
	public List<Power> findChildren(List<Power> list){
		for (Power power : list) {
			List<Power> childrenList = this.powerDAO.findChildren(power.getId());
			if(childrenList!=null){
				findChildren(childrenList);
			}
			power.setChildren(childrenList);
		}
		return list;
	}

}
