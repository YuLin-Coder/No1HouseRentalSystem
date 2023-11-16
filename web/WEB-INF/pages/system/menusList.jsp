<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>查看所有菜单</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css">
</head>
<body>
<div class="layui-fluid" style="margin-top: 40px;">
    <fieldset class="layui-elem-field layui-field-title">
        <legend style="font-size: 26px">所有菜单</legend>
    </fieldset>
    <button type="button" id="addSite" class="layui-btn layui-btn-sm">添加一级菜单</button>
    <table id="allUser" lay-filter="user"></table>
</div>
<script type="text/html" id="tools">
    <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>

    {{#
    var statusBut= function(parentId){
        if(parentId!=null && parentId!='0' && parentId!=0){
            return "";
        }else {
            return '<a class="layui-btn layui-btn-xs" lay-event="add">添加子级</a>';
        }
    }
    }}
    {{ statusBut(d.parentId)}}

    <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete">删除</a>
</script>

<script type="text/html" id="titleTpl">
    {{#
    var titleText= function(title,parentId){
        if(parentId!=null && parentId!='0' && parentId!=0){
            return "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+title;
        }else{
            return title;
        }
    }
    }}

    {{ titleText(d.title,d.parentId)}}
</script>

<script type="text/html" id="title2Tpl">
    {{#
    var titleText2= function(parentId){
    if(parentId!=null && parentId!='0' && parentId!=0){
    return "二级菜单";
    }else{
    return "一级菜单";;
    }
    }
    }}

    {{ titleText2(d.parentId)}}
</script>


<script src="${pageContext.request.contextPath }/layui/layui.js"></script>
<script>
    layui.use(['element', 'table'], function () {
        let element = layui.element,
            $ = layui.jquery,
            table = layui.table;


    /*    private Long menuId; //id
        private String title;//名称
        private String icon;//图标
        private String href;//路径
        private String perms;//权限
        private String spread;//true：展开，false：不展开
        private Long parentId;//父节点
        private Long sorting; //排序*/

        /*渲染数据*/
        let dt = table.render({
            elem: "#allUser",
            url: "${pageContext.request.contextPath}/menus/getMenusList",
            page: false,
            cols: [[
                {field: 'title', title: '菜单名称', align: 'left' , templet: '#titleTpl'},
                {title: '等级',  align: 'center', templet: '#title2Tpl'},
                {field: 'href', title: '路径', align: 'center'},
                {field: 'sorting', title: '排序', align: 'center'},
                {title: '操作', align: 'left', toolbar: "#tools"}
                ]]
        });

        table.on('tool(user)', function (obj) {
            let data = obj.data;
            let layEvent = obj.event;
            let tr = obj.tr;
            let currPage = dt.config.page.curr;


            if(layEvent==='edit'){
                $.post("${pageContext.request.contextPath}/menus/findMenusById", {menuId: data.menuId}, function (success) {
                    if (success.code == 0) {
                        layer.open({
                            title: '编辑菜单',
                            type: 1,
                            area: ['700px', '400px'],
                            content: '<blockquote class="layui-elem-quote layui-text">注意事项: 请填写相关的数据信息! </blockquote>' +
                                '<form class="layui-form"> ' +
                                '<div class="layui-form-item">' +
                                '<div class="layui-inline">' +
                                '<label class="layui-form-label">菜单名称</label>' +
                                '<div class="layui-input-inline">' +
                                '<input type="text" placeholder="请输入菜单名称" required lay-verify="required" name="title"  class="layui-input" value="'+data.title+'" >' +
                                '</div></div>' +
                                '</div>' +
                                '<div class="layui-form-item">' +
                                '<div class="layui-inline">' +
                                '<label class="layui-form-label">路径</label>' +
                                '<div class="layui-input-inline">' +
                                '<input type="text"  placeholder="请输入路径" required lay-verify="required" name="href"  class="layui-input" value="'+data.href+'" >' +
                                '</div></div>' +
                                '</div>' +
                                '<div class="layui-form-item" style="width: 621px;">' +
                                '<label class="layui-form-label">排序</label>' +
                                '<div class="layui-input-block">' +
                                '<input placeholder="请输入排序" name="sorting" class="layui-input" value="'+data.sorting+'"  />' +
                                '</div>' +
                                '</div>' +
                                '<input style="display: none;" name="parentId" class="layui-input" value="'+data.parentId+'"  />' +
                                '<input style="display: none;" name="menuId" class="layui-input" value="'+data.menuId+'"  />' +

                                '</form>',
                            btnAlign: 'c',
                            btn: ['确定', '取消'],
                            yes: function (index, layero) {

                                if ($("input[name=title]").val() == null || $("input[name=title]").val() == "") {
                                    layer.msg('请输入菜单名称', {icon: 5, time: 2000, area: '200px', type: 0, anim: 6,}, function () {
                                        $("input[name=title]").focus();
                                    });
                                    return false;
                                }
                                if ($("input[name=href]").val() == null || $("input[name=href]").val() == "") {
                                    layer.msg('请输入路径', {icon: 5, time: 2000, area: '200px', type: 0, anim: 6,}, function () {
                                        $("input[name=href]").focus();
                                    });
                                    return false;
                                }

                                //数组
                                var formData = {
                                    title: $("input[name=title]").val(),
                                    href: $("input[name=href]").val(),
                                    sorting: $("input[name=sorting]").val(),
                                    parentId:$("input[name=parentId]").val(),
                                    menuId:$("input[name=menuId]").val(),
                                };
                                console.log(formData);
                                $.post('${pageContext.request.contextPath}/menus/editMenus', formData, function (data) {
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

            }
            if(layEvent==='add'){
                layer.open({
                    title: '添加子级菜单',
                    type: 1,
                    area: ['700px', '400px'],
                    content: '<blockquote class="layui-elem-quote layui-text">注意事项: 请填写相关的数据信息! </blockquote>' +
                        '<form class="layui-form"> ' +
                        '<div class="layui-form-item">' +
                        '<div class="layui-inline">' +
                        '<label class="layui-form-label">菜单名称</label>' +
                        '<div class="layui-input-inline">' +
                        '<input type="text" placeholder="请输入菜单名称" required lay-verify="required" name="title"  class="layui-input" value="" >' +
                        '</div></div>' +
                        '</div>' +
                        '<div class="layui-form-item">' +
                        '<div class="layui-inline">' +
                        '<label class="layui-form-label">路径</label>' +
                        '<div class="layui-input-inline">' +
                        '<input type="text"  placeholder="请输入路径" required lay-verify="required" name="href"  class="layui-input" value="" >' +
                        '</div></div>' +
                        '</div>' +
                        '<div class="layui-form-item" style="width: 621px;">' +
                        '<label class="layui-form-label">排序</label>' +
                        '<div class="layui-input-block">' +
                        '<input placeholder="请输入排序" name="sorting" class="layui-input"/>' +
                        '</div>' +
                        '</div>' +
                        '<input style="display: none;" name="parentId" class="layui-input" value="'+data.menuId+'" />' +
                        '</form>',
                    btnAlign: 'c',
                    btn: ['确定', '取消'],
                    yes: function (index, layero) {

                        if ($("input[name=title]").val() == null || $("input[name=title]").val() == "") {
                            layer.msg('请输入菜单名称', {icon: 5, time: 2000, area: '200px', type: 0, anim: 6,}, function () {
                                $("input[name=title]").focus();
                            });
                            return false;
                        }
                        if ($("input[name=href]").val() == null || $("input[name=href]").val() == "") {
                            layer.msg('请输入路径', {icon: 5, time: 2000, area: '200px', type: 0, anim: 6,}, function () {
                                $("input[name=href]").focus();
                            });
                            return false;
                        }

                        //数组
                        var formData = {
                            title: $("input[name=title]").val(),
                            href: $("input[name=href]").val(),
                            sorting: $("input[name=sorting]").val(),
                            parentId:$("input[name=parentId]").val(),
                        };
                        console.log(formData);
                        $.post('${pageContext.request.contextPath}/menus/addMenus', formData, function (data) {
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

            if (layEvent === 'delete') {
                layer.confirm('确认删除当前数据吗？', {icon: 5, shade: 0.1}, function (index) {
                    $.post("${pageContext.request.contextPath}/menus/menusDeleteById", {menuId: data.menuId}, function (success) {

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
            layer.open({
                title: '添加菜单',
                type: 1,
                area: ['700px', '400px'],
                content: '<blockquote class="layui-elem-quote layui-text">注意事项: 请填写相关的数据信息! </blockquote>' +
                    '<form class="layui-form"> ' +
                    '<div class="layui-form-item">' +
                    '<div class="layui-inline">' +
                    '<label class="layui-form-label">菜单名称</label>' +
                    '<div class="layui-input-inline">' +
                    '<input type="text" placeholder="请输入菜单名称" required lay-verify="required" name="title"  class="layui-input" value="" >' +
                    '</div></div>' +
                    '</div>' +
                    '<div class="layui-form-item">' +
                    '<div class="layui-inline">' +
                    '<label class="layui-form-label">路径</label>' +
                    '<div class="layui-input-inline">' +
                    '<input type="text"  placeholder="请输入路径" required lay-verify="required" name="href"  class="layui-input" value="" >' +
                    '</div></div>' +
                    '</div>' +
                    '<div class="layui-form-item" style="width: 621px;">' +
                    '<label class="layui-form-label">排序</label>' +
                    '<div class="layui-input-block">' +
                    '<input placeholder="请输入排序" name="sorting" class="layui-input"/>' +
                    '</div>' +
                    '</div>' +
                    '</form>',
                btnAlign: 'c',
                btn: ['确定', '取消'],
                yes: function (index, layero) {

                    if ($("input[name=title]").val() == null || $("input[name=title]").val() == "") {
                        layer.msg('请输入菜单名称', {icon: 5, time: 2000, area: '200px', type: 0, anim: 6,}, function () {
                            $("input[name=title]").focus();
                        });
                        return false;
                    }


                    //数组
                    var formData = {
                        title: $("input[name=title]").val(),
                        sorting: $("input[name=sorting]").val(),
                        parentId:0,
                    };
                    console.log(formData);
                    $.post('${pageContext.request.contextPath}/menus/addMenus', formData, function (data) {
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
        })


    });



</script>
</body>
</html>