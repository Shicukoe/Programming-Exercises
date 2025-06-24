package com.laptrinhjavaweb.controller.admin;

import java.io.IOException;
import java.util.List;

import com.laptrinhjavaweb.model.Order;
import com.laptrinhjavaweb.model.OrderDetail;
import com.laptrinhjavaweb.service.iOrderService;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/admin-update-order", "/admin-view-order", "/admin-delete-order"})
public class OrderController extends HttpServlet {
    
    @Inject
    private iOrderService orderService;

    @Override
    public void init() {
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in as admin
        HttpSession session = request.getSession();
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");
            
            if (status != null && !status.isEmpty()) {
                orderService.updateOrderStatus(orderId, status);
                response.getWriter().write("success");
            } else {
                response.getWriter().write("error: status is required");
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("error: invalid order id");
        } catch (IOException e) {
            response.getWriter().write("error: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Remove redundant admin check, AuthFilter will handle it
        String servletPath = request.getServletPath();
        if ("/admin-view-order".equals(servletPath)) {
            String idParam = request.getParameter("id");
            if (idParam != null) {
                try {
                    int orderId = Integer.parseInt(idParam);
                    // Use getOrderById and getOrderItems
                    Order order = orderService.getOrderById(orderId);
                    List<OrderDetail> orderItems = orderService.getOrderItems(orderId);
                    request.setAttribute("order", order);
                    request.setAttribute("orderItems", orderItems);
                    request.getRequestDispatcher("/views/admin/order-view.jsp").forward(request, response);
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid order ID");
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Order ID required");
            }
        } else if ("/admin-delete-order".equals(servletPath)) {
            String idParam = request.getParameter("id");
            if (idParam != null) {
                try {
                    int orderId = Integer.parseInt(idParam);
                    orderService.deleteOrderWithItems(orderId);
                } catch (NumberFormatException e) {
                    // Optionally log error
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin-home");
        }
    }
}
