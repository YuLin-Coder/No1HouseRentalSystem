package com.house.dao;



import com.house.entity.Order;
import com.house.entity.Page;
import com.house.entity.UserOrder;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author 386869957@qq.com
 */
public interface OrderMapper {
    /**
     * 添加房屋收藏订单
     *
     * @param order order
     * @return int
     */
    int addOrder(Order order);

    /**
     * 查询所有收藏信息
     *
     * @param page 分页
     * @return List
     */
    List<UserOrder> findAllOrder(Page page);

    /**
     * 查询所有订单数
     *
     * @param userId id
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

    List<UserOrder> findAllOrder2(Page page);
    int getOrderCount2();

    int editOrder(@Param("orderId") int orderId, @Param("status") int status);

}
