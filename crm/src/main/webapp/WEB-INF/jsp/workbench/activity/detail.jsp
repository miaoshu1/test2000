<%@page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/jsp/inc/commons_head.jsp" %>
	<script type="text/javascript">

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;
	
	jQuery(function($){
		$("#remark").focus(function(){
			if(cancelAndSaveBtnDefault){
				//设置remarkDiv的高度为130px
				$("#remarkDiv").css("height","130px");
				//显示
				$("#cancelAndSaveBtn").show("2000");
				cancelAndSaveBtnDefault = false;
			}
		});
		
		$("#cancelBtn").click(function(){
			//显示
			$("#cancelAndSaveBtn").hide();
			//设置remarkDiv的高度为130px
			$("#remarkDiv").css("height","90px");
			cancelAndSaveBtnDefault = true;
			$("#remark").val("");

			currentId = undefined;
		});

		let currentId;

		$("#remarks").on("mouseenter", ".remarkDiv",function(){
			$(this).children("div").children("div").show();
		}).on("mouseleave",".remarkDiv",function(){
			$(this).children("div").children("div").hide();
		}).on("mouseenter",".myHref",function(){
			$(this).children("span").css("color","red");
		}).on("mouseleave",".myHref",function(){
			$(this).children("span").css("color","#E6E6E6");
		}).on("click", "a[edit]", function () {
			// 将备注内容赋值给备注输入框
			let content = $(this).attr("edit");
			$("#remark").val( content );

			currentId = $(this).attr("remarkId");

			$("#remark").focus();
		}).on("click","a[del]", function () {
			if (!confirm("确定删除吗？")) return ;
			$.ajax({
				url: "/act/delRemark.do?id="+$(this).attr("del"),
				type: "delete",
				success: function (data) {
					if (data.success) {
						loadRemarks();
					}
					if (data.msg) {
						alert(data.msg);
					}
				}
			})
		});

		//alert("${param.id}")
		//alert("<%=request.getParameter("id")%>")

		function loadRemarks() {
			$.ajax({
				url: "/act/remarks.json?actId=${param.id}",
				success: function (data) {
					let arr = [];
					$(data).each(function () {
						arr.push(
							'<div class="remarkDiv" style="height: 60px;">\
								<img title="zhangsan" src="/static/image/user-thumbnail.png" style="width: 30px; height:30px;">\
								<div style="position: relative; top: -40px; left: 40px;" >\
									<h5>',this.noteContent,'</h5>\
									<font color="gray">市场活动</font> <font color="gray">-</font> <b>',act.name,'</b> <small style="color: gray;"> ',this.noteTime,' 由',this.notePerson,'</small>\
									<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">\
										<a edit="',this.noteContent,'" remarkId="',this.id,'" class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>\
										&nbsp;&nbsp;&nbsp;&nbsp;\
										<a del="',this.id,'" class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>\
									</div>\
								</div>\
							</div>'
						)
					})

					$("#remarks").html( arr.join("") );
				}
			})
		}

		let act;
		$.ajax({
			url: "/act/activity.json?id=${param.id}",
			success: function (data) {
				act = data;
				/*$("[content=name]").html(data.name);
				$("[content=owner]").html(data.owner);
				$("[content=startDate]").html(data.startDate);
				$("[content=endDate]").html(data.endDate);*/
				// ...

				$("[content]").html(function () {
					//return data[this.content];
					//return data[ $(this).prop("content") ]; // 同上
					return (data[ $(this).attr("content") ] || "") + "&nbsp;";
				});
			}
		}).done(loadRemarks);

		$("#saveBtn").click(function () {
			$.ajax({
				url: "/act/saveRemark.do",
				type: "post",
				data: {
					id: currentId,
					noteContent: $("#remark").val(),
					marketingActivitiesId: "${param.id}"
				},
				success: function (data) {
					if (data.success) {
						loadRemarks();
						$("#cancelBtn").click(); // 调用绑定的click事件
					}
					if (data.msg) {
						alert(data.msg);
					}
				}
			})
		})
	});
	
</script>

</head>
<body>
	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3>市场活动-<span content="name"></span> <small><span content="startDate"></span> ~ <span content="endDate"></span></small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" data-toggle="modal" data-target="#editActivityModal"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b content="owner"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b content="name"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>

		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">开始日期</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b content="startDate"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b content="endDate"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">成本</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b content="cost"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b content="createBy"></b><small content="createTime" style="font-size: 10px; color: gray;"></small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b content="editBy"></b><small content="editTime" style="font-size: 10px; color: gray;"></small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b content="description"></b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
	</div>
	
	<!-- 备注 -->
	<div style="position: relative; top: 30px; left: 40px;">
		<div class="page-header">
			<h4>备注</h4>
		</div>

		<div id="remarks"></div>
		
		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
					<button id="saveBtn" type="button" class="btn btn-primary">保存</button>
				</p>
			</form>
		</div>
	</div>
	<div style="height: 200px;"></div>
</body>
</html>