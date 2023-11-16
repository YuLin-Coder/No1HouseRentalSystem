package com.house.service.impl;

import com.house.dao.HouseEquipmentMapper;
import com.house.entity.HouseEquipment;
import com.house.service.IHouseEquipmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class HouseEquipmentServiceImpl implements IHouseEquipmentService {
   @Autowired
   private HouseEquipmentMapper houseEquipmentMapper;

    @Override
    public int insert(HouseEquipment houseEquipment) {
        return houseEquipmentMapper.insert(houseEquipment);
    }

    @Override
    public List<Map> selList(int id) {
        return houseEquipmentMapper.selList(id);
    }

    @Override
    public int deleteById(int id) {
        return houseEquipmentMapper.deleteById(id);
    }
}
