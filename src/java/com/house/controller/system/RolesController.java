package com.house.controller.system;


import com.house.dto.ResultUtil;
import com.house.entity.Menus;
import com.house.entity.Roles;
import com.house.entity.RolesMenus;
import com.house.service.ILogService;
import com.house.service.IRolesMenusService;
import com.house.service.IRolesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("roles/")
public class RolesController {

    @Autowired
    private IRolesService rolesService;

    @Autowired
    private IRolesMenusService rolesMenusService;

    @RequestMapping("rolesList.html")
    public String rolesList() {
        return "system/rolesList.jsp";
    }

    @RequestMapping("getRolesList")
    @ResponseBody
    public ResultUtil getRolesList(Integer page, Integer limit) {
        ResultUtil resultUtil = new ResultUtil();
        resultUtil.setCode(0);
        resultUtil.setCount(Long.valueOf(rolesService.selListCount()));
        resultUtil.setData(rolesService.selList((page - 1) * limit, limit));
        resultUtil.setMsg("查询成功");
        return resultUtil;
    }

    @RequestMapping("rolesDeleteById")
    @ResponseBody
    public String rolesDeleteById(Integer roleId) {
        rolesService.rolesDeleteById(roleId);
        return "OK";
    }

    @RequestMapping("getRolesMenusListByRoleId")
    @ResponseBody
    public ResultUtil getRolesMenusListByRoleId(Long roleId) {
        List<Map> map= rolesMenusService.getRolesMenusListByRoleId(roleId);
        return ResultUtil.ok(map);
    }


    @RequestMapping("findRolesById")
    @ResponseBody
    public ResultUtil findRolesById(Integer roleId) {
        Map map= rolesService.selById(roleId);
        return ResultUtil.ok(map);
    }


    @RequestMapping("editRoles")
    @ResponseBody
    public ResultUtil editMenus(String roleId,String roleName,String roleRemark ,String roleMenus) {
        //添加角色
        Roles roles=new Roles();
        roles.setRoleName(roleName);
        roles.setRoleRemark(roleRemark);
        roles.setRoleId(Long.valueOf(roleId));
        rolesService.update(roles);
        rolesMenusService.deleteById(Long.valueOf(roleId));
        String[] roleMenu=roleMenus.split(",");
        for(int i=0;i<roleMenu.length;i++){
            RolesMenus rolesMenus=new RolesMenus();
            rolesMenus.setMenuId(Long.valueOf(roleMenu[i]));
            rolesMenus.setRoleId(Long.valueOf(roleId));
            rolesMenusService.insert(rolesMenus);
        }
        return ResultUtil.ok("修改成功");
    }
    @RequestMapping("addRoles")
    @ResponseBody
    public ResultUtil addRoles(String roleName,String roleRemark ,String roleMenus) {

        //添加角色
        Roles roles=new Roles();
        roles.setRoleName(roleName);
        roles.setRoleRemark(roleRemark);
        rolesService.insert(roles);
        Roles roles1=rolesService.selByName(roleName);
        rolesMenusService.deleteById(roles1.getRoleId());
        String[] roleMenu=roleMenus.split(",");
        for(int i=0;i<roleMenu.length;i++){
            RolesMenus rolesMenus=new RolesMenus();
            rolesMenus.setMenuId(Long.valueOf(roleMenu[i]));
            rolesMenus.setRoleId(roles1.getRoleId());
            rolesMenusService.insert(rolesMenus);
        }
        return ResultUtil.ok("添加成功");
    }


}
