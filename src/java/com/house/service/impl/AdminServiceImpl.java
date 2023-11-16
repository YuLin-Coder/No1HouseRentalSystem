package com.house.service.impl;


import com.house.dao.AdminMapper;
import com.house.entity.Admin;
import com.house.entity.House;
import com.house.entity.Page;
import com.house.entity.User;
import com.house.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.Map;

/**
 * @author 386869957@qq.com
 */
@Service
public class AdminServiceImpl implements IAdminService {

    @Autowired
    private AdminMapper service;


    @Override
    public Admin adminAccess(Admin admin) {
        return service.adminAccess(admin);
    }

    @Override
    public List<User> findAllUser() {
        return service.findAllUser();
    }

    @Override
    public List<House> findAllHouse(Page page) {
        return service.findAllHouse(page);
    }

    @Override
    public int deleteHouse(int houseId) {
        return service.deleteHouse(houseId);
    }

    @Override
    public User findUserById(int userId) {
        return service.findUserById(userId);
    }

    @Override
    public int deleteUser(int userId) {
        return service.deleteUser(userId);
    }

    @Override
    public int changePassword(Admin admin) {
        return service.updateAdminPwd(admin);
    }

    @Override
    public Admin checkAdminPwd(Admin admin) {
        return service.checkAdminPwd(admin);
    }

    @Override
    public int updateUser(User user) {
        return service.updateUser(user);
    }

    @Override
    public List<Map> findRoleAll() {
        return service.findRoleAll();
    }

    @Override
    public int addAdmin(String username, String userpwd,Long roleId) {
        return service.addAdmin(username,userpwd,roleId);
    }

    @Override
    public int adminDeleteById(Long id) {
        return service.adminDeleteById(id);
    }

    @Override
    public int editAdmin(Admin admin) {
        return service.editAdmin(admin);
    }

    @Override
    public List<Map> selList(Integer page, Integer limit) {
        return service.selList(page,limit);
    }

    @Override
    public int selListCount() {
        return service.selListCount();
    }

    @Override
    public int editAdminPwd(Long id, String userpwd) {
        return service.editAdminPwd(id,userpwd);
    }

    @Override
    public List<Map> getMyMenuListByRoleId(Long id) {
        return service.getMyMenuListByRoleId(id);
    }
}
