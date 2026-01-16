/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class CartItemBeli {
    private int produkId;
    private String kode;
    private String nama;
    private int qty;
    private int hargaBeli;

    public CartItemBeli() {}

    public CartItemBeli(int produkId, String kode, String nama, int qty, int hargaBeli) {
        this.produkId = produkId;
        this.kode = kode;
        this.nama = nama;
        this.qty = qty;
        this.hargaBeli = hargaBeli;
    }

    public int getProdukId() { return produkId; }
    public void setProdukId(int produkId) { this.produkId = produkId; }

    public String getKode() { return kode; }
    public void setKode(String kode) { this.kode = kode; }

    public String getNama() { return nama; }
    public void setNama(String nama) { this.nama = nama; }

    public int getQty() { return qty; }
    public void setQty(int qty) { this.qty = qty; }

    public int getHargaBeli() { return hargaBeli; }
    public void setHargaBeli(int hargaBeli) { this.hargaBeli = hargaBeli; }

    public int getSubtotal() {
        return qty * hargaBeli;
    }
}

