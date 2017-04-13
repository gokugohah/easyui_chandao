/**日期:2016-11-30下午3:51:37
 * 姓名:李黎
 */
package com.baidu.power.dao;

import java.util.List;

import com.baidu.power.entity.Power;

public interface PowerDAO {

	List<Power> list();

	List<Power> findChildren(Integer id);

}
