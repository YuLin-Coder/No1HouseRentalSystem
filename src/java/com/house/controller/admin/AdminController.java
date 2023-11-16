package com.house.controller.admin;


import com.house.dto.ResultUtil;
import com.house.dto.UserData;
import com.house.dto.UserHouseData;
import com.house.entity.*;

import com.house.service.IAdminService;
import com.house.service.ILogService;
import com.house.util.MyUtil;
import com.house.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * 管理员控制器
 *
 * @author 386869957@qq.com
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private IAdminService service;
    @Autowired
    private ILogService logService;

    /**
     * 登录请求
     *
     * @param userName     用户名
     * @param userPassword 密码
     * @param
     * @return res
     */
    @PostMapping("/adminAccess")
    @ResponseBody
    public String adminAccess(String userName, String userPassword, HttpServletRequest request) {
        Admin admin = new Admin();
        admin.setId(0);
        admin.setUserName(userName);
        admin.setUserPassword(userPassword);
        Admin adminAccess = service.adminAccess(admin);
        request.getSession().setAttribute("Admin", adminAccess);
        request.getSession().setAttribute("loginUser", null);

        //添加日志
        Log log=new Log();
        log.setUsername(userName);
        log.setCreateTime(MyUtil.getNowDateStr2());
        String ip= WebUtils.getRemoteAddr(request);
        log.setIp(ip);
        log.setOperation("登录后台");
        log.setMethod(request.getRequestURI());
        logService.insLog(log);

        if (adminAccess != null) {
            return "OK";
        }


        return "FAIL";
    }

    /**
     * 查询所有用户
     *
     * @return res
     */
    @GetMapping("/allUser")
    @ResponseBody
    public UserData findAllUser() {
        List<User> findAllUser = service.findAllUser();
        UserData userData = new UserData();
        userData.setCode(0);
        userData.setCount(findAllUser.size());
        userData.setData(findAllUser);
        userData.setMsg("OK");
        return userData;
    }

    /**
     * 更新用户信息
     *
     * @param user user
     * @return res
     */
    @PostMapping("/editUser")
    @ResponseBody
    public String editUser(User user) {
        int n = service.updateUser(user);
        if (n > 0) {
            return "OK";
        }
        return "FAIL";
    }

    /**
     * 查询所有房源
     *
     * @param page  page
     * @param limit limit
     * @return res
     */
    @RequestMapping("/houseList")
    @ResponseBody
    public UserHouseData findAllHouse(int page, int limit) {
        Page p = new Page();
        p.setLimit(limit);
        p.setPage((page - 1) * limit);
        List<House> findAllHouse = service.findAllHouse(p);
        UserHouseData data = new UserHouseData();
        data.setCode(0);
        data.setCount(findAllHouse.size());
        data.setData(findAllHouse);
        data.setMsg("OK");
        return data;
    }

    /**
     * 删除房源
     *
     * @param houseId 房源id
     * @return res
     */
    @RequestMapping("/deleteHouse")
    @ResponseBody
    public String deleteHouse(int houseId) {
        int deleteHouse = service.deleteHouse(houseId);
        if (deleteHouse > 0) {
            return "OK";
        }
        return "FAIL";
    }

    /**
     * 管理员删除用户
     */
    @PostMapping("/deleteUser")
    @ResponseBody
    public String deleteUser(Integer userId) {
        int n = service.deleteUser(userId);
        if (n > 0) {
            return "OK";
        }
        return "FAIL";
    }

    /**
     * 修改管理员登录密码
     *
     * @param request     req
     * @param oldPwd      旧密码
     * @param newPwd      新密码
     * @param confirmPwd 确认密码
     * @return res
     */
    @PostMapping("/changePassword")
    @ResponseBody
    public String changePassword(HttpServletRequest request, String oldPwd, String newPwd, String confirmPwd) {
        Admin checkAdmin = new Admin();
        Admin adminSession = (Admin) request.getSession().getAttribute("Admin");
        checkAdmin.setId(adminSession.getId());
        checkAdmin.setUserPassword(oldPwd);
        // 拿到当前登录的账户密码
        Admin checkAdminPwd = service.checkAdminPwd(checkAdmin);
        if (checkAdminPwd == null) {
            return "ERROR";
        }
        if (!newPwd.equals(confirmPwd)) {
            return "FAIL";
        }
        Admin admin = new Admin();
        admin.setId(adminSession.getId());
        admin.setUserPassword(newPwd);
        int n = service.changePassword(admin);
        if (n > 0) {
            return "OK";
        }
        return "FAIL";
    }



    @RequestMapping("findRoleAll")
    @ResponseBody
    public ResultUtil findRoleAll() {
        List<Map> map=   service.findRoleAll();
        return ResultUtil.ok(map);
    }


    @RequestMapping("addAdmin")
    @ResponseBody
    public ResultUtil addAdmin( String username,String userpwd, Long roleId) {
        service.addAdmin(username,userpwd,roleId);
        return ResultUtil.ok("插入成功!");
    }

    @RequestMapping("adminDeleteById")
    @ResponseBody
    public String adminDeleteById(Long id) {
        service.adminDeleteById(id);
        return "OK";
    }
    @RequestMapping("editAdmin")
    @ResponseBody
    public ResultUtil editAdmin(Admin admin) {
        service.editAdmin(admin);
        return ResultUtil.ok("修改成功!");
    }

    @RequestMapping("adminList.html")
    public String adminList() {
        return "system/adminList.jsp";
    }
    @RequestMapping("getAdminList")
    @ResponseBody
    public ResultUtil getRolesList(Integer page, Integer limit) {
        ResultUtil resultUtil = new ResultUtil();
        resultUtil.setCode(0);
        resultUtil.setCount(Long.valueOf(service.selListCount()));
        resultUtil.setData(service.selList((page - 1) * limit, limit));
        resultUtil.setMsg("查询成功");
        return resultUtil;
    }

    @RequestMapping("editAdminPwd")
    @ResponseBody
    public ResultUtil editAdminPwd(Long id,String userpwd ) {
        service.editAdminPwd(id,userpwd);
        return ResultUtil.ok("修改成功!");
    }




}
