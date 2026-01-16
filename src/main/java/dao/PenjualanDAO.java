        /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.CartItemJual;
import util.DBConnection;
import model.PenjualanHeader;
import model.PenjualanDetailRow;
import model.PenjualanRow;
import model.DashboardSummary;

import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class PenjualanDAO {

    public int insertPenjualan(int kasirId, List<CartItemJual> cart, int bayar, int kembalian, String namaPembeli) throws Exception {
        if (cart == null || cart.isEmpty()) {
            throw new Exception("Keranjang kosong");
        }

        String insertHeader
                = "INSERT INTO penjualan (kasir_id, total, bayar, kembalian, nama_pembeli) "
                + "VALUES (?, ?, ?, ?, ?) RETURNING id";
        String insertDetail
                = "INSERT INTO detail_penjualan (penjualan_id, produk_id, qty, harga, subtotal) VALUES (?,?,?,?,?)";
        String updateStok
                = "UPDATE produk SET stok = stok - ? WHERE id = ? AND stok >= ?";

        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            int total = 0;
            for (CartItemJual i : cart) {
                total += i.getSubtotal();
            }

            int penjualanId;

            // header
            try (PreparedStatement ps = conn.prepareStatement(insertHeader)) {
                ps.setInt(1, kasirId);
                ps.setInt(2, total);
                ps.setInt(3, bayar);
                ps.setInt(4, kembalian);
                ps.setString(5, namaPembeli);

                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        throw new Exception("Gagal membuat penjualan");
                    }
                    penjualanId = rs.getInt(1);
                }
            }

            // detail + stok
            try (PreparedStatement psDetail = conn.prepareStatement(insertDetail); PreparedStatement psStok = conn.prepareStatement(updateStok)) {

                for (CartItemJual i : cart) {
                    psDetail.setInt(1, penjualanId);
                    psDetail.setInt(2, i.getProdukId());
                    psDetail.setInt(3, i.getQty());
                    psDetail.setInt(4, i.getHarga());
                    psDetail.setInt(5, i.getSubtotal());
                    psDetail.addBatch();

                    psStok.setInt(1, i.getQty());
                    psStok.setInt(2, i.getProdukId());
                    psStok.setInt(3, i.getQty());
                    psStok.addBatch();
                }

                psDetail.executeBatch();
                int[] stokRes = psStok.executeBatch();

                for (int r : stokRes) {
                    if (r == 0) {
                        throw new Exception("Stok tidak mencukupi");
                    }
                }
            }

            conn.commit();
            return penjualanId;

        } catch (Exception e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                } catch (Exception ignored) {
                }
                try {
                    conn.close();
                } catch (Exception ignored) {
                }
            }
        }
    }

    public PenjualanHeader findHeaderById(int id) {
        String sql
                = "SELECT p.id, p.tanggal, u.nama AS kasir_nama, p.total, p.bayar, p.kembalian, p.nama_pembeli "
                + "FROM penjualan p JOIN users u ON p.kasir_id = u.id WHERE p.id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new PenjualanHeader(
                            rs.getInt("id"),
                            rs.getTimestamp("tanggal"),
                            rs.getString("kasir_nama"),
                            rs.getInt("total"),
                            rs.getInt("bayar"),
                            rs.getInt("kembalian"),
                            rs.getString("nama_pembeli")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<PenjualanDetailRow> findDetailByPenjualanId(int penjualanId) {
        List<PenjualanDetailRow> list = new ArrayList<>();

        String sql
                = "SELECT pr.kode, pr.nama, d.qty, d.harga, d.subtotal "
                + "FROM detail_penjualan d "
                + "JOIN produk pr ON d.produk_id = pr.id "
                + "WHERE d.penjualan_id = ? "
                + "ORDER BY d.id";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, penjualanId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new PenjualanDetailRow(
                            rs.getString("kode"),
                            rs.getString("nama"),
                            rs.getInt("qty"),
                            rs.getInt("harga"),
                            rs.getInt("subtotal")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<PenjualanRow> findRiwayat(Integer kasirId, String q, Date from, Date to) {
        List<PenjualanRow> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT p.id, p.tanggal, u.nama AS kasir_nama, p.total, p.bayar, p.kembalian "
                + "FROM penjualan p "
                + "JOIN users u ON p.kasir_id = u.id "
                + "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        // kalau mau riwayat khusus kasir yang sedang login
        if (kasirId != null) {
            sql.append(" AND p.kasir_id = ? ");
            params.add(kasirId);
        }

        // filter keyword (ID transaksi)
        if (q != null && !q.isBlank()) {
            sql.append(" AND CAST(p.id AS TEXT) ILIKE ? ");
            params.add("%" + q.trim() + "%");
        }

        // filter tanggal
        if (from != null) {
            sql.append(" AND p.tanggal::date >= ? ");
            params.add(from);
        }
        if (to != null) {
            sql.append(" AND p.tanggal::date <= ? ");
            params.add(to);
        }

        sql.append(" ORDER BY p.id DESC LIMIT 200 ");

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new PenjualanRow(
                            rs.getInt("id"),
                            rs.getTimestamp("tanggal"),
                            rs.getString("kasir_nama"),
                            rs.getInt("total"),
                            rs.getInt("bayar"),
                            rs.getInt("kembalian")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public DashboardSummary getSummary(java.sql.Date from, java.sql.Date to) {
        String sql
                = "SELECT "
                + "  COUNT(DISTINCT p.id) AS total_transaksi, "
                + "  COALESCE(SUM(p.total), 0) AS total_pendapatan, "
                + "  COALESCE(SUM(d.qty), 0) AS total_item "
                + "FROM penjualan p "
                + "LEFT JOIN detail_penjualan d ON d.penjualan_id = p.id "
                + "WHERE p.tanggal::date >= ? AND p.tanggal::date <= ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, from);
            ps.setDate(2, to);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new DashboardSummary(
                            rs.getInt("total_transaksi"),
                            rs.getInt("total_pendapatan"),
                            rs.getInt("total_item")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new DashboardSummary(0, 0, 0);
    }

    public List<PenjualanRow> findLatest(int limit) {
        List<PenjualanRow> list = new ArrayList<>();

        String sql
                = "SELECT p.id, p.tanggal, u.nama AS kasir_nama, p.total, p.bayar, p.kembalian "
                + "FROM penjualan p "
                + "JOIN users u ON p.kasir_id = u.id "
                + "ORDER BY p.id DESC "
                + "LIMIT ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new PenjualanRow(
                            rs.getInt("id"),
                            rs.getTimestamp("tanggal"),
                            rs.getString("kasir_nama"),
                            rs.getInt("total"),
                            rs.getInt("bayar"),
                            rs.getInt("kembalian")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<PenjualanRow> findTerbaru(int limit) {
        List<PenjualanRow> list = new ArrayList<>();

        String sql
                = "SELECT p.id, p.tanggal, u.nama AS kasir_nama, p.total, p.bayar, p.kembalian "
                + "FROM penjualan p "
                + "JOIN users u ON p.kasir_id = u.id "
                + "ORDER BY p.id DESC "
                + "LIMIT ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new PenjualanRow(
                            rs.getInt("id"),
                            rs.getTimestamp("tanggal"),
                            rs.getString("kasir_nama"),
                            rs.getInt("total"),
                            rs.getInt("bayar"),
                            rs.getInt("kembalian")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}
