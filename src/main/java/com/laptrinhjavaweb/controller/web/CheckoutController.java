package com.laptrinhjavaweb.controller.web;

import java.io.IOException;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.laptrinhjavaweb.dao.iOrderDAO;
import com.laptrinhjavaweb.dao.iUserDAO;
import com.laptrinhjavaweb.model.CartItem;
import com.laptrinhjavaweb.model.Order;
import com.laptrinhjavaweb.model.Users;

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
        String cartJson = request.getParameter("cartData");
        java.util.List<CartItem> cart = null;
        if (cartJson != null && !cartJson.isEmpty()) {
            Gson gson = new Gson();
            cart = gson.fromJson(cartJson, new TypeToken<java.util.List<CartItem>>(){}.getType());
        } else {
            // fallback to session cart if not provided
            HttpSession session = request.getSession();
            cart = (java.util.List<CartItem>) session.getAttribute("cart");
        }
        // Create or update user
        Users customer = new Users();
        customer.setUsername(email); // Use email as username
        customer.setFullName(fullName);
        customer.setEmail(email);
        customer.setPhone(phone);
        if (!userDAO.checkUsernameExists(email)) {
            userDAO.createCustomer(customer);
        }
        // Create order
        Order order = new Order();
        order.setCustomerName(email);
        order.setShippingAddress(address);
        order.setPhone(phone);
        order.setEmail(email);
        double total = 0.0;
        int totalQuantity = 0;
        if (cart != null) {
            for (CartItem item : cart) {
                total += item.getPrice() * item.getQuantity();
                totalQuantity += item.getQuantity();
            }
        }
        order.setTotalAmount(total);
        // Optionally, if your Order model supports it:
        // order.setTotalQuantity(totalQuantity);
        request.setAttribute("totalPrice", total);
        request.setAttribute("totalQuantity", totalQuantity);
        orderDAO.createOrder(order);
        // Clear cart from session
        HttpSession session = request.getSession();
        session.removeAttribute("cart");
        // Redirect to order confirmation
        response.sendRedirect(request.getContextPath() + "/order-confirmation?id=" + order.getOrderId());
    }
}
