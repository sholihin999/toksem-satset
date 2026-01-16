-- 1. Membuat Tabel Role (ADMIN & KASIR)
CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(20) UNIQUE NOT NULL
);

-- 2. Membuat Tabel Users
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    nama VARCHAR(100) NOT NULL,
    role_id INT NOT NULL,
    aktif BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- 3. Membuat Tabel Kategori Produk
CREATE TABLE kategori (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(100) NOT NULL
);

-- 4. Membuat Tabel Produk
CREATE TABLE produk (
    id SERIAL PRIMARY KEY,
    kode VARCHAR(20) UNIQUE NOT NULL,
    nama VARCHAR(100) NOT NULL,
    kategori_id INT NOT NULL,
    satuan VARCHAR(20),
    harga INT NOT NULL,
    stok INT DEFAULT 0,
    FOREIGN KEY (kategori_id) REFERENCES kategori(id)
);

-- 5. Membuat Tabel Supplier
CREATE TABLE supplier (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    no_hp VARCHAR(20),
    alamat TEXT
);

-- 6. Membuat Tabel Penjualan
CREATE TABLE penjualan (
    id SERIAL PRIMARY KEY,
    tanggal TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    kasir_id INT NOT NULL,
    total INT NOT NULL,
    bayar INT NOT NULL,
    kembalian INT NOT NULL,
    nama_pembeli VARCHAR(100),
    FOREIGN KEY (kasir_id) REFERENCES users(id)
);

-- 7. Membuat Tabel Detail Penjualan
CREATE TABLE detail_penjualan (
    id SERIAL PRIMARY KEY,
    penjualan_id INT NOT NULL,
    produk_id INT NOT NULL,
    qty INT NOT NULL,
    harga INT NOT NULL,
    subtotal INT NOT NULL,
    FOREIGN KEY (penjualan_id) REFERENCES penjualan(id),
    FOREIGN KEY (produk_id) REFERENCES produk(id)
);

-- 8. Membuat Tabel Pembelian
CREATE TABLE pembelian (
    id SERIAL PRIMARY KEY,
    tanggal TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    supplier_id INT NOT NULL,
    admin_id INT NOT NULL,
    total INT NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES supplier(id),
    FOREIGN KEY (admin_id) REFERENCES users(id)
);

-- 9. Membuat Tabel Detail Pembelian
CREATE TABLE detail_pembelian (
    id SERIAL PRIMARY KEY,
    pembelian_id INT NOT NULL,
    produk_id INT NOT NULL,
    qty INT NOT NULL,
    harga_beli INT NOT NULL,
    subtotal INT NOT NULL,
    FOREIGN KEY (pembelian_id) REFERENCES pembelian(id),
    FOREIGN KEY (produk_id) REFERENCES produk(id)
);

-- Membuat Index agar pencarian lebih cepat
CREATE INDEX idx_produk_nama ON produk(nama);
CREATE INDEX idx_produk_kode ON produk(kode);
CREATE INDEX idx_produk_kategori ON produk(kategori_id);
CREATE INDEX idx_produk_stok ON produk(stok);
CREATE INDEX idx_penjualan_tanggal ON penjualan(tanggal);
CREATE INDEX idx_pembelian_tanggal ON pembelian(tanggal);