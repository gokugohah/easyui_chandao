/**日期:2016-11-29下午2:11:09
 * 姓名:李黎
 */
package com.baidu.product.service;

import java.util.List;
import java.util.Map;

import com.baidu.product.entity.AutoComplete;
import com.baidu.product.entity.ProType;
import com.baidu.product.entity.Product;
import com.baidu.product.entity.ProductFrom;
import com.baidu.product.entity.ProductModel;
import com.baidu.product.entity.ProductPlan;
import com.baidu.product.entity.ProductRequire;
import com.baidu.product.entity.TableHead;
import com.baidu.product.entity.Znotes;
import com.baidu.user.entity.User;

public interface ProductService {

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

	Map<String, Object> charts(String chart);

	void update(Product product);
	//获取导出表格的表头
	List<TableHead> findTableHead();
	//获取表格的数据
	List<Map<String,Object>> findTable();
	//处理reqlist，将里面联表显示的name换成对应的id
	List<Map<String, Object>> changeName(List<Map<String, Object>> reqlist);
	//添加或修改
	void addOrUpdateRequire(List reqlist);

	List<Product> findProductMap();

	List<ProductModel> findModelMap();

	List<ProductPlan> findPlanMap();

	List<ProductFrom> findFromMap();

	List<User> findUserMap();

}
