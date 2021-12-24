<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<meta charset="UTF-8">
<link href="/static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="/static/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="/static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/static/js/jquery.md5.js"></script>

<%--时间控件--%>
<link href="/static/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="/static/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="/static/bootstrap-datetimepicker/locale/bootstrap-datetimepicker.zh-CN.js"></script>
<%--jQuery的form插件--%>
<script type="text/javascript" src="/static/js/jquery.form.js"></script>

<%--jQuery对象函数扩展--%>
<script type="text/javascript" src="/static/js/jquery.fn.extend.js"></script>

<%--分页插件--%>
<link href="/static/bs_pagination/jquery.bs_pagination.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="/static/bs_pagination/en.js"></script>
<script type="text/javascript" src="/static/bs_pagination/jquery.bs_pagination.min.js"></script>

<%--自动补全--%>
<script type="text/javascript" src="/static/bs_typeahead/bootstrap3-typeahead.min.js"></script>

<script>
    jQuery(function ($) {
        $("input[datetime]").datetimepicker({
            language: "zh-CN",
            format: "yyyy-mm-dd hh:ii:ss",//显示格式
            minView: "hour", // 日期时间选择器所能够提供的最精确的时间选择视图。
            initialDate: new Date(),//初始化当前日期
            autoclose: true, //选中自动关闭
            clearBtn: true,
            todayBtn: true,
            pickerPosition: "bottom-right"
        })
        .prop("readonly", true)
        .css("cursor", "default")
        // 输入框中的值发生改变并失去焦点时触发
        .on("change", function () { // 将秒设置为00
            //console.log(this.value);
            //console.log(this.value.replace(/\d\d$/, "00"));
            //console.log(this);
            //this.value = this.value.replace(/\d\d$/, "00")
            // setTimeout: 定时器：指定函数在多少毫秒之后执行
            setTimeout(function () {
                //console.log(this);
                this.value = this.value.replace(/\d\d$/, "00");
            }.bind(this), 1);
        });

        $("input[date]").datetimepicker({
            language: "zh-CN",
            format: "yyyy-mm-dd",//显示格式
            minView: "month", // 日期时间选择器所能够提供的最精确的时间选择视图。
            initialDate: new Date(),//初始化当前日期
            autoclose: true, //选中自动关闭
            clearBtn: true,
            todayBtn: true,
            pickerPosition: "bottom-right"
        }).
        // 设置只读、修改光标样式
        prop("readonly", true).css("cursor", "default");


        if ($("select[owner]").size())
        // 加载所有者下拉框
        $.ajax({
            url: "/user/owners.json",
            success(data) {
                $(data).each(function () {
                    $("<option>"+this+"</option>").appendTo("select[owner]");
                })
            }
        });

        let loaded = []; // 已经读取过的字典类型
        $("select[options]").each(function () {
            let type = $(this).attr("options");
            if ( !loaded.includes(type) ) { // 该类型还没有读取
                loaded.push(type); // 标记已经读取
                $.ajax({
                    //url: "/cache/options.json?type="+type, // 传统路径风格
                    url: "/cache/"+type, // REST风格
                    success: function(data) {
                        $(data).each(function () {
                            $("<option>"+this.text+"</option>").appendTo("select[options="+type+"]");
                        })
                    }
                });
            }
        })


    });

    function closeModal() {
        jQuery("div[id$=Modal]:visible").modal('hide');
    }

</script>

