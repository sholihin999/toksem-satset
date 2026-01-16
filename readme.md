# 🛒 Toksem Satset  
**Sistem Manajemen Toko Sembako Berbasis Web (Java Servlet & JSP)**

Toksem Satset adalah aplikasi web untuk mengelola operasional toko sembako yang dibangun menggunakan **Java Servlet, JSP, dan PostgreSQL**.  
Aplikasi ini mendukung **multi-role user (Admin & Kasir)** dengan autentikasi, session management, dan role-based access control.

Project ini dibuat untuk keperluan **praktikum / UAS Pemrograman Berorientasi Objek (PBO)** serta dapat digunakan sebagai **portofolio**.

---

## ✨ Fitur Aplikasi

### 🔐 Autentikasi & Keamanan
- Login & Logout (Servlet)
- Session management
- AuthFilter & RoleFilter
- Landing page bersifat public

### 👨‍💼 Fitur Admin
- Dashboard ringkasan:
  - Pendapatan
  - Transaksi
  - Stok menipis
  - Keuntungan
- Manajemen data:
  - Produk
  - Kategori
  - Supplier
- Transaksi pembelian:
  - Keranjang pembelian
  - Checkout pembelian
- Riwayat pembelian:
  - Filter tanggal & supplier
  - Detail pembelian
- Riwayat penjualan seluruh kasir
- Download laporan penjualan

### 🧑‍💻 Fitur Kasir
- Dashboard kasir
- Transaksi penjualan (POS):
  - Tambah produk ke keranjang
  - Hitung total otomatis
  - Input bayar & kembalian
- Cetak struk penjualan
- Riwayat penjualan kasir (filter tanggal)

### 🧾 Struk Penjualan
- Tampilan modern & print-friendly
- Barcode transaksi
- Siap cetak thermal / A4

---

## 🧱 Teknologi yang Digunakan

| Layer | Teknologi |
|-----|----------|
| Backend | Java Servlet (Jakarta EE) |
| Frontend | JSP, Bootstrap 5, Bootstrap Icons |
| Database | PostgreSQL |
| Server | Apache Tomcat 10 |
| Build Tool | Maven |
| IDE | NetBeans |

---

## 🗂️ Struktur Project

```

toksem_satset/
│
├── database/
│   ├── create_database.sql
│   ├── schema.sql
│   └── seed.sql
│
├── src/main/java/
│   ├── controller/
│   │   ├── AdminDashboardServlet.java
│   │   ├── AdminProdukServlet.java
│   │   ├── AdminKategoriServlet.java
│   │   ├── AdminSupplierServlet.java
│   │   ├── AdminPembelianServlet.java
│   │   ├── AdminPembelianRiwayatServlet.java
│   │   ├── AdminPembelianDetailServlet.java
│   │   ├── AdminRiwayatPenjualanServlet.java
│   │   ├── AdminLaporanDownloadServlet.java
│   │   ├── KasirDashboardServlet.java
│   │   ├── KasirPenjualanServlet.java
│   │   ├── KasirRiwayatPenjualanServlet.java
│   │   ├── KasirStrukServlet.java
│   │   ├── LoginServlet.java
│   │   └── LogoutServlet.java
│   │
│   ├── dao/
│   ├── model/
│   ├── filter/
│   │   ├── AuthFilter.java
│   │   └── RoleFilter.java
│   └── util/
│       └── DBConnection.java
│
├── src/main/webapp/
│   ├── admin/
│   ├── kasir/
│   ├── includes/
│   ├── css/
│   ├── images/
│   ├── login.jsp
│   └── index.jsp   (Landing Page)
│
├── pom.xml
└── README.md

```

---

## 🔐 Alur Akses Aplikasi

```

Landing Page
↓
Login
↓
Admin / Kasir
↓
Logout
↓
Landing Page

```

---

## ⚙️ Cara Menjalankan Project

### 1️⃣ Persiapan
- Java JDK 17+
- Apache Tomcat 10+
- PostgreSQL
- IDE (NetBeans / IntelliJ)

### 2️⃣ Setup Database
1. Buat database PostgreSQL
2. Jalankan file:
   - `database/create_database.sql`
   - `database/schema.sql`
   - `database/seed.sql`
3. Sesuaikan konfigurasi di:
```

src/main/java/util/DBConnection.java

```

### 3️⃣ Jalankan Aplikasi
1. Build project dengan Maven
2. Deploy ke Tomcat
3. Akses melalui browser:
```

[http://localhost:8080/toksem_satset/](http://localhost:8080/toksem_satset/)

```

## 👨‍💻 Author
**Muhamad Solihin**  
**Ariq Jamhari**  
**Eshi Aulia**  
**Eka Vitaloka**  
**Ananda Tasya**  
Mahasiswa Teknik Informatika 

---

## 📜 Lisensi
Project ini dibuat untuk keperluan **akademik & pembelajaran**.  
Bebas dikembangkan kembali sesuai kebutuhan.
