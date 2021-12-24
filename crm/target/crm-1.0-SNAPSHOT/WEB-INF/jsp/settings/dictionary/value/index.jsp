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
				location = "/value/edit.html?id=" + $cks.val();
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

				if(!confirm("确定删除吗？")) return;

				location = "/value/del.do?id="+id;
			})

			$("#selectAll").click(function () {
				$(":checkbox[name=id]").prop("checked", this.checked);
			});

			$(":checkbox[name=id]").click(function () {
				$("#selectAll").prop("checked", $(":checkbox[name=id]").size() == $(":checkbox:checked[name=id]").size())
			})

			$(":text[name=orderNo]").blur(function () {
				let oldOrderNo = $(this).data("oldOrderNo");
				if (oldOrderNo == this.value) return; // 没有修改，什么都不做

				let $tr = $(this).parent().parent(); // 当前输入框所在的行

				let orderNo = this.value;

				$.ajax({
					url: "/value/changeOrderNo.do",
					data: {
						id: $(this).data("id"),
						orderNo: orderNo
					},
					success(data) {
						if (data.success) {
							//location.reload(); // 偷懒做法

							// 获取类型相同的兄弟元素
							let $siblings = $tr.siblings("[data-type="+$tr.data("type")+"]");

							if($siblings.size() != 0) {
								let $prev = $tr.prev("[data-type="+$tr.data("type")+"]"); // 上一行
								let $next = $tr.next("[data-type="+$tr.data("type")+"]"); // 下一行

								// 无需调整位置
								if ($prev.size() && $prev.find(":text").val() == orderNo
										|| $next.size() && $next.find(":text").val() == orderNo) {
									return ;
								}

								let $flag; // 需要调整到这个位置之后

								// 根据排序号大小判定
								$siblings.each(function () {
									if ($(this).find(":text").val() <= orderNo - 0) {
										$flag = $(this);
									}
								});

								if($flag) {
									$tr.insertAfter($flag);
								}
								// 没有找到, 那就插入到最前面
								else {
									$tr.insertBefore($siblings.first());
								}

								// 纠正序号
								$("tbody tr").each(function () {
									let index = $(this).index(); // 当前行在同辈元素中的索引
									$(this).find("td:eq(1)").text(index + 1);
								})
							}
						}
					}
				});
			}).focus(function () {
				$(this).data("oldOrderNo", this.value);
			});

			// drag:被拖拽
			// drop:目标位置
			let $drag,$drop;
			$("tbody tr").on("dragstart", function (e) {
				//console.log( e.currentTarget.tagName )
				//console.log( $(e.currentTarget).find("td:eq(3)").text() );

				$drag = $(e.currentTarget); // 记录被拖拽的元素

			}).on("dragenter", function (e) {
				//console.log( e.currentTarget.tagName ) // tagName: 标签名
				//console.log( $(e.currentTarget).find("td:eq(3)").text() );

				// 限定近在相同类型下才记录目标位置
				if ($(e.currentTarget).data("type") == $drag.data("type")) {
					$drop = $(e.currentTarget); // 记录拖拽到的目标位置
					console.log( "记录目标位置：" + $(e.currentTarget).find("td:eq(3)").text() );
				}
			}).on("dragend", function () {
				console.log("拖拽完成！");

				//console.log( "被拖拽：" + drag.find("td:eq(3)").text() );
				//console.log( "拖拽到：" + drop.find("td:eq(3)").text() );

				if ($drag.index() == $drop.index()) return ;
				if ($drag.index() < $drop.index()) {
					// detach:删除元素，保留事件，返回被删除的元素
					$drag.detach().insertAfter($drop);
				} else {
					$drag.detach().insertBefore($drop);
				}

				// 纠正序号
				$("tbody tr").each(function () {
					let index = $(this).index(); // 当前行在同辈元素中的索引
					$(this).find("td:eq(1)").text(index + 1);
				})

				// 纠正排序号
				let type = $drag.data("type");
				$("tbody tr[data-type="+type+"]").each(function (i) {
					$(this).find("td:eq(4)").text(i+1);
				})

				// 后端修改
				let ids = "";
				$("tbody tr[data-type="+type+"]").each(function (i) {
					ids += "," + $(this).find(":checkbox").val();
				});
				ids = ids.substring(1);

				$.ajax("/value/changeOrderNos.do?ids="+ids);
			});

		})
	</script>
</head>
<body>

	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3>字典值列表</h3>
			</div>
		</div>
	</div>
	<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px;">
		<div class="btn-group" style="position: relative; top: 18%;">
		  <button type="button" class="btn btn-primary" onclick="window.location.href='/settings/dictionary/value/save.html'"><span class="glyphicon glyphicon-plus"></span> 创建</button>
		  <button id="editBtn" type="button" class="btn btn-default"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
		  <button id="delBtn" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	<div style="position: relative; left: 30px; top: 20px;">
		<table class="table table-hover table-striped">
			<thead>
				<tr style="color: #B3B3B3;">
					<td><input id="selectAll" type="checkbox" /></td>
					<td>序号</td>
					<td>字典值</td>
					<td>文本</td>
					<td>排序号</td>
					<td>字典类型</td>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${values}" var="v" varStatus="sta">
				<tr draggable="true" data-type="${v.typeId}">
					<td><input type="checkbox" name="id" value="${v.id}" /></td>
					<td>${sta.count}</td>
					<td>${v.value}</td>
					<td>${v.text}</td>
					<td><input name="orderNo" data-type="${v.typeId}" data-id="${v.id}" value="${v.orderNo}" style="width:50px;border:none;background-color: transparent;outline: none;" /></td>
					<%--<td>${v.orderNo}</td>--%>
					<td>${v.type.name}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	
</body>
</html>