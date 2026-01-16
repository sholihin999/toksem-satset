/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class CartItemJual {
    private int produkId;
    private String kode;
    private String nama;
    private int qty;
    private int harga;

    public CartItemJual(int produkId, String kode, String nama, int qty, int harga) {
        this.produkId = produkId;
        this.kode = kode;
        this.nama = nama;
        this.qty = qty;
        this.harga = harga;
    }

    public int getProdukId() { return produkId; }
    public String getKode() { return kode; }
    public String getNama() { return nama; }
    public int getQty() { return qty; }
    public int getHarga() { return harga; }

    public void setQty(int qty) { this.qty = qty; }

    public int getSubtotal() {
        return qty * harga;
    }
}

