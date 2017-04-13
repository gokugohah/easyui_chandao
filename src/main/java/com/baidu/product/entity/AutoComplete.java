/**日期:2016-12-8下午7:32:47
 * 姓名:李黎
 */
package com.baidu.product.entity;

public class AutoComplete {
	private Integer id;
	private String label;
	private String value;
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	@Override
	public String toString() {
		return "AutoComplete [id=" + id + ", label=" + label + ", value="
				+ value + "]";
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
}
