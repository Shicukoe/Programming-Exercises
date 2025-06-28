package com.laptrinhjavaweb.dao;

import java.util.List;

import com.laptrinhjavaweb.model.Pet;

public interface iPetDAO extends GenericDAO<Pet> {
    List<Pet> findAll();
    Pet findById(int id);
    void save(Pet pet);
    void update(Pet pet);
    void delete(int id);
    List<Pet> findByType(String type);
    List<Pet> filterPets(String type, String breed, Double minPrice, Double maxPrice, String gender);
    List<String> getAllTypes();
}