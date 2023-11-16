package com.house.service.impl;


import com.house.dao.OrderMapper;
import com.house.entity.Order;
import com.house.entity.Page;
import com.house.entity.UserOrder;

import com.house.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 386869957@qq.com
 */
@Service
public class OrderServiceImpl implements IOrderService {

	@Autowired
	private OrderMapper mapper;
	
	@Override
	public int addOrder(Order order) {
		return mapper.addOrder(order);
	}

	@Override
	public List<UserOrder> findAllOrder(Page page) {
		return mapper.findAllOrder(page);
	}

	@Override
	public int getOrderCount(int userId) {
		return mapper.getOrderCount(userId);
	}

	@Override
	public int deleteOrder(int orderId) {
		return mapper.deleteOrder(orderId);
	}

    @Override
    public List<UserOrder> findAllOrder2(Page page) {
        return mapper.findAllOrder2(page);
    }

    @Override
    public int getOrderCount2() {
        return mapper.getOrderCount2();
    }


    @Override
    public int editOrder(int orderId, int stauts) {
        return mapper.editOrder(orderId,stauts);
    }
}
