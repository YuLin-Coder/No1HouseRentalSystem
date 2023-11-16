package com.house.service.impl;

import com.house.dao.MenusMapper;
import com.house.dao.RolesMapper;
import com.house.entity.Menus;
import com.house.entity.Roles;
import com.house.service.IMenusService;
import com.house.service.IRolesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class MenusServiceImpl implements IMenusService {

    @Autowired
    private MenusMapper menusMapper;
    @Override
    public int insert(Menus menus) {
        return menusMapper.insert(menus);
    }

    @Override
    public int update(Menus menus) {
        return menusMapper.update(menus);
    }

    @Override
    public List<Map> selList() {
        return menusMapper.selList();
    }

    @Override
    public int menusDeleteById(Integer menuId) {
        return menusMapper.menusDeleteById(menuId);
    }


    @Override
    public Map selById(Integer menuId) {
        return menusMapper.selById(menuId);
    }
}
