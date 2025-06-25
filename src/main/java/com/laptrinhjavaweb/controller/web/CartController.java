package com.laptrinhjavaweb.controller.web;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.laptrinhjavaweb.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String CART_SESSION_KEY = "cart";
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        List<CartItem> cart = getCart(req.getSession());
        PrintWriter out = resp.getWriter();
        out.print(gson.toJson(cart));
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        HttpSession session = req.getSession();
        List<CartItem> cart = getCart(session);

        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = req.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }
        String body = sb.toString();
        if (body == null || body.isEmpty()) {
            resp.getWriter().print(gson.toJson(cart));
            return;
        }
        try {
            var node = gson.fromJson(body, java.util.Map.class);
            String action = (String) node.get("action");
            if ("add".equals(action)) {
                int id = ((Number) node.get("id")).intValue();
                String name = (String) node.get("name");
                double price = ((Number) node.get("price")).doubleValue();
                boolean found = false;
                for (CartItem item : cart) {
                    if (item.getId() == id) {
                        item.setQuantity(item.getQuantity() + 1);
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    CartItem newItem = new CartItem(id, name, price, 1);
                    cart.add(newItem);
                }
            } else if ("remove".equals(action)) {
                int index = ((Number) node.get("index")).intValue();
                if (index >= 0 && index < cart.size()) {
                    cart.remove(index);
                }
            }
            // Save cart back to session
            session.setAttribute(CART_SESSION_KEY, cart);
        } catch (JsonSyntaxException e) {
            // Ignore and return current cart
        }
        resp.getWriter().print(gson.toJson(cart));
    }

    @SuppressWarnings("unchecked")
    private List<CartItem> getCart(HttpSession session) {
        Object cartObj = session.getAttribute(CART_SESSION_KEY);
        if (cartObj == null) {
            List<CartItem> cart = new ArrayList<>();
            session.setAttribute(CART_SESSION_KEY, cart);
            return cart;
        }
        return (List<CartItem>) cartObj;
    }
}
