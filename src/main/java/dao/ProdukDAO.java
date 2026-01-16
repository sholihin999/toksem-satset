/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Produk;
import util.DBConnection;
import model.StokMenipisRow;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProdukDAO {

    public List<Produk> findAll(String keyword, Integer kategoriId) {
        List<Produk> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT p.id, p.kode, p.nama, p.kategori_id, k.nama AS kategori_nama, "
                + "p.satuan, p.harga, p.stok "
                + "FROM produk p JOIN kategori k ON p.kategori_id = k.id WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (LOWER(p.nama) LIKE ? OR LOWER(p.kode) LIKE ?) ");
            String kw = "%" + keyword.trim().toLowerCase() + "%";
            params.add(kw);
            params.add(kw);
        }

        if (kategoriId != null && kategoriId > 0) {
            sql.append("AND p.kategori_id = ? ");
            params.add(kategoriId);
        }

        sql.append("ORDER BY p.id");

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Produk p = new Produk(
                            rs.getInt("id"),
                            rs.getString("kode"),
                            rs.getString("nama"),
                            rs.getInt("kategori_id"),
                            rs.getString("kategori_nama"),
                            rs.getString("satuan"),
                            rs.getInt("harga"),
                            rs.getInt("stok")
                    );
                    list.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Produk findById(int id) {
        String sql
                = "SELECT p.id, p.kode, p.nama, p.kategori_id, k.nama AS kategori_nama, "
                + "p.satuan, p.harga, p.stok "
                + "FROM produk p JOIN kategori k ON p.kategori_id = k.id "
                + "WHERE p.id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Produk(
                            rs.getInt("id"),
                            rs.getString("kode"),
                            rs.getString("nama"),
                            rs.getInt("kategori_id"),
                            rs.getString("kategori_nama"),
                            rs.getString("satuan"),
                            rs.getInt("harga"),
                            rs.getInt("stok")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean insert(Produk p) {
        String sql = "INSERT INTO produk (kode, nama, kategori_id, satuan, harga, stok) VALUES (?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getKode());
            ps.setString(2, p.getNama());
            ps.setInt(3, p.getKategoriId());
            ps.setString(4, p.getSatuan());
            ps.setInt(5, p.getHarga());
            ps.setInt(6, p.getStok());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(Produk p) {
        String sql = "UPDATE produk SET kode=?, nama=?, kategori_id=?, satuan=?, harga=?, stok=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getKode());
            ps.setString(2, p.getNama());
            ps.setInt(3, p.getKategoriId());
            ps.setString(4, p.getSatuan());
            ps.setInt(5, p.getHarga());
            ps.setInt(6, p.getStok());
            ps.setInt(7, p.getId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM produk WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            // bisa gagal kalau produk sudah dipakai transaksi
            e.printStackTrace();
        }
        return false;
    }

    public List<StokMenipisRow> findStokMenipis(int batas, int limit) {
        List<StokMenipisRow> list = new ArrayList<>();
        String sql
                = "SELECT kode, nama, stok FROM produk "
                + "WHERE stok <= ? "
                + "ORDER BY stok ASC, nama ASC "
                + "LIMIT ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, batas);
            ps.setInt(2, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new StokMenipisRow(
                            rs.getString("kode"),
                            rs.getString("nama"),
                            rs.getInt("stok")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
