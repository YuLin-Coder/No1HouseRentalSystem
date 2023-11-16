package com.house.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @author 386869957@qq.com
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class UserOrder {
    private int orderId;
    private int houseId;
    private int userId;
    private Date orderTime;
    private String orderUser;
    private String houseDesc;
    private String houseModel;
    private String houseArea;
    private String houseFloor;
    private String houseType;
    private int type ;
    private int status ;
    private int housePrice;
    private String houseAddress;
    private String houseImage;
    private String communityName;
    private String houseLinkMan;
    private String houseOriented;


    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getHouseId() {
        return houseId;
    }

    public void setHouseId(int houseId) {
        this.houseId = houseId;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public String getOrderUser() {
        return orderUser;
    }

    public void setOrderUser(String orderUser) {
        this.orderUser = orderUser;
    }

    public String getHouseDesc() {
        return houseDesc;
    }

    public void setHouseDesc(String houseDesc) {
        this.houseDesc = houseDesc;
    }

    public String getHouseModel() {
        return houseModel;
    }

    public void setHouseModel(String houseModel) {
        this.houseModel = houseModel;
    }

    public String getHouseArea() {
        return houseArea;
    }

    public void setHouseArea(String houseArea) {
        this.houseArea = houseArea;
    }

    public String getHouseFloor() {
        return houseFloor;
    }

    public void setHouseFloor(String houseFloor) {
        this.houseFloor = houseFloor;
    }

    public String getHouseType() {
        return houseType;
    }

    public void setHouseType(String houseType) {
        this.houseType = houseType;
    }

    public int getHousePrice() {
        return housePrice;
    }

    public void setHousePrice(int housePrice) {
        this.housePrice = housePrice;
    }

    public String getHouseAddress() {
        return houseAddress;
    }

    public void setHouseAddress(String houseAddress) {
        this.houseAddress = houseAddress;
    }

    public String getHouseImage() {
        return houseImage;
    }

    public void setHouseImage(String houseImage) {
        this.houseImage = houseImage;
    }

    public String getCommunityName() {
        return communityName;
    }

    public void setCommunityName(String communityName) {
        this.communityName = communityName;
    }

    public String getHouseLinkMan() {
        return houseLinkMan;
    }

    public void setHouseLinkMan(String houseLinkMan) {
        this.houseLinkMan = houseLinkMan;
    }

    public String getHouseOriented() {
        return houseOriented;
    }

    public void setHouseOriented(String houseOriented) {
        this.houseOriented = houseOriented;
    }
}
