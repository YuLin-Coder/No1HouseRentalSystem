<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>





<head>
    <meta charset="UTF-8">
    <title>查看所有角色</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css">
</head>
<body>
<div class="layui-fluid" style="margin-top: 40px;">
    <fieldset class="layui-elem-field layui-field-title">
        <legend style="font-size: 26px">所有角色</legend>
    </fieldset>
    <button type="button" id="addSite" class="layui-btn layui-btn-sm">添加角色</button>
    <table id="allUser" lay-filter="user"></table>
</div>
<script type="text/html" id="tools">
    <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
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
            url: "${pageContext.request.contextPath}/roles/getRolesList",
            page: true,
            cols: [[
                {field: 'roleName', title: '角色名称', align: 'center'},
                {field: 'roleRemark', title: '角色备注', align: 'center'},
                {title: '操作', align: 'center', toolbar: "#tools"}
                ]]
        });

        table.on('tool(user)', function (obj) {
            let data = obj.data;
            let layEvent = obj.event;
            let tr = obj.tr;
            let currPage = dt.config.page.curr;

            if(layEvent === 'edit'){

                //查询此roles信息
                $.post("${pageContext.request.contextPath}/roles/findRolesById", {roleId: data.roleId}, function (success1) {

                    //查询此所有菜单信息
                        $.post("${pageContext.request.contextPath}/menus/getMenusList", {}, function (success2) {

                            $.post("${pageContext.request.contextPath}/roles/getRolesMenusListByRoleId", {roleId:success1.data.roleId}, function (success3) {

                                let str='';
                                for(let j=0;j<success3.data.length;j++){
                                    str+=success3.data[j].menuId+',';
                                }

                                let checkboxHtml='';
                                for(let i=0;i<success2.data.length;i++){
                                    if(success2.data[i].parentId!=null && success2.data[i].parentId!='0' && success2.data[i].parentId!=0){
                                        if(str.indexOf(success2.data[i].menuId) != -1){
                                            checkboxHtml+= '<input type="checkbox" name="'+success2.data[i].menuId+'" title="'+ '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+success2.data[i].title+'" value="1" checked>'
                                        }else{
                                            checkboxHtml+= '<input type="checkbox" name="'+success2.data[i].menuId+'" title="'+ '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+success2.data[i].title+'" value="1">'
                                        }

                                    }else{
                                        if(str.indexOf(success2.data[i].menuId) != -1){
                                            checkboxHtml+=  '<input type="checkbox" name="'+success2.data[i].menuId+'" title="'+success2.data[i].title+'" value="1"  checked>'
                                        }else{
                                            checkboxHtml+=  '<input type="checkbox" name="'+success2.data[i].menuId+'" title="'+success2.data[i].title+'" value="1">'
                                        }
                                    }
                                }

                                layer.open({
                                    title: '修改角色',
                                    type: 1,
                                    area: ['700px', '400px'],
                                    content: '<blockquote class="layui-elem-quote layui-text">注意事项: 请填写相关的数据信息! </blockquote>' +
                                        '<form class="layui-form"> ' +
                                        '<div class="layui-form-item">' +
                                        '<div class="layui-inline">' +
                                        '<label class="layui-form-label">角色名称</label>' +
                                        '<div class="layui-input-inline">' +
                                        '<input type="text"  required lay-verify="required" name="roleName"  class="layui-input" value="'+success1.data.roleName+'" >' +
                                        '</div></div>' +
                                        '</div>' +

                                        '<div class="layui-form-item">' +
                                        '<div class="layui-inline">' +
                                        '<label class="layui-form-label">分配权限</label>' +
                                        '<div class="layui-input-inline">' +

                                        checkboxHtml+

                                        '</div></div>' +
                                        '</div>' +
                                        '<div class="layui-form-item" style="width: 621px;">' +
                                        '<label class="layui-form-label">备注</label>' +
                                        '<div class="layui-input-block">' +
                                        '<textarea placeholder="请输入备注" name="roleRemark" class="layui-textarea">'+success1.data.roleRemark+'</textarea>' +
                                        '</div>' +
                                        '</div>' +
                                        '<input type="text" style="display: none;" name="roleId"  class="layui-input" value="'+success1.data.roleId+'" >' +
                                        '</form>',
                                    btnAlign: 'c',
                                    btn: ['确定', '取消'],
                                    yes: function (index, layero) {

                                        if ($("input[name=roleName]").val() == null || $("input[name=roleName]").val() == "") {
                                            layer.msg('请输入角色名称', {icon: 5, time: 2000, area: '200px', type: 0, anim: 6,}, function () {
                                                $("input[name=roleName]").focus();
                                            });
                                            return false;
                                        }
                                        var arr_box = [];
                                        $('input[type=checkbox]:checked').each(function() {
                                            arr_box.push($(this).attr("name"));
                                        });
                                        //数组
                                        console.log(arr_box);
                                        var formData = {
                                            roleName: $("input[name=roleName]").val(),
                                            roleRemark: $("textarea[name=roleRemark]").val(),
                                            roleId: $("input[name=roleId]").val(),
                                            roleMenus:arr_box.join(",")
                                        };
                                        console.log(formData);
                                        $.post('${pageContext.request.contextPath}/roles/editRoles', formData, function (data) {
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



                            });
                        });


                })
             }

            if (layEvent === 'delete') {
                layer.confirm('确认删除当前数据吗？', {icon: 5, shade: 0.1}, function (index) {
                    $.post("${pageContext.request.contextPath}/roles/rolesDeleteById", {roleId: data.roleId}, function (success) {

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

            $.post("${pageContext.request.contextPath}/menus/getMenusList", {}, function (success) {

                let checkboxHtml='';

                for(let i=0;i<success.data.length;i++){
                    if(success.data[i].parentId!=null && success.data[i].parentId!='0' && success.data[i].parentId!=0){
                        checkboxHtml+= '<input type="checkbox" name="'+success.data[i].menuId+'" title="'+ '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+success.data[i].title+'" value="1">'
                    }else{
                        checkboxHtml+=  '<input type="checkbox" name="'+success.data[i].menuId+'" title="'+success.data[i].title+'" value="1">'
                    }
                }

                layer.open({
                    title: '添加角色',
                    type: 1,
                    area: ['700px', '400px'],
                    content: '<blockquote class="layui-elem-quote layui-text">注意事项: 请填写相关的数据信息! </blockquote>' +
                        '<form class="layui-form"> ' +
                        '<div class="layui-form-item">' +
                        '<div class="layui-inline">' +
                        '<label class="layui-form-label">角色名称</label>' +
                        '<div class="layui-input-inline">' +
                        '<input type="text"  required lay-verify="required" name="roleName"  class="layui-input" value="" >' +
                        '</div></div>' +
                        '</div>' +

                        '<div class="layui-form-item">' +
                        '<div class="layui-inline">' +
                        '<label class="layui-form-label">分配权限</label>' +
                        '<div class="layui-input-inline">' +

                        checkboxHtml+

                        '</div></div>' +
                        '</div>' +
                        '<div class="layui-form-item" style="width: 621px;">' +
                        '<label class="layui-form-label">备注</label>' +
                        '<div class="layui-input-block">' +
                        '<textarea placeholder="请输入备注" name="roleRemark" class="layui-textarea"></textarea>' +
                        '</div>' +
                        '</div>' +
                        '</form>',
                    btnAlign: 'c',
                    btn: ['确定', '取消'],
                    yes: function (index, layero) {

                        if ($("input[name=roleName]").val() == null || $("input[name=roleName]").val() == "") {
                            layer.msg('请输入角色名称', {icon: 5, time: 2000, area: '200px', type: 0, anim: 6,}, function () {
                                $("input[name=roleName]").focus();
                            });
                            return false;
                        }
                        var arr_box = [];
                        $('input[type=checkbox]:checked').each(function() {
                            arr_box.push($(this).attr("name"));
                        });
                        //数组
                        console.log(arr_box);
                        var formData = {
                            roleName: $("input[name=roleName]").val(),
                            roleRemark: $("textarea[name=roleRemark]").val(),
                            roleMenus:arr_box.join(",")
                        };
                        console.log(formData);
                        $.post('${pageContext.request.contextPath}/roles/addRoles', formData, function (data) {
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
            });

        })


    });





</script>
</body>
</html>