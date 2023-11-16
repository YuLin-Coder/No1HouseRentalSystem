package com.house.dao;


import com.house.dto.LogData;
import com.house.entity.Log;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LogMapper {


    int insert(Log record);

    //获取日志列表
    List<Log> selLogList(@Param("page") Integer page,@Param("limit") Integer limit);
    int selLogListCount();
}