package com.house.dao;



import com.house.entity.HouseFault;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface HouseFaultMapper {


    int insert(HouseFault houseFault);
    int update(HouseFault houseFault);

    List<Map> selList(@Param("page") Integer page, @Param("limit") Integer limit);
    int selListCount();

    List<Map> selListByUserId(@Param("page") Integer page, @Param("limit") Integer limit ,@Param("userId")Integer userId);
    int selListCountByUserId(@Param("userId") Integer userId);

}