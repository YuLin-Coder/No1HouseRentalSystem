<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>查看所有房屋报障</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css">
</head>
<body>
<div class="layui-fluid" style="margin-top: 40px;">
    <fieldset class="layui-elem-field layui-field-title">
        <legend style="font-size: 26px">所有房屋报障</legend>
    </fieldset>

    <table id="allUser" lay-filter="user"></table>
</div>
<script type="text/html" id="tools">
    <a class="layui-btn layui-btn-xs" lay-event="delete">修改状态</a>
</script>
<script src="${pageContext.request.contextPath }/layui/layui.js"></script>
<script>
    layui.use(['element', 'table'], function () {
        let element = layui.element,
            $ = layui.jquery,
            table = layui.table;

        /*渲染数据*/
        let dt = table.render({
            elem: "#allUser",
            url: "${pageContext.request.contextPath}/houseFault/getHouseFaultAllList",
            page: true,
            cols: [[
                {field: 'houseDesc', title: '房屋', align: 'center'},
                {field: 'reason', title: '报障原因', align: 'center'},
                {field: 'status', title: '状态', align: 'center', templet: function (d) {
                        if(d.status==1){
                            return "未维修"
                        }else if(d.status==2){
                            return "已维修"
                        }

                    }},
                {field: 'createTime', title: '操作时间', align: 'center',templet: '<div>{{ formatTime(d.createTime,"yyyy-MM-dd hh:mm:ss")}}</div>'},
                {title: '操作', align: 'center', toolbar: "#tools"}
                ]]
        });

        table.on('tool(user)', function (obj) {
            let data = obj.data;
            let layEvent = obj.event;
            let tr = obj.tr;
            let currPage = dt.config.page.curr;



            if (layEvent === 'delete') {
                layer.confirm('确认修改当前状态为已维修吗？', {icon: 5, shade: 0.1}, function (index) {
                    $.post("${pageContext.request.contextPath}/houseFault/editHouseFault", {id: data.id}, function (success) {

                        if (success === "OK") {
                            dt.reload({
                                page: {curr: 1}
                            });
                            layer.msg("修改成功!");
                        }
                    })
                });
            }
        });



    });



    //格式化时间
    function formatTime(datetime, fmt) {
        if (datetime == null || datetime == 0) {
            return "";
        }
        if (parseInt(datetime) == datetime) {
            if (datetime.length == 10) {
                datetime = parseInt(datetime) * 1000;
            } else if (datetime.length == 13) {
                datetime = parseInt(datetime);
            }
        }
        datetime = new Date(datetime);
        var o = {
            "M+": datetime.getMonth() + 1, //月份
            "d+": datetime.getDate(), //日
            "h+": datetime.getHours(), //小时
            "m+": datetime.getMinutes(), //分
            "s+": datetime.getSeconds(), //秒
            "q+": Math.floor((datetime.getMonth() + 3) / 3), //季度
            "S": datetime.getMilliseconds()
            //毫秒
        };
        if (/(y+)/.test(fmt))
            fmt = fmt.replace(RegExp.$1, (datetime.getFullYear() + "")
                .substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt))
                fmt = fmt.replace(RegExp.$1,
                    (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k])
                        .substr(("" + o[k]).length)));
        return fmt;
    }

</script>
</body>
</html>