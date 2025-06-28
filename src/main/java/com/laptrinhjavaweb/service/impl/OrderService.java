package com.laptrinhjavaweb.service.impl;

import java.util.List;

import com.laptrinhjavaweb.dao.iOrderDAO;
import com.laptrinhjavaweb.dao.impl.OrderDAO;
import com.laptrinhjavaweb.model.Order;
import com.laptrinhjavaweb.model.OrderDetail;
import com.laptrinhjavaweb.service.iOrderService;

import jakarta.inject.Inject;

public class OrderService implements iOrderService {

    @Inject
    private iOrderDAO orderDAO;

    public OrderService() {
        orderDAO = new OrderDAO();
    }

    @Override
    public List<Order> getAllOrders() {
        return orderDAO.getAllOrders();
    }

    @Override
    public Order getOrderById(int id) {
        return orderDAO.getOrderById(id);
    }

    @Override
    public void createOrder(Order order) {
        orderDAO.createOrder(order);
    }

    @Override
    public void updateOrderStatus(int orderId, String status) {
        orderDAO.updateOrderStatus(orderId, status);
    }

    @Override
    public List<Order> getOrdersByCustomer(String customerName) {
        return orderDAO.getOrdersByCustomer(customerName);
    }

    @Override
    public List<OrderDetail> getOrderItems(int orderId) {
        return orderDAO.findOrderItems(orderId);
    }

    @Override
    public void deleteOrderWithItems(int orderId) {
        orderDAO.deleteOrderWithItems(orderId);
    }

    @Override
    public List<Order> filterOrders(String status, java.sql.Timestamp startDate, java.sql.Timestamp endDate, String customerName) {
        return orderDAO.filterOrders(status, startDate, endDate, customerName);
    }
}
