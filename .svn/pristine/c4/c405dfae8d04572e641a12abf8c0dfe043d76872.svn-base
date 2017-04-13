/**日期:2016-11-29下午2:11:14
 * 姓名:李黎
 */
package com.baidu.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baidu.user.dao.UserDAO;
import com.baidu.user.entity.User;
@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDAO userDAO;
	
	@Override
	public String login(User user) {
		User user0 = this.userDAO.login(user);
		if(user0!=null){
			return "1";
		}
		return "0";
	}

	@Override
	public List<User> list() {
		List<User> list = this.userDAO.list();
		return list;
	}

	@Override
	public void addAll(List<User> userList) {
		this.userDAO.addAll(userList);
	}

	@Override
	public void updateAll(List<User> userList) {
		this.userDAO.updateAll(userList);
	}

}
