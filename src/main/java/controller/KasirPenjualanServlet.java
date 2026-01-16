/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.PenjualanDAO;
import dao.ProdukDAO;
import model.CartItemJual;
import model.Produk;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/kasir/penjualan")
public class KasirPenjualanServlet extends HttpServlet {

    private final ProdukDAO produkDAO = new ProdukDAO();
    private final PenjualanDAO penjualanDAO = new PenjualanDAO();

    private void flash(HttpSession session, String type, String msg) {
        session.setAttribute("flashType", type); // success/danger/info/warning
        session.setAttribute("flashMsg", msg);
    }

    @SuppressWarnings("unchecked")
    private List<CartItemJual> getCart(HttpSession s) {
        Object o = s.getAttribute("cartJual");
        if (o == null) {
            List<CartItemJual> c = new ArrayList<>();
            s.setAttribute("cartJual", c);
            return c;
        }
        return (List<CartItemJual>) o;
    }

    private int total(List<CartItemJual> c) {
        int t = 0;
        for (CartItemJual i : c) t += i.getSubtotal();
        return t;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession s = req.getSession();
        List<CartItemJual> cart = getCart(s);

        String q = req.getParameter("q");
        List<Produk> produkList = produkDAO.findAll(q, null);

        req.setAttribute("produkList", produkList);
        req.setAttribute("cart", cart);
        req.setAttribute("total", total(cart));

        req.getRequestDispatcher("/kasir/penjualan/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession s = req.getSession();
        List<CartItemJual> cart = getCart(s);
        String action = req.getParameter("action");

        try {
            if ("add".equalsIgnoreCase(action)) {
                int produkId = Integer.parseInt(req.getParameter("produkId"));
                int qty = Integer.parseInt(req.getParameter("qty"));

                if (qty <= 0) {
                    flash(s, "danger", "Qty tidak valid");
                    resp.sendRedirect(req.getContextPath() + "/kasir/penjualan");
                    return;
                }

                Produk p = produkDAO.findById(produkId);
                if (p == null) {
                    flash(s, "danger", "Produk tidak ditemukan");
                    resp.sendRedirect(req.getContextPath() + "/kasir/penjualan");
                    return;
                }

                if (p.getStok() <= 0) {
                    flash(s, "warning", "Stok produk habis");
                    resp.sendRedirect(req.getContextPath() + "/kasir/penjualan");
                    return;
                }

                boolean found = false;
                for (CartItemJual i : cart) {
                    if (i.getProdukId() == produkId) {
                        i.setQty(i.getQty() + qty);
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    cart.add(new CartItemJual(p.getId(), p.getKode(), p.getNama(), qty, p.getHarga()));
                }

                resp.sendRedirect(req.getContextPath() + "/kasir/penjualan");
                return;

            } else if ("remove".equalsIgnoreCase(action)) {
                int produkId = Integer.parseInt(req.getParameter("produkId"));
                cart.removeIf(i -> i.getProdukId() == produkId);

                resp.sendRedirect(req.getContextPath() + "/kasir/penjualan");
                return;

            } else if ("checkout".equalsIgnoreCase(action)) {
                Object kasirIdObj = s.getAttribute("userId");
                if (kasirIdObj == null) {
                    resp.sendRedirect(req.getContextPath() + "/login");
                    return;
                }
                int kasirId = Integer.parseInt(String.valueOf(kasirIdObj));

                if (cart == null || cart.isEmpty()) {
                    flash(s, "info", "Keranjang masih kosong");
                    resp.sendRedirect(req.getContextPath() + "/kasir/penjualan");
                    return;
                }

                // Nama pembeli (opsional)
                String namaPembeli = req.getParameter("namaPembeli");
                if (namaPembeli != null) namaPembeli = namaPembeli.trim();
                if (namaPembeli != null && namaPembeli.isBlank()) namaPembeli = null;

                int bayar;
                try {
                    bayar = Integer.parseInt(req.getParameter("bayar"));
                } catch (Exception ex) {
                    flash(s, "danger", "Uang bayar tidak valid");
                    resp.sendRedirect(req.getContextPath() + "/kasir/penjualan");
                    return;
                }

                int totalBelanja = total(cart);

                if (bayar < totalBelanja) {
                    flash(s, "danger", "Uang bayar tidak mencukupi");
                    resp.sendRedirect(req.getContextPath() + "/kasir/penjualan");
                    return;
                }

                int kembalian = bayar - totalBelanja;

                // IMPORTANT: pastikan PenjualanDAO sudah diubah menerima namaPembeli
                int id = penjualanDAO.insertPenjualan(kasirId, cart, bayar, kembalian, namaPembeli);

                cart.clear();
                resp.sendRedirect(req.getContextPath() + "/kasir/penjualan/struk?id=" + id);
                return;
            }

            resp.sendRedirect(req.getContextPath() + "/kasir/penjualan");

        } catch (Exception e) {
            e.printStackTrace();
            flash(s, "danger", "Terjadi error: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/kasir/penjualan");
        }
    }
}
