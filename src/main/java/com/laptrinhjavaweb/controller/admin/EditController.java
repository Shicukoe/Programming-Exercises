package com.laptrinhjavaweb.controller.admin;

import java.io.IOException;
import java.sql.Timestamp;

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
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig
@WebServlet(urlPatterns = {"/admin-editpage"})
public class EditController extends HttpServlet {
    private static final long serialVersionUID = 2686801510274002166L;

    @Inject
    iNewService NewService;

    @Override
    public void init() {
        if (NewService == null) {
            NewService = new com.laptrinhjavaweb.service.impl.NewService();
            try {
                java.lang.reflect.Field petDaoField = NewService.getClass().getDeclaredField("petDAO");
                petDaoField.setAccessible(true);
                petDaoField.set(NewService, new com.laptrinhjavaweb.dao.impl.PetDAO());
            } catch (IllegalAccessException | IllegalArgumentException | NoSuchFieldException | SecurityException e) {
                System.out.println("Failed to inject petDAO: " + e.getMessage());
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        try {
            int id = Integer.parseInt(idParam);
            Pet pet = NewService.findById(id);
            if (pet != null) {
                // Set base64Image for display in JSP
                pet.setBase64Image(pet.convertImageToBase64());
                request.setAttribute("pet", pet);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/editpage.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Pet not found");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Pet ID");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in as admin
        HttpSession session = request.getSession();
        // if (session == null || !"admin".equals(session.getAttribute("role"))) {
        //     response.sendRedirect(request.getContextPath() + "/login");
        //     return;
        // }

        try {
            // Set character encoding for proper UTF-8 handling
            request.setCharacterEncoding("UTF-8");
            
            Pet pet = new Pet();
            pet.setPetId(Integer.parseInt(request.getParameter("petId")));
            pet.setName(request.getParameter("name"));
            
            String priceStr = request.getParameter("price");
            if (priceStr != null && !priceStr.isEmpty()) {
                pet.setPrice(Double.parseDouble(priceStr));
            }
            
            pet.setType(request.getParameter("type"));
            pet.setBreed(request.getParameter("breed"));
            
            String ageStr = request.getParameter("age");
            if (ageStr != null && !ageStr.isEmpty()) {
                pet.setAge(Integer.parseInt(ageStr));
            }
            
            pet.setGender(request.getParameter("gender"));
            pet.setDescription(request.getParameter("description"));
            
            // Get current admin username from session
            String addedBy = (String) session.getAttribute("username");
            pet.setAddedBy(addedBy);
            
            // Set update timestamp
            pet.setCreatedAt(new Timestamp(System.currentTimeMillis()));

            // Handle image upload
            Part imagePart = request.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                byte[] imageBytes = imagePart.getInputStream().readAllBytes();
                pet.setImage(imageBytes);
            } else {
                // If no new image uploaded, keep the old image
                Pet oldPet = NewService.findById(pet.getPetId());
                if (oldPet != null) {
                    pet.setImage(oldPet.getImage());
                }
            }

            NewService.update(pet);
            response.sendRedirect(request.getContextPath() + "/admin-home");
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid number format in form data");
            doGet(request, response);
        } catch (ServletException | IOException e) {
            request.setAttribute("errorMessage", "Error updating pet: " + e.getMessage());
            doGet(request, response);
        }
    }
}

