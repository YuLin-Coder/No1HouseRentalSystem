package com.house.entity;

import java.io.Serializable;

public class RolesMenus implements Serializable {
	private Long menuId;

    private Long roleId;

    public Long getMenuId() {
        return menuId;
    }

    public void setMenuId(Long menuId) {
        this.menuId = menuId;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    private static final long serialVersionUID = 1L;

}