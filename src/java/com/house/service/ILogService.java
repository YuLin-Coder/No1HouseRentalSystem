package com.house.service;

import com.house.entity.Log;


import java.util.Date;
import java.util.List;

public interface ILogService {
	//添加日志
	public void insLog(Log log);
	
	//获取日志列表
	List<Log> selLogList(Integer page, Integer limit);
	int selLogListCount();

}
