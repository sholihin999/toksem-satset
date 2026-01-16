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

@WebServlet("/kasir/penjualan/riwayat")
public class KasirRiwayatPenjualanServlet extends HttpServlet {

    private final PenjualanDAO penjualanDAO = new PenjualanDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        // kalau kamu simpan userId di session (sudah kamu pakai sebelumnya)
        Object kasirIdObj = session.getAttribute("userId");
        if (kasirIdObj == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        Integer kasirId = Integer.parseInt(String.valueOf(kasirIdObj));

        String q = req.getParameter("q");
        Date from = null, to = null;

        try {
            String fromStr = req.getParameter("from");
            if (fromStr != null && !fromStr.isBlank()) from = Date.valueOf(fromStr);

            String toStr = req.getParameter("to");
            if (toStr != null && !toStr.isBlank()) to = Date.valueOf(toStr);
        } catch (Exception ignored) {}

        List<PenjualanRow> list = penjualanDAO.findRiwayat(kasirId, q, from, to);

        req.setAttribute("list", list);
        req.getRequestDispatcher("/kasir/penjualan/riwayat.jsp").forward(req, resp);
    }
}

