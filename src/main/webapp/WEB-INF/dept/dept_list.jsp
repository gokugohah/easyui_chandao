<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="easyui-layout" title="部门结构" fit="true">
	<div data-options="region:'west',title:'维护部门结构',collapsible:false" style="width:200px;">
		<ul id="depttree" class="easyui-tree" data-options="lines:true"></ul>
	</div>
	<div data-options="region:'center',iconCls:'icon-man',title:'下级部门'" style="border:0;">
		<form id="childrenForm">
		</form>
	</div>
</div>
<script type="text/javascript">
	$("#depttree").tree({
		url:"${pageContext.request.contextPath}/dept/list.do",
		textField:"name",
		parentField:"pid",
		onLoadSuccess:function(){
			$(this).tree('collapseAll');
		},
		onClick:function(node){
			showDept(node.id,node.name);
		}
	});
	function showDept(id,name){
		$("form").empty();
		$.post(
			"${pageContext.request.contextPath}/dept/findChildren.do",
			{id:id},
			function(msg){
				for(var i in msg){
					$("form").append("<input name='name["+msg[i].id+"]' value='"+msg[i].name+"'><br>");
				}
				for(var i=0;i<5;i++){
					$("form").append("<input name='name[]'><br>");
				}
				$("form").append("<input type='submit' value='保存'><input type='button' value='返回'><br>");
			},
			"json"
		);
	}
	$("#childrenForm").form({
		url:"",
		onSubmit:function(){
			
		},
		success:function(msg){
			
		}
	});
</script>
</body>
</html>