/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import util.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/test-conn")
public class TestConnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = resp.getWriter();
             Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement()) {

            // Tes query sederhana
            ResultSet rs = st.executeQuery("SELECT NOW() as waktu");
            rs.next();

            out.println("<h2>Koneksi PostgreSQL: BERHASIL ✅</h2>");
            out.println("<p>Waktu DB: " + rs.getString("waktu") + "</p>");

        } catch (Exception e) {
            try (PrintWriter out = resp.getWriter()) {
                out.println("<h2>Koneksi PostgreSQL: GAGAL ❌</h2>");
                out.println("<pre>" + e.toString() + "</pre>");
            }
        }
    }
}

