package com.laptrinhjavaweb.controller.admin;

import java.io.IOException;

import com.laptrinhjavaweb.model.Pet;
import com.laptrinhjavaweb.service.iNewService;

import jakarta.inject.Inject;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig
@WebServlet(urlPatterns = {"/admin-add-pet"})
public class AddController extends HttpServlet {
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
                System.out.println("Failed to inject petDAO: " + e.getMessage());
            }
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/views/admin/create.jsp");
			rd.forward(request, response);     
        
    }
    
    @Override
    @SuppressWarnings("UnnecessaryTemporaryOnConversionFromString")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Pet petAdd = new Pet();
        request.setCharacterEncoding("UTF-8");
        petAdd.setName(request.getParameter("name"));
        String priceStr = request.getParameter("price");
        if (priceStr != null && !priceStr.isEmpty()) {
            petAdd.setPrice(Double.parseDouble(priceStr));
        } else {
            petAdd.setPrice(0.0);
        }
        petAdd.setType(request.getParameter("type"));
        petAdd.setBreed(request.getParameter("breed"));
        petAdd.setAge(Integer.parseInt(request.getParameter("age")));
        petAdd.setGender(request.getParameter("gender"));
        petAdd.setDescription(request.getParameter("description"));

        // Handle image upload
        Part imagePart = request.getPart("image");
        if (imagePart != null && imagePart.getSize() > 0) {
            byte[] imageBytes = imagePart.getInputStream().readAllBytes();
            petAdd.setImage(imageBytes);
        }
        // Set addedBy from request parameter (or session if needed)
        petAdd.setAddedBy(request.getParameter("addedBy"));

        try {
            petService.save(petAdd);
            response.sendRedirect(request.getContextPath() + "/admin-home");
        } catch (IOException e) {
            System.out.println("Failed to add pet at controller." + e.getMessage());
        }
    }
}