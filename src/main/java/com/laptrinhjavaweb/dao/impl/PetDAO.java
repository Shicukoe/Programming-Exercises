package com.laptrinhjavaweb.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import com.laptrinhjavaweb.dao.iPetDAO;
import com.laptrinhjavaweb.mapper.PetMapper;
import com.laptrinhjavaweb.model.Pet;

public class PetDAO extends AbstractDAO<Pet> implements iPetDAO {
    
    @Override
    public List<Pet> findAll() {
        String sql = "SELECT * FROM Pets ORDER BY created_at DESC";
        return query(sql, new PetMapper());
    }
    
    @Override
    public Pet findById(int id) {
        String sql = "SELECT * FROM Pets WHERE pet_id = ?";
        List<Pet> pets = query(sql, new PetMapper(), id);
        return pets.isEmpty() ? null : pets.get(0);
    }
    
    @Override
    public void save(Pet pet) {
        String sql = "INSERT INTO Pets (name, price, type, breed, age, gender, description, image, added_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = connect();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, pet.getName());
            stmt.setDouble(2, pet.getPrice());
            stmt.setString(3, pet.getType());
            stmt.setString(4, pet.getBreed());
            stmt.setInt(5, pet.getAge());
            stmt.setString(6, pet.getGender());
            stmt.setString(7, pet.getDescription());
            stmt.setBytes(8, pet.getImage());
            stmt.setString(9, pet.getAddedBy());
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Failed to save pet: " + e.getMessage());
        }
    }
    
    @Override
    public void update(Pet pet) {
        String sql = "UPDATE Pets SET name = ?, price = ?, type = ?, breed = ?, age = ?, gender = ?, description = ?, image = ?, added_by = ? WHERE pet_id = ?";
        Connection conn = connect();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, pet.getName());
            stmt.setDouble(2, pet.getPrice());
            stmt.setString(3, pet.getType());
            stmt.setString(4, pet.getBreed());
            stmt.setInt(5, pet.getAge());
            stmt.setString(6, pet.getGender());
            stmt.setString(7, pet.getDescription());
            stmt.setBytes(8, pet.getImage());
            stmt.setString(9, pet.getAddedBy());
            stmt.setInt(10, pet.getPetId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Failed to update pet: " + e.getMessage());
        }
    }
    
    @Override
    public void delete(int id) {
        String sql = "DELETE FROM Pets WHERE pet_id = ?";
        Connection conn = connect();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Failed to delete pet: " + e.getMessage());
        }
    }
    
    @Override
    public List<Pet> findByType(String type) {
        String sql = "SELECT * FROM Pets WHERE type = ? ORDER BY created_at DESC";
        return query(sql, new PetMapper(), type);
    }
    
    @Override
    public List<Pet> filterPets(String type, String breed, Double minPrice, Double maxPrice, String gender) {
        StringBuilder sql = new StringBuilder("SELECT * FROM Pets WHERE 1=1");
        java.util.List<Object> params = new java.util.ArrayList<>();
        if (type != null && !type.isEmpty()) {
            sql.append(" AND type = ?");
            params.add(type);
        }
        if (breed != null && !breed.isEmpty()) {
            sql.append(" AND breed = ?");
            params.add(breed);
        }
        if (minPrice != null) {
            sql.append(" AND price >= ?");
            params.add(minPrice);
        }
        if (maxPrice != null) {
            sql.append(" AND price <= ?");
            params.add(maxPrice);
        }
        if (gender != null && !gender.isEmpty()) {
            sql.append(" AND gender = ?");
            params.add(gender);
        }
        sql.append(" ORDER BY created_at DESC");
        return query(sql.toString(), new PetMapper(), params.toArray());
    }
    
    // New: get all unique pet types
    public List<String> getAllTypes() {
        String sql = "SELECT DISTINCT type FROM Pets ORDER BY type ASC";
        List<String> types = new java.util.ArrayList<>();
        java.sql.Connection conn = connect();
        try {
            java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
            java.sql.ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                types.add(rs.getString("type"));
            }
            rs.close();
            stmt.close();
        } catch (java.sql.SQLException e) {
            System.out.println("Failed to get pet types: " + e.getMessage());
        } finally {
            try { conn.close(); } catch (Exception ignore) {}
        }
        return types;
    }
}




