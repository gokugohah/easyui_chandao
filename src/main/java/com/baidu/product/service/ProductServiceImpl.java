/**日期:2016-11-29下午2:11:14
 * 姓名:李黎
 */
package com.baidu.product.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baidu.product.dao.ProductDAO;
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
@Service
public class ProductServiceImpl implements ProductService {
	@Autowired
	private ProductDAO productDAO;

	@Override
	public List<Product> list() {
		return this.productDAO.list();
	}

	@Override
	public void add(Product product) {
		this.productDAO.add(product);
	}

	@Override
	public List<Znotes> userList() {
		List<Znotes> userList = this.productDAO.userList();
		return userList;
	}

	@Override
	public List<ProType> protypeList() {
		return this.productDAO.protypeList();
	}

	@Override
	public List<ProductModel> modelList(ProductModel pm) {
		return this.productDAO.modelList(pm);
	}

	@Override
	public List<ProductPlan> planList(ProductPlan pp) {
		return this.productDAO.planList(pp);
	}

	@Override
	public List<ProductFrom> fromList(ProductFrom pf) {
		return this.productDAO.fromList(pf);
	}

	@Override
	public void addRequire(ProductRequire pr) {
		this.productDAO.addRequire(pr);
	}

	@Override
	public List<AutoComplete> userAll(String term) {
		return this.productDAO.userAll(term);
	}

	@Override
	public List<ProductRequire> requireList() {
		List<ProductRequire> requireList = this.productDAO.requireList();
		for (ProductRequire pr : requireList) {
			pr.setTousers(this.productDAO.toUserName(pr.getTousers()));
		}
		return requireList;
	}

	@Override
	public ProductRequire findRequire(Integer reqid) {
		return this.productDAO.findRequire(reqid);
	}

	@Override
	public List<User> findToUsers(String tousers) {
		return this.productDAO.findToUsers(tousers);
	}

	@Override
	public Map<String, Object> charts(String chart) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Charts> charts = new ArrayList<Charts>();
		
		String tablename = "";
		String chartid = "";
		//优先级没有表，需要特别写sql语句
		if(!"prolevel".equals(chart)){
			//产品表起名不规律
			if("product".equals(chart)){
				tablename = "t_product";
				chartid = "proid";
			}else{
				tablename = "t_pro"+chart;
				chartid = chart+"id";
			}
			map.put("tablename", tablename);
			map.put("chartid", chartid);
			charts = this.productDAO.charts(map);
		}else{
			charts = this.productDAO.prolevelCharts();
		}
		String[] nameArray = new String[charts.size()];
		int[] valueArray = new int[charts.size()];
    	int i = 0;
    	for (Charts c : charts) {
			nameArray[i] = c.getName();
			i++;
		}
    	int j = 0;
    	for (Charts c : charts) {
    		valueArray[j] = c.getValue();
    		j++;
    	}
    	map.put("list", charts);
    	map.put("nameArray", nameArray);
    	map.put("valueArray", valueArray);
    	return map;
	}

	@Override
	public void update(Product product) {
		this.productDAO.update(product);
	}

	@Override
	public List<TableHead> findTableHead() {
		return this.productDAO.findTableHead();
	}

	@Override
	public List<Map<String,Object>> findTable() {
		List<Map<String,Object>> list = this.productDAO.findTable();
		for (Map<String,Object> map : list) {
			String userName = this.productDAO.toUserName(map.get("TOUSERS").toString());
			map.put("TOUSERS", userName);
		}
		return list;
	}
	
	@Override
	public List<Product> findProductMap() {
		return this.productDAO.findProductMap();
	}
	
	@Override
	public List<ProductModel> findModelMap() {
		return this.productDAO.findModelMap();
	}
	
	@Override
	public List<ProductPlan> findPlanMap() {
		return this.productDAO.findPlanMap();
	}
	
	@Override
	public List<ProductFrom> findFromMap() {
		return this.productDAO.findFromMap();
	}
	
	@Override
	public List<User> findUserMap() {
		return this.productDAO.findUserMap();
	}

	@Override
	public List<Map<String, Object>> changeName(List<Map<String, Object>> reqlist) {
		List<Product> prolist =  this.findProductMap();
		List<ProductModel> modellist =  this.findModelMap();
		List<ProductPlan> planlist =  this.findPlanMap();
		List<ProductFrom> fromlist =  this.findFromMap();
		List<User> userlist =  this.findUserMap();
		for (Map<String, Object> map : reqlist) {
			String proname = map.get("proid").toString();
			String modelname = map.get("modelid").toString();
			String planname = map.get("planid").toString();
			String fromname = map.get("fromid").toString();
			for(Product pro:prolist){
				if(pro.getName().equals(proname)){
					map.put("proid", pro.getId());
				}
			}
			for(ProductModel model:modellist){
				if(model.getName().equals(modelname)){
					map.put("modelid", model.getId());
				}
			}
			for(ProductPlan plan:planlist){
				if(plan.getName().equals(planname)){
					map.put("planid", plan.getId());
				}
			}
			for(ProductFrom fr:fromlist){
				if(fr.getName().equals(fromname)){
					map.put("fromid", fr.getId());
				}
			}
			//抄送人
			String[] split = map.get("tousers").toString().split(",");
			String ids = "";
			for (int i = 0; i < split.length; i++) {
				for(User user:userlist){
					if(user.getName().equals(split[i])){
						ids += ","+ user.getId();
					}
				}
			}
			ids = ids==""?"":ids.substring(1);
			map.put("tousers", ids);
		}
		return reqlist;
	}

	@Override
	public void addOrUpdateRequire(List reqlist) {
		this.productDAO.addAllRequire(reqlist);
	}

}
