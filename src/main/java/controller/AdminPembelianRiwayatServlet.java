/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.PembelianDAO;
import model.PembelianHeader;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/pembelian/riwayat")
public class AdminPembelianRiwayatServlet extends HttpServlet {

    private final PembelianDAO pembelianDAO = new PembelianDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Date from = null;
        Date to = null;

        try {
            String fromStr = req.getParameter("from");
            if (fromStr != null && !fromStr.isBlank()) from = Date.valueOf(fromStr);

            String toStr = req.getParameter("to");
            if (toStr != null && !toStr.isBlank()) to = Date.valueOf(toStr);
        } catch (Exception ignored) {}

        String supplier = req.getParameter("supplier");

        List<PembelianHeader> list = pembelianDAO.findRiwayat(from, to, supplier);
        req.setAttribute("list", list);

        req.getRequestDispatcher("/admin/pembelian/riwayat.jsp").forward(req, resp);
    }
}
