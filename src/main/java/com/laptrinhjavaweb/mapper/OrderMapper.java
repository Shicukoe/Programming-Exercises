package com.laptrinhjavaweb.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.laptrinhjavaweb.model.Order;

public class OrderMapper implements RowMapper<Order> {
    @Override
    public Order mapRow(ResultSet resultSet) {
        try {
            Order order = new Order();
            order.setOrderId(resultSet.getInt("order_id"));
            order.setCustomerName(resultSet.getString("customer_name"));
            order.setTotalAmount(resultSet.getDouble("total_amount"));
            order.setOrderDate(resultSet.getTimestamp("order_date"));
            order.setStatus(resultSet.getString("status"));
            order.setShippingAddress(resultSet.getString("shipping_address"));
            order.setPhone(resultSet.getString("phone"));
            order.setEmail(resultSet.getString("email"));
            return order;
        } catch (SQLException e) {
            return null;
        }
    }
}
