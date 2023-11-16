package com.house.controller.house;

import com.house.dto.ResultUtil;
import com.house.entity.*;
import com.house.service.IHouseEquipmentService;
import com.house.service.IHouseFaultService;
import com.house.service.IHouseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 *
 * @author 386869957@qq.com
 */
@Controller
@RequestMapping("/houseFault")
public class HouseFaultController {

    @Autowired
    private IHouseFaultService houseFaultService;

    @RequestMapping("houseFaultAllList.html")
    public String houseFaultAllList() {
        return "admin/houseFaultAllList.jsp";
    }

    @RequestMapping("houseFaultListByUserId.html")
    public String houseFaultListByUserId() {
        return "user/houseFaultListByUserId.jsp";
    }

    @RequestMapping("getHouseFaultAllList")
    @ResponseBody
    public ResultUtil getHouseFaultAllList(Integer page, Integer limit) {
        ResultUtil resultUtil = new ResultUtil();
        resultUtil.setCode(0);
        resultUtil.setCount(Long.valueOf(houseFaultService.selListCount()));
        resultUtil.setData(houseFaultService.selList((page - 1) * limit, limit));
        resultUtil.setMsg("查询成功");
        return resultUtil;
    }

    @RequestMapping("getHouseFaultListByUserId")
    @ResponseBody
    public ResultUtil getHouseFaultListByUserId(Integer page, Integer limit,HttpServletRequest request) {
       User user=(User) request.getSession().getAttribute("loginUser");

        ResultUtil resultUtil = new ResultUtil();
        resultUtil.setCode(0);
        resultUtil.setCount(Long.valueOf(houseFaultService.selListCountByUserId(user.getUserId())));
        resultUtil.setData(houseFaultService.selListByUserId((page - 1) * limit, limit,user.getUserId()));
        resultUtil.setMsg("查询成功");
        return resultUtil;
    }

    @RequestMapping("editHouseFault")
    @ResponseBody
    public String editHouseFault(Long id) {

        HouseFault houseFault=new HouseFault();
        houseFault.setId(id);
        houseFault.setStatus(2);
        houseFaultService.update(houseFault);
        return "OK";
    }


    @RequestMapping("addHouseFault")
    @ResponseBody
    public ResultUtil addHouseFault(HouseFault houseFault) {
        houseFault.setStatus(1);
        houseFault.setCreateTime(new Date());
        houseFaultService.insert(houseFault);
        return ResultUtil.ok("添加成功");
    }


}
