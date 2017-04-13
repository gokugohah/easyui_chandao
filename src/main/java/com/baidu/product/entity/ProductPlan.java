/**日期:2016-12-7上午10:43:58
 * 姓名:李黎
 */
package com.baidu.product.entity;

public class ProductPlan {
	private Integer id;
	private String name;
	private String content;
	private String startdate;
	private String enddate;
	private Integer proid;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public Integer getProid() {
		return proid;
	}
	public void setProid(Integer proid) {
		this.proid = proid;
	}
	@Override
	public String toString() {
		return "ProductPlan [id=" + id + ", name=" + name + ", content="
				+ content + ", startdate=" + startdate + ", enddate=" + enddate
				+ ", proid=" + proid + "]";
	}
	
}
