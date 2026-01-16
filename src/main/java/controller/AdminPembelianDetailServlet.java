/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.PembelianDAO;
import model.PembelianHeader;
import model.PembelianDetailRow;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/pembelian/detail")
public class AdminPembelianDetailServlet extends HttpServlet {

    private final PembelianDAO pembelianDAO = new PembelianDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        PembelianHeader header = pembelianDAO.findHeaderById(id);
        if (header == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/pembelian?msg=Data pembelian tidak ditemukan&type=danger");
            return;
        }

        List<PembelianDetailRow> detail = pembelianDAO.findDetailByPembelianId(id);

        req.setAttribute("header", header);
        req.setAttribute("detail", detail);

        req.getRequestDispatcher("/admin/pembelian/detail.jsp").forward(req, resp);
    }
}

