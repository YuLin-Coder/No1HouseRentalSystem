package com.house.controller.log;


import com.house.dto.ResultUtil;
import com.house.service.ILogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("log/")
public class LogController {

    @Autowired
    private ILogService logService;

    @RequestMapping("logList.html")
    public String logList() {
        return "log/logList.jsp";
    }

    @RequestMapping("getLogList")
    @ResponseBody
    public ResultUtil getLogList(Integer page, Integer limit) {
        ResultUtil resultUtil = new ResultUtil();
        resultUtil.setCode(0);
        resultUtil.setCount(Long.valueOf(logService.selLogListCount()));
        resultUtil.setData(logService.selLogList((page - 1) * limit, limit));
        resultUtil.setMsg("查询成功");

        return resultUtil;
    }
}
