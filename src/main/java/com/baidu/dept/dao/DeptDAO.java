/**日期:2016-11-29下午2:16:40
 * 姓名:李黎
 */
package com.baidu.dept.dao;

import java.util.List;

import com.baidu.dept.entity.Dept;

public interface DeptDAO {

	List<Dept> list();

	List<Dept> findChildren(Integer id);

}
