/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.PenjualanDAO;
import dao.PembelianDAO;
import model.DashboardSummary;
import model.PembelianSummary;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.sql.Date;

@WebServlet("/admin/laporan/download")
public class AdminLaporanDownloadServlet extends HttpServlet {

    private final PenjualanDAO penjualanDAO = new PenjualanDAO();
    private final PembelianDAO pembelianDAO = new PembelianDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String range = req.getParameter("range");
        if (range == null || range.isBlank()) range = "month";

        LocalDate today = LocalDate.now();
        LocalDate start;
        LocalDate end = today;

        switch (range) {
            case "today":
                start = today; break;
            case "week":
                start = today.minusDays(6); break;
            case "month":
                start = today.withDayOfMonth(1); break;
            case "year":
                start = today.withDayOfYear(1); break;
            default:
                start = today.withDayOfMonth(1);
                range = "month";
        }

        DashboardSummary jual = penjualanDAO.getSummary(Date.valueOf(start), Date.valueOf(end));
        PembelianSummary beli = pembelianDAO.getSummary(Date.valueOf(start), Date.valueOf(end));

        int pendapatan = (jual != null ? jual.getTotalPendapatan() : 0);
        int transaksiJual = (jual != null ? jual.getTotalTransaksi() : 0);
        int itemJual = (jual != null ? jual.getTotalItem() : 0);

        int pengeluaran = (beli != null ? beli.getTotalPengeluaran() : 0);
        int transaksiBeli = (beli != null ? beli.getTotalTransaksi() : 0);
        int itemBeli = (beli != null ? beli.getTotalItem() : 0);

        int keuntungan = pendapatan - pengeluaran;

        // CSV Response
        String filename = "laporan_" + range + "_" + start + "_sd_" + end + ".csv";
        resp.setContentType("text/csv; charset=UTF-8");
        resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

        try (PrintWriter out = resp.getWriter()) {
            out.println("range,from,to,total_pendapatan,total_transaksi_penjualan,total_item_terjual,total_pengeluaran,total_transaksi_pembelian,total_item_dibeli,total_keuntungan");
            out.printf("%s,%s,%s,%d,%d,%d,%d,%d,%d,%d%n",
                    range, start, end,
                    pendapatan, transaksiJual, itemJual,
                    pengeluaran, transaksiBeli, itemBeli,
                    keuntungan
            );
        }
    }
}

