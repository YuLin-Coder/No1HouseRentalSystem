package com.house.dao;


import com.house.entity.HouseEquipment;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface HouseEquipmentMapper {
    int insert(HouseEquipment houseEquipment);
    List<Map> selList(@Param("houseId") int houseId);
    int deleteById(@Param("houseId") int houseId);
}