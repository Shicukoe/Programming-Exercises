package com.laptrinhjavaweb.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.laptrinhjavaweb.model.Pet;

public class PetMapper implements RowMapper<Pet> {
    @Override
    public Pet mapRow(ResultSet resultSet) {
        try {
            Pet pet = new Pet();
            pet.setPetId(resultSet.getInt("pet_id"));
            pet.setName(resultSet.getString("name"));
            pet.setPrice(resultSet.getDouble("price"));
            pet.setType(resultSet.getString("type"));
            pet.setBreed(resultSet.getString("breed"));
            pet.setAge(resultSet.getInt("age"));
            pet.setGender(resultSet.getString("gender"));
            pet.setDescription(resultSet.getString("description"));
            pet.setImage(resultSet.getBytes("image"));
            pet.setAddedBy(resultSet.getString("added_by"));
            pet.setCreatedAt(resultSet.getTimestamp("created_at"));
            return pet;
        } catch (SQLException e) {
            System.out.println("Error mapping pet: " + e.getMessage());
            return null;
        }
    }
}
