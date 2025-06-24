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
        
        String petType = request.getParameter("type"); // Optional filter by pet type
    Pet petList = new Pet(); // This is your model that extends AbstractModel<Pet>
    List<Pet> pets;

    if (petType != null && !petType.isEmpty()) {
        pets = petService.findByType(petType);
    } else {
        pets = petService.findAll();
    }

    // Convert pet images to base64 if needed
    for (Pet pet : pets) {
        if (pet.getImage() != null) {
            String base64Image = java.util.Base64.getEncoder().encodeToString(pet.getImage());
            pet.setBase64Image(base64Image);
        }
    }

    petList.setListResult(pets);
    request.setAttribute("petList", petList);

        RequestDispatcher rd = request.getRequestDispatcher("/views/web/shopping.jsp");
        rd.forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle any POST requests (e.g., adding to cart via AJAX)
        String action = request.getParameter("action");
        
        if ("add-to-cart".equals(action)) {
            // This will be handled by client-side JavaScript using sessionStorage
            response.setContentType("application/json");
            response.getWriter().write("{\"status\": \"success\"}");
        }
    }
}
