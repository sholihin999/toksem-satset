/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.KategoriDAO;
import dao.ProdukDAO;
import model.Kategori;
import model.Produk;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/produk")
public class AdminProdukServlet extends HttpServlet {

    private final ProdukDAO produkDAO = new ProdukDAO();
    private final KategoriDAO kategoriDAO = new KategoriDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // dropdown kategori selalu dikirim ke JSP
        List<Kategori> kategoriList = kategoriDAO.findAll();
        req.setAttribute("kategoriList", kategoriList);

        // filter
        String q = req.getParameter("q");
        Integer kategoriId = null;
        try {
            String kid = req.getParameter("kategoriId");
            if (kid != null && !kid.isBlank()) kategoriId = Integer.parseInt(kid);
        } catch (Exception ignored) {}

        // edit mode
        if ("edit".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Produk p = produkDAO.findById(id);
            req.setAttribute("produk", p);
        }

        List<Produk> list = produkDAO.findAll(q, kategoriId);
        req.setAttribute("list", list);

        req.getRequestDispatcher("/admin/produk/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        boolean ok = false;

        try {
            if ("add".equalsIgnoreCase(action) || "update".equalsIgnoreCase(action)) {
                String kode = req.getParameter("kode");
                String nama = req.getParameter("nama");
                String satuan = req.getParameter("satuan");
                int kategoriId = Integer.parseInt(req.getParameter("kategori_id"));
                int harga = Integer.parseInt(req.getParameter("harga"));
                int stok = Integer.parseInt(req.getParameter("stok"));

                // validasi simpel
                if (kode == null || kode.isBlank() || nama == null || nama.isBlank()) {
                    resp.sendRedirect(req.getContextPath() + "/admin/produk?msg=Kode dan Nama wajib diisi&type=danger");
                    return;
                }
                if (harga < 0 || stok < 0) {
                    resp.sendRedirect(req.getContextPath() + "/admin/produk?msg=Harga/Stok tidak boleh minus&type=danger");
                    return;
                }

                Produk p = new Produk();
                p.setKode(kode.trim());
                p.setNama(nama.trim());
                p.setKategoriId(kategoriId);
                p.setSatuan(satuan != null ? satuan.trim() : null);
                p.setHarga(harga);
                p.setStok(stok);

                if ("add".equalsIgnoreCase(action)) {
                    ok = produkDAO.insert(p);
                } else {
                    int id = Integer.parseInt(req.getParameter("id"));
                    p.setId(id);
                    ok = produkDAO.update(p);
                }

            } else if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                ok = produkDAO.delete(id);
            }

            if (ok) {
                resp.sendRedirect(req.getContextPath() + "/admin/produk?msg=Berhasil&type=success");
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/produk?msg=Gagal (kode mungkin duplikat/terpakai transaksi)&type=danger");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/produk?msg=Terjadi error&type=danger");
        }
    }
}
