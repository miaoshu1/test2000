<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/jsp/inc/commons_head.jsp" %>
	<script type="text/javascript">
	jQuery(function($){
		$("#isCreateTransaction").click(function(){
			if(this.checked){
				$("#create-transaction2").show(200);
			}else{
				$("#create-transaction2").hide(200);
			}
		});
		$.ajax({
			url: "/clue/clue.json?id=${param.id}",
			success: function (data) {
				$("span[content=customerName]").text(data.company);
				$("span[content=contactsName]").text(data.fullName);
				$("b[content=owner]").text(data.owner);
			}
		})

		$("#convertBtn").click(function () {
			if(!confirm("确定转换吗？")) return;

			$("#createTran").val( $("#isCreateTransaction").prop("checked") )

			// 立即以ajax的形式提交
			$("#tranForm").ajaxSubmit(function (data) {
				if(data.success) {
					alert("转换成功！");
				}
			});
		});


		$.ajax({
			url: "/clue/clueActivities.json?clueId=${param.id}",
			success(data) {
				let arr = [];
				//relArr.length = 0; // 清空数组
				relArr = []; // 重新指定新数组
				$(data).each(function () {

					relArr.push(this.activity.id);

					arr.push(
							'<tr trid="',this.id,'">\
								<td><input type="radio" data-name="',this.activity.name,'" data-id="',this.activityId,'" name="id" /></td>\
								<td>',this.activity.name,'</td>\
								<td>',this.activity.startDate,'</td>\
								<td>',this.activity.endDate,'</td>\
								<td>',this.activity.owner,'</td>\
							</tr>'
					)
				});

				$("#dataBody").html( arr.join("") )
			}
		})

		$("#dataBody").on("click", "tr", function () {
			let $radio = $(this).find(":radio").prop("checked", true);
			$("#activityName").val( $radio.data("name") )
			$("#activityId").val( $radio.data("id") )
		}).on("dblclick", "tr", closeModal);
	});
</script>

</head>
<body>
	
	<!-- 搜索市场活动的模态窗口 -->
	<div class="modal fade" id="searchActivityModal" role="dialog" >
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">搜索市场活动</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						<form class="form-inline" role="form">
						  <div class="form-group has-feedback">
						    <input type="text" class="form-control" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
						</form>
					</div>
					<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
							</tr>
						</thead>
						<tbody id="dataBody"></tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<div id="title" class="page-header" style="position: relative; left: 20px;">
		<h4>转换线索 <small><span content="contactsName"></span>-<span content="contactsName"></span></small></h4>
	</div>
	<div id="create-customer" style="position: relative; left: 40px; height: 35px;">
		新建客户：<span content="customerName"></span>
	</div>
	<div id="create-contact" style="position: relative; left: 40px; height: 35px;">
		新建联系人：<span content="contactsName"></span>
	</div>
	<div id="create-transaction1" style="position: relative; left: 40px; height: 35px; top: 25px;">
		<input type="checkbox" id="isCreateTransaction"/>
		为客户创建交易
	</div>
	<div id="create-transaction2" style="position: relative; left: 40px; top: 20px; width: 80%; background-color: #F7F7F7; display: none;" >
		<form id="tranForm" action="/clue/convert.do" method="post">
			<input type="hidden" name="clueId" value="${param.id}" />
			<input type="hidden" name="activityId" id="activityId" />
			<input type="hidden" name="createTran" id="createTran" />


		  <div class="form-group" style="width: 400px; position: relative; left: 20px;">
		    <label for="amountOfMoney">金额</label>
		    <input name="amountOfMoney" type="text" class="form-control" id="amountOfMoney">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="tradeName">交易名称</label>
		    <input name="name" type="text" class="form-control" id="tradeName" value="动力节点-">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="expectedClosingDate">预计成交日期</label>
		    <input date name="expectedClosingDate" type="text" class="form-control" id="expectedClosingDate">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="stage">阶段</label>
		    <select options="stage" name="stage" id="stage"  class="form-control">
		    	<option value="">--请选择--</option>
		    </select>
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="activityName">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal" data-target="#searchActivityModal" style="text-decoration: none;"><span class="glyphicon glyphicon-search"></span></a></label>
		    <input type="text" class="form-control" id="activityName" placeholder="点击上面搜索" readonly>
		  </div>
		</form>
		
	</div>
	
	<div id="owner" style="position: relative; left: 40px; height: 35px; top: 50px;">
		记录的所有者：<br>
		<b content="owner"></b>
	</div>
	<div id="operation" style="position: relative; left: 40px; height: 35px; top: 100px;">
		<input id="convertBtn" class="btn btn-primary" type="button" value="转换">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input class="btn btn-default" type="button" value="取消">
	</div>
</body>
</html>