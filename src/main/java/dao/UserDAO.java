/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.User;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    // Login sederhana (plaintext dulu).
    // Nanti kalau mau hash, tinggal ubah bagian password compare.
    public User login(String username, String password) {

    String sql =
        "SELECT u.id, u.username, u.nama, u.aktif, r.nama AS role " +
        "FROM users u " +
        "JOIN roles r ON u.role_id = r.id " +
        "WHERE u.username = ? " +
        "AND u.password = ? " +
        "AND u.aktif = TRUE";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, username);
        ps.setString(2, password);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("nama"),
                    rs.getString("role"),
                    rs.getBoolean("aktif")
                );
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return null;
}
}