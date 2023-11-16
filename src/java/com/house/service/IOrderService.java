package com.house.service;

import com.house.entity.Order;
import com.house.entity.Page;
import com.house.entity.UserOrder;

import java.util.List;

/**
 * @author 386869957@qq.com
 */
public interface IOrderService {
    /**
     * 添加订单信息
     *
     * @param order 房源收藏对象
     * @return int
     */
    int addOrder(Order order);

    /**
     * 查询所有订单信息
     *
     * @param page 分页
     * @return userOrder list
     */
    List<UserOrder> findAllOrder(Page page);
    List<UserOrder> findAllOrder2(Page page);
    int getOrderCount2();
    /**
     * 查询单个用户所有订单
     *
     * @param userId userId
     * @return int
     */
    int getOrderCount(int userId);

    /**
     * 删除用户订单
     *
     * @param orderId orderId
     * @return int
     */
    int deleteOrder(int orderId);
    int editOrder(int orderId,int stauts);
}
