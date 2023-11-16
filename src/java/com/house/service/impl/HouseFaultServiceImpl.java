package com.house.service.impl;

import com.house.dao.HouseEquipmentMapper;
import com.house.dao.HouseFaultMapper;
import com.house.entity.HouseEquipment;
import com.house.entity.HouseFault;
import com.house.service.IHouseEquipmentService;
import com.house.service.IHouseFaultService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class HouseFaultServiceImpl implements IHouseFaultService {
   @Autowired
   private HouseFaultMapper houseFaultMapper;

    @Override
    public int insert(HouseFault houseFault) {
        return houseFaultMapper.insert(houseFault);
    }

    @Override
    public int update(HouseFault houseFault) {
        return houseFaultMapper.update(houseFault);
    }

    @Override
    public List<Map> selList(Integer page, Integer limit) {
        return houseFaultMapper.selList(page,limit);
    }

    @Override
    public int selListCount() {
        return houseFaultMapper.selListCount();
    }

    @Override
    public List<Map> selListByUserId(Integer page, Integer limit, Integer userId) {
        return houseFaultMapper.selListByUserId(page,limit,userId);
    }

    @Override
    public int selListCountByUserId(Integer userId) {
        return houseFaultMapper.selListCountByUserId(userId);
    }
}
