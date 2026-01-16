/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.CartItemBeli;
import model.PembelianHeader;
import model.PembelianDetailRow;
import model.PembelianSummary;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PembelianDAO {

    public int insertPembelian(int supplierId, int adminId, List<CartItemBeli> cart) throws Exception {
        if (cart == null || cart.isEmpty()) {
            throw new Exception("Keranjang kosong");
        }

        String insertHeader = "INSERT INTO pembelian (supplier_id, admin_id, total) VALUES (?,?,?) RETURNING id";
        String insertDetail = "INSERT INTO detail_pembelian (pembelian_id, produk_id, qty, harga_beli, subtotal) VALUES (?,?,?,?,?)";
        String updateStok = "UPDATE produk SET stok = stok + ? WHERE id = ?";

        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // mulai transaction

            int total = 0;
            for (CartItemBeli item : cart) {
                total += item.getSubtotal();
            }

            int pembelianId;

            // 1) insert header -> ambil id
            try (PreparedStatement ps = conn.prepareStatement(insertHeader)) {
                ps.setInt(1, supplierId);
                ps.setInt(2, adminId);
                ps.setInt(3, total);

                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        throw new Exception("Gagal membuat pembelian (header)");
                    }
                    pembelianId = rs.getInt(1);
                }
            }

            // 2) insert detail + update stok
            try (PreparedStatement psDetail = conn.prepareStatement(insertDetail); PreparedStatement psStok = conn.prepareStatement(updateStok)) {

                for (CartItemBeli item : cart) {
                    int subtotal = item.getSubtotal();

                    psDetail.setInt(1, pembelianId);
                    psDetail.setInt(2, item.getProdukId());
                    psDetail.setInt(3, item.getQty());
                    psDetail.setInt(4, item.getHargaBeli());
                    psDetail.setInt(5, subtotal);
                    psDetail.addBatch();

                    psStok.setInt(1, item.getQty());
                    psStok.setInt(2, item.getProdukId());
                    psStok.addBatch();
                }

                psDetail.executeBatch();
                psStok.executeBatch();
            }

            conn.commit();
            return pembelianId;

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

    public PembelianHeader findHeaderById(int id) {
        String sql
                = "SELECT b.id, b.tanggal, s.nama AS supplier_nama, u.nama AS admin_nama, b.total "
                + "FROM pembelian b "
                + "JOIN supplier s ON b.supplier_id = s.id "
                + "JOIN users u ON b.admin_id = u.id "
                + "WHERE b.id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new PembelianHeader(
                            rs.getInt("id"),
                            rs.getTimestamp("tanggal"),
                            rs.getString("supplier_nama"),
                            rs.getString("admin_nama"),
                            rs.getInt("total")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<PembelianDetailRow> findDetailByPembelianId(int pembelianId) {
        List<PembelianDetailRow> list = new ArrayList<>();

        String sql
                = "SELECT p.kode, p.nama, d.qty, d.harga_beli, d.subtotal "
                + "FROM detail_pembelian d "
                + "JOIN produk p ON d.produk_id = p.id "
                + "WHERE d.pembelian_id = ? "
                + "ORDER BY d.id";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, pembelianId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new PembelianDetailRow(
                            rs.getString("kode"),
                            rs.getString("nama"),
                            rs.getInt("qty"),
                            rs.getInt("harga_beli"),
                            rs.getInt("subtotal")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<PembelianHeader> findRiwayat(Date from, Date to, String supplierKeyword) {
        List<PembelianHeader> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT b.id, b.tanggal, s.nama AS supplier_nama, u.nama AS admin_nama, b.total "
                + "FROM pembelian b "
                + "JOIN supplier s ON b.supplier_id = s.id "
                + "JOIN users u ON b.admin_id = u.id "
                + "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (from != null) {
            sql.append("AND DATE(b.tanggal) >= ? ");
            params.add(from);
        }
        if (to != null) {
            sql.append("AND DATE(b.tanggal) <= ? ");
            params.add(to);
        }
        if (supplierKeyword != null && !supplierKeyword.trim().isEmpty()) {
            sql.append("AND LOWER(s.nama) LIKE ? ");
            params.add("%" + supplierKeyword.trim().toLowerCase() + "%");
        }

        sql.append("ORDER BY b.id DESC");

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new PembelianHeader(
                            rs.getInt("id"),
                            rs.getTimestamp("tanggal"),
                            rs.getString("supplier_nama"),
                            rs.getString("admin_nama"),
                            rs.getInt("total")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public PembelianSummary getSummary(java.sql.Date from, java.sql.Date to) {
        String sql
                = "SELECT "
                + "  COUNT(DISTINCT pb.id) AS total_transaksi, "
                + "  COALESCE(SUM(pb.total), 0) AS total_pengeluaran, "
                + "  COALESCE(SUM(dp.qty), 0) AS total_item "
                + "FROM pembelian pb "
                + "LEFT JOIN detail_pembelian dp ON dp.pembelian_id = pb.id "
                + "WHERE pb.tanggal::date >= ? AND pb.tanggal::date <= ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, from);
            ps.setDate(2, to);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new PembelianSummary(
                            rs.getInt("total_transaksi"),
                            rs.getInt("total_pengeluaran"),
                            rs.getInt("total_item")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new PembelianSummary(0, 0, 0);
    }
}
