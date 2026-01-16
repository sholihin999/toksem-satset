/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class PembelianSummary {
    private int totalTransaksi;
    private int totalPengeluaran;
    private int totalItem;

    public PembelianSummary(int totalTransaksi, int totalPengeluaran, int totalItem) {
        this.totalTransaksi = totalTransaksi;
        this.totalPengeluaran = totalPengeluaran;
        this.totalItem = totalItem;
    }

    public int getTotalTransaksi() { return totalTransaksi; }
    public int getTotalPengeluaran() { return totalPengeluaran; }
    public int getTotalItem() { return totalItem; }
}

