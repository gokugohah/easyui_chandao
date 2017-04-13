<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table id="menuList" fit="true"></table>
<div id="menufunbuttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="addMenu()" data-options="iconCls:'icon-add',plain:true">添加</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateMenu()" data-options="iconCls:'icon-edit',plain:true">编辑</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="deleteMenu()" data-options="iconCls:'icon-remove',plain:true">删除</a>
</div>
<!-- 添加 -->
<div id="addMenuDialog" class="easyui-dialog" style="width:500px;height:400px;"
	 data-options="title:'添加菜单',iconCls:'icon-add',modal:true,closed:true">
	<form id="addMenuForm" method="post">
		<table align="center">
			<tr><td colspan="11"><br></td></tr>
			<tr>
				<td>菜单名称：<input name="name"></td>
				<td>父菜单：&nbsp;&nbsp;&nbsp;&nbsp;
				<select id="addSelect" name="pid" class="easyui-combotree" style="width:150px;"   
				 data-options="textField:'name',parentField:'pid',url:'${pageContext.request.contextPath}/menu/list.do'"></select></td>
			</tr>
			<tr><td colspan="11"><br></td></tr>
			<tr>
				<td></td>
				<td>链接地址：<input name="url"></td>
			</tr><tr><td colspan="11"><br></td></tr>
			<tr>
				<td>图标：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="iconId" class="easyui-combobox" 
					data-options="valueField:'iconId',textField:'iconCls',url:'${pageContext.request.contextPath}/menu/iconList.do'"></td>
				<td></td>
			</tr><tr><td colspan="11"><br></td></tr>
			<tr>
				<td>排序：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="orderby"></td>
				<td></td>
			</tr><tr><td colspan="11"><br></td></tr>
			<tr align="center">
				<td colspan="11"><input type="submit" value="保存"><input type="reset" value="清空"></td>
			</tr>
		</table>
	</form>
</div>
<!-- 修改 -->
<div id="updateMenuDialog" class="easyui-dialog" style="width:500px;height:400px;"
	 data-options="title:'修改菜单',iconCls:'icon-reload',modal:true,closed:true">
	<form id="updateMenuForm" method="post">
		<table align="center">
			<tr><td colspan="11"><br></td></tr>
			<tr>
				<td>菜单名称：<input name="name"><input type="hidden" name="id"></td>
				<td>父菜单：&nbsp;&nbsp;&nbsp;&nbsp;
				<select id="updateSelect" name="pid" class="easyui-combotree" style="width:150px;"   
				 data-options="textField:'name',parentField:'pid',url:'${pageContext.request.contextPath}/menu/list.do'"></select></td>
			</tr>
			<tr><td colspan="11"><br></td></tr>
			<tr>
				<td></td>
				<td>链接地址：<input name="url"></td>
			</tr><tr><td colspan="11"><br></td></tr>
			<tr>
				<td>图标：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="iconId" class="easyui-combobox" 
					data-options="valueField:'iconId',textField:'iconCls',url:'${pageContext.request.contextPath}/menu/iconList.do'"></td>
				<td></td>
			</tr><tr><td colspan="11"><br></td></tr>
			<tr>
				<td>排序：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="orderby"></td>
				<td></td>
			</tr><tr><td colspan="11"><br></td></tr>
			<tr align="center">
				<td colspan="11"><input type="submit" value="修改"><input type="reset" value="清空"></td>
			</tr>
		</table>
	</form>
</div>

<script type="text/javascript">
	//使用syUtil.js
	$("#menuList").treegrid({
		url:"${pageContext.request.contextPath}/menu/list.do",
		idField:'id',
		treeField:'name',
		parentField:'pid',
		columns:[[    
	        {field:'cb',checkbox:true},    
	        {field:'id',title:'编号',width:80,align:'center'},    
	        {field:'name',title:'菜单名称',width:80,align:'center'},
	        {field:'parentName',title:'父级菜单',width:80,align:'center'},
	        {field:'url',title:'链接地址',width:80,align:'center'},
	        {field:'iconCls',title:'图标',width:80,align:'center'},
	        {field:'orderby',title:'排序',width:80,align:'center'},
	        {field:'function',title:'操作',width:100,align:'center',
	        	formatter:function(value,row,index){
	        		return "<a href='javascript:void(0)' class='bianji'>编辑</a>"
	        		+"<a href='javascript:void(0)' class='shanchu'>删除</a>"
	        		+"<a href='javascript:void(0)' class='fenpei'>菜单分配</a>";
	        	}
	        	
	        }
	    ]],
	    singleSelect:true,//treegrid复选框默认是true
	    checkOnSelect:false,
	    selectOnCheck:false,
	    fitColumns:true,
	    pagination:true,
	    pageSize:5,
	    pageList:[3,5,8],
	    toolbar:"#menufunbuttons",
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
       			text:'菜单分配',
       			plain:true,
       			iconCls:'icon-ok'
       		});
	    	$("#menuList").treegrid('collapseAll');
       	}
	});
	function addMenu(){
		$("#addMenuForm").form('clear');
		$("#addSelect").combotree('reload');
		$("#addMenuDialog").dialog('open');
	}
	$("#addMenuForm").form({
		url:"${pageContext.request.contextPath}/menu/add.do",
		onSubmit:function(){
			return true;
		},
		success:function(msg){
			$.messager.alert('添加结果','添加成功','icon-info',
				function(){
					$("#addMenuDialog").dialog('close');
					$("#menuList").treegrid('reload');
				}
			);
		}
	});
	function updateMenu(){
		$("#updateMenuForm").form('clear');
		$("#updateSelect").combotree('reload');
		var row = $("#menuList").treegrid('getSelected');
		if(row!=null){
			$("#updateMenuDialog").dialog('open');
			$("#updateMenuForm").form('load',row);
		}else{
			$.messager.alert('提示','请选择要编辑的菜单','warning');
		}
	}
	$("#updateMenuForm").form({
		url:"${pageContext.request.contextPath}/menu/update.do",
		onSubmit:function(){
			return true;
		},
		success:function(msg){
			$.messager.alert('修改结果','修改成功','icon-info',
				function(){
					$("#updateMenuDialog").dialog('close');
					$("#menuList").treegrid('reload');
				}
			);
		}
	});
	function deleteMenu(){
		var rows = $("#menuList").treegrid('getChecked');
		if(rows.length==0){
			$.messager.alert('提示','请至少选择一项删除','warning');
		}else{
			var ids = "";
			for(var i=0;i<rows.length;i++){
				ids += ","+rows[i].id;
			}
			ids = ids.substring(1);
			$.messager.confirm("删除提示","是否删除编号为"+ids+"的菜单？",
				function(msg){
					if(msg){
						$.post(
							"${pageContext.request.contextPath}/menu/delete.do",
							{ids:ids},
							function(succ){
								$.messager.show({
									title:"删除结果",
									msg:"删除成功，2秒后关闭本窗口。",
									timeout:2000,
									showType:'fade'
								});
								$("#menuList").treegrid('reload');
							}
						);
					}
				}
			);
		}
	}
	//分页工具（直接查出全部数据，由工具类分页展示，后台不需要接收page和rows）
	(function($){
			function pagerFilter(data){
		        if ($.isArray(data)){    // is array  
		            data = {  
		                total: data.length,  
		                rows: data  
		            }  
		        }
		        var dg = $(this);  
				var state = dg.data('treegrid');
		        var opts = dg.treegrid('options');  
		        var pager = dg.treegrid('getPager');  
		        pager.pagination({  
		            onSelectPage:function(pageNum, pageSize){  
		                opts.pageNumber = pageNum;  
		                opts.pageSize = pageSize;  
		                pager.pagination('refresh',{  
		                    pageNumber:pageNum,  
		                    pageSize:pageSize  
		                });  
		                dg.treegrid('loadData',state.originalRows);  
		            }  
		        });  
		        if (!state.originalRows){
		        	state.originalRows = data.rows;
		        }
		        var topRows = [];
		        var childRows = [];
		        $.map(state.originalRows, function(row){
		        	row._parentId ? childRows.push(row) : topRows.push(row);
		        });
		        data.total = topRows.length;
		        var start = (opts.pageNumber-1)*parseInt(opts.pageSize);  
		        var end = start + parseInt(opts.pageSize);  
				data.rows = $.extend(true,[],topRows.slice(start, end).concat(childRows));
				return data;
			}

			var appendMethod = $.fn.treegrid.methods.append;
			var loadDataMethod = $.fn.treegrid.methods.loadData;
			$.extend($.fn.treegrid.methods, {
				clientPaging: function(jq){
					return jq.each(function(){
						var state = $(this).data('treegrid');
						var opts = state.options;
						opts.loadFilter = pagerFilter;
						var onBeforeLoad = opts.onBeforeLoad;
						opts.onBeforeLoad = function(row,param){
							state.originalRows = null;
							onBeforeLoad.call(this, row, param);
						}
						$(this).treegrid('loadData', state.data);
						$(this).treegrid('reload');
					});
				},
				loadData: function(jq, data){
					jq.each(function(){
						$(this).data('treegrid').originalRows = null;
					});
					return loadDataMethod.call($.fn.treegrid.methods, jq, data);
				},
				append: function(jq, param){
					return jq.each(function(){
						var state = $(this).data('treegrid');
						if (state.options.loadFilter == pagerFilter){
							$.map(param.data, function(row){
								row._parentId = row._parentId || param.parent;
								state.originalRows.push(row);
							});
							$(this).treegrid('loadData', state.originalRows);
						} else {
							appendMethod.call($.fn.treegrid.methods, jq, param);
						}
					})
				}
			});

		})(jQuery);

		function formatProgress(value){
	    	if (value){
		    	var s = '<div style="width:100%;border:1px solid #ccc">' +
		    			'<div style="width:' + value + '%;background:#cc0000;color:#fff">' + value + '%' + '</div>'
		    			'</div>';
		    	return s;
	    	} else {
		    	return '';
	    	}
		}
		
		$(function(){
			$('#menuList').treegrid().treegrid('clientPaging');
		})
</script>
</body>
</html>