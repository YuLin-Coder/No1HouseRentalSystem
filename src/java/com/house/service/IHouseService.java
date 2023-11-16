package com.house.service;

import com.house.entity.House;
import com.house.entity.Page;

import java.util.List;
import java.util.Map;

/**
 * @author 386869957@qq.com
 */
public interface IHouseService {
    /**
     * 首页信息展示
     *
     * @return house list
     */
    List<House> findHomeInfo();

    /**
     * 通过id查询房屋详情
     *
     * @param houseId houseId
     * @return house
     */
    House findHouseDetailsById(int houseId);

    /**
     * 添加房源信息
     *
     * @param house house
     * @return int
     */
    int addNewHouse(House house);

    /**
     * 查询用户发布的房源信息
     *
     * @param page 分页
     * @return house list
     */
    List<House> findHouseByUser(Page page);

    /**
     * 删除用户发布的房源信息
     *
     * @param houseId houseId
     * @return ibt
     */
    int deleteUserHouse(int houseId);

    /**
     * 修改用户发布的房源信息
     *
     * @param house house
     * @return int
     */
    int updateHouse(House house);

    /**
     * 条件查询
     *
     * @param keywords 关键字
     * @return house list
     */
    List<House> findHouseByLike(String keywords);

    /**
     * 降序查询
     *
     * @return house list
     */
    List<House> findHouseOrderByDesc(String keywords);

    /**
     * 升序序查询
     *
     * @return house list
     */
    List<House> findHouseOrderByAsc(String keywords);


    Map findHouseByName(String strName);
}
