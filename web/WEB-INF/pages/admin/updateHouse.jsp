<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>修改房源信息</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css">
</head>
<body>
<div class="wrapper" style="width: 45%;margin-top: 40px;float: left">
    <fieldset class="layui-elem-field layui-field-title">
        <legend style="font-size: 26px">修改我发布的房源信息</legend>
    </fieldset>
    <form id="updateHouse" class="layui-form">
        <div class="layui-form-item">
            <label class="layui-form-label">房源标题</label>
            <div class="layui-input-block">
                <input type="hidden" value="${House.houseId}" name="houseId">
                <textarea name="houseDesc" placeholder="请输入内容" class="layui-textarea" required
                          lay-verify="required">${House.houseDesc }</textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">房屋类型</label>
            <div class="layui-input-block">
                <input type="text" name="houseModel" required lay-verify="required" placeholder="几室几厅"
                       autocomplete="off" value="${House.houseModel }" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">房屋面积</label>
            <div class="layui-input-block">
                <input type="text" name="houseArea" required lay-verify="required" placeholder=""
                       autocomplete="off" value="${House.houseArea }" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">房屋楼层</label>
            <div class="layui-input-block">
                <input type="text" name="houseFloor" required lay-verify="required" placeholder="高层/低层/几楼"
                       autocomplete="off" value="${House.houseFloor }" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">出租方式</label>
            <div class="layui-input-block">
                <select name="houseType" lay-verify="required">
                    <option value=""></option>
                    <option value="整租"<c:if test="${House.houseType == '整租'}"> selected</c:if>>整租</option>
                    <option value="合租"<c:if test="${House.houseType == '合租'}"> selected</c:if>>合租</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">地&emsp;&emsp;址</label>
            <div class="layui-input-block">
                <input type="text" id="houseAddress" name="houseAddress"  required lay-verify="required"
                       class="layui-input "  placeholder="请输入地址" value="${House.houseAddress }">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">地址经度</label>
            <div class="layui-input-block">
                <input type="text" id="addressLat" name="addressLat" class="layui-input userName"
                       placeholder="请输入地址经度" value="${House.addressLat }" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">地址纬度</label>
            <div class="layui-input-block">
                <input type="text" id="addressLon" name="addressLon" class="layui-input userName"
                       placeholder="请输入地址纬度" value="${House.addressLon }" lay-verify="required">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">小区名字</label>
            <div class="layui-input-block">
                <input type="text" name="communityName" required lay-verify="required" placeholder=""
                       autocomplete="off" value="${House.communityName }" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">租房价格</label>
            <div class="layui-input-block">
                <input type="text" name="housePrice" required lay-verify="required|number" placeholder=""
                       autocomplete="off" value="${House.housePrice }" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">联系电话</label>
            <div class="layui-input-block">
                <input type="text" name="houseLinkMan" required lay-verify="required|phone" placeholder=""
                       autocomplete="off" value="${House.houseLinkMan }" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">房屋朝向</label>
            <div class="layui-input-block">
                <select name="houseOriented" lay-verify="required">
                    <option value=""></option>
                    <option value="南北"<c:if test="${House.houseOriented == '南北'}"> selected</c:if>>南北</option>
                    <option value="东西"<c:if test="${House.houseOriented == '东西'}"> selected</c:if>>东西</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">房屋配置</label>
            <div class="layui-input-block">
                <c:choose>

                    <c:when test="${houseEquipmentList[0]=='1'}">
                        <input type="checkbox" name="houseType1" title="床" value="1" checked>
                    </c:when>
                    <c:otherwise>
                        <input type="checkbox" name="houseType1" title="床" value="1" >
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${houseEquipmentList[1]=='2'}">
                        <input type="checkbox" name="houseType2" title="空调" value="2" checked>
                    </c:when>
                    <c:otherwise>
                        <input type="checkbox" name="houseType2" title="空调" value="2" >
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${houseEquipmentList[2]=='3'}">
                        <input type="checkbox" name="houseType3" title="衣柜" value="3" checked>
                    </c:when>
                    <c:otherwise>
                        <input type="checkbox" name="houseType3" title="衣柜" value="3" >
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${houseEquipmentList[3]=='4'}">
                        <input type="checkbox" name="houseType4" title="桌椅" value="4" checked>
                    </c:when>
                    <c:otherwise>
                        <input type="checkbox" name="houseType4" title="桌椅" value="4" >
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${houseEquipmentList[4]=='5'}">
                        <input type="checkbox" name="houseType5" title="洗衣机" value="5" checked>
                    </c:when>
                    <c:otherwise>
                        <input type="checkbox" name="houseType5" title="洗衣机" value="5" >
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${houseEquipmentList[5]=='6'}">
                        <input type="checkbox" name="houseType6" title="沙发" value="6" checked>
                    </c:when>
                    <c:otherwise>
                        <input type="checkbox" name="houseType6" title="沙发" value="6" >
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${houseEquipmentList[6]=='7'}">
                        <input type="checkbox" name="houseType7" title="消毒柜" value="7" checked>
                    </c:when>
                    <c:otherwise>
                        <input type="checkbox" name="houseType7" title="消毒柜" value="7" >
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${houseEquipmentList[7]=='8'}">
                        <input type="checkbox" name="houseType8" title="微波炉" value="8" checked>
                    </c:when>
                    <c:otherwise>
                        <input type="checkbox" name="houseType8" title="微波炉" value="8" >
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${houseEquipmentList[8]=='9'}">
                        <input type="checkbox" name="houseType9" title="抽油烟机" value="9" checked>
                    </c:when>
                    <c:otherwise>
                        <input type="checkbox" name="houseType9" title="抽油烟机" value="9" >
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${houseEquipmentList[9]=='10'}">
                        <input type="checkbox" name="houseType10" title="电视" value="10" checked>
                    </c:when>
                    <c:otherwise>
                        <input type="checkbox" name="houseType10" title="电视" value="10" >
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${houseEquipmentList[10]=='11'}">
                        <input type="checkbox" name="houseType11" title="天然气" value="11" checked>
                    </c:when>
                    <c:otherwise>
                        <input type="checkbox" name="houseType11" title="天然气" value="11" >
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${houseEquipmentList[11]=='12'}">
                        <input type="checkbox" name="houseType12" title="宽带" value="12" checked>
                    </c:when>
                    <c:otherwise>
                        <input type="checkbox" name="houseType12" title="宽带" value="12" >
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${houseEquipmentList[12]=='13'}">
                        <input type="checkbox" name="houseType13" title="热水器" value="13" checked >
                    </c:when>
                    <c:otherwise>
                        <input type="checkbox" name="houseType13" title="热水器" value="13" >
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${houseEquipmentList[13]=='14'}">
                        <input type="checkbox" name="houseType14" title="冰箱" value="14"  checked>
                    </c:when>
                    <c:otherwise>
                        <input type="checkbox" name="houseType14" title="冰箱" value="14" >
                    </c:otherwise>
                </c:choose>

            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="updateHouse" id="updateHouse-btn">立即修改</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>



<div style="width: 50%;float:right;">
    <div style="height: 500px;">
        <div id='container'style="height: 500px;"></div>
    </div>
    <div>
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
            <legend>帮助信息</legend>
        </fieldset>

        <div class="info">
            <div class="layui-form-item">
                <label class="layui-form-label">投放地查询</label>
                <div class="layui-input-block">
                    <input type="text"  id='tipinput' name="tipinput" class="layui-input userName"
                           placeholder="请输入关键字" value=""  lay-verify="required">
                </div>
            </div>
            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
                <legend >查询定位信息</legend>
            </fieldset>
            <div style=" margin-left: 18px;">
                <p id='pois'></p>
            </div>

            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
                <legend >本地定位信息</legend>
            </fieldset>
            <div style=" margin-left: 18px;">
                定位状态：<span id='status'></span>
                <p id='result'></p>
            </div>


        </div>
    </div>
</div>
<script type="text/javascript" src="https://webapi.amap.com/maps?v=1.4.11&key=3254c1bd950c279b4a05d66533af3bf0&plugin=AMap.Autocomplete,AMap.PlaceSearch"></script>
<script type="text/javascript" src="https://cache.amap.com/lbs/static/addToolbar.js"></script>



<script src="${pageContext.request.contextPath }/layui/layui.js"></script>
<script>

    var map = new AMap.Map('container', {
        resizeEnable: true
    });

    var auto = new AMap.Autocomplete({
        input: "tipinput"
    });
    var placeSearch = new AMap.PlaceSearch({
        map: map
    });  //构造地点查询类
    AMap.event.addListener(auto, "select", select);//注册监听，当选中某条记录时会触发
    function select(e) {
        console.log(e);
        placeSearch.setCity(e.poi.adcode);
        placeSearch.search(e.poi.name,function(status, result) {
            // 搜索成功时，result即是对应的匹配数据
            console.log(status);
            console.log(result);
            var pois=result.poiList.pois;
            var str = [];
            for(var i=0;i<pois.length;i++){
                str.push('定位地址：'+pois[i].pname+pois[i].cityname+pois[i].adname+pois[i].address+pois[i].name );
                var poStr=pois[i].location.toString();
                var po=poStr.split(",");
                str.push('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;经度：'+ po[0]);
                str.push('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;纬度：' + po[1]+"<br>" );

                if(i==0){
                    document.getElementById('houseAddress').value=pois[i].pname+pois[i].cityname+pois[i].adname+pois[i].address+pois[i].name;
                    document.getElementById('addressLat').value=po[0];
                    document.getElementById('addressLon').value=po[1];
                }
            }
            document.getElementById('pois').innerHTML = str.join('<br>');

        });  //关键字查询查询
    }


    AMap.plugin('AMap.Geolocation', function() {
        var geolocation = new AMap.Geolocation({
            enableHighAccuracy: true,//是否使用高精度定位，默认:true
            timeout: 10000,          //超过10秒后停止定位，默认：5s
            buttonPosition:'RB',    //定位按钮的停靠位置
            buttonOffset: new AMap.Pixel(10, 20),//定位按钮与设置的停靠位置的偏移量，默认：Pixel(10, 20)
            zoomToAccuracy: true,   //定位成功后是否自动调整地图视野到定位点

        });
        map.addControl(geolocation);
        geolocation.getCurrentPosition(function(status,result){
            if(status=='complete'){
                onComplete(result)
            }else{
                onError(result)
            }
        });
    });
    //解析定位结果
    function onComplete(data) {
        document.getElementById('status').innerHTML='定位成功'
        var str = [];
        var poStr=data.position.toString();
        var po=poStr.split(",");
        str.push('定位结果：' );
        str.push('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;经度：'+ po[0]);
        str.push('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;纬度：' + po[1] );

        str.push('定位类别：' + data.location_type);
        if(data.accuracy){
            str.push('精度：' + data.accuracy + ' 米');
        }//如为IP精确定位结果则没有精度信息
        str.push('是否经过偏移：' + (data.isConverted ? '是' : '否'));
        document.getElementById('result').innerHTML = str.join('<br>');
    }
    //解析定位错误信息
    function onError(data) {
        document.getElementById('status').innerHTML='定位失败'
        document.getElementById('result').innerHTML = '失败原因排查信息:'+data.message;
    }


    layui.use(['element', 'form', 'layer'], function () {
        let element = layui.element,
            form = layui.form,
            layer = layui.layer,
            $ = layui.jquery;

        form.on("submit(updateHouse)", function () {
            // HouseController
            $.post("${pageContext.request.contextPath}/house/updateHouse", $("#updateHouse").serialize(), function (res) {
                $("#updateHouse")[0].reset();
                if (res === "OK") {
                    layer.msg("修改成功！", {
                        time: 1000, end: function () {
                            window.history.back(-1);
                        }
                    });
                }
            });
            return false;
        })
    });
</script>
</body>
</html>
