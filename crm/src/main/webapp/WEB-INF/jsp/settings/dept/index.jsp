<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/jsp/inc/commons_head.jsp" %>
	<script>
		jQuery(function ($) {
			function load() {
				$.ajax({
					url: "/dept/depts.json",
					success(data) {

						let html = "";
						$(data).each(function () {
							html += '<tr>';
							html += '	<td><input type="checkbox" name="id" value="'+this.id+'" /></td>';
							html += '	<td>'+this.no+'</td>';
							html += '	<td>'+this.name+'</td>';
							html += '	<td>'+this.manager+'</td>';
							html += '	<td>'+this.phone+'</td>';
							html += '	<td>'+this.description+'</td>';
							html += '</tr>';
						});

						$("#dataBody").html( html );
					}
				});
			}
			load();

			$("#createBtn").click(function () {
				//$(":input[id^=create]").val(""); // 清空id以create开头的表单元素中的值
				$("#createForm :input").val("");
				//$("#createForm").get(0).reset();
			});

			$("#saveBtn").click(function () {

				let no = $("#create-no").val();
				if(!/^\d{4}$/.test(no)) {
					alert("部门编号必须是4位数字！");
					return;
				}

				$.ajax({
					url: "/dept/save.do",
					type: "post", // post(添加)/get/delete/put(修改)
					data: {
						no: $("#create-no").val(),
						name: $("#create-name").val(),
						manager: $("#create-manager").val(),
						description: $("#create-description").val(),
						phone: $("#create-phone").val()
					},
					success(data) {
						if (data.success) {
							// 关闭窗口
							$("#createDeptModal").modal("hide");
							load(); // 重新加载列表

						}

						if(data.msg) {
							alert(data.msg);
						}
					}
				})
			})

			$("#editBtn").click(function (e) {
				// 获取选中的复选框
				let $cks = $(":checkbox[name=id]:checked");
				if($cks.size() != 1) {
					alert("必须且只能选择一项！");

					//e.stopPropagation(); // 阻止事件冒泡传播
					//e.preventDefault(); // 阻止事件在元素上的默认行为

					return false; // 阻止事件冒泡传播和元素的默认动作
				}

				$.ajax({
					url: "/dept/dept.json?id="+$cks.val(),
					success(data) {
						$("#edit-id").val(data.id);
						$("#edit-no").val(data.no);
						$("#edit-name").val(data.name);
						$("#edit-manager").val(data.manager);
						$("#edit-description").val(data.description);
						$("#edit-phone").val(data.phone);
					}
				})


			})




			/***
			 * 以下用于演示
			$("body").click(function () {
				//alert("点击了body")
			})

			$("#dataBody").click(function (e) {
				//alert("点击了dataBody");
				//e.stopPropagation();
			})

			$("#myCheckBox").click(function (e) {
				//alert("你点到我了！");
				//e.preventDefault(); // 阻止事件在元素（复选框）上的默认行为(选中)，此时复选框不会选中
			})
			*/


			$("#updateBtn").click(function () {

				$.ajax({
					url: "/dept/edit.do",
					type: "put",
					data: {
						id: $("#edit-id").val(),
						no: $("#edit-no").val(),
						name: $("#edit-name").val(),
						manager: $("#edit-manager").val(),
						description: $("#edit-description").val(),
						phone: $("#edit-phone").val()
					},
					success: function(data) {
						if (data.success) {
							load(); // 重新加载列表
							$("#editDeptModal").modal("hide");
							//alert(1);
						}

						if(data.msg) {
							alert(data.msg);
						}
					}
				});

				//alert(2); // 因为是异步（多线程、不阻塞），所以先打印2，再打印上面的1
				return false;
			})

			$("#delBtn").click(function () {
				let $cks = $(":checkbox[name=id]:checked");
				if ($cks.size() == 0) {
					alert("请选择删除项！");
					return ;
				}
				if ( !confirm("确定删除吗？") ) return;

				// 将元素数组转换为值的数组
				let ids = $cks.map(function () {
					return this.value;
				}).get().join(",");

				$.ajax({
					url: "/dept/del.do?ids="+ids,
					type: "delete",
					success(data) {
						if (data.success) {
							load(); // 重新加载列表
						}

						if(data.msg) {
							alert(data.msg);
						}
					}
				})
			})

			$("#selectAll").click(function () {
				$(":checkbox[name=id]").prop("checked", this.checked);
			});

			// 绑定事件时，元素不存在，无法进行绑定
			/*$(":checkbox[name=id]").click(function () {
				$("#selectAll").prop("checked", $(":checkbox[name=id]").size() == $(":checkbox:checked[name=id]").size())
			})*/

			// 委派机制底层原理
			/*$("#dataBody").click(function (e) {
				if($(e.target).is(":checkbox[name=id]")) {
					$("#selectAll").prop("checked", $(":checkbox[name=id]").size() == $(":checkbox:checked[name=id]").size())
				}
			});*/

			$("#dataBody").on("click", ":checkbox[name=id]", function () {
				$("#selectAll").prop("checked", $(":checkbox[name=id]").size() == $(":checkbox:checked[name=id]").size())
			})


			// 作业：权限管理 ==> 用户管理 ==> 添加用户
		})
	</script>
</head>
<body>

	<!-- 我的资料 -->
	<div class="modal fade" id="myInformation" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">我的资料</h4>
				</div>
				<div class="modal-body">
					<div style="position: relative; left: 40px;">
						姓名：<b>张三</b><br><br>
						登录帐号：<b>zhangsan</b><br><br>
						组织机构：<b>1005，市场部，二级部门</b><br><br>
						邮箱：<b>zhangsan@bjpowernode.com</b><br><br>
						失效时间：<b>2017-02-14 10:10:10</b><br><br>
						允许访问IP：<b>127.0.0.1,192.168.100.2</b>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 修改密码的模态窗口 -->
	<div class="modal fade" id="editPwdModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 70%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">修改密码</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="oldPwd" class="col-sm-2 control-label">原密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="oldPwd" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="newPwd" class="col-sm-2 control-label">新密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="newPwd" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="confirmPwd" style="width: 200%;">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="window.location.href='../login.html';">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 退出系统的模态窗口 -->
	<div class="modal fade" id="exitModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">离开</h4>
				</div>
				<div class="modal-body">
					<p>您确定要退出系统吗？</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="window.location.href='../../login.html';">确定</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 顶部 -->
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2017&nbsp;动力节点</span></div>
		<div style="position: absolute; top: 15px; right: 15px;">
			<ul>
				<li class="dropdown user-dropdown">
					<a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
						<span class="glyphicon glyphicon-user"></span> zhangsan <span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="../../workbench/index.html"><span class="glyphicon glyphicon-home"></span> 工作台</a></li>
						<li><a href="../index.html"><span class="glyphicon glyphicon-wrench"></span> 系统设置</a></li>
						<li><a href="javascript:void(0)" data-toggle="modal" data-target="#myInformation"><span class="glyphicon glyphicon-file"></span> 我的资料</a></li>
						<li><a href="javascript:void(0)" data-toggle="modal" data-target="#editPwdModal"><span class="glyphicon glyphicon-edit"></span> 修改密码</a></li>
						<li><a href="javascript:void(0);" data-toggle="modal" data-target="#exitModal"><span class="glyphicon glyphicon-off"></span> 退出</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	
	<%@include file="/WEB-INF/jsp/inc/header.jsp"%>
	
	<!-- 创建部门的模态窗口 -->
	<div class="modal fade" id="createDeptModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-plus"></span> 新增部门</h4>
				</div>
				<div class="modal-body">
				
					<form id="createForm" class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-no" class="col-sm-2 control-label">编号<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-no" style="width: 200%;" placeholder="编号为四位数字，不能为空，具有唯一性">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-name" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-manager" class="col-sm-2 control-label">负责人</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-manager" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-phone" class="col-sm-2 control-label">电话</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-phone" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 55%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="saveBtn" type="button" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改部门的模态窗口 -->
	<div class="modal fade" id="editDeptModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title"><span class="glyphicon glyphicon-edit"></span> 编辑部门</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
						<input type="hidden" id="edit-id" />

						<div class="form-group">
							<label for="edit-no" class="col-sm-2 control-label">编号<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-no" style="width: 200%;" placeholder="编号为四位数字，不能为空，具有唯一性" value="1110">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-name" class="col-sm-2 control-label">名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-name" style="width: 200%;" value="财务部">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-manager" class="col-sm-2 control-label">负责人</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-manager" style="width: 200%;" value="张飞">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-phone" class="col-sm-2 control-label">电话</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-phone" style="width: 200%;" value="010-84846004">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 55%;">
								<textarea class="form-control" rows="3" id="edit-description">description info</textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="updateBtn" type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	<div style="width: 95%">
		<div>
			<div style="position: relative; left: 30px; top: -10px;">
				<div class="page-header">
					<h3>部门列表</h3>
					<%--<input type="checkbox" id="myCheckBox" />--%>
				</div>
			</div>
		</div>
		<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; top:-30px;">
			<div class="btn-group" style="position: relative; top: 18%;">
			  <button id="createBtn" type="button" class="btn btn-primary" data-toggle="modal" data-target="#createDeptModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
			  <button id="editBtn" type="button" class="btn btn-default" data-toggle="modal" data-target="#editDeptModal"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			  <button id="delBtn" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
			</div>
		</div>
		<div style="position: relative; left: 30px; top: -10px;">
			<table class="table table-hover table-striped">
				<thead>
					<tr style="color: #B3B3B3;">
						<td><input id="selectAll" type="checkbox" /></td>
						<td>编号</td>
						<td>名称</td>
						<td>负责人</td>
						<td>电话</td>
						<td>描述</td>
					</tr>
				</thead>
				<tbody id="dataBody"></tbody>
			</table>
		</div>
		

			
	</div>
	
</body>
</html>