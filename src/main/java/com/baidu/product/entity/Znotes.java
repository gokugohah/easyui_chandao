/**日期:2016-12-6上午9:19:40
 * 姓名:李黎
 */
package com.baidu.product.entity;


public class Znotes {
	private String id;
	private String name;
	private String pId;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	@Override
	public String toString() {
		return "Znotes [id=" + id + ", name=" + name + ", pId=" + pId + "]";
	}
	
}
