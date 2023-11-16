package com.house.dao;


import com.house.entity.Roles;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

public interface RolesMapper {


    int insert(Roles roles);
    int update(Roles roles);

    //
    List<Map> selList(@Param("page") Integer page, @Param("limit") Integer limit);
    int selListCount();


    Map selById(@Param("roleId") Integer roleId);

    Roles selByName(@Param("roleName") String roleName);
    int rolesDeleteById(@Param("roleId") Integer roleId);
}