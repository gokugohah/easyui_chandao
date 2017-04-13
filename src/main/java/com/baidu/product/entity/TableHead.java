/**日期:2016-12-26上午11:10:07
 * 姓名:李黎
 */
package com.baidu.product.entity;

public class TableHead {
	private String column_name;
	private String comments;
	public String getColumn_name() {
		return column_name;
	}
	public void setColumn_name(String column_name) {
		this.column_name = column_name;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	@Override
	public String toString() {
		return "TableHead [column_name=" + column_name + ", comments="
				+ comments + "]";
	}
	public TableHead() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TableHead(String column_name, String comments) {
		super();
		this.column_name = column_name;
		this.comments = comments;
	}
	
}
