<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<body>
<h1 align="center">提需求</h1>

<div style="margin: 50px 100px;">
<form id="proRequireForm" method="post">
	所属产品：<input name="proid" class="easyui-combobox" data-options="
			url:'${pageContext.request.contextPath}/product/list.do',
			valueField:'id',
			textField:'name',
			width:150,
			panelHeight:'auto',
			onSelect:function(rec){
				$('#promodel').combobox('clear');
				$('#proplan').combobox('clear');
				var modelurl = '${pageContext.request.contextPath}/product/modelList.do?proid='+rec.id;
				$('#promodel').combobox('reload',modelurl);
				var planurl = '${pageContext.request.contextPath}/product/planList.do?proid='+rec.id;
				$('#proplan').combobox('reload',planurl);
			}
		">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	所属模块：<input name="modelid" id="promodel" class="easyui-combobox" data-options="
			valueField:'id',
			textField:'name',
			width:150,
			panelHeight:'auto'
		"><br><br>
	所属计划：<input name="planid" id="proplan" class="easyui-combobox" data-options="
			valueField:'id',
			textField:'name',
			width:150,
			panelHeight:'auto'
		">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	需求来源：<input name="fromid" id="profrom" class="easyui-combobox" data-options="
			url:'${pageContext.request.contextPath}/product/fromList.do',
			valueField:'id',
			textField:'name',
			width:150,
			panelHeight:'auto'
		"><br><br>
	由谁评审：<input name="examuser" id="examuser" class="easyui-combobox" data-options="
			url:'${pageContext.request.contextPath}/user/list.do',
			valueField:'realname',
			textField:'realname',
			width:150,
			panelHeight:'auto'
		"><br><br>
	需求名称：<input name="name" class="easyui-textbox" data-options="width:150,required:true">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	优先级：<select id="prolevelCombo" name="prolevel" style="width:160px;" class="SelectDiv2"></select>
		<br><br>
	需求描述：<iframe src="${pageContext.request.contextPath}/product/toContent.do" height="180" width="790"></iframe>
	<textarea name="content" style="display:none;"></textarea>
	<br><br>
	抄送给：<input class="easyui-combotree" name="tousers" data-options="
		url:'${pageContext.request.contextPath}/product/userList.do',
		valueField:'id',
		textField:'name',
		parentField:'pId',
		width:300,
		panelHeight:'auto',
		multiple:true,
		lines:true,
		onlyLeafCheck:true
	"><br><br>
	<%-- <iframe src="${pageContext.request.contextPath}/product/toUsersZtree.do"></iframe> --%>
	附件：<iframe id="uploadRequireIframe" style="width:100%;" src="${pageContext.request.contextPath}/product/toUpload.do"></iframe><br><br>
	<a href="javascript:void(0)" onclick="saveRequire()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">保存</a>
</form>
<div id="prolevelComboImg">
	<div style="padding:10px">
		<input type="image" value="0" text="0" src="${pageContext.request.contextPath}/icon/1.png">
		<input type="image" value="1" text="1" src="${pageContext.request.contextPath}/icon/2.png">
		<input type="image" value="2" text="2" src="${pageContext.request.contextPath}/icon/3.png">
		<input type="image" value="3" text="3" src="${pageContext.request.contextPath}/icon/4.png">
		<input type="image" value="4" text="4" src="${pageContext.request.contextPath}/icon/5.png">
	</div>
</div>
</div>
<script type="text/javascript">
	$(function(){
	$("#prolevelCombo").combo({
		required:true,
		editable:false,
		panelHeight:'auto'
	});
	$("#prolevelComboImg").appendTo($('#prolevelCombo').combo('panel'));
	$("#prolevelComboImg input").click(function(){
				var v = $(this).val();
				var s = $(this).attr("text");
				//var s = "<img src='${pageContext.request.contextPath}/icon/"+v+".png' />";
				$("#prolevelCombo").combo('setValue', v).combo('setText', s).combo('hidePanel');
			});
	});
	//获取编辑器的值，给隐藏文本域赋值
	function setTextarea(content){
		$("textarea[name='content']").val(content);
	}
	//提交需求
	function saveRequire(){
		//先提交需求，获得新的需求id，然后再上传附件
		$("#proRequireForm").form('submit',{
			url:"${pageContext.request.contextPath}/product/addRequire.do",
			onSubmit:function(){
				return $(this).form('validate');
			},
			success:function(msg){
				//调用子页面的方法来进行附件的上传
				window.frames["uploadRequireIframe"].contentWindow.uploadRequire(msg);
				//alert("上传成功");
				//添加成功后，跳转到需求列表标签，并刷新列表（列表标签存在时，需要刷新来展示刚添加的数据）
				$.messager.progress();
				addTabs('需求列表','product/torequirelist.do');
				setTimeout("delayWork("+msg+")",5000);
				
				//关闭添加产品标签
				$("#tabs").tabs('close','提需求');
			}
		});
	}
	//设置延迟
	function delayWork(id){
		$.post(
			"${pageContext.request.contextPath}/product/sendmail.do",
			{reqid:id},
			function(msg){
				$.messager.progress('close');
			}
		);
		$("#proRequireList").datagrid('load');
	}
</script>
</body>
</html>