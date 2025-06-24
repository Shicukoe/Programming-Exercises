package com.laptrinhjavaweb.controller.web;

import java.io.IOException;

import com.laptrinhjavaweb.dao.iUserDAO;
import com.laptrinhjavaweb.model.Users;

import jakarta.inject.Inject;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet(urlPatterns = {"/login", "/dang-nhap","/logout"})
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 2686801510274002166L;
    
    @Inject 
    private iUserDAO userDAO;

    // Manual fallback initialization for environments where @Inject does not work
    @Override
    public void init() {
        if (userDAO == null) {
            userDAO = new com.laptrinhjavaweb.dao.impl.UserDAO();
            // Only inject if the field exists in the class
            // Remove reflection for 'userDAO' if not present in the implementation
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();

        if (uri.endsWith("/logout")) {
            // Handle logout
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate(); // destroy session
            }
            response.sendRedirect(request.getContextPath() + "/login"); // redirect to login
            return;
        }

        // Handle login GET request
        RequestDispatcher rd = request.getRequestDispatcher("/views/web/login.jsp");
        rd.forward(request, response);
    }
	
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve username and password from form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // Validate user credentials
            Users user = userDAO.getUserByUsernameAndPassword(username, password);

            if (user != null) {
                // Credentials are valid: set user in session and redirect to dashboard
                HttpSession session = request.getSession();
                session.setAttribute("loggedUser", user);
                session.setAttribute("role", user.getRole()); // Ensure role is set for admin check

                // Redirect based on user role
                if ("Admin".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/admin-home");
                } else {
                    response.sendRedirect(request.getContextPath() + "/shopping");
                }
            } else {
                // Invalid credentials: set error message and return to login page
                request.setAttribute("errorMessage", "Invalid username or password!");
                request.getRequestDispatcher("/views/web/login.jsp").forward(request, response);
            }
        } catch (IOException e) {
            throw new ServletException("Error during login process", e);
        }
    }
}
