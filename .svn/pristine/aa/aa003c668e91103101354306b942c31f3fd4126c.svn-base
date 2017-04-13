<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery-1.8.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/kindeditor-4.1.7/kindeditor-all.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/kindeditor-4.1.7/themes/default/default.css" type="text/css"></link>
<link rel="stylesheet" href="${pageContext.request.contextPath}/kindeditor-4.1.7/plugins/code/prettify.css" type="text/css"></link>
<script type="text/javascript" src="${pageContext.request.contextPath}/kindeditor-4.1.7/lang/zh_CN.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/kindeditor-4.1.7/plugins/code/prettify.js"></script></head>
<body>
<script type="text/javascript">
	var editor;
	KindEditor.ready(function(K) {
			editor = K.create('textarea[name="content"]', {
				allowFileManager : true,
				afterBlur:function(){
					window.parent.setTextarea(editor.html());
				}
			});
		});
	 
</script>
<!-- 
	用kindEditor编辑栏制作文本域，无法直接获取该文本域的值，
	可以通过触发事件让编辑器的值同步到一个隐藏的文本域，再把这个隐藏文本域的值返回给父页面
 -->
<textarea id="procontent" name="content" style="width:100%;height:100%;visibility:hidden;"></textarea>
</body>
</html>