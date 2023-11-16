<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>订单</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
</head>
<body>
<div class="layui-fluid" style="margin-top: 40px;">
    <fieldset class="layui-elem-field layui-field-title">
        <legend style="font-size: 26px">租房信息</legend>
    </fieldset>
    <table id="houseList" lay-filter="order"></table>
</div>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    layui.use(['element', 'form', 'table', 'util'], function () {
        let element = layui.element,
            $ = layui.jquery,
            table = layui.table,
            util = layui.util;

        let dt = table.render({
            elem: "#houseList",
            url: "${pageContext.request.contextPath}/order/allOrderInfo",
            page: true,
            method: 'post',
            limit: 10,
            loading: true,
            cols: [[
                {field: 'orderId', title: '序号', align: 'center'}
                , {field: 'houseDesc', title: '房屋详情', align: 'center'}
                , {field: 'houseModel', title: '几室几厅', align: 'center'}
                , {field: 'houseArea', title: '面积', align: 'center'}
                , {field: 'houseFloor', title: '楼层', align: 'center'}
                , {field: 'houseType', title: '出租方式', align: 'center'}
                , {field: 'housePrice', title: '价格', align: 'center'}
                , {field: 'houseAddress', title: '地址', align: 'center'}
                , {field: 'houseLinkMan', title: '联系人', align: 'center'}
                , {field: 'communityName', title: '小区名', align: 'center'}
                , {field: 'houseOriented', title: '朝向', align: 'center'}
                , {
                    field: 'type', title: '类型', align: 'center',
                    templet: function (d) {
                        if(d.type==1){
                            return "申请看房"
                        }else if(d.type==2){
                            return "申请签合同"
                        }

                    }
                }, {
                    field: 'status', title: '状态', align: 'center',
                    templet: function (d) {
                        if(d.type==1&&d.status==1){
                            return "正在申请看房"
                        }else if(d.type==1&&d.status==2){
                            return "看房完毕"
                        }else if(d.type==2&&d.status==1){
                            return "正在申请签合同"
                        }else if(d.type==2&&d.status==2){
                            return "签合同完毕"
                        }

                    }
                }

                , {
                    field: 'orderTime', title: '订单时间', align: 'center',
                    templet: function (d) {
                        return util.toDateString(d.orderTime)
                    }
                }
                , {field: 'orderUser', title: '订单人', align: 'center'}
                , {title: '操作', align: 'center', width:"200",toolbar: "#tools"}
            ]],
        });

        table.on('tool(order)', function (obj) {
            let data = obj.data;
            let layEvent = obj.event;
            let tr = obj.tr;
            let currPage = dt.config.page.curr;
            if (layEvent === 'edit') {
                layer.confirm('确认要修改为完成状态吗？', {icon: 5, shade: 0.1}, function (index) {
                    $.post("${pageContext.request.contextPath}/order/editOrder", {orderId: data.orderId}, function (success) {
                        if (success === "OK") {
                            dt.reload({
                                page: {curr: 1}
                            });
                            layer.msg("修改成功");
                        }
                    })
                });
            }

            if (layEvent === 'delete') {
                layer.confirm('确认删除当前数据吗？', {icon: 5, shade: 0.1}, function (index) {
                    $.post("${pageContext.request.contextPath}/order/deleteOrder", {orderId: data.orderId}, function (success) {
                        if (success === "OK") {
                            obj.del();
                            dt.reload({
                                page: {curr: 1}
                            });
                            layer.msg("删除成功");
                        }
                    })
                });
            }
        });
    });
</script>
<script type="text/html" id="tools">
    <a class="layui-btn layui-btn-xs" lay-event="edit">修改状态</a>
    <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete">删除</a>

</script>
</body>
</html>