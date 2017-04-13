/**日期:2016-12-15下午2:42:23
 * 姓名:李黎
 */
package com.baidu.product.entity;

public class Charts {
	private String label;
	private int value;
	private String name;
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public int getValue() {
		return value;
	}
	public void setValue(int value) {
		this.value = value;
	}
	@Override
	public String toString() {
		return "Charts [label=" + label + ", value=" + value + ", name=" + name
				+ "]";
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
