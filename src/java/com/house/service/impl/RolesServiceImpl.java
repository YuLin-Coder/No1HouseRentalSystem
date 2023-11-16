package com.house.service.impl;

import com.house.dao.LogMapper;
import com.house.dao.RolesMapper;
import com.house.entity.Log;
import com.house.entity.Roles;
import com.house.service.ILogService;
import com.house.service.IRolesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class RolesServiceImpl implements IRolesService {
	
	@Autowired
	private RolesMapper rolesMapper;

    @Override
    public int insert(Roles roles) {
        return rolesMapper.insert(roles);
    }

    @Override
    public int update(Roles roles) {
        return rolesMapper.update(roles);
    }

    @Override
    public List<Map> selList(Integer page, Integer limit) {
        return rolesMapper.selList(page,limit);
    }

    @Override
    public int selListCount() {
        return rolesMapper.selListCount();
    }

    @Override
    public int rolesDeleteById(Integer roleId) {
        return rolesMapper.rolesDeleteById(roleId);
    }

    @Override
    public Map selById(Integer roleId) {
        return rolesMapper.selById(roleId);
    }

    @Override
    public Roles selByName(String roleName) {
        return rolesMapper.selByName(roleName);
    }
}
