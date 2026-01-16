/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.PenjualanDAO;
import model.PenjualanRow;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;

@WebServlet("/kasir/dashboard")
public class KasirDashboardServlet extends HttpServlet {

    private final PenjualanDAO penjualanDAO = new PenjualanDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        Object userIdObj = session.getAttribute("userId"); // di project kamu ini dipakai juga di pembelian
        if (userIdObj == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        int kasirId = Integer.parseInt(String.valueOf(userIdObj));

        // tanggal hari ini
        LocalDate today = LocalDate.now();
        Date from = Date.valueOf(today);
        Date to = Date.valueOf(today);

        // ambil riwayat khusus kasir hari ini (maks 200 dari DAO)
        List<PenjualanRow> allToday = penjualanDAO.findRiwayat(kasirId, null, from, to);

        // potong 5 terbaru untuk tabel
        List<PenjualanRow> latest5 = allToday.size() > 5 ? allToday.subList(0, 5) : allToday;

        // hitung ringkasan kasir hari ini (real)
        int totalTransaksi = allToday.size();
        int omzet = 0;
        for (PenjualanRow r : allToday) omzet += r.getTotal();

        req.setAttribute("totalTransaksi", totalTransaksi);
        req.setAttribute("omzet", omzet);
        req.setAttribute("latest5", latest5);

        req.getRequestDispatcher("/kasir/dashboard.jsp").forward(req, resp);
    }
}
