package com.house.dao;

import com.house.entity.Log;
import com.house.entity.Menus;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface MenusMapper {


    int insert(Menus menus);
    int update(Menus menus);


    List<Map> selList();

    Map selById(@Param("menuId") Integer menuId);
    int menusDeleteById(@Param("menuId") Integer menuId);

}