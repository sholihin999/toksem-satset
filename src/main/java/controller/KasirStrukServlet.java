package controller;

import dao.PenjualanDAO;
import model.PenjualanHeader;
import model.PenjualanDetailRow;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/kasir/penjualan/struk")
public class KasirStrukServlet extends HttpServlet {

    private final PenjualanDAO penjualanDAO = new PenjualanDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 1) Proteksi session login
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 2) Validasi parameter id
        int id;
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/kasir/penjualan?msg=ID transaksi tidak valid&type=danger");
            return;
        }

        // 3) Ambil data
        PenjualanHeader header = penjualanDAO.findHeaderById(id);
        if (header == null) {
            resp.sendRedirect(req.getContextPath() + "/kasir/penjualan?msg=Data tidak ditemukan&type=warning");
            return;
        }

        List<PenjualanDetailRow> detail = penjualanDAO.findDetailByPenjualanId(id);

        // 4) Tentukan tombol "Kembali" mau ke mana
        // Cara paling aman: pakai parameter src=admin/kasir dari link yang membuka struk
        // (Kalau gak ada, fallback berdasarkan role session)
        String src = req.getParameter("src"); // "admin" atau "kasir"
        String backUrl;

        if ("admin".equalsIgnoreCase(src)) {
            backUrl = req.getContextPath() + "/admin/penjualan/riwayat";
        } else if ("kasir".equalsIgnoreCase(src)) {
            backUrl = req.getContextPath() + "/kasir/penjualan/riwayat";
        } else {
            // fallback: coba baca role dari session (sesuaikan nama attribute kalau beda)
            String role = String.valueOf(session.getAttribute("role")); // contoh: ADMIN / KASIR
            if ("ADMIN".equalsIgnoreCase(role)) {
                backUrl = req.getContextPath() + "/admin/penjualan/riwayat";
            } else {
                backUrl = req.getContextPath() + "/kasir/penjualan/riwayat";
            }
        }

        req.setAttribute("backUrl", backUrl);

        // 5) Forward ke JSP
        req.setAttribute("header", header);
        req.setAttribute("detail", detail);
        req.getRequestDispatcher("/kasir/penjualan/struk.jsp").forward(req, resp);
    }
}
