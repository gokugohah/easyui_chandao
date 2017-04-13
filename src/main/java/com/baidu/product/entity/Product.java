/**日期:2016-11-29下午2:04:34
 * 姓名:李黎
 */
package com.baidu.product.entity;

public class Product {
	private Integer id;
	private String name;
	private String version;
	private Integer pro_userId;
	private String pro_userName;
	private Integer test_userId;
	private String test_userName;
	private Integer pub_userId;
	private String pub_userName;
	private Integer pro_typeId;
	private String pro_typeName;
	private String content;
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
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public Integer getPro_userId() {
		return pro_userId;
	}
	public void setPro_userId(Integer pro_userId) {
		this.pro_userId = pro_userId;
	}
	public String getPro_userName() {
		return pro_userName;
	}
	public void setPro_userName(String pro_userName) {
		this.pro_userName = pro_userName;
	}
	public Integer getTest_userId() {
		return test_userId;
	}
	public void setTest_userId(Integer test_userId) {
		this.test_userId = test_userId;
	}
	public String getTest_userName() {
		return test_userName;
	}
	public void setTest_userName(String test_userName) {
		this.test_userName = test_userName;
	}
	public Integer getPub_userId() {
		return pub_userId;
	}
	public void setPub_userId(Integer pub_userId) {
		this.pub_userId = pub_userId;
	}
	public String getPub_userName() {
		return pub_userName;
	}
	public void setPub_userName(String pub_userName) {
		this.pub_userName = pub_userName;
	}
	public Integer getPro_typeId() {
		return pro_typeId;
	}
	public void setPro_typeId(Integer pro_typeId) {
		this.pro_typeId = pro_typeId;
	}
	public String getPro_typeName() {
		return pro_typeName;
	}
	public void setPro_typeName(String pro_typeName) {
		this.pro_typeName = pro_typeName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "Product [id=" + id + ", name=" + name + ", version=" + version
				+ ", pro_userId=" + pro_userId + ", pro_userName="
				+ pro_userName + ", test_userId=" + test_userId
				+ ", test_userName=" + test_userName + ", pub_userId="
				+ pub_userId + ", pub_userName=" + pub_userName
				+ ", pro_typeId=" + pro_typeId + ", pro_typeName="
				+ pro_typeName + ", content=" + content + "]";
	}
	
	
}
