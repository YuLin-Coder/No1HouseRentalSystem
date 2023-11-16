package com.house.service.impl;

import com.house.dao.LogMapper;
import com.house.entity.Log;
import com.house.service.ILogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LogServiceImpl implements ILogService {
	
	@Autowired
	private LogMapper tbLogMapper;

	@Override
	public void insLog(Log log) {
		tbLogMapper.insert(log);
	}

	@Override
	public List<Log> selLogList(Integer page, Integer limit) {
       List<Log> logList=tbLogMapper.selLogList( page, limit);
		return logList;
	}

    @Override
    public int selLogListCount() {
        return tbLogMapper.selLogListCount();
    }
}
