/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.SupplierDAO;
import model.Supplier;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/supplier")
public class AdminSupplierServlet extends HttpServlet {

    private final SupplierDAO supplierDAO = new SupplierDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("edit".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Supplier s = supplierDAO.findById(id);
            req.setAttribute("supplier", s);
        }

        List<Supplier> list = supplierDAO.findAll();
        req.setAttribute("list", list);

        req.getRequestDispatcher("/admin/supplier/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        boolean ok = false;

        try {
            if ("add".equalsIgnoreCase(action) || "update".equalsIgnoreCase(action)) {
                String nama = req.getParameter("nama");
                String noHp = req.getParameter("no_hp");
                String alamat = req.getParameter("alamat");

                if (nama == null || nama.trim().isEmpty()) {
                    resp.sendRedirect(req.getContextPath() + "/admin/supplier?msg=Nama supplier wajib diisi&type=danger");
                    return;
                }

                Supplier s = new Supplier();
                s.setNama(nama.trim());
                s.setNoHp(noHp != null ? noHp.trim() : null);
                s.setAlamat(alamat != null ? alamat.trim() : null);

                if ("add".equalsIgnoreCase(action)) {
                    ok = supplierDAO.insert(s);
                } else {
                    int id = Integer.parseInt(req.getParameter("id"));
                    s.setId(id);
                    ok = supplierDAO.update(s);
                }

            } else if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                ok = supplierDAO.delete(id);
            }

            if (ok) {
                resp.sendRedirect(req.getContextPath() + "/admin/supplier?msg=Berhasil&type=success");
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/supplier?msg=Gagal (mungkin dipakai pembelian)&type=danger");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/supplier?msg=Terjadi error&type=danger");
        }
    }
}

