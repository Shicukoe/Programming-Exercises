package com.laptrinhjavaweb.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.laptrinhjavaweb.dao.iUserDAO;
import com.laptrinhjavaweb.mapper.UserMapper;
import com.laptrinhjavaweb.model.Users;

public class UserDAO extends AbstractDAO<Users> implements iUserDAO {

    @Override
    public Users getUserByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
        List<Users> users = query(sql, new UserMapper(), username, password);
        if (users != null && !users.isEmpty()) {
            return users.get(0);
        }
        return null;
    }

    @Override
    public boolean checkUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM Users WHERE username = ?";
        Connection conn = connect();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error checking username: " + e.getMessage());
        }
        return false;
    }

    @Override
    public void createCustomer(Users customer) {
        String sql = "INSERT INTO Users (username, password, full_name, birthday, address, email, phone, role) VALUES (?, ?, ?, ?, ?, ?, ?, 'customer')";
        Connection conn = connect();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, customer.getUsername());
            stmt.setString(2, customer.getPassword());
            stmt.setString(3, customer.getFullName());
            stmt.setDate(4, customer.getBirthday());
            stmt.setString(5, customer.getAddress());
            stmt.setString(6, customer.getEmail());
            stmt.setString(7, customer.getPhone());
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Failed to create customer: " + e.getMessage());
        }
    }

    @Override
    public List<Users> getAllCustomers() {
        String sql = "SELECT * FROM Users WHERE role = 'customer'";
        return query(sql, new UserMapper());
    }

    @Override
    public void updateUser(Users user) {
        String sql = "UPDATE Users SET password = ?, full_name = ?, birthday = ?, address = ?, email = ?, phone = ? WHERE username = ?";
        Connection conn = connect();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getPassword());
            stmt.setString(2, user.getFullName());
            stmt.setDate(3, user.getBirthday());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getEmail());
            stmt.setString(6, user.getPhone());
            stmt.setString(7, user.getUsername());
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Failed to update user: " + e.getMessage());
        }
    }
}

