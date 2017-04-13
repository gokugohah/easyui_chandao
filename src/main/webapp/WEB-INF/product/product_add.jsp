<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div style="margin: 0 100px;">
<h1>新增产品</h1>
<form id="addProductForm" method="post">
	产品名称：<input name="name" class="easyui-validatebox" data-options="required:true"><br><br>
	产品代号：<input name="version" class="easyui-validatebox" data-options="required:true"><br><br>
	<!-- 设置一个隐藏的文本框，用于放dialog返回的id -->
	<input type="hidden" id="pro_userId1" name="pro_userId">
	产品负责人：<input id="pro_user1" class="easyui-textbox" data-options="width:150,icons: [{iconCls:'icon-add',handler:prouserChoose}]"><br><br>
	
	<input type="hidden" id="test_userId1" name="test_userId">
	测试负责人：<input id="test_user1" class="easyui-textbox" data-options="width:150,icons: [{iconCls:'icon-add',handler:testuserChoose}]"><br><br>
	
	<input type="hidden" id="pub_userId1" name="pub_userId">
	发布负责人：<input id="pub_user1" class="easyui-textbox" data-options="width:150,icons: [{iconCls:'icon-add',handler:pubuserChoose}]"><br><br>
	产品类型：<input name="pro_typeId" class="easyui-combobox"
			 data-options="
			 url:'${pageContext.request.contextPath}/product/protypeList.do',
			 valueField:'id',
			 textField:'name',
			 width:150,
			 panelHeight:'auto'
			 "><br><br>
	产品内容：<iframe src="${pageContext.request.contextPath}/product/toContent.do" height="180" width="790"></iframe><br><br>
	<!-- 设置一个隐藏的文本域，用于放从iframe子页面返回的值 -->
	<textarea name="content" style="display:none;"></textarea>
	
	<a href="javascript:void(0)" onclick="saveProduct()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">保存</a><br><br>
</form>
<!-- 通过textbox的按钮点击，弹出一个dialog，里面是以zTree的形式展示的部门与员工 -->
<div id="userDialog1" class="easyui-dialog" data-options="resizable:true,closed:true,modal:true" style="width:250px;height:400px;">
	<iframe src="${pageContext.request.contextPath}/product/toZtree.do" style="width:100%;height:100%;"></iframe>
</div>
</div>
<script type="text/javascript">
	//设置一个全局变量，用于dialog里的zTree节点点击事件给父页面赋值时，确定文本框的id用
	var prefix = "";
	//点击产品负责人选择按钮
	function prouserChoose(){
		//给全局变量赋值
		prefix = "pro";
		$("#userDialog1").dialog('open');
	}
	//点击测试负责人选择按钮
	function testuserChoose(){
		prefix = "test";
		$("#userDialog1").dialog('open');
	}
	//点击发布负责人选择按钮
	function pubuserChoose(){
		prefix = "pub";
		$("#userDialog1").dialog('open');
	}
	//
	function setZtree(id,name){
		//点击节点，给父页面对应的文本框赋值（通过变量拼接来区分不同的id）
		$("#"+prefix+"_userId1").val(id);
		$("#"+prefix+"_user1").textbox('setValue',name);
		//赋值完毕，关闭dialog
		$("#userDialog1").dialog('close');
	}
	//获取编辑器的值，给隐藏文本域赋值
	function setTextarea(content){
		$("textarea[name='content']").val(content);
	}
	//提交表单
	function saveProduct(){
		//获取iframe的子页面里面的文本域的值
		//var contents = $("iframe").contents().find("#schtmlnr").val();
		//console.info(contents);
		//将获取到的值，赋值给本页面隐藏的文本域
		//$("textarea[name='content']").val(contents);
		$("#addProductForm").form('submit',{
			url:"${pageContext.request.contextPath}/product/add.do",
			onSubmit:function(){
				var isValid = $(this).form('validate');
				return isValid;
			},
			success:function(msg){
				$.messager.show({
					title:"添加结果",
					msg:"添加成功！",
					timeout:2000,
					showType:'fade'
				});
				//添加成功后，跳转到产品列表标签，并刷新列表（列表标签存在时，需要刷新来展示刚添加的数据）
				addTabs('全部产品','product/toproductPage.do');
				$("#productList").datagrid('load');
				//关闭添加产品标签
				$("#tabs").tabs('close','添加产品');
			}
		});
	}
	
</script>
</body>
</html>