/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.UserDAO;
import model.User;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // kalau sudah login, arahkan sesuai role
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            String role = (String) session.getAttribute("role");
            if ("ADMIN".equalsIgnoreCase(role)) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
                return;
            } else {
                resp.sendRedirect(req.getContextPath() + "/kasir/dashboard");
                return;
            }
        }

        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // validasi ringan
        if (username == null || password == null || username.isBlank() || password.isBlank()) {
            req.setAttribute("error", "Username dan password wajib diisi.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        User user = userDAO.login(username.trim(), password);

        if (user == null) {
            req.setAttribute("error", "Login gagal. Username/password salah atau akun nonaktif.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        // buat session
        HttpSession session = req.getSession(true);
        session.setAttribute("user", user);              // simpan object user
        session.setAttribute("role", user.getRole());    // simpan role string
        session.setAttribute("userId", user.getId());    // opsional, sering dipakai

        // redirect sesuai role
        if ("ADMIN".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        } else {
            resp.sendRedirect(req.getContextPath() + "/kasir/dashboard");
        }
    }
}
