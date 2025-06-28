package com.laptrinhjavaweb.service.impl;

import java.util.List;

import com.laptrinhjavaweb.dao.iPetDAO;
import com.laptrinhjavaweb.dao.impl.PetDAO;
import com.laptrinhjavaweb.model.Pet;
import com.laptrinhjavaweb.service.iNewService;

import jakarta.inject.Inject;

public class NewService implements iNewService {

    @Inject
    private iPetDAO petDAO;

    public NewService() {
        petDAO = new PetDAO();
    }

    @Override
    public List<Pet> findAll() {
        return petDAO.findAll();
    }

    @Override
    public Pet findById(int id) {
        return petDAO.findById(id);
    }

    @Override
    public void save(Pet pet) {
        petDAO.save(pet);
    }

    @Override
    public void update(Pet pet) {
        petDAO.update(pet);
    }

    @Override
    public void delete(int id) {
        petDAO.delete(id);
    }

    @Override
    public List<Pet> findByType(String type) {
        return petDAO.findByType(type);
    }

    @Override
    public List<Pet> filterPets(String type, String breed, Double minPrice, Double maxPrice, String gender) {
        return petDAO.filterPets(type, breed, minPrice, maxPrice, gender);
    }

    // New: get all unique pet types
    public List<String> getAllTypes() {
        return petDAO.getAllTypes();
    }
}
