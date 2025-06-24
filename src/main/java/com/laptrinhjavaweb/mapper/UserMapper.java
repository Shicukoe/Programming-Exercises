package com.laptrinhjavaweb.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.laptrinhjavaweb.model.Users;

public class UserMapper implements RowMapper<Users> {
    @Override
    public Users mapRow(ResultSet resultSet) {
        try {
            Users user = new Users();
            user.setUsername(resultSet.getString("username"));
            user.setPassword(resultSet.getString("password"));
            user.setRole(resultSet.getString("role"));
            user.setFullName(resultSet.getString("full_name"));
            user.setBirthday(resultSet.getDate("birthday"));
            user.setAddress(resultSet.getString("address"));
            user.setEmail(resultSet.getString("email"));
            user.setPhone(resultSet.getString("phone"));
            return user;
        } catch (SQLException e) {
            return null;
        }
    }
}
