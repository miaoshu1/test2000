<%@page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/jsp/inc/commons_head.jsp" %>
	<script>
		jQuery(function ($) {
			$("#updateBtn").click(function () {
				$("form").submit();
			})
		})
	</script>
</head>
<body>

	<div style="position:  relative; left: 30px;">
		<h3>修改字典值</h3>
	  	<div style="position: relative; top: -40px; left: 70%;">
			<button id="updateBtn" type="button" class="btn btn-primary">更新</button>
			<button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
		</div>
		<hr style="position: relative; top: -40px;">
	</div>
	<form action="/value/edit.do" method="post" class="form-horizontal" role="form">

		<%--id作为修改的条件，不需要显示，但必须提交，使用隐藏域--%>
		<input type="hidden" name="id" value="${value.id}" />

		<div class="form-group">
			<label for="edit-dicTypeCode" class="col-sm-2 control-label">字典类型</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="edit-dicTypeCode" style="width: 200%;" value="${value.type.name}" readonly>
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-dicValue" class="col-sm-2 control-label">字典值<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input name="value" type="text" class="form-control" id="edit-dicValue" style="width: 200%;" value="${value.value}">
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-text" class="col-sm-2 control-label">文本</label>
			<div class="col-sm-10" style="width: 300px;">
				<input name="text" type="text" class="form-control" id="edit-text" style="width: 200%;" value="${value.text}">
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-orderNo" class="col-sm-2 control-label">排序号</label>
			<div class="col-sm-10" style="width: 300px;">
				<input name="orderNo" type="text" class="form-control" id="edit-orderNo" style="width: 200%;" value="${value.orderNo}">
			</div>
		</div>
	</form>
	
	<div style="height: 200px;"></div>
</body>
</html>