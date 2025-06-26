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
        HttpSession session = request.getSession();
        java.util.List<CartItem> cart = (java.util.List<CartItem>) session.getAttribute("cart");
        double total = 0.0;
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/shopping?error=emptycart");
            return;
        }
        // If not logged in, show login/register form
        String loggedInUser = (String) session.getAttribute("username");
        String action = request.getParameter("action");
        if (loggedInUser == null && action == null) {
            // Show login/register form
            request.setAttribute("cart", cart);
            for (CartItem item : cart) total += item.getPrice() * item.getQuantity();
            request.setAttribute("totalPrice", total);
            request.getRequestDispatcher("/views/web/checkout-auth.jsp").forward(request, response);
            return;
        }
        com.laptrinhjavaweb.model.Users user = null;
        boolean justRegistered = false;
        // Handle login
        if ("login".equals(action)) {
            String username = request.getParameter("loginUsername");
            String password = request.getParameter("loginPassword");
            user = userDAO.getUserByUsernameAndPassword(username, password);
            if (user == null) {
                request.setAttribute("errorMessage", "Invalid username or password.");
                request.setAttribute("cart", cart);
                for (CartItem item : cart) total += item.getPrice() * item.getQuantity();
                request.setAttribute("totalPrice", total);
                request.getRequestDispatcher("/views/web/checkout-auth.jsp").forward(request, response);
                return;
            }
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            // Continue to order creation below (no redirect)
        }
        // Handle register
        if ("register".equals(action)) {
            String username = request.getParameter("regUsername");
            String password = request.getParameter("regPassword");
            String fullName = request.getParameter("regFullName");
            String email = request.getParameter("regEmail");
            String phone = request.getParameter("regPhone");
            String address = request.getParameter("regAddress");
            if (username == null || username.isBlank() || password == null || password.isBlank() || fullName == null || fullName.isBlank() || email == null || email.isBlank() || phone == null || phone.isBlank() || address == null || address.isBlank()) {
                request.setAttribute("errorMessage", "Please fill in all registration fields.");
                request.setAttribute("cart", cart);
                for (CartItem item : cart) total += item.getPrice() * item.getQuantity();
                request.setAttribute("totalPrice", total);
                request.getRequestDispatcher("/views/web/checkout-auth.jsp").forward(request, response);
                return;
            }
            // Check if username or email exists
            for (com.laptrinhjavaweb.model.Users u : userDAO.getAllCustomers()) {
                if (u.getUsername().equalsIgnoreCase(username)) {
                    request.setAttribute("errorMessage", "Username already exists.");
                    request.setAttribute("cart", cart);
                    for (CartItem item : cart) total += item.getPrice() * item.getQuantity();
                    request.setAttribute("totalPrice", total);
                    request.getRequestDispatcher("/views/web/checkout-auth.jsp").forward(request, response);
                    return;
                }
                if (u.getEmail().equalsIgnoreCase(email)) {
                    request.setAttribute("errorMessage", "Email already exists.");
                    request.setAttribute("cart", cart);
                    for (CartItem item : cart) total += item.getPrice() * item.getQuantity();
                    request.setAttribute("totalPrice", total);
                    request.getRequestDispatcher("/views/web/checkout-auth.jsp").forward(request, response);
                    return;
                }
            }
            com.laptrinhjavaweb.model.Users newUser = new com.laptrinhjavaweb.model.Users();
            newUser.setUsername(username);
            newUser.setPassword(password);
            newUser.setFullName(fullName);
            newUser.setEmail(email);
            newUser.setPhone(phone);
            newUser.setAddress(address);
            newUser.setRole("customer");
            userDAO.createCustomer(newUser);
            session.setAttribute("username", newUser.getUsername());
            session.setAttribute("role", newUser.getRole());
            user = newUser;
            justRegistered = true;
            // No redirect or return here, continue to order creation below
        }
        if (user == null && !justRegistered) {
            // At this point, user is logged in (either just logged in or was already logged in)
            String username = (String) session.getAttribute("username");
            for (com.laptrinhjavaweb.model.Users u : userDAO.getAllCustomers()) {
                if (u.getUsername().equalsIgnoreCase(username)) {
                    user = u;
                    break;
                }
            }
        }
        // Create order
        if (user == null) {
            request.setAttribute("errorMessage", "User information not found. Please log in again.");
            request.setAttribute("cart", cart);
            for (CartItem item : cart) total += item.getPrice() * item.getQuantity();
            request.setAttribute("totalPrice", total);
            request.getRequestDispatcher("/views/web/checkout-auth.jsp").forward(request, response);
            return;
        }
        // Use justRegisteredUser if available (registration flow)
        com.laptrinhjavaweb.model.Order order = new com.laptrinhjavaweb.model.Order();
        order.setCustomerName(user.getUsername()); // FIX: must be username for FK
        order.setFullName(user.getFullName());
        order.setShippingAddress(user.getAddress());
        order.setPhone(user.getPhone());
        order.setEmail(user.getEmail());
        double totalAmount = 0.0;
        java.util.List<com.laptrinhjavaweb.model.OrderDetail> orderDetails = new java.util.ArrayList<>();
        for (CartItem item : cart) {
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
