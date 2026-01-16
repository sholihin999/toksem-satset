/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class DashboardSummary {
    private int totalTransaksi;
    private int totalPendapatan;
    private int totalItem; // opsional

    public DashboardSummary(int totalTransaksi, int totalPendapatan, int totalItem) {
        this.totalTransaksi = totalTransaksi;
        this.totalPendapatan = totalPendapatan;
        this.totalItem = totalItem;
    }

    public int getTotalTransaksi() { return totalTransaksi; }
    public int getTotalPendapatan() { return totalPendapatan; }
    public int getTotalItem() { return totalItem; }
}

