package com.laptrinhjavaweb.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AuthFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String uri = req.getRequestURI();

        // Public paths that don't need authentication
        boolean isPublicPath = uri.endsWith("/home.jsp") || 
                             uri.endsWith("/shopping") ||
                             uri.endsWith("/login") ||
                             uri.endsWith("/checkout") ||
                             uri.contains("/assets/");

        // Admin paths that need admin role
        boolean isAdminPath = uri.contains("/admin-");
        
        if (isPublicPath) {
            chain.doFilter(request, response);
            return;
        }

        // Check authentication
        if (session == null || session.getAttribute("username") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Check authorization for admin paths
        if (isAdminPath && !"admin".equals(session.getAttribute("role"))) {
            res.sendRedirect(req.getContextPath() + "/shopping");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
