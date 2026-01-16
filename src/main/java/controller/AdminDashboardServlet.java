/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.PenjualanDAO;
import dao.ProdukDAO;
import dao.PembelianDAO;                 // 🔹 BARU
import model.DashboardSummary;
import model.PenjualanRow;
import model.StokMenipisRow;
import model.PembelianSummary;          // 🔹 BARU

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.sql.Date;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final PenjualanDAO penjualanDAO = new PenjualanDAO();
    private final ProdukDAO produkDAO = new ProdukDAO();
    private final PembelianDAO pembelianDAO = new PembelianDAO(); // 🔹 BARU

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Range default: bulan ini
        String range = req.getParameter("range");
        if (range == null || range.isBlank()) {
            range = "month";
        }

        LocalDate today = LocalDate.now();
        LocalDate start;
        LocalDate end = today;

        switch (range) {
            case "today":
                start = today;
                break;
            case "week":
                start = today.minusDays(6); // 7 hari terakhir
                break;
            case "month":
                start = today.withDayOfMonth(1);
                break;
            case "year": 
                start = today.withDayOfYear(1);
                break;
            default:
                start = today.withDayOfMonth(1);
                range = "month";
                break;
        }

        // =========================
        // 1️⃣ SUMMARY PENJUALAN
        // =========================
        DashboardSummary summary
                = penjualanDAO.getSummary(Date.valueOf(start), Date.valueOf(end));

        // =========================
        // 2️⃣ SUMMARY PEMBELIAN (BARU)
        // =========================
        PembelianSummary pembelianSummary
                = pembelianDAO.getSummary(Date.valueOf(start), Date.valueOf(end));

        // =========================
        // 3️⃣ HITUNG KEUNTUNGAN (BARU)
        // =========================
        int pendapatan = (summary != null ? summary.getTotalPendapatan() : 0);
        int pengeluaran = (pembelianSummary != null ? pembelianSummary.getTotalPengeluaran() : 0);
        int totalKeuntungan = pendapatan - pengeluaran;

        // =========================
        // 4️⃣ DATA LAIN (SUDAH ADA)
        // =========================
        List<PenjualanRow> latest = penjualanDAO.findLatest(10);
        List<StokMenipisRow> stokMenipis = produkDAO.findStokMenipis(5, 10);
        List<PenjualanRow> terbaru = penjualanDAO.findTerbaru(5);

        // =========================
        // 5️⃣ KIRIM KE JSP
        // =========================
        req.setAttribute("range", range);
        req.setAttribute("start", start);
        req.setAttribute("end", end);

        req.setAttribute("summary", summary);
        req.setAttribute("pembelianSummary", pembelianSummary); // 🔹 BARU
        req.setAttribute("totalKeuntungan", totalKeuntungan);   // 🔹 BARU

        req.setAttribute("latest", latest);
        req.setAttribute("terbaru", terbaru);
        req.setAttribute("stokMenipis", stokMenipis);

        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }
}
