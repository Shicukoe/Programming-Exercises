package com.laptrinhjavaweb.controller.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        List<CartItem> cart = getCart(req.getSession());
        req.setAttribute("cart", cart);
        req.getRequestDispatcher("/views/web/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute(CART_SESSION_KEY);
        if (cart == null) cart = new ArrayList<>();

        String idStr = req.getParameter("id");
        String action = req.getParameter("action");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            if ("increase".equals(action)) {
                for (CartItem item : cart) {
                    if (item.getId() == id) {
                        item.setQuantity(item.getQuantity() + 1);
                        break;
                    }
                }
            } else if ("decrease".equals(action)) {
                for (int i = 0; i < cart.size(); i++) {
                    CartItem item = cart.get(i);
                    if (item.getId() == id) {
                        if (item.getQuantity() > 1) {
                            item.setQuantity(item.getQuantity() - 1);
                        } else {
                            cart.remove(i);
                        }
                        break;
                    }
                }
            } else if ("delete".equals(action)) {
                cart.removeIf(item -> item.getId() == id);
            } else {
                // Default: add to cart (from shopping.jsp)
                String name = req.getParameter("name");
                String priceStr = req.getParameter("price");
                if (name != null && priceStr != null) {
                    double price = Double.parseDouble(priceStr);
                    boolean found = false;
                    for (CartItem item : cart) {
                        if (item.getId() == id) {
                            item.setQuantity(item.getQuantity() + 1);
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        cart.add(new CartItem(id, name, price, 1));
                    }
                }
            }
        }
        session.setAttribute(CART_SESSION_KEY, cart);
        resp.sendRedirect(req.getContextPath() + "/views/web/cart.jsp");
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
