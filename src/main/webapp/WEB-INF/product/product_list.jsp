<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table id="productList" fit="true"></table>
<div id="proButtons">
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="updatePro()" data-options="iconCls:'icon-edit'"></a>
</div>
<!-- 通过textbox的按钮点击，弹出一个dialog，里面是以zTree的形式展示的部门与员工 -->
<div id="userDialog2" class="easyui-dialog" data-options="resizable:true,closed:true,modal:true" style="width:250px;height:400px;">
	<iframe id="iframeTree" src="${pageContext.request.contextPath}/product/toZtree.do" style="width:100%;height:100%;border: none;"></iframe>
</div>
<div id="proUpdateDialog" class="easyui-dialog" data-options="resizable:true,closed:true,modal:true" >
	<form id="updateProductForm" method="post">
		<input type="hidden" name="id">
		产品名称：<input name="name" class="easyui-validatebox" data-options="required:true"><br><br>
		产品代号：<input name="version" class="easyui-validatebox" data-options="required:true"><br><br>
		<!-- 设置一个隐藏的文本框，用于放dialog返回的id -->
		<input type="hidden" id="pro_userId2" name="pro_userId">
		产品负责人：<input id="pro_user2" name="pro_userName" class="easyui-textbox" data-options="width:150,
				 icons: [{iconCls:'icon-add',handler:function(){
				 	prefix = 'pro';
					$('#userDialog2').dialog('open');
					window.frames['iframeTree'].contentWindow.updateTree($('#pro_userId2').val());
				 }}]"><br><br>
		
		<input type="hidden" id="test_userId2" name="test_userId">
		测试负责人：<input id="test_user2" name="test_userName" class="easyui-textbox" data-options="width:150,
				 icons: [{iconCls:'icon-add',handler:function(){
				 	prefix = 'test';
					$('#userDialog2').dialog('open');
					window.frames['iframeTree'].contentWindow.updateTree($('#test_userId2').val());
				 }}]"><br><br>
		
		<input type="hidden" id="pub_userId2" name="pub_userId">
		发布负责人：<input id="pub_user2" name="pub_userName" class="easyui-textbox" data-options="width:150,
				 icons: [{iconCls:'icon-add',handler:function(){
				 	prefix = 'pub';
					$('#userDialog2').dialog('open');
					window.frames['iframeTree'].contentWindow.updateTree($('#pub_userId2').val());
				 }}]"><br><br>
		产品类型：<input name="pro_typeId" class="easyui-combobox"
				 data-options="
				 url:'${pageContext.request.contextPath}/product/protypeList.do',
				 valueField:'id',
				 textField:'name',
				 width:150,
				 panelHeight:'auto'
				 "><br><br>
		产品内容：<iframe id="updateProFrame" src="${pageContext.request.contextPath}/product/toContent.do" height="180" width="790"></iframe><br><br>
		<!-- 设置一个隐藏的文本域，用于放从iframe子页面返回的值 -->
		<textarea name="content" style="display:none;"></textarea>
		
		<a href="javascript:void(0)" onclick="updateProduct()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">保存</a><br><br>
	</form>
</div>
<script type="text/javascript">
	//设置一个全局变量，用于dialog里的zTree节点点击事件给父页面赋值时，确定文本框的id用
	var prefix = "";
	
	$("#productList").datagrid({
		url:"${pageContext.request.contextPath}/product/list.do",
		columns:[[
			{field:'id',title:'产品编号',align:'center',width:100},
			{field:'name',title:'产品名称',align:'center',width:100},
			{field:'version',title:'产品代号',align:'center',width:100},
			{field:'pro_userName',title:'产品负责人',align:'center',width:100},
			{field:'test_userName',title:'测试负责人',align:'center',width:100},
			{field:'pub_userName',title:'发布负责人',align:'center',width:100},
			{field:'pro_typeName',title:'产品类型',align:'center',width:100},
			{field:'content',title:'产品内容',align:'center',width:100},
		]],
		fitColumns:true,
		//pagination:true,
		singleSelect:true,
		toolbar:"#proButtons"
	});
	//定义zTree弹出窗口每次关闭后自动收缩所有节点
	$("#userDialog2").dialog({
		onClose:function(){
			$("#iframeTree").contents().find("#tags").val("");
			//父页面调用子页面的方法
			window.frames["iframeTree"].contentWindow.expandTree(false);
		}
	});
	//修改功能
	function updatePro(){
		var rows = $("#productList").datagrid('getSelections');
		console.info(rows[0]);
		if(rows.length==1){
			$("#proUpdateDialog").dialog('open');
			$("#updateProductForm").form('load',rows[0]);
		}else{
			alert("请选择一项修改！")
		}
	}
	//zTree子页面点击节点赋值时，调用该方法，来操作父页面
	function setZtree(id,name){
		//点击节点，给父页面对应的文本框赋值（通过变量拼接来区分不同的id）
		$("#"+prefix+"_userId2").val(id);
		$("#"+prefix+"_user2").textbox('setValue',name);
		//赋值完毕，关闭dialog
		$("#userDialog2").dialog('close');
	}
	//修改
	function updateProduct(){
		$("#updateProductForm").form('submit',{
			url:"${pageContext.request.contextPath}/product/update.do",
			onSubmit:function(){
				var isValid = $(this).form('validate');
				return isValid;
			},
			success:function(msg){
				$.messager.show({
					title:"修改结果",
					msg:"修改成功！",
					timeout:2000,
					showType:'fade'
				});
				$("#proUpdateDialog").dialog('close');
				$("#productList").datagrid('load');
			}
		});
	}
</script>
</body>
</html>