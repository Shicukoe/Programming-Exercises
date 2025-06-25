package com.laptrinhjavaweb.controller.web;

import java.io.IOException;

import com.laptrinhjavaweb.dao.iOrderDAO;
import com.laptrinhjavaweb.dao.iUserDAO;
import com.laptrinhjavaweb.model.CartItem;

import jakarta.inject.Inject;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/checkout"})
public class CheckoutController extends HttpServlet {
    
    @Inject
    private iOrderDAO orderDAO;
    
    @Inject
    private iUserDAO userDAO;

    @Override
    public void init() {
        if (userDAO == null) {
            userDAO = new com.laptrinhjavaweb.dao.impl.UserDAO();
        }
        if (orderDAO == null) {
            orderDAO = new com.laptrinhjavaweb.dao.impl.OrderDAO();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        java.util.List<CartItem> cart = (java.util.List<CartItem>) session.getAttribute("cart");
        double total = 0.0;
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/shopping?error=emptycart");
            return;
        }
        for (CartItem item : cart) {
            total += item.getPrice() * item.getQuantity();
        }
        request.setAttribute("cart", cart);
        request.setAttribute("totalPrice", total);
        RequestDispatcher rd = request.getRequestDispatcher("/views/web/checkout.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        HttpSession session = request.getSession();
        java.util.List<CartItem> cart = (java.util.List<CartItem>) session.getAttribute("cart");
        double total = 0.0;
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/shopping?error=emptycart");
            return;
        }
        // Validate required fields
        if (fullName == null || fullName.isBlank() || email == null || email.isBlank() || phone == null || phone.isBlank() || address == null || address.isBlank()) {
            request.setAttribute("errorMessage", "Please fill in all required fields (Full Name, Email, Phone, Address).");
            request.setAttribute("cart", cart);
            for (CartItem item : cart) total += item.getPrice() * item.getQuantity();
            request.setAttribute("totalPrice", total);
            request.getRequestDispatcher("/views/web/checkout.jsp").forward(request, response);
            return;
        }
        // Check if user exists by email, if not, create
        com.laptrinhjavaweb.model.Users user = null;
        for (com.laptrinhjavaweb.model.Users u : userDAO.getAllCustomers()) {
            if (u.getEmail() != null && u.getEmail().equalsIgnoreCase(email)) {
                user = u;
                break;
            }
        }
        if (user == null) {
            user = new com.laptrinhjavaweb.model.Users();
            user.setEmail(email);
            user.setFullName(fullName);
            user.setAddress(address);
            user.setPhone(phone);
            user.setRole("customer");
            // Generate a username and password for guest (or leave blank/null)
            user.setUsername(email);
            user.setPassword("");
            userDAO.createCustomer(user);
        }
        // Create order
        com.laptrinhjavaweb.model.Order order = new com.laptrinhjavaweb.model.Order();
        order.setCustomerName(user.getFullName() != null && !user.getFullName().isEmpty() ? user.getFullName() : user.getUsername());
        order.setFullName(user.getFullName());
        order.setShippingAddress(address);
        order.setPhone(phone);
        order.setEmail(email);
        double totalAmount = 0.0;
        java.util.List<com.laptrinhjavaweb.model.OrderDetail> orderDetails = new java.util.ArrayList<>();
        for (CartItem item : cart) {
            System.out.println("CartItem: id=" + item.getId() + ", name=" + item.getName() + ", price=" + item.getPrice() + ", quantity=" + item.getQuantity());
            com.laptrinhjavaweb.model.OrderDetail detail = new com.laptrinhjavaweb.model.OrderDetail();
            detail.setPetId(item.getId());
            detail.setQuantity(item.getQuantity());
            detail.setPriceAtTime(item.getPrice());
            orderDetails.add(detail);
            totalAmount += item.getPrice() * item.getQuantity();
        }
        order.setOrderDetails(orderDetails);
        order.setTotalAmount(totalAmount);
        order.setStatus("pending");
        orderDAO.createOrder(order);
        // Remove cart from session after order is placed
        session.removeAttribute("cart");
        request.setAttribute("order", order);
        request.setAttribute("cart", cart);
        request.setAttribute("totalPrice", totalAmount);
        RequestDispatcher rd = request.getRequestDispatcher("/views/web/order-confirmation.jsp");
        rd.forward(request, response);
    }
}
