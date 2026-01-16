/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {"/admin/*", "/kasir/*"})
public class RoleFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) { }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("role") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String role = String.valueOf(session.getAttribute("role")).toUpperCase();
        String path = req.getRequestURI().substring(req.getContextPath().length());

        boolean isAdminArea = path.startsWith("/admin/");
        boolean isKasirArea = path.startsWith("/kasir/");

        // aturan akses
        if (isAdminArea && !"ADMIN".equals(role)) {
            // kasir masuk admin -> lempar ke dashboard kasir
            resp.sendRedirect(req.getContextPath() + "/kasir/dashboard");
            return;
        }

        if (isKasirArea && !"KASIR".equals(role) && !"ADMIN".equals(role)) {
            // kalau ada role lain (misal nanti) -> tendang login
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() { }
}

