package com.house.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.UUID;

/**
 * 工具类
 *
 * @author 386869957@qq.com
 */
public class MyUtil {
	/**
	 * 映射本地路径
	 */
	public static String DIR_PATH = "C:\\work\\code\\YuLin-Coder\\No1HouseRentalSystem\\src\\resources\\upload\\hrs\\";

	/**
	 * 简介图片地址
	 * 注意：虚拟路径映射的关键位置
	 */
	public static String SIMPLE_PATH = "/hrs/";
	/**
	 * 返回当前日期的字符串表示
	 * YYYY-MM-DD
	 * @return 当前日期的字符串表示
	 */
	public static String getNowDate(){
		return new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	}
	
	public static Date getDateByString(String dateStr){
		Date date=null;
		try {
			date=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}
	
	/**
	 * 获取当前日期的Date格式化类型(yyyy-MM-dd)
	 * @return
	 */
	public static Date createDate(){
		String nowDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		Date date=null;
		try {
			date=new SimpleDateFormat("yyyy-MM-dd").parse(nowDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return date;
	}
	
	/**
	 * 得到yyyyMMddHHmmss
	 */
	public static String getNowDateStr(){
		return new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
	}
	/**
	 * 得到yyyyMMddHHmmss
	 */
	public static String getNowDateStr2(){
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
	}
	
	/**
	 * 得到一个字符串形式的格式化UUID
	 * @return
	 */
	public static String getStrUUID(){
		Random random = new Random();
		int end = random.nextInt(999);
		//如果不足三位前面补0
		String endStr =String.format("%03d", end);
		return UUID.randomUUID().toString().replace("-", "")+endStr;
	}
}
