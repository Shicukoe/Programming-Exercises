package com.laptrinhjavaweb.dao;

import java.util.List;

import com.laptrinhjavaweb.model.Order;
import com.laptrinhjavaweb.model.OrderDetail;

public interface iOrderDAO extends GenericDAO<Order> {
    Order getOrderById(int id);
    List<Order> getAllOrders();
    void createOrder(Order order);
    void updateOrderStatus(int orderId, String status);
    List<Order> getOrdersByCustomer(String customerName);
    // New methods
    List<OrderDetail> findOrderItems(int orderId);
    void deleteOrderWithItems(int orderId);
    // New: filter by status, date range, customer name
    List<Order> filterOrders(String status, java.sql.Timestamp startDate, java.sql.Timestamp endDate, String customerName);
}
