/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Produk {
    private int id;
    private String kode;
    private String nama;
    private int kategoriId;
    private String kategoriNama; // untuk join tampil list
    private String satuan;
    private int harga;
    private int stok;

    public Produk() {}

    public Produk(int id, String kode, String nama, int kategoriId, String kategoriNama,
                  String satuan, int harga, int stok) {
        this.id = id;
        this.kode = kode;
        this.nama = nama;
        this.kategoriId = kategoriId;
        this.kategoriNama = kategoriNama;
        this.satuan = satuan;
        this.harga = harga;
        this.stok = stok;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getKode() { return kode; }
    public void setKode(String kode) { this.kode = kode; }

    public String getNama() { return nama; }
    public void setNama(String nama) { this.nama = nama; }

    public int getKategoriId() { return kategoriId; }
    public void setKategoriId(int kategoriId) { this.kategoriId = kategoriId; }

    public String getKategoriNama() { return kategoriNama; }
    public void setKategoriNama(String kategoriNama) { this.kategoriNama = kategoriNama; }

    public String getSatuan() { return satuan; }
    public void setSatuan(String satuan) { this.satuan = satuan; }

    public int getHarga() { return harga; }
    public void setHarga(int harga) { this.harga = harga; }

    public int getStok() { return stok; }
    public void setStok(int stok) { this.stok = stok; }
}
