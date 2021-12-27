<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/jsp/inc/commons_head.jsp" %>
	<script>
		jQuery(function ($) {
			$("#editBtn").click(function () {
				let $cks = $(":checkbox:checked[name=id]");
				if ($cks.size() != 1) {
					alert("必须且只能选择一项！");
					return ;
				}

				//alert($cks.val());
				location = "/type/edit.html?id=" + $cks.val();
			})

			$("#delBtn").click(function () {
				let $cks = $(":checkbox:checked[name=id]");
				if ($cks.size() == 0) {
					alert("请选择删除项！");
					return ;
				}

				let id="";
				$cks.each(function () {
					id+=","+this.value;
				});
				// ,1,2,3
				id = id.substring(1);

				$.ajax({
					url: "/type/checkDel.do?id="+id,
					success(data) {
						// data: 被关联的id
						if(data.length > 0) {
							alert("选中的类型中【"+data+"】已被关联，请使用旁边强制删除！");
							return ;
						}

						if(!confirm("确定删除吗？")) return;

						location = "/type/del.do?id="+id;
					}
				})
			})

			$("#delBtn2").click(function () {
				let $cks = $(":checkbox:checked[name=id]");
				if ($cks.size() == 0) {
					alert("请选择删除项！");
					return ;
				}

				let id="";
				$cks.each(function () {
					id+=","+this.value;
				});
				// ,1,2,3
				id = id.substring(1);

				if(!confirm("是否确定同时删除类型对于的字典值？")) return;

				location = "/type/delForce.do?id="+id;
			})

			$("#selectAll").click(function () {
				$(":checkbox[name=id]").prop("checked", this.checked);
			})

			$(":checkbox[name=id]").click(function () {
				$("#selectAll").prop("checked", $(":checkbox[name=id]").size() == $(":checkbox:checked[name=id]").size());
			})
		})
	</script>
</head>
<body>

	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3>字典类型列表</h3>
			</div>
		</div>
	</div>
	<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px;">
		<div class="btn-group" style="position: relative; top: 18%;">
		  <button type="button" class="btn btn-primary" onclick="window.location.href='/settings/dictionary/type/save.html'"><span class="glyphicon glyphicon-plus"></span> 创建</button>
		  <button id="editBtn" type="button" class="btn btn-default"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
		  <button id="delBtn" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		  <button id="delBtn2" type="button" class="btn btn-danger" style="margin-left: 3px;"><span class="glyphicon glyphicon-minus"></span> 强制删除</button>
		</div>
	</div>
	<div style="position: relative; left: 30px; top: 20px;">
		<table class="table table-hover">
			<thead>
				<tr style="color: #B3B3B3;">
					<td><input type="checkbox" id="selectAll"/></td>
					<td>序号</td>
					<td>编码</td>
					<td>名称</td>
					<td>描述</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${types}" var="t" varStatus="sta">
				<tr class="${sta.index%2==0?"active":""}">
					<td><input type="checkbox" value="${t.id}" name="id" /></td>
					<td>${sta.count}</td>
					<td>${t.id}</td>
					<td>${t.name}</td>
					<td>${t.description}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
</body>
</html>