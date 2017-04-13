<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-ui/jquery-1.6.2.js"></script>
<!-- zTree的css、js -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/zTree/css/demo.css" type="text/css"></link>
<link rel="stylesheet" href="${pageContext.request.contextPath}/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css"></link>
<script type="text/javascript" src="${pageContext.request.contextPath}/zTree/jquery.ztree.all.js"></script>
<!-- jQuery ui的css、js -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/jquery-ui/themes/base/jquery.ui.all.css" type="text/css"></link>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-ui/ui/jquery.ui.core.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-ui/ui/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-ui/ui/jquery.ui.position.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-ui/ui/jquery.ui.autocomplete.js"></script>
</head>
<body>
<!-- 通过textbox的按钮点击，弹出一个dialog，里面是以zTree的形式展示的部门与员工 -->
	<div class="ui-widget">
		<input id="tags" value="" />
	</div>
		<ul id="usertree" class="ztree" ></ul>
<script type="text/javascript">
	//zTree的setting，设置数据，回调函数等
	var setting = {
			data: {
				simpleData: {
					enable: true,
					//idKey: "id",     //设置zTree每个节点的id
					//pIdKey: "pId",   //设置zTree每个节点的父节点id
					//rootPId: 0        //设置zTree的根节点id值
				}
			},
			callback:{
				onClick:zTreeClick
			},
			view: {
				expandSpeed: "slow",
				selectedMulti: true
			}
		};
		//zTree的url返回值，用于填充到树的结构里面
		var zNodes;
		//预加载函数
		$(document).ready(function(){
			//ajax获取部门和员工的一个集合，默认集合里面的对象属性有id，name，pId（大小写区分）
			//如果名称不对应，可以在setting里面data里设置
			$.ajax({
				url:"${pageContext.request.contextPath}/product/userList.do",
				success:function(msg){
					//console.info(msg);
					zNodes = msg;
				},
				dataType:"json",
				async:false
			});
			//zTree的初始化函数，需要放置zTree的ul标签的id，zTree的设置参数，zTree要加载的数据
			$.fn.zTree.init($("#usertree"), setting, zNodes);
		});
	//zTree的setting里面设置的节点点击事件（treeId是zTree的ul标签id，treeNode是当前点击的节点对象）
	function zTreeClick(event,treeId,treeNode){
		window.parent.setZtree(treeNode.id,treeNode.name);
	}
	//zTree打开时选中父页面回显的值
	function updateTree(id){
		//获取zTree的节点对象
		var treeObj = $.fn.zTree.getZTreeObj("usertree");
		//根据父页面传过来的id来确定要回显的节点id
		var node = treeObj.getNodeByParam("id", id, null);
		//var nodes = treeObj.getNodesByParam("name", id, null);
		//将回显的节点变成选中状态
		treeObj.selectNode(node);
	}
	//收缩所有节点，由父页面在dialog关闭后调用
	function expandTree(){
		$("#tags").autocomplete('close');
		$.fn.zTree.getZTreeObj("usertree").expandAll(false);
	}
	
	
	$(function(){
		//自动补全
		var availableTags ;
		$.ajax({
			url:"${pageContext.request.contextPath}/product/userAll.do",
			async:false,
			success:function(msg){
				console.info(msg);
				availableTags = msg;
			},
			dataType:"json"
		});
		
		$("#tags").autocomplete({
			source: availableTags,
			select: function( event, ui ) {
		        console.info(ui.item);
		        window.parent.setZtree(ui.item.id,ui.item.value);
		    }
		});
	});
</script>
</body>
</html>