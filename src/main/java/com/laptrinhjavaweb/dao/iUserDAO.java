package com.laptrinhjavaweb.dao;

import java.util.List;

import com.laptrinhjavaweb.model.Users;

public interface iUserDAO extends GenericDAO<Users> {
    Users getUserByUsernameAndPassword(String username, String password);
    boolean checkUsernameExists(String username);
    void createCustomer(Users customer);
    List<Users> getAllCustomers();
    void updateUser(Users user);
}
