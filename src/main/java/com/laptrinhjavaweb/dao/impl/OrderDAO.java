package com.laptrinhjavaweb.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.laptrinhjavaweb.dao.iOrderDAO;
import com.laptrinhjavaweb.mapper.OrderDetailMapper;
import com.laptrinhjavaweb.mapper.OrderMapper;
import com.laptrinhjavaweb.model.Order;
import com.laptrinhjavaweb.model.OrderDetail;

public class OrderDAO extends AbstractDAO<Order> implements iOrderDAO {

    @Override
    public Order getOrderById(int id) {
        String sql = "SELECT * FROM Orders WHERE order_id = ?";
        List<Order> order = query(sql, new OrderMapper(), id);
        return order.isEmpty() ? null : order.get(0);
    }

    @Override
    public List<Order> getAllOrders() {
        String sql = "SELECT * FROM Orders ORDER BY order_date DESC";
        return query(sql, new OrderMapper());
    }

    @Override
    public void createOrder(Order order) {
        String sql = "INSERT INTO Orders (customer_name, total_amount, status, shipping_address, phone, email) VALUES (?, ?, ?, ?, ?, ?)";
        Connection conn = connect();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, order.getCustomerName());
            stmt.setDouble(2, order.getTotalAmount());
            stmt.setString(3, "pending"); // Default status
            stmt.setString(4, order.getShippingAddress());
            stmt.setString(5, order.getPhone());
            stmt.setString(6, order.getEmail());
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Failed to create order: " + e.getMessage());
        }
    }

    @Override
    public void updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE Orders SET status = ? WHERE order_id = ?";
        Connection conn = connect();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Failed to update order status: " + e.getMessage());
        }
    }

    @Override
    public List<Order> getOrdersByCustomer(String customerName) {
        String sql = "SELECT * FROM Orders WHERE customer_name = ? ORDER BY order_date DESC";
        return query(sql, new OrderMapper(), customerName);
    }

    // New: Get order items for an order
    public List<OrderDetail> findOrderItems(int orderId) {
        List<OrderDetail> items = new ArrayList<>();
        String sql = "SELECT * FROM OrderDetails WHERE order_id = ?";
        Connection conn = connect();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            OrderDetailMapper mapper = new OrderDetailMapper();
            while (rs.next()) {
                OrderDetail detail = mapper.mapRow(rs);
                if (detail != null) items.add(detail);
            }
        } catch (SQLException e) {
            System.out.println("Failed to get order items: " + e.getMessage());
        }
        return items;
    }

    // New: Delete order and its items
    public void deleteOrderWithItems(int orderId) {
        Connection conn = connect();
        try {
            // Delete order items first
            String deleteItemsSql = "DELETE FROM OrderDetails WHERE order_id = ?";
            PreparedStatement stmtItems = conn.prepareStatement(deleteItemsSql);
            stmtItems.setInt(1, orderId);
            stmtItems.executeUpdate();

            // Then delete the order
            String deleteOrderSql = "DELETE FROM Orders WHERE order_id = ?";
            PreparedStatement stmtOrder = conn.prepareStatement(deleteOrderSql);
            stmtOrder.setInt(1, orderId);
            stmtOrder.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Failed to delete order: " + e.getMessage());
        }
    }
}
