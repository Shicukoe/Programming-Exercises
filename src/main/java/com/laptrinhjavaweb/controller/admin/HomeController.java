package com.laptrinhjavaweb.controller.admin;

import java.io.IOException;
import java.util.List;

import com.laptrinhjavaweb.model.Order;
import com.laptrinhjavaweb.model.Pet;
import com.laptrinhjavaweb.model.Users;
import com.laptrinhjavaweb.service.iNewService;
import com.laptrinhjavaweb.service.iOrderService;

import jakarta.inject.Inject;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/admin-home"})
public class HomeController extends HttpServlet {
    
    @Inject
    private iNewService petService;
    
    @Inject
    private iOrderService orderService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Enhanced security: check for logged-in admin
        HttpSession session = request.getSession(false);
        Users user = (session != null) ? (Users) session.getAttribute("loggedUser") : null;
        String role = (session != null) ? (String) session.getAttribute("role") : null;
        if (user == null || role == null || !"admin".equalsIgnoreCase(role)) {
            // Not logged in as admin, show login page
            RequestDispatcher rd = request.getRequestDispatcher("/views/web/login.jsp");
            rd.forward(request, response);
            return;
        }
        
        // Get all pets for inventory
        List<Pet> pets = petService.findAll();
        request.setAttribute("pets", pets);
        
        // Get all orders
        List<Order> orders = orderService.getAllOrders();
        request.setAttribute("orders", orders);
        
        RequestDispatcher rd = request.getRequestDispatcher("/views/admin/home.jsp");
        rd.forward(request, response);
    }
    //Manually inject dependency    
    @Override
        public void init() {
        if (petService == null) {
            petService = new com.laptrinhjavaweb.service.impl.NewService();
            // Manually inject petDAO dependency as well
            try {
                java.lang.reflect.Field petDaoField = petService.getClass().getDeclaredField("petDAO");
                petDaoField.setAccessible(true);
                petDaoField.set(petService, new com.laptrinhjavaweb.dao.impl.PetDAO());
            } catch (IllegalAccessException | IllegalArgumentException | NoSuchFieldException | SecurityException e) {
                System.out.println("Failed to inject petDAO: " + e.getMessage());
            }
        }
        if (orderService == null) {
            orderService = new com.laptrinhjavaweb.service.impl.OrderService();
            try {
                java.lang.reflect.Field orderDaoField = orderService.getClass().getDeclaredField("orderDAO");
                orderDaoField.setAccessible(true);
                orderDaoField.set(orderService, new com.laptrinhjavaweb.dao.impl.OrderDAO());
            } catch (IllegalAccessException | IllegalArgumentException | NoSuchFieldException | SecurityException e) {
                System.out.println("Failed to inject orderDAO: " + e.getMessage());
            }
        }
    }
}
