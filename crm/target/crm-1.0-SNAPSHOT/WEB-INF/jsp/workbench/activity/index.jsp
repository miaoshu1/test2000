<%@page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/jsp/inc/commons_head.jsp" %>
<script type="text/javascript">

	jQuery(function($){
		function load() {
			$.ajax({
				url: "/act/activities.json",
				data: {
					name: $("#search-name").val(),
					owner: $("#search-owner").val(),
					startDate: $("#search-startDate").val(),
					endDate: $("#search-endDate").val()
				},
				success(data) {
					let arr = [];
					$(data).each(function () {
						arr.push(
							`<tr>
								<td><input type="checkbox" name="id" value="`+this.id+`" /></td>
								<td><a href="detail.html?id=`+this.id+`">`+this.name+`</a></td>
								<td>`+this.owner+`</td>
								<td>`+this.startDate+`</td>
								<td>`+this.endDate+`</td>
							</tr>`
						);
					});
					$("#dataBody").html( arr.join(""));
				}
			})
		}
		load();

		$("#searchBtn").click(function () {
			load();
		})

		/*$("#saveForm").submit(function () {

			let data = {};
			$(this).find(":input[name]").each(function () {
				let propName = $(this).prop("name")
				data[propName] = $(this).val();
			});

			$.ajax({
				url: $(this).prop("action"),
				type: $(this).prop("method"),
				data: data,
				success(data) {

				}
			});

			return false;
		});*/

		/*$("#saveForm,#editForm").ajaxForm(function (data) {
			if (data.success) {
				load();
				closeModal();
			}
			if (data.msg) {
				alert(data.msg);
			}
		});*/

		let suc = function (data) {
			if (data.success) {
				load();
				closeModal();
			}
			if (data.msg) {
				alert(data.msg);
			}
		};

		$("#saveForm").ajaxForm(suc);

		$("#editForm").ajaxForm({
			type: "put",
			success: suc
		});

		$("#saveBtn").click(function () {
			$("#saveForm").submit();
			return false; // 不关闭窗口
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

			/*$.ajax({
				url: "/act/activity.json?id="+$cks.val(),
				success(data) {
					//$("#editForm :input[name=id]").val(data.id);
					//$("#editForm :input[name=name]").val(data.name);
					//$("#editForm :input[name=owner]").val(data.owner);
					//...

					$("#editForm :input[name]").val(function () {
						return data[this.name];
					});
				}
			});*/

			$("#editForm").initForm("/act/activity.json?id="+$cks.val());

		})

		$("#updateBtn").click(function () {
			$("#editForm").submit();
		})

		$("#exportBtn").click(function () {
			location = "/act/export.do";
		})


		$("#importBtn").click(function () {
			// ajax文件上传必须使用FormData对象来完成
			var data = new FormData();
			// 获取选择的文件，是一个file数组
			var files = $("#upFile").prop("files");
			for (var i = 0; i < files.length; i++) {
				data.append("upFile", files[i]);
			}

			$.ajax({
				url: "/act/import.do",
				type: "post",
				data: data,
				contentType: false, processData: false, // 告诉jQuery，不要对数据进行任何处理
				success: suc
			});

			return false;
		})
	});
	
</script>
</head>
<body>

	<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form id="saveForm" action="/act/save.do" method="post" class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select name="owner" owner class="form-control" id="create-marketActivityOwner">
								  <option value="">--请选择--</option>
								</select>
							</div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input name="name" type="text" class="form-control" id="create-marketActivityName">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input date name="startDate" type="text" class="form-control" id="create-startTime">
							</div>
							<label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input date name="endDate" type="text" class="form-control" id="create-endTime">
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input name="cost" type="text" class="form-control" id="create-cost">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea name="description" class="form-control" rows="3" id="create-describe"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="saveBtn" type="button" class="btn btn-primary" data-dismiss="modal">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form id="editForm" action="/act/edit.do" method="put" class="form-horizontal" role="form">

						<input type="hidden" name="id" />

						<div class="form-group">
							<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select name="owner" owner class="form-control" id="edit-marketActivityOwner">
								  <option value="">--请选择--</option>
								</select>
							</div>
                            <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input name="name" type="text" class="form-control" id="edit-marketActivityName">
                            </div>
						</div>

						<div class="form-group">
							<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input name="startDate" type="text" class="form-control" id="edit-startTime">
							</div>
							<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input name="endDate" type="text" class="form-control" id="edit-endTime">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-cost" class="col-sm-2 control-label">成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input name="cost" type="text" class="form-control" id="edit-cost">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea name="description" class="form-control" rows="3" id="edit-describe"></textarea>
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
	
	
	<!-- 导入市场活动的模态窗口 -->
	<div class="modal fade" id="importActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">导入市场活动</h4>
				</div>
				<div class="modal-body" style="height: 350px;">
					<div style="position: relative;top: 20px; left: 50px;">
						请选择要上传的文件：<small style="color: gray;">[仅支持.xls或.xlsx格式]</small>
					</div>
					<div style="position: relative;top: 40px; left: 50px;">
						<input id="upFile" type="file">
					</div>
					<div style="position: relative; width: 400px; height: 320px; left: 45% ; top: -40px;" >
						<h3>重要提示</h3>
						<ul>
							<li>给定文件的第一行将视为字段名。</li>
							<li>请确认您的文件大小不超过5MB。</li>
							<li>从XLS/XLSX文件中导入全部重复记录之前都会被忽略。</li>
							<li>复选框值应该是1或者0。</li>
							<li>日期值必须为MM/dd/yyyy格式。任何其它格式的日期都将被忽略。</li>
							<li>日期时间必须符合MM/dd/yyyy hh:mm:ss的格式，其它格式的日期时间将被忽略。</li>
							<li>默认情况下，字符编码是UTF-8 (统一码)，请确保您导入的文件使用的是正确的字符编码方式。</li>
							<li>建议您在导入真实数据之前用测试文件测试文件导入功能。</li>
						</ul>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="importBtn" type="button" class="btn btn-primary" data-dismiss="modal">导入</button>
				</div>
			</div>
		</div>
	</div>
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input id="search-name" class="form-control" type="text">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input id="search-owner" class="form-control" type="text">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">开始日期</div>
					  <input date id="search-startDate" class="form-control" type="text" id="startTime" />
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input date id="search-endDate" class="form-control" type="text" id="endTime">
				    </div>
				  </div>
				  
				  <button id="searchBtn" type="button" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createActivityModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button id="editBtn" type="button" class="btn btn-default" data-toggle="modal" data-target="#editActivityModal"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-default" data-toggle="modal" data-target="#importActivityModal"><span class="glyphicon glyphicon-import"></span> 导入</button>
				  <button id="exportBtn" type="button" class="btn btn-default"><span class="glyphicon glyphicon-export"></span> 导出</button>
				</div>
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover table-striped">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" /></td>
							<td>名称</td>
                            <td>所有者</td>
							<td>开始日期</td>
							<td>结束日期</td>
						</tr>
					</thead>
					<tbody id="dataBody"></tbody>
				</table>
			</div>
			

			
		</div>
		
	</div>
</body>
</html>