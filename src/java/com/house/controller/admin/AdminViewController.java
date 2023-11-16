package com.house.controller.admin;

import com.house.entity.Admin;
import com.house.entity.House;
import com.house.entity.User;
import com.house.service.IAdminService;
import com.house.service.IHouseEquipmentService;
import com.house.service.IHouseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;

/**
 * 管理员界面视图跳转
 *
 * @author 386869957@qq.com
 */
@Controller
@RequestMapping("/admin")
public class AdminViewController {

    @Autowired
    private IAdminService service;

    @Autowired
    private IHouseService dao;
    @Autowired
    private IHouseEquipmentService houseEquipmentService;
    /**
     * 登录页
     *
     * @return view
     */
    @GetMapping({"/", "/index.html"})
    public String toAdminLogin() {
        return "/admin/login.jsp";
    }

    /**
     * 注销登录
     *
     * @param request req
     * @return view
     */
    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/index.html";
    }

    /**
     * 管理员首页
     *
     * @return view
     */
    @GetMapping("/home.html")
    public String toAdminHomePage( HttpServletRequest request) {
        //查询登录菜单
      Admin admin=(Admin)  request.getSession().getAttribute("Admin");

       List<Map> menuList= service.getMyMenuListByRoleId(Long.valueOf(admin.getRoleId()));
        request.setAttribute("menuList",getStoringMenus(menuList));
        return "/admin/home.jsp";
    }

    /**
     * 修改密码页
     *
     * @return view
     */
    @GetMapping("/changePassword.html")
    public String changePasswordPage() {
        return "/admin/changePassword.jsp";
    }

    /**
     * 查询所有用户页
     *
     * @return view
     */
    @GetMapping("/allUser.html")
    public String toAllUserPage() {
        return "/admin/allUser.jsp";
    }

    /**
     * 所有房源数据页
     *
     * @return view
     */
    @GetMapping("/houseList.html")
    public String toAllHousePage() {
        return "/admin/houseList.jsp";
    }

    /**
     * 传入id,跳转到修改用户界面
     *
     * @return view
     */
    @GetMapping("/editUser.html")
    public String toEditUserPage(int userId, HttpServletRequest req) {
        User findUserById = service.findUserById(userId);
        req.getSession().setAttribute("User", findUserById);
        return "/admin/editUser.jsp";
    }

    /**
     * 跳转到管理员更新房源界面
     *
     * @param houseId 房源ID
     * @param request req
     * @return view
     */
    @RequestMapping("/updateHouse.html")
    public String toUpdatePage(int houseId, HttpServletRequest request) {
        House house = dao.findHouseDetailsById(houseId);
        List<Map> mapList = houseEquipmentService.selList(houseId);
        String[] str= new String[14];
        if (mapList != null) {
            for (int j=0;j<mapList.size();j++) {
                str[Integer.valueOf(mapList.get(j).get("type").toString())-1]=mapList.get(j).get("type").toString();
            }
        }
        request.getSession().setAttribute("House", house);
        request.getSession().setAttribute("houseEquipmentList", str);
        return "/admin/updateHouse.jsp";
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
