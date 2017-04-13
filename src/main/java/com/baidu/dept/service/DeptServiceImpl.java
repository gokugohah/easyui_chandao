/**日期:2016-11-29下午2:11:14
 * 姓名:李黎
 */
package com.baidu.dept.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baidu.dept.dao.DeptDAO;
import com.baidu.dept.entity.Dept;
@Service
public class DeptServiceImpl implements DeptService {
	@Autowired
	private DeptDAO deptDAO;

	@Override
	public List<Dept> list() {
		return this.deptDAO.list();
	}

	@Override
	public List<Dept> findChildren(Integer id) {
		return this.deptDAO.findChildren(id);
	}
	
	

}
