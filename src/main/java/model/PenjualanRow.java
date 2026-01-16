/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

public class PenjualanRow {
    private int id;
    private Timestamp tanggal;
    private String kasirNama;
    private int total;
    private int bayar;
    private int kembalian;

    public PenjualanRow(int id, Timestamp tanggal, String kasirNama, int total, int bayar, int kembalian) {
        this.id = id;
        this.tanggal = tanggal;
        this.kasirNama = kasirNama;
        this.total = total;
        this.bayar = bayar;
        this.kembalian = kembalian;
    }

    public int getId() { return id; }
    public Timestamp getTanggal() { return tanggal; }
    public String getKasirNama() { return kasirNama; }
    public int getTotal() { return total; }
    public int getBayar() { return bayar; }
    public int getKembalian() { return kembalian; }
}

