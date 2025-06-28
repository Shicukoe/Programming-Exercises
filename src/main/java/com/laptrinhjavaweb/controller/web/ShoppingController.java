package com.laptrinhjavaweb.controller.web;

import java.io.IOException;
import java.util.List;

import com.laptrinhjavaweb.model.Pet;
import com.laptrinhjavaweb.service.iNewService;

import jakarta.inject.Inject;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/shopping"})
public class ShoppingController extends HttpServlet {
    private static final long serialVersionUID = 2686801510274002166L;
    
    @Inject
    private iNewService petService;

    @Override
    public void init() {
        if (petService == null) {
            petService = new com.laptrinhjavaweb.service.impl.NewService();
            try {
                java.lang.reflect.Field petDaoField = petService.getClass().getDeclaredField("petDAO");
                petDaoField.setAccessible(true);
                petDaoField.set(petService, new com.laptrinhjavaweb.dao.impl.PetDAO());
            } catch (IllegalAccessException | IllegalArgumentException | NoSuchFieldException | SecurityException e) {
                System.out.println("Manual petDAO injection failed: " + e.getMessage());
            }
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String petType = request.getParameter("type");
        String breed = request.getParameter("breed");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String gender = request.getParameter("gender");
        Double minPrice = (minPriceStr != null && !minPriceStr.isEmpty()) ? Double.valueOf(minPriceStr) : null;
        Double maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty()) ? Double.valueOf(maxPriceStr) : null;
        List<Pet> pets = petService.filterPets(petType, breed, minPrice, maxPrice, gender);
        // Convert pet images to base64 if needed
        for (Pet pet : pets) {
            if (pet.getImage() != null) {
                String base64Image = java.util.Base64.getEncoder().encodeToString(pet.getImage());
                pet.setBase64Image(base64Image);
            }
        }
        Pet petList = new Pet();
        petList.setListResult(pets);
        request.setAttribute("petList", petList);
        
        List<String> petTypes = petService.getAllTypes();
        request.setAttribute("petTypes", petTypes);
        
        RequestDispatcher rd = request.getRequestDispatcher("/views/web/shopping.jsp");
        rd.forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // No cart logic needed here. All cart management is done client-side.
        // You can handle other POST actions here if needed in the future.
    }
}
