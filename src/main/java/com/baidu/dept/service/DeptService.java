/**日期:2016-11-29下午2:11:09
 * 姓名:李黎
 */
package com.baidu.dept.service;

import java.util.List;

import com.baidu.dept.entity.Dept;

public interface DeptService {

	List<Dept> list();

	List<Dept> findChildren(Integer id);

}
