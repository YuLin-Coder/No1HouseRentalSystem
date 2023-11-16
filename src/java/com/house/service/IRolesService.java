package com.house.service;

import com.house.entity.Menus;
import com.house.entity.Roles;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface IRolesService {

    int insert(Roles roles);
    int update(Roles roles);

    //
    List<Map> selList(@Param("page") Integer page, @Param("limit") Integer limit);
    int selListCount();

    int rolesDeleteById(@Param("roleId") Integer roleId);

    Map selById(@Param("roleId") Integer roleId);
    Roles selByName(@Param("roleName") String roleName);

}
