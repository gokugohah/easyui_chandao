<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="upload/style.css" type="text/css"></link>
<!-- easyui的css、js -->
<link rel="stylesheet" href="easyui/themes/ui-sunny/easyui.css" type="text/css"></link>
<link rel="stylesheet" href="easyui/themes/icon.css" type="text/css"></link>
<script type="text/javascript" src="easyui/jquery-1.8.2.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="easyui/syUtil.js"></script>
<!-- 报表 -->
<script type="text/javascript" src="charts/fusioncharts/fusioncharts.js"></script>
<script type="text/javascript" src="charts/echarts/echarts.js"></script>
</head>
<body class="easyui-layout">
    <div data-options="region:'north',iconCls:'icon-man',title:'标题'" style="height:100px;"></div>   
    <div data-options="region:'west',iconCls:'icon-search',title:'功能菜单'" style="width:200px;">
    	<div id="aa" class="easyui-accordion" border="0" fit="true">
    	<ul id="tree" class="easyui-tree" data-options="lines:true" ></ul>
    	</div> 
    </div> 
    <div data-options="region:'center',iconCls:'icon-man',title:'易软天创项目管理系统'" style="border:0;">
    
	    <div id="tabs" class="easyui-tabs" data-options="fit:'true',tabWidth:100"></div> 
    
    </div>   
<script type="text/javascript">
	$("#tree").tree({
		url:"${pageContext.request.contextPath}/menu/list.do",
		textField:"name",
		parentField:"pid",
		onLoadSuccess:function(node){
			$("#tree").tree('collapseAll');//加载成功后折叠所有子节点
		},
		onClick: function(node){
			if($("#tree").tree('isLeaf',node.target)){
				addTabs(node.name,node.url);
			}else{
				var tabs = $("#tabs").tabs('tabs');
				for(var j=tabs.length-1;j>=0;j--){
					$("#tabs").tabs('close',j);
				}
				var children = $("#tree").tree('getChildren',node.target);
				for(var i=0;i<children.length;i++){
					addTabs(children[i].name,children[i].url);
				}
			}
		}
	});
	
	function addTabs(title,url){
		var flag = $("#tabs").tabs('exists',title);
		if(flag){
			$("#tabs").tabs('select',title);
		}else{
			$("#tabs").tabs('add',{
				closable:'true',
				title:title,
				href:"${pageContext.request.contextPath}/"+url
			});
		}
	}
</script>
</body>
</html>