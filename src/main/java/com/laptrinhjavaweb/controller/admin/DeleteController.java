package com.laptrinhjavaweb.controller.admin;

import java.io.IOException;

import com.laptrinhjavaweb.service.iNewService;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/admin-delete"})
public class DeleteController extends HttpServlet {
    
    @Inject
    private iNewService NewService;

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in as admin
        HttpSession session = request.getSession();
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int petId = Integer.parseInt(request.getParameter("id"));
            NewService.delete(petId);
            response.sendRedirect(request.getContextPath() + "/admin-home");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid pet ID");
        } catch (IOException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting pet");
        }
    }
}

