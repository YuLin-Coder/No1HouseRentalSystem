package com.house.service;

import com.house.entity.Roles;
import com.house.entity.RolesMenus;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface IRolesMenusService {

    int insert(RolesMenus rolesMenus);
    int deleteById(@Param("roleId") Long roleId);
    List<Map> getRolesMenusListByRoleId(@Param("roleId") Long roleId);
}

