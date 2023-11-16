<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>查看所有管理员</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css">
</head>
<body>
<div class="layui-fluid" style="margin-top: 40px;">
    <fieldset class="layui-elem-field layui-field-title">
        <legend style="font-size: 26px">所有管理员</legend>
    </fieldset>
    <button type="button" id="addSite" class="layui-btn layui-btn-sm">添加管理员</button>
    <table id="allUser" lay-filter="user"></table>
</div>
<script type="text/html" id="tools">
    <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-xs" lay-event="editPassword">初始化密码</a>
    <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete">删除</a>
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
            url: "${pageContext.request.contextPath}/admin/getAdminList",
            page: false,
            cols: [[
                {field: 'username', title: '用户名', align: 'center' },
                {field: 'roleName',title: '角色名称',  align: 'center'},
                {title: '操作', align: 'left', toolbar: "#tools"}
                ]]
        });

        table.on('tool(user)', function (obj) {
            let data = obj.data;
            let layEvent = obj.event;
            let tr = obj.tr;
            let currPage = dt.config.page.curr;

            if(layEvent==="editPassword"){
                layer.confirm('确认初始化密码为888888吗？', {icon: 5, shade: 0.1}, function (index) {
                    $.post("${pageContext.request.contextPath}/admin/editAdminPwd", {id: data.id,userpwd:"888888"}, function (success) {

                        if (success.code ==0) {
                            layer.msg("修改成功");
                        }
                    })
                });


            }

            if(layEvent==='edit'){
                     $.post("${pageContext.request.contextPath}/admin/findRoleAll", {}, function (success2) {
                        let optionHtml='';
                        for(let i=0;i<success2.data.length;i++){

                            if(success2.data[i].roleId==data.roleId){
                                optionHtml+= '<option value="'+success2.data[i].roleId+'" selected="selected">'+success2.data[i].roleName+'</option>';
                            }else{
                                optionHtml+= '<option value="'+success2.data[i].roleId+'">'+success2.data[i].roleName+'</option>';
                            }
                        }

                         console.log(data);

                        layer.open({
                            title: '编辑管理员',
                            type: 1,
                            area: ['700px', '500px'],
                            content: '<blockquote class="layui-elem-quote layui-text">注意事项: 请填写相关的数据信息! </blockquote>' +
                                '<form class="layui-form"> ' +
                                '<div class="layui-form-item">' +
                                '<div class="layui-inline">' +
                                '<label class="layui-form-label">管理员登录账户</label>' +
                                '<div class="layui-input-inline">' +
                                '<input type="text" placeholder="请输入管理员名称" required lay-verify="required" name="username"  class="layui-input" value="'+data.username+'" >' +
                                '</div></div>' +
                                '</div>' +
                                '<div class="layui-form-item">' +
                                '<div class="layui-inline">' +
                                '<label class="layui-form-label">角色</label>' +
                                '<div class="layui-input-inline">' +
                                '<select name="roleId" lay-verify="required">'+
                                optionHtml+
                                '</select> '+
                                '</div></div>' +
                                '</div>' +
                                '<input type="text" style="display: none;"  name="id"  class="layui-input" value="'+data.id+'" >' +
                                '</form>',
                            btnAlign: 'c',
                            btn: ['确定', '取消'],
                            yes: function (index, layero) {

                                if ($("input[name=username]").val() == null || $("input[name=username]").val() == "") {
                                    layer.msg('请输入管理员登录账户', {icon: 5, time: 2000, area: '200px', type: 0, anim: 6,}, function () {
                                        $("input[name=username]").focus();
                                    });
                                    return false;
                                }

                                if ($("select[name=roleId]").val() == null || $("select[name=roleId]").val() == "") {
                                    layer.msg('请选择角色', {
                                        icon: 5,
                                        time: 2000,
                                        area: '200px',
                                        type: 0,
                                        anim: 6
                                    }, function () {
                                        $("input[name=roleId]").focus();
                                    });
                                    return false;
                                }
                                //数组
                                var formData = {
                                    userName: $("input[name=username]").val(),
                                    id: $("input[name=id]").val(),
                                    roleId: $("select[name=roleId]").val(),
                                };
                                console.log(formData);
                                $.post('${pageContext.request.contextPath}/admin/editAdmin', formData, function (data) {
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
                                    form.render('select');
                                    form.on('checkbox(istrue)', function (data) {
                                        /* if(data.elem.checked){
                                         emailConfig['isenterprise']=1;
                                         }; //是否被选中，true或者false*/
                                    });
                                });
                            }
                        });
                    })

            }


            if (layEvent === 'delete') {
                layer.confirm('确认删除当前数据吗？', {icon: 5, shade: 0.1}, function (index) {
                    $.post("${pageContext.request.contextPath}/admin/adminDeleteById", {id: data.id}, function (success) {

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

        $("#addSite").click(function () {
            $.post("${pageContext.request.contextPath}/admin/findRoleAll", {}, function (success2) {

                let optionHtml='';
                for(let i=0;i<success2.data.length;i++){
                    optionHtml+= '<option value="'+success2.data[i].roleId+'">'+success2.data[i].roleName+'</option>';
                }

                layer.open({
                    title: '添加管理员',
                    type: 1,
                    area: ['700px', '500px'],
                    content: '<blockquote class="layui-elem-quote layui-text">注意事项: 请填写相关的数据信息! </blockquote>' +
                        '<form class="layui-form"> ' +
                        '<div class="layui-form-item">' +
                        '<div class="layui-inline">' +
                        '<label class="layui-form-label">管理员登录账户</label>' +
                        '<div class="layui-input-inline">' +
                        '<input type="text" placeholder="请输入管理员名称" required lay-verify="required" name="username"  class="layui-input" value="" >' +
                        '</div></div>' +
                        '</div>' +
                        '<div class="layui-form-item">' +
                        '<div class="layui-inline">' +
                        '<label class="layui-form-label">管理员登录密码</label>' +
                        '<div class="layui-input-inline">' +
                        '<input type="password" placeholder="请输入管理员密码" required lay-verify="required" name="userpwd"  class="layui-input" value="" >' +
                        '</div></div>' +
                        '</div>' +
                        '<div class="layui-form-item">' +
                        '<div class="layui-inline">' +
                        '<label class="layui-form-label">角色</label>' +
                        '<div class="layui-input-inline">' +
                        '<select name="roleId" lay-verify="required">'+
                        optionHtml+
                        '</select> '+
                        '</div></div>' +
                        '</div>' +
                        '</form>',
                    btnAlign: 'c',
                    btn: ['确定', '取消'],
                    yes: function (index, layero) {

                        if ($("input[name=username]").val() == null || $("input[name=username]").val() == "") {
                            layer.msg('请输入管理员登录账户', {icon: 5, time: 2000, area: '200px', type: 0, anim: 6,}, function () {
                                $("input[name=username]").focus();
                            });
                            return false;
                        }
                        if ($("input[name=userpwd]").val() == null || $("input[name=userpwd]").val() == "") {
                            layer.msg('请输入管理员登录密码', {icon: 5, time: 2000, area: '200px', type: 0, anim: 6,}, function () {
                                $("input[name=userpwd]").focus();
                            });
                            return false;
                        }

                        if ($("select[name=roleId]").val() == null || $("select[name=roleId]").val() == "") {
                            layer.msg('请选择角色', {
                                icon: 5,
                                time: 2000,
                                area: '200px',
                                type: 0,
                                anim: 6
                            }, function () {
                                $("input[name=roleId]").focus();
                            });
                            return false;
                        }
                        //数组
                        var formData = {
                            username: $("input[name=username]").val(),
                            userpwd: $("input[name=userpwd]").val(),
                            roleId: $("select[name=roleId]").val(),
                        };
                        console.log(formData);
                        $.post('${pageContext.request.contextPath}/admin/addAdmin', formData, function (data) {
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
                            form.render('select');
                            form.on('checkbox(istrue)', function (data) {
                                /* if(data.elem.checked){
                                 emailConfig['isenterprise']=1;
                                 }; //是否被选中，true或者false*/
                            });
                        });
                    }
                });
            })
        })


    });



</script>
</body>
</html>