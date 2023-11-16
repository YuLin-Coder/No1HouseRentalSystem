package com.house.service.impl;

import com.house.dao.RolesMapper;
import com.house.dao.RolesMenusMapper;
import com.house.entity.Roles;
import com.house.entity.RolesMenus;
import com.house.service.IRolesMenusService;
import com.house.service.IRolesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class RolesMenusServiceImpl implements IRolesMenusService {
	
	@Autowired
	private RolesMenusMapper rolesMenusMapper;

    @Override
    public int insert(RolesMenus rolesMenus) {
        return rolesMenusMapper.insert(rolesMenus);
    }

    @Override
    public int deleteById(Long roleId) {
        return rolesMenusMapper.deleteById(roleId);
    }


    @Override
    public List<Map> getRolesMenusListByRoleId(Long roleId) {
        return rolesMenusMapper.getRolesMenusListByRoleId(roleId);
    }
}
