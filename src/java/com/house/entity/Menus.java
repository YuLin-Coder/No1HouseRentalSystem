package com.house.entity;

public class Menus {
    private Long menuId; //id
    private String title;//名称
    private String icon;//图标
    private String href;//路径
    private String perms;//权限
    private String spread;//true：展开，false：不展开
    private Long parentId;//父节点
    private Long sorting; //排序
    private String checked;
    private Boolean isOpen=false;


    
    public String getChecked() {
		return checked;
	}

	public void setChecked(String checked) {
		this.checked = checked;
	}

	public Long getMenuId() {
        return menuId;
    }

    public void setMenuId(Long menuId) {
        this.menuId = menuId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon == null ? null : icon.trim();
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href == null ? null : href.trim();
    }

    public String getPerms() {
        return perms;
    }

    public void setPerms(String perms) {
        this.perms = perms == null ? null : perms.trim();
    }

    public String getSpread() {
        return spread;
    }

    public void setSpread(String spread) {
        this.spread = spread == null ? null : spread.trim();
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public Long getSorting() {
        return sorting;
    }

    public void setSorting(Long sorting) {
        this.sorting = sorting;
    }

	public Boolean getIsOpen() {
		return isOpen;
	}

	public void setIsOpen(Boolean isOpen) {
		this.isOpen = isOpen;
	}
    
}