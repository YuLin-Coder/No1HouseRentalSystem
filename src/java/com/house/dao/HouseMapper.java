package com.house.dao;



import com.house.entity.House;
import com.house.entity.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author 386869957@qq.com
 */
public interface HouseMapper {
    /**
     * 首页信息展示
     *
     * @return List
     */
    List<House> findHomeInfo();

    /**
     * 通过id查询房屋详情
     *
     * @param id id
     * @return House
     */
    House findHouseDetailsById(int id);

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
     * @param page page分页
     * @return List
     */
    List<House> findHouseByUser(Page page);

    /**
     * 删除用户发布的房源信息
     *
     * @param houseId id
     * @return int
     */
    int deleteUserHouse(int houseId);

    /**
     * 修改用户发布的房源信息
     *
     * @param house house对象
     * @return int
     */
    int updateHouse(House house);

    /**
     * 条件查询
     *
     * @param keywords 关键字
     * @return list
     */
    List<House> findHouseByLike(String keywords);

    /**
     * 降序查询
     *
     * @return list
     */
    List<House> findHouseOrderByDesc(String keywords);

    /**
     * 升序序查询
     *
     * @return list
     */
    List<House> findHouseOrderByAsc(String keywords);

    Map findHouseByName(@Param("strName") String strName);
}
