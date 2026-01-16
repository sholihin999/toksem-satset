/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

public class PembelianHeader {
    private int id;
    private Timestamp tanggal;
    private String supplierNama;
    private String adminNama;
    private int total;

    public PembelianHeader(int id, Timestamp tanggal, String supplierNama, String adminNama, int total) {
        this.id = id;
        this.tanggal = tanggal;
        this.supplierNama = supplierNama;
        this.adminNama = adminNama;
        this.total = total;
    }

    public int getId() { return id; }
    public Timestamp getTanggal() { return tanggal; }
    public String getSupplierNama() { return supplierNama; }
    public String getAdminNama() { return adminNama; }
    public int getTotal() { return total; }
}

