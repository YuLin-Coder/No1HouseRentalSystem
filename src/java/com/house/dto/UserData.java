package com.house.dto;


import com.house.entity.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 用户数据传输对象
 * @author 386869957@qq.com
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class UserData {
	private int code;

	private String msg;

	private int count;

	private List<User> data;

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public List<User> getData() {
		return data;
	}

	public void setData(List<User> data) {
		this.data = data;
	}
}
