<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table id="powerList" fit="true"></table>
<div id="powerfunbuttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="addPower()" data-options="iconCls:'icon-add',plain:true">添加</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
</div>
<div id="addPowerDialog" class="easyui-dialog" style="width:500px;height:400px;"
	 data-options="title:'添加权限',iconCls:'icon-add',closed:true">
	<form id="addPowerForm" method="post">
		<table>
			<tr><td colspan="11"><br></td></tr>
			<tr>
				<td>权限名称：<input name="name"></td>
				<td>父权限：&nbsp;&nbsp;&nbsp;&nbsp;<input name="parentName"></td>
			</tr>
			<tr><td colspan="11"><br></td></tr>
			<tr>
				<td>权限类型：<input name="name"></td>
				<td>链接地址：<input name="parentName"></td>
			</tr><tr><td colspan="11"><br></td></tr>
			<tr>
				<td>图标：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="name"></td>
				<td>图标代码：<input name="parentName"></td>
			</tr><tr><td colspan="11"><br></td></tr>
			<tr>
				<td>排序：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="orderby"></td>
				<td></td>
			</tr><tr><td colspan="11"><br></td></tr>
			<tr>
				<td colspan="11"><input type="submit" value="保存"><input type="reset" value="清空"></td>
			</tr>
		</table>
	</form>
</div>
<script type="text/javascript">
	/* //使用递归
	$("#powerList").treegrid({
		url:"${pageContext.request.contextPath}/power/list.do",
		idField:'id',
		treeField:'name',
		columns:[[    
	        {field:'id',title:'编号',width:100,align:'center'},    
	        {field:'name',title:'权限名称',width:100,align:'center'}   
	    ]],
	    fitColumns:true
	}); */
	//使用syUtil.js
	$("#powerList").treegrid({
		url:"${pageContext.request.contextPath}/power/list.do",
		idField:'id',
		treeField:'name',
		parentField:'pid',
		columns:[[    
	        {field:'id',title:'编号',width:100,align:'center'},    
	        {field:'name',title:'权限名称',width:100,align:'center'},
	        {field:'function',title:'操作',width:100,align:'center',
	        	formatter:function(value,row,index){
	        		return "<a href='javascript:void(0)' class='bianji'>编辑</a>"
	        		+"<a href='javascript:void(0)' class='shanchu'>删除</a>"
	        		+"<a href='javascript:void(0)' class='fenpei'>权限分配</a>";
	        	}
	        	
	        }
	    ]],
	    fitColumns:true,
	    pagination:true,
	    pageSize:5,
	    pageList:[3,5,8],
	    toolbar:"#powerfunbuttons",
	    onLoadSuccess:function(data){
       		$(".bianji").linkbutton({
       			text:'编辑',
       			plain:true,
       			iconCls:'icon-edit'
       		});
       		$(".shanchu").linkbutton({
       			text:'删除',
       			plain:true,
       			iconCls:'icon-remove'
       		});
       		$(".fenpei").linkbutton({
       			text:'权限分配',
       			plain:true,
       			iconCls:'icon-ok'
       		});
	    	$("#powerList").treegrid('collapseAll');
       	}
	});
	function addPower(){
		$("#addPowerDialog").dialog('open');
	}
</script>
</body>
</html>