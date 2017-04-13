<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table id="userList" fit="true"></table>
<div id="userButton">
	<a href="javascript:void(0)" onclick="addUser()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">批量添加</a>
	<a href="javascript:void(0)" onclick="saveUser()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">批量保存</a>
	<a href="javascript:void(0)" onclick="updateUser()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">批量修改</a>
</div>


<script type="text/javascript">
	$("#userList").datagrid({
		url:"${pageContext.request.contextPath}/user/list.do",
		columns:[[
			{field:'id',title:'编号',align:'center',width:100},
			{field:'realname',title:'真实姓名',align:'center',width:100,
				editor:{type: 'validatebox',options:{required:true}}
			},
			{field:'name',title:'用户名',align:'center',width:100,
				editor:{type: 'text'}//定义编辑器，设置列的样式
			},
			{field:'pwd',title:'密码',align:'center',width:100,
				editor:{type: 'text'}
			},
			{field:'mail',title:'邮箱',align:'center',width:100,
				editor:{type: 'text'}
			},
			{field:'tel',title:'电话',align:'center',width:100,
				editor:{type: 'text'}
			},
			{field:'sex',title:'性别',align:'center',width:100,
				editor:{type: 'combobox',options:{
					valueField:'id',
					textField:'text',
					panelHeight:true,
					data:[{"id":"男","text":"男"},{"id":"女","text":"女"}]
				}}
			},
			{field:'add_date',title:'入职日期',align:'center',width:100,
				editor:{type: 'datebox'}
			},
			{field:'deptName',title:'所在部门',align:'center',width:100,
				editor:{type: 'combotree',options:{
					url:"${pageContext.request.contextPath}/dept/list.do",
					textField:'name',
					parentField:'pid'
				}}
			},
			{field:'function',title:'操作',align:'center',width:100,
				formatter:function(value,row,index){
					if (row.editing){
							var s = '<a href="javascript:void(0)" onclick="saverow(this)">保存</a> ';
							var c = '<a href="javascript:void(0)" onclick="cancelrow(this)">取消</a>';
							return s+c;
						} else {
							var e = '<a href="javascript:void(0)" onclick="editrow(this)">修改</a> ';
							var d = '<a href="javascript:void(0)" onclick="deleterow(this)">删除</a>';
							return e+d;
						}
				}
			}
		]],
		fitColumns:true,
		toolbar:"#userButton",
		onClickCell:onClickCell,
		onBeforeEdit:function(index,row){
			row.editing = true;
			updateActions(index);
		},
		onAfterEdit:function(index,row){
			row.editing = false;
			updateActions(index);
		},
		onCancelEdit:function(index,row){
			row.editing = false;
			updateActions(index);
		}
	});
	function updateActions(index){
		$('#userList').datagrid('updateRow',{
			index: index,
			row:{}
		});
	}
	function getRowIndex(target){
		var tr = $(target).closest('tr.datagrid-row');
		return parseInt(tr.attr('datagrid-row-index'));
	}
	function editrow(target){
		$('#userList').datagrid('beginEdit', getRowIndex(target));
	}
	function deleterow(target){
		$.messager.confirm('Confirm','Are you sure?',function(r){
			if (r){
				$('#userList').datagrid('deleteRow', getRowIndex(target));
			}
		});
	}
	function saverow(target){
		$('#userList').datagrid('endEdit', getRowIndex(target));
	}
	function cancelrow(target){
		$('#userList').datagrid('cancelEdit', getRowIndex(target));
		$('#userList').datagrid('refreshRow', getRowIndex(target));
	}
	//设置editCell的方法，在onClickCell触发事件时调用该方法
	$.extend($.fn.datagrid.methods, {
			editCell: function(jq,param){
				return jq.each(function(){
					var opts = $(this).datagrid('options');
					var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
					for(var i=0; i<fields.length; i++){
						var col = $(this).datagrid('getColumnOption', fields[i]);
						col.editor1 = col.editor;
						if (fields[i] != param.field){
							col.editor = null;
						}
					}
					$(this).datagrid('beginEdit', param.index);
					for(var i=0; i<fields.length; i++){
						var col = $(this).datagrid('getColumnOption', fields[i]);
						col.editor = col.editor1;
					}
				});
			}
		});
	//定义一个变量，存放编辑的行的索引，并判断
	var editIndex = undefined;
		function endEditing(){
			if (editIndex == undefined){return true}
			if ($('#userList').datagrid('validateRow', editIndex)){
				$('#userList').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
	//点击单元格时触发事件,editCell是手写的方法
	function onClickCell(index, field){
		if (endEditing()){
			$('#userList').datagrid('selectRow', index)
						.datagrid('editCell', {index:index,field:field});
			editIndex = index;
		}
	}
	//批量添加
	function addUser(){
		//获取当前添加的行的索引
		var index=$('#userList').datagrid('appendRow', {}).datagrid('getRows').length-1;
		//给指定索引的行开启编辑，这样才能让行属性里的editor生效
		$('#userList').datagrid('beginEdit',index)
	}
	//批量保存
	function saveUser(){
		//获取从上一次的提交开始改变的所有行，inserted是特指用添加改变的
		var row = $("#userList").datagrid('getChanges','inserted');
		//提交所有从加载或者上一次调用acceptChanges函数后更改的数据
		$("#userList").datagrid('acceptChanges');
		//将获取到的对象转换成json字符串格式
		var rows = JSON.stringify(row);
		console.info(rows);
		$.post(
			"${pageContext.request.contextPath}/user/addAll.do",
			{json:rows},
			function(msg){
				alert("添加成功");
				$("#userList").datagrid('reload');
			}
		);
	}
	//批量修改
	function updateUser(){
		//获取从上一次的提交开始改变的所有行，inserted是特指用添加改变的
		var row = $("#userList").datagrid('getChanges','updated');
		//提交所有从加载或者上一次调用acceptChanges函数后更改的数据
		$("#userList").datagrid('acceptChanges');
		//将获取到的对象转换成json字符串格式
		var rows = JSON.stringify(row);
		console.info(rows);
		$.post(
			"${pageContext.request.contextPath}/user/updateAll.do",
			{json:rows},
			function(msg){
				alert("修改成功");
				$("#userList").datagrid('reload');
			}
		);
	}
</script>
</body>
</html>