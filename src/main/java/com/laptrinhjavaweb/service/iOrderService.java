package com.laptrinhjavaweb.service;

import java.util.List;

import com.laptrinhjavaweb.model.Order;
import com.laptrinhjavaweb.model.OrderDetail;

public interface iOrderService {
    List<Order> getAllOrders();
    Order getOrderById(int id);
    void createOrder(Order order);
    void updateOrderStatus(int orderId, String status);
    List<Order> getOrdersByCustomer(String customerName);
    List<OrderDetail> getOrderItems(int orderId);
    void deleteOrderWithItems(int orderId);
}
