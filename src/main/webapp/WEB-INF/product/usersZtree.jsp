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
</head>
<body>
	<select id="toUserstree" class="ztree" style="width:300px;"></select>
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
			view: {
				selectedMulti: true
			},
			check: {
				enable: true
			}
		};
		//zTree的url返回值，用于填充到树的结构里面
		var zNodes;
		//预加载函数
		$(document).ready(function(){
			$.ajax({
				url:"${pageContext.request.contextPath}/product/list.do",
				success:function(msg){
					console.info(msg);
					zNodes = msg;
				},
				dataType:"json",
				async:false
			});
			//zTree的初始化函数，需要放置zTree的ul标签的id，zTree的设置参数，zTree要加载的数据
			$.fn.zTree.init($("#toUserstree"), setting, zNodes);
		});
</script>
</body>
</html>