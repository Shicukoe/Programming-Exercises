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
        String sql = "INSERT INTO Orders (customer_name, full_name, shipping_address, phone, email, total_amount, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = connect();
        PreparedStatement stmt = null;
        ResultSet generatedKeys = null;
        try {
            stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setString(1, order.getCustomerName());
            stmt.setString(2, order.getFullName());
            stmt.setString(3, order.getShippingAddress());
            stmt.setString(4, order.getPhone());
            stmt.setString(5, order.getEmail());
            stmt.setDouble(6, order.getTotalAmount());
            stmt.setString(7, order.getStatus() != null ? order.getStatus() : "pending");
            stmt.executeUpdate();
            generatedKeys = stmt.getGeneratedKeys();
            int orderId = -1;
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            }
            // Insert order details
            if (order.getOrderDetails() != null && orderId != -1) {
                String detailSql = "INSERT INTO OrderDetails (order_id, pet_id, quantity, price_at_time) VALUES (?, ?, ?, ?)";
                PreparedStatement detailStmt = null;
                try {
                    for (OrderDetail detail : order.getOrderDetails()) {
                        detailStmt = conn.prepareStatement(detailSql);
                        detailStmt.setInt(1, orderId);
                        detailStmt.setInt(2, detail.getPetId());
                        detailStmt.setInt(3, detail.getQuantity());
                        detailStmt.setDouble(4, detail.getPriceAtTime());
                        detailStmt.executeUpdate();
                        detailStmt.close();
                    }
                } finally {
                    if (detailStmt != null) detailStmt.close();
                }
            }
        } catch (SQLException e) {
            System.out.println("Failed to create order: " + e.getMessage());
            throw new RuntimeException("Failed to create order", e);
        } finally {
            try { if (generatedKeys != null) generatedKeys.close(); } catch (SQLException ignore) {}
            try { if (stmt != null) stmt.close(); } catch (SQLException ignore) {}
            try { if (conn != null) conn.close(); } catch (SQLException ignore) {}
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
    @Override
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
    @Override
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
