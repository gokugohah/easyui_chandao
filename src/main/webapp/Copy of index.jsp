<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/easyui/themes/ui-sunny/easyui.css" type="text/css"></link>
<link rel="stylesheet" href="${pageContext.request.contextPath}/easyui/themes/icon.css" type="text/css"></link>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery-1.8.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/locale/easyui-lang-zh_CN.js"></script>
</head>
<body class="easyui-layout">
    <div data-options="region:'north',iconCls:'icon-man',title:'标题'" style="height:100px;"></div>   
    <div data-options="region:'west',iconCls:'icon-search',title:'功能菜单'" style="width:200px;">
    	<div id="aa" class="easyui-accordion" border="0" fit="true">
    	<ul class="easyui-tree" data-options="lines:true">
    		<li data-options="state:'closed'">
    			<span>我的地盘</span>
		    	<ul class="easyui-tree">
	   				<li><a href="javascript:void(0)" onclick="addTabs('首页','')">首页</a></li>
	   				<li><a>待办</a></li>
	   				<li><a>任务</a></li>
	   				<li><a>Bug</a></li>
	   				<li><a>测试</a></li>
	   				<li><a>需求</a></li>
	   				<li><a>项目</a></li>
	   				<li><a>动态</a></li>
	   				<li><a>档案</a></li>
	   				<li><a>联系人</a></li>
		    	</ul>
	    	</li>
	    	<li data-options="state:'closed'">
	    		<span>产品</span>
	   			<ul class="easyui-tree">
	   				<li><a>需求</a></li>
	   				<li><a>动态</a></li>
	   				<li><a>计划</a></li>
	   				<li><a>发布</a></li>
	   				<li><a>路线图</a></li>
	   				<li><a>文档</a></li>
	   				<li><a>项目</a></li>
	   				<li><a>模块</a></li>
	   				<li><a>概况</a></li>
	   			</ul>
   			</li>
	    	<li data-options="state:'closed'">
	    		<span>项目</span>
	   			<ul class="easyui-tree">
	   				<li><a href="javascript:void(0)" onclick="addTabs()">任务</a></li>
	   				<li><a>需求</a></li>
	   				<li><a>Bug</a></li>
	   				<li><a>版本</a></li>
	   				<li><a>测试</a></li>
	   				<li><a>团队</a></li>
	   				<li><a>动态</a></li>
	   				<li><a>文档</a></li>
	   				<li><a>产品</a></li>
	   				<li><a>概况</a></li>
	   			</ul>
   			</li>
	    	<li data-options="state:'closed'">
	    		<span>测试</span>
	   			<ul class="easyui-tree">
	   				<li><a href="javascript:void(0)" onclick="addTabs()">Bug</a></li>
	   				<li><a>用例</a></li>
	   				<li><a>版本</a></li>
	   			</ul>
   			</li>
	    	<li data-options="state:'closed'">
	    		<span>文档</span>
   			</li>
	    	<li data-options="state:'closed'">
	    		<span>统计</span>
	   			<ul class="easyui-tree">
	   				<li><a href="javascript:void(0)" onclick="addTabs()">产品</a></li>
	   				<li><a>项目</a></li>
	   				<li><a>测试</a></li>
	   				<li><a>组织</a></li>
	   			</ul>
   			</li>
	    	<li data-options="state:'closed'">
	    		<span>组织</span>
	   			<ul class="easyui-tree">
	   				<li><a href="javascript:void(0)" onclick="addTabs()">用户</a></li>
	   				<li><a>部门</a></li>
	   				<li><a>权限</a></li>
	   				<li><a>公司</a></li>
	   				<li><a>动态</a></li>
	   			</ul>
   			</li>
    	</ul>
    	</div> 
    	</div> 
    </div>   
    <div data-options="region:'center'" style="border:0;background:#eee;">
    
	    <div id="tabs" class="easyui-tabs" fit="true">   
		    <div title="Demo" data-options="iconCls:'icon-man'" style="padding: 200px 400px;">   
		        <h1>易软天创项目管理系统</h1>    
		    </div>   
		</div> 
    
    </div>   
    
<script type="text/javascript">
	function addTabs(){
		
	}
</script>
</body>
</html>