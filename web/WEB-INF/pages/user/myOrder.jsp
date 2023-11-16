<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>我的收藏</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
</head>
<body>
<div class="layui-fluid" style="margin-top: 40px;">
    <fieldset class="layui-elem-field layui-field-title">
        <legend style="font-size: 26px">我的租房信息</legend>
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
            url: "${pageContext.request.contextPath}/order/myOrderInfo",
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
                , {title: '操作',width:'200', align: 'center', toolbar: "#tools"}
            ]],
        });

        table.on('tool(order)', function (obj) {
            let data = obj.data;
            let layEvent = obj.event;
            let tr = obj.tr;
            let currPage = dt.config.page.curr;

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


            if (layEvent === 'edit') {
                        layer.open({
                            title: '添加报障',
                            type: 1,
                            area: ['700px', '400px'],
                            content: '<blockquote class="layui-elem-quote layui-text">注意事项: 请填写相关的数据信息! </blockquote>' +
                                '<form class="layui-form"> ' +
                                '<div class="layui-form-item">' +
                                '<div class="layui-inline">' +
                                '<label class="layui-form-label">保障原因</label>' +
                                '<div class="layui-input-inline">' +
                                '<input type="text" placeholder="请输入保障原因" required lay-verify="required" name="reason"  class="layui-input" value="" >' +
                                '</div></div>' +
                                '</div>' +

                                '<input style="display: none;" name="houseId" class="layui-input" value="'+data.houseId+'"  />' +
                                '<input style="display: none;" name="userId" class="layui-input" value="'+data.userId+'"  />' +
                                '</form>',
                            btnAlign: 'c',
                            btn: ['确定', '取消'],
                            yes: function (index, layero) {

                                if ($("input[name=reason]").val() == null || $("input[name=reason]").val() == "") {
                                    layer.msg('请输入保障原因', {icon: 5, time: 2000, area: '200px', type: 0, anim: 6,}, function () {
                                        $("input[name=reason]").focus();
                                    });
                                    return false;
                                }

                                //数组
                                var formData = {
                                    reason: $("input[name=reason]").val(),
                                    houseId: $("input[name=houseId]").val(),
                                    userId: $("input[name=userId]").val(),
                                };
                                console.log(formData);
                                $.post('${pageContext.request.contextPath}/houseFault/addHouseFault', formData, function (data) {
                                    //判断是否发送成功
                                    if (data.code == 0) {
                                        layer.msg(data.msg);
                                        layer.close(index);
                                        parent.document.getElementById('my_iframe').contentWindow.location.reload(true);
                                    } else {
                                        layer.msg("保存失败...", {type: 1});
                                    }
                                })
                            }, btn2: function (index, layero) {
                                layer.msg("取消");
                                //return false 开启该代码可禁止点击该按钮关闭
                            }, cancel: function () {
                                layer.msg("关闭窗口");
                                //右上角关闭回调
                                //return false 开启该代码可禁止点击该按钮关闭
                            },
                            success: function () {
                                layui.use('form', function () {
                                    var form = layui.form; //只有执行了这一步，部分表单元素才会修饰成功
                                    form.render('checkbox');
                                    form.on('checkbox(istrue)', function (data) {
                                        /* if(data.elem.checked){
                                         emailConfig['isenterprise']=1;
                                         }; //是否被选中，true或者false*/
                                    });
                                });
                            }
                        });

                    }
                })

        });

</script>
<script type="text/html" id="tools">
    <a class="layui-btn layui-btn-xs " lay-event="edit">房屋报障</a>
    <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete">删除</a>
</script>
</body>
</html>