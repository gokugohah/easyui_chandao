<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table id="proRequireList" fit="true"></table>
<div id="proRequireButtons">
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="downloadTable()" data-options="iconCls:'icon-print'">导出报表</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="uploadTable()" data-options="iconCls:'icon-redo'">导入报表</a>
</div>
<div class="mskelayBox">
  <div class="mske_html"></div>
  <img class="mskeClaose" src="images/mke_close.png" width="27" height="27" />
</div>
<div id="downloadRequire" class="easyui-dialog" data-options="closed:true,modal:true">
	<form id="downloadRequireForm" method="post">
	文件名:<input name="filename">
		<input name="filetype" class="easyui-combobox" data-options="
			width:150,
			valueField: 'value',
			textField: 'label',
			data: [{
				label: 'excel',
				value: '.xls'
			},{
				label: 'word',
				value: '.doc'
			},{
				label: 'pdf',
				value: '.pdf'
			}],
			panelHeight:'auto'">
		<input type="submit" value="生成报表">
	</form>
</div>
<div id="uploadRequire" class="easyui-dialog" data-options="closed:true,modal:true">
	<form id="uploadRequireForm1" method="post" enctype="multipart/form-data">
	选择导入的文件:<input type="file" name="file">
		<input type="submit" value="正常导入报表">
	</form><br><br>
	<form id="uploadRequireForm2" method="post" enctype="multipart/form-data">
	选择导入的文件:<input type="file" name="file">
		<input type="submit" value="反射导入报表">
	</form>
</div>
<script type="text/javascript">
	$("#proRequireList").datagrid({
		url:"${pageContext.request.contextPath}/product/requireList.do",
		columns:[[
			{field:'id',title:'需求编号',align:'center',width:100},
			{field:'name',title:'需求名称',align:'center',width:100},
			{field:'proname',title:'所属产品',align:'center',width:100},
			{field:'modelname',title:'所属模块',align:'center',width:100},
			{field:'planname',title:'所属计划',align:'center',width:100},
			{field:'fromname',title:'需求来源',align:'center',width:100},
			{field:'examuser',title:'由谁评审',align:'center',width:100},
			{field:'prolevel',title:'优先级',align:'center',width:100},
			{field:'tousers',title:'抄送给',align:'center',width:100},
			{field:'content',title:'需求描述',align:'center',width:100},
			/* {field:'images',title:'预览图',align:'center',width:100,
				formatter:function(value,row,index){
					//通过获取数据库保存的blob，并输出流的形式显示图片
					var str = "";
					for(var i in value){
						str += "<img src='${pageContext.request.contextPath}/img/downloadImg.do?id="+value[i].id+"' width=100% height=100% /><br>";
					}
					return str;
				}
			}, */
			{field:'images',title:'预览图',align:'center',
				formatter:function(value,row,index){
					//通过获取数据库保存的blob，并输出流的形式显示图片
					var str = "";
					for(var i in value){
						str += "<br><a href='javascript:void(0)' onclick='bigPic("+value[i].id+")' class='msKeimgBox'><img src='${pageContext.request.contextPath}/img/downloadImg.do?id="+value[i].id+"' width=100% height=100% />"
								+"<span class='hidden' id="+value[i].id+" style='display:none;'><img src='${pageContext.request.contextPath}/img/downloadImg.do?id="+value[i].id+"'  width=100% height=100%/></span></a><br>";
					}
					return str;
				}
			},
			/* {field:'images2',title:'预览图',align:'center',width:100,
				formatter:function(value,row,index){
					//通过图片存放路径回显
					var str = "";
					for(var i in value){
						var dian = value[i].name.lastIndexOf(".");
						var name = value[i].name.substring(0,dian)+"-thumbnail.png";
						str += "<img class='mskeClaose' src='/pic/"+name+"' width=100% height=100% /><br>";
					}
					return str;
				}
			}, */
			{field:'download',title:'附件下载',align:'center',width:100,
				formatter:function(value,row,index){
					var str = "";
					var images = row.images;
					for(var i in images){
						str += "<br><a href='${pageContext.request.contextPath}/img/downloadImg.do?id="+images[i].id+"'>下载</a><br><br>";
					}
					return str;
				}
			}
		]],
		fitColumns:true,
		singleSelect:true,
		toolbar:'#proRequireButtons'
	});
	$(".mskeClaose").click(function(){
		$(".mskeLayBg,.mskelayBox").hide()
	});
	function bigPic(id){
		$(".mske_html").html($(".hidden[id="+id+"]").html());
		$(".mskelayBox").fadeIn(300);
	}
	//导出报表
	function downloadTable(){
		$("#downloadRequireForm").form('clear');
		$("#downloadRequire").dialog('open');
	}
	$("#downloadRequireForm").form({
		url:'${pageContext.request.contextPath}/poi/productPoi.do',
		onSubmit:function(){
			$("#downloadRequire").dialog('close');
			return true;
		}
	});
	//导入报表
	function uploadTable(){
		$("#uploadRequireForm1").form('clear');
		$("#uploadRequireForm2").form('clear');
		$("#uploadRequire").dialog('open');
	}
	$("#uploadRequireForm1").form({
		url:'${pageContext.request.contextPath}/import/requireImport1.do',
		success:function(msg){
			if(msg==1){
				$("#uploadRequire").dialog('close');
				$("#proRequireList").datagrid('load');
				alert("文件导入成功");
			}else{
				alert("导入的文件有问题，请仔细检查后再导入");
			}
		}
	});
	$("#uploadRequireForm2").form({
		url:'${pageContext.request.contextPath}/import/requireImport2.do',
		success:function(msg){
			if(msg==1){
				$("#uploadRequire").dialog('close');
				$("#proRequireList").datagrid('load');
				alert("文件导入成功");
			}else{
				alert("导入的文件有问题，请仔细检查后再导入");
			}
		}
	});
</script>
</body>
</html>