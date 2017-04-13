/**日期:2016-12-7下午2:34:43
 * 姓名:李黎
 */
package com.baidu.product.entity;

public class ProductFrom {
	private Integer id;
	private String name;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Override
	public String toString() {
		return "ProductFrom [id=" + id + ", name=" + name + "]";
	}
	
}
