/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.PenjualanDAO;
import model.PenjualanRow;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/admin/penjualan/riwayat")
public class AdminRiwayatPenjualanServlet extends HttpServlet {

    private final PenjualanDAO penjualanDAO = new PenjualanDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String q = req.getParameter("q");
        Date from = null;
        Date to = null;

        try {
            String fromStr = req.getParameter("from");
            if (fromStr != null && !fromStr.isBlank()) from = Date.valueOf(fromStr); // yyyy-mm-dd

            String toStr = req.getParameter("to");
            if (toStr != null && !toStr.isBlank()) to = Date.valueOf(toStr);
        } catch (Exception ignored) {}

        // ✅ Admin = lihat semua -> kasirId = null
        List<PenjualanRow> list = penjualanDAO.findRiwayat(null, q, from, to);

        req.setAttribute("list", list);
        req.setAttribute("q", q);
        req.setAttribute("from", req.getParameter("from"));
        req.setAttribute("to", req.getParameter("to"));

        req.getRequestDispatcher("/admin/penjualan/riwayat.jsp").forward(req, resp);
    }
}

