package com.house.controller.house;

import com.house.entity.House;

import com.house.service.IHouseEquipmentService;
import com.house.service.IHouseService;
import com.house.util.MyUtil;
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
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 房屋详情控制类
 *
 * @author 386869957@qq.com
 */
@Controller
public class HouseDetailController {

    @Autowired
    private IHouseService service;
    @Autowired
    private IHouseEquipmentService houseEquipmentService;

    /**
     * 房源详情
     *
     * @param id      id
     * @param request req
     * @return view
     */
    @GetMapping("/detail.html")
    public String detail(int id, HttpServletRequest request) {
        House details = service.findHouseDetailsById(id);
        List<String> list = new ArrayList<String>();
        String[] split = details.getHouseDetailsImg().split(":-:");
        for (int i = 0; i < split.length; i++) {
            list.add(split[i]);
        }
        List<Map> mapList = houseEquipmentService.selList(id);
        String[] str= new String[14];
        if (mapList != null) {
            for (int j=0;j<mapList.size();j++) {
                str[Integer.valueOf(mapList.get(j).get("type").toString())-1]=mapList.get(j).get("type").toString();
            }
        }
        //houseFaultList
        request.getSession().setAttribute("Details", details);
        request.getSession().setAttribute("DetailsImg", list);
        request.getSession().setAttribute("houseEquipmentList", str);
        return "/user/houseDetails.jsp";
    }


    /**
     * 管理端模板下载
     *
     * @param request
     * @param response
     */
    @RequestMapping("/hrs/{img}")
    @ResponseBody
    public void downLoadFileExcel(@PathVariable("img") String img, HttpServletRequest request, HttpServletResponse response) {
        try {
            String separator= File.separator;
            String dirPath = MyUtil.DIR_PATH;


            String requestUrl = request.getRequestURL().toString();
            img=requestUrl.split("/")[requestUrl.split("/").length-1];

            String filePath=dirPath+separator+img;


            exportExcel(request,response,filePath,img);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
     * Excel 文件导出流
     *
     * @param request
     * @param response
     * @param filePath
     * @param fileName
     */
    public static void exportExcel(HttpServletRequest request, HttpServletResponse response, String filePath, String fileName) {
        if (filePath.contains("..")) {
            throw new RuntimeException("路径不安全!");
        }
        FileInputStream inputStream = null;
        ServletOutputStream outputStream = null;
        try {
            String projectUrl = request.getContextPath();
            response.setContentType("multipart/form-data");
            String regex = "[`~!@#$%^&*()\\+\\=\\{}|:\"?><\\/r\\/n]";
            Pattern pa = Pattern.compile(regex);
            Matcher ma = pa.matcher(fileName);
            if (ma.find()) {
                fileName = ma.replaceAll("");
            }
            response.setHeader("content-Disposition", "atachment;fileName=" + URLEncoder.encode(fileName , "UTF-8"));
            File file = new File(filePath);
            inputStream = new FileInputStream(file);
            outputStream = response.getOutputStream();
            byte[] b = new byte[100];
            int len;
            try {
                while ((len = inputStream.read(b)) > 0)
                    outputStream.write(b, 0, len);
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (outputStream != null) {
                try {
                    outputStream.flush();
                    outputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
