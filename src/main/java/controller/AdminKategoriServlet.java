/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.KategoriDAO;
import model.Kategori;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/kategori")
public class AdminKategoriServlet extends HttpServlet {

    private final KategoriDAO kategoriDAO = new KategoriDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("edit".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Kategori k = kategoriDAO.findById(id);
            req.setAttribute("kategori", k);
        }

        List<Kategori> list = kategoriDAO.findAll();
        req.setAttribute("list", list);

        req.getRequestDispatcher("/admin/kategori/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        boolean ok = false;

        try {
            if ("add".equalsIgnoreCase(action)) {
                String nama = req.getParameter("nama");
                if (nama == null || nama.trim().isEmpty()) {
                    resp.sendRedirect(req.getContextPath() + "/admin/kategori?msg=Nama wajib diisi&type=danger");
                    return;
                }
                ok = kategoriDAO.insert(nama.trim());

            } else if ("update".equalsIgnoreCase(action)) {
                String nama = req.getParameter("nama");
                if (nama == null || nama.trim().isEmpty()) {
                    resp.sendRedirect(req.getContextPath() + "/admin/kategori?msg=Nama wajib diisi&type=danger");
                    return;
                }
                int id = Integer.parseInt(req.getParameter("id"));
                ok = kategoriDAO.update(id, nama.trim());

            } else if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                ok = kategoriDAO.delete(id);
            }

            if (ok) {
                resp.sendRedirect(req.getContextPath() + "/admin/kategori?msg=Berhasil&type=success");
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/kategori?msg=Gagal (mungkin dipakai produk)&type=danger");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/kategori?msg=Terjadi error&type=danger");
        }
    }

}
