/**日期:2016-11-29下午4:20:31
 * 姓名:李黎
 */
package com.baidu.menu.entity;


public class Menu {
	private Integer id;
	private String name;
	private Integer pid;
	private String url;
	private Integer orderby;
	private Integer iconId;
	private String iconCls;
	private String parentName;
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
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Integer getOrderby() {
		return orderby;
	}
	public void setOrderby(Integer orderby) {
		this.orderby = orderby;
	}
	public Integer getIconId() {
		return iconId;
	}
	public void setIconId(Integer iconId) {
		this.iconId = iconId;
	}
	public String getIconCls() {
		return iconCls;
	}
	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	@Override
	public String toString() {
		return "Menu [id=" + id + ", name=" + name + ", pid=" + pid + ", url="
				+ url + ", orderby=" + orderby + ", iconId=" + iconId
				+ ", iconCls=" + iconCls + ", parentName=" + parentName + "]";
	}
	
}
