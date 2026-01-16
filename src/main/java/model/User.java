/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class User {
    private int id;
    private String username;
    private String nama;
    private String role;   // "ADMIN" / "KASIR"
    private boolean aktif;

    public User() {}

    public User(int id, String username, String nama, String role, boolean aktif) {
        this.id = id;
        this.username = username;
        this.nama = nama;
        this.role = role;
        this.aktif = aktif;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getNama() { return nama; }
    public void setNama(String nama) { this.nama = nama; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public boolean isAktif() { return aktif; }
    public void setAktif(boolean aktif) { this.aktif = aktif; }
}

