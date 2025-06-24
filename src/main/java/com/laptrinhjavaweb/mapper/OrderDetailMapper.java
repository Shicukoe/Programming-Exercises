package com.laptrinhjavaweb.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.laptrinhjavaweb.model.OrderDetail;

public class OrderDetailMapper implements RowMapper<OrderDetail> {
    @Override
    public OrderDetail mapRow(ResultSet rs) {
        try {
            OrderDetail detail = new OrderDetail();
            detail.setOrderDetailId(rs.getInt("order_detail_id"));
            detail.setOrderId(rs.getInt("order_id"));
            detail.setPetId(rs.getInt("pet_id"));
            detail.setQuantity(rs.getInt("quantity"));
            detail.setPriceAtTime(rs.getDouble("price_at_time"));
            // Optionally map Pet if joined
            return detail;
        } catch (SQLException e) {
            return null;
        }
    }
}
