/**日期:2016-11-29下午2:16:40
 * 姓名:李黎
 */
package com.baidu.product.dao;

import java.util.List;
import java.util.Map;

import com.baidu.product.entity.AutoComplete;
import com.baidu.product.entity.Charts;
import com.baidu.product.entity.ProType;
import com.baidu.product.entity.Product;
import com.baidu.product.entity.ProductFrom;
import com.baidu.product.entity.ProductModel;
import com.baidu.product.entity.ProductPlan;
import com.baidu.product.entity.ProductRequire;
import com.baidu.product.entity.TableHead;
import com.baidu.product.entity.Znotes;
import com.baidu.user.entity.User;

public interface ProductDAO {

	List<Product> list();

	void add(Product product);

	List<Znotes> userList();

	List<ProType> protypeList();

	List<ProductModel> modelList(ProductModel pm);

	List<ProductPlan> planList(ProductPlan pp);

	List<ProductFrom> fromList(ProductFrom pf);

	void addRequire(ProductRequire pr);

	List<AutoComplete> userAll(String term);

	List<ProductRequire> requireList();

	ProductRequire findRequire(Integer reqid);

	List<User> findToUsers(String tousers);

	List<Charts> prolevelCharts();

	List<Charts> charts(Map<String, Object> map);

	String toUserName(String tousers);

	void update(Product product);

	List<TableHead> findTableHead();

	List<Map<String,Object>> findTable();

	List<Product> findProductMap();

	List<ProductModel> findModelMap();

	List<ProductPlan> findPlanMap();

	List<ProductFrom> findFromMap();

	List<User> findUserMap();

	void addAllRequire(List<Map<String, Object>> reqlist);

}
