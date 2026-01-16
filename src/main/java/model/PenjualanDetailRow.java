/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class PenjualanDetailRow {
    private String kode;
    private String nama;
    private int qty;
    private int harga;
    private int subtotal;

    public PenjualanDetailRow(String kode, String nama, int qty, int harga, int subtotal) {
        this.kode = kode;
        this.nama = nama;
        this.qty = qty;
        this.harga = harga;
        this.subtotal = subtotal;
    }

    public String getKode() { return kode; }
    public String getNama() { return nama; }
    public int getQty() { return qty; }
    public int getHarga() { return harga; }
    public int getSubtotal() { return subtotal; }
}

