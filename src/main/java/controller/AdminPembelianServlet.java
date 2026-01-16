/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.PembelianDAO;
import dao.ProdukDAO;
import dao.SupplierDAO;
import model.CartItemBeli;
import model.Produk;
import model.Supplier;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/pembelian")
public class AdminPembelianServlet extends HttpServlet {

    private final SupplierDAO supplierDAO = new SupplierDAO();
    private final ProdukDAO produkDAO = new ProdukDAO();
    private final PembelianDAO pembelianDAO = new PembelianDAO();

    @SuppressWarnings("unchecked")
    private List<CartItemBeli> getCart(HttpSession session) {
        Object obj = session.getAttribute("cartBeli");
        if (obj == null) {
            List<CartItemBeli> cart = new ArrayList<>();
            session.setAttribute("cartBeli", cart);
            return cart;
        }
        return (List<CartItemBeli>) obj;
    }

    private int cartTotal(List<CartItemBeli> cart) {
        int total = 0;
        for (CartItemBeli i : cart) {
            total += i.getSubtotal();
        }
        return total;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        List<CartItemBeli> cart = getCart(session);

        // data dropdown supplier + list produk (untuk pilih)
        List<Supplier> suppliers = supplierDAO.findAll();

        String q = req.getParameter("q"); // search produk
        Integer kategoriId = null;
        try {
            String kid = req.getParameter("kategoriId");
            if (kid != null && !kid.isBlank()) {
                kategoriId = Integer.parseInt(kid);
            }
        } catch (Exception ignored) {
        }

        // re-use findAll dari ProdukDAO kamu (yang bisa keyword & kategori)
        List<Produk> produkList = produkDAO.findAll(q, kategoriId);

        req.setAttribute("suppliers", suppliers);
        req.setAttribute("produkList", produkList);
        req.setAttribute("cart", cart);
        req.setAttribute("total", cartTotal(cart));

        req.getRequestDispatcher("/admin/pembelian/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        List<CartItemBeli> cart = getCart(session);

        String action = req.getParameter("action");

        try {
            if ("addItem".equalsIgnoreCase(action)) {
                int produkId = Integer.parseInt(req.getParameter("produkId"));
                int qty = Integer.parseInt(req.getParameter("qty"));
                int hargaBeli = Integer.parseInt(req.getParameter("hargaBeli"));

                if (qty <= 0 || hargaBeli < 0) {
                    resp.sendRedirect(req.getContextPath() + "/admin/pembelian?msg=Qty/harga beli tidak valid&type=danger");
                    return;
                }

                Produk p = produkDAO.findById(produkId);
                if (p == null) {
                    resp.sendRedirect(req.getContextPath() + "/admin/pembelian?msg=Produk tidak ditemukan&type=danger");
                    return;
                }

                // kalau produk sudah ada di cart -> update qty & harga
                boolean found = false;
                for (CartItemBeli item : cart) {
                    if (item.getProdukId() == produkId) {
                        item.setQty(item.getQty() + qty);
                        item.setHargaBeli(hargaBeli); // update harga beli terakhir
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    cart.add(new CartItemBeli(produkId, p.getKode(), p.getNama(), qty, hargaBeli));
                }

                resp.sendRedirect(req.getContextPath() + "/admin/pembelian?msg=Item ditambahkan&type=success");
                return;

            } else if ("updateItem".equalsIgnoreCase(action)) {
                int produkId = Integer.parseInt(req.getParameter("produkId"));
                int qty = Integer.parseInt(req.getParameter("qty"));
                int hargaBeli = Integer.parseInt(req.getParameter("hargaBeli"));

                if (qty <= 0 || hargaBeli < 0) {
                    resp.sendRedirect(req.getContextPath() + "/admin/pembelian?msg=Qty/harga beli tidak valid&type=danger");
                    return;
                }

                boolean updated = false;
                for (CartItemBeli item : cart) {
                    if (item.getProdukId() == produkId) {
                        item.setQty(qty);
                        item.setHargaBeli(hargaBeli);
                        updated = true;
                        break;
                    }
                }

                if (updated) {
                    resp.sendRedirect(req.getContextPath() + "/admin/pembelian?msg=Item diperbarui&type=success");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/admin/pembelian?msg=Item tidak ditemukan di cart&type=danger");
                }
                return;

            } else if ("removeItem".equalsIgnoreCase(action)) {
                int produkId = Integer.parseInt(req.getParameter("produkId"));
                cart.removeIf(i -> i.getProdukId() == produkId);
                resp.sendRedirect(req.getContextPath() + "/admin/pembelian?msg=Item dihapus&type=success");
                return;

            } else if ("clear".equalsIgnoreCase(action)) {
                cart.clear();
                resp.sendRedirect(req.getContextPath() + "/admin/pembelian?msg=Keranjang dikosongkan&type=success");
                return;

            } else if ("checkout".equalsIgnoreCase(action)) {
                int supplierId = Integer.parseInt(req.getParameter("supplierId"));

                Object adminIdObj = session.getAttribute("userId");
                if (adminIdObj == null) {
                    resp.sendRedirect(req.getContextPath() + "/login");
                    return;
                }
                int adminId = Integer.parseInt(String.valueOf(adminIdObj));

                if (supplierId <= 0) {
                    resp.sendRedirect(req.getContextPath() + "/admin/pembelian?msg=Supplier wajib dipilih&type=danger");
                    return;
                }
                if (cart.isEmpty()) {
                    resp.sendRedirect(req.getContextPath() + "/admin/pembelian?msg=Keranjang masih kosong&type=danger");
                    return;
                }

                int pembelianId = pembelianDAO.insertPembelian(supplierId, adminId, cart);

                cart.clear(); // clear setelah sukses
                resp.sendRedirect(req.getContextPath() + "/admin/pembelian/detail?id=" + pembelianId);
                return;
            }

            resp.sendRedirect(req.getContextPath() + "/admin/pembelian");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/pembelian?msg=Terjadi error: " + e.getMessage() + "&type=danger");
        }
    }
}
