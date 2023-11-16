package com.house.controller.system;


import com.house.dto.ResultUtil;
import com.house.entity.Menus;
import com.house.service.IMenusService;
import com.house.service.IRolesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("menus/")
public class MenusController {

    @Autowired
    private IMenusService menusService;

    @RequestMapping("menusList.html")
    public String menusList() {
        return "system/menusList.jsp";
    }

    @RequestMapping("getMenusList")
    @ResponseBody
    public ResultUtil getMenusList() {
        ResultUtil resultUtil = new ResultUtil();
        resultUtil.setCode(0);
        resultUtil.setCount(0L);
        List<Map> menuList=menusService.selList();
        resultUtil.setData(getStoringMenus(menuList));
        resultUtil.setMsg("查询成功");
        return resultUtil;
    }

    @RequestMapping("addMenus")
    @ResponseBody
    public ResultUtil addMenus(Menus menus) {

        menusService.insert(menus);
        return ResultUtil.ok("插入成功");
    }

    @RequestMapping("findMenusById")
    @ResponseBody
    public ResultUtil findMenusById(Integer menuId) {
       Map map= menusService.selById(menuId);
        return ResultUtil.ok(map);
    }
    @RequestMapping("editMenus")
    @ResponseBody
    public ResultUtil editMenus(Menus menus) {
        menusService.update(menus);
        return ResultUtil.ok("修改成功");
    }

    @RequestMapping("menusDeleteById")
    @ResponseBody
    public String menusDeleteById(Integer menuId) {
        menusService.menusDeleteById(menuId);
        return "OK";
    }

    private LinkedHashSet<Map> getStoringMenus(List<Map> menuList){
        LinkedHashSet<Map> maps=new LinkedHashSet<>();
        if(menuList!=null&& menuList.size()>0){
            for(Map map:menuList){
                if(map.get("parentId")==null||"0".equals(map.get("parentId").toString())){
                    maps.add(map);
                    for(Map map1:menuList){
                        if(map1.get("parentId")!=null&& map1.get("parentId").toString().equals(map.get("menuId").toString())){
                            maps.add(map1);
                        }
                    }
                }
            }
        }
       return maps;

    }

}
