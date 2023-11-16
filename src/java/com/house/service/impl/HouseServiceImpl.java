package com.house.service.impl;


import com.house.dao.HouseMapper;
import com.house.entity.House;
import com.house.entity.Page;
import com.house.service.IHouseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author 386869957@qq.com
 */
@Service
public class HouseServiceImpl implements IHouseService {

    @Autowired
    private HouseMapper dao;

    @Override
    public List<House> findHomeInfo() {
        return dao.findHomeInfo();
    }

    @Override
    public House findHouseDetailsById(int id) {
        return dao.findHouseDetailsById(id);
    }

    @Override
    public int addNewHouse(House house) {
        return dao.addNewHouse(house);
    }

    @Override
    public List<House> findHouseByUser(Page page) {
        return dao.findHouseByUser(page);
    }

    @Override
    public int deleteUserHouse(int houseId) {
        return dao.deleteUserHouse(houseId);
    }

    @Override
    public int updateHouse(House house) {
        return dao.updateHouse(house);
    }

    @Override
    public List<House> findHouseByLike(String keywords) {
        return dao.findHouseByLike(keywords);
    }

    @Override
    public List<House> findHouseOrderByAsc(String keywords) {
        return dao.findHouseOrderByAsc(keywords);
    }

    @Override
    public List<House> findHouseOrderByDesc(String keywords) {
        return dao.findHouseOrderByDesc(keywords);
    }

    @Override
    public Map findHouseByName(String strName) {
        return dao.findHouseByName(strName);
    }
}
