/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class PembelianDetailRow {
    private String kode;
    private String nama;
    private int qty;
    private int hargaBeli;
    private int subtotal;

    public PembelianDetailRow(String kode, String nama, int qty, int hargaBeli, int subtotal) {
        this.kode = kode;
        this.nama = nama;
        this.qty = qty;
        this.hargaBeli = hargaBeli;
        this.subtotal = subtotal;
    }

    public String getKode() { return kode; }
    public String getNama() { return nama; }
    public int getQty() { return qty; }
    public int getHargaBeli() { return hargaBeli; }
    public int getSubtotal() { return subtotal; }
}

