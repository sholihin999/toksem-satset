-- 1 Mengisinya
INSERT INTO roles (nama) VALUES
('ADMIN'),
('KASIR');

-- 2 Mengisinya 
INSERT INTO users (username, password, nama, role_id)
VALUES
('admin', 'admin123', 'Pemilik Toko', 1),
('kasir1', 'kasir123', 'Kasir Ariq', 2),
('kasir2', 'kasir456', 'Kasir Ihin', 2),
('kasir3', 'kasir789', 'Kasir Eka', 2),
('kasir4', 'kasir321', 'Kasir Eshi', 2),
('kasir5', 'kasir654', 'Kasir Tasya', 2);

-- 3 Mengisinya
INSERT INTO kategori (nama) VALUES
('Beras'),
('Minyak'),
('Gula'),
('Mie Instan'),
('Telur'),
('Susu');

-- 4 Mengisinya
INSERT INTO produk (kode, nama, kategori_id, satuan, harga, stok) VALUES
('BR001', 'Beras Ramos 5 Kg', 1, 'kg', 65000, 15),
('BR002', 'Beras Ramos 10 Kg', 1, 'kg', 125000, 10),
('BR003', 'Beras Setra Ramos 5 Kg', 1, 'kg', 68000, 15),
('BR004', 'Beras Pandan Wangi 5 Kg', 1, 'kg', 75000, 10),
('BR005', 'Beras IR 64 5 Kg', 1, 'kg', 60000, 20),
('MN001', 'Minyak Goreng Bimoli 1 L', 2, 'liter', 17000, 25),
('MN002', 'Minyak Goreng Sania 2 L', 2, 'liter', 34000, 12),
('MN003', 'Minyak Goreng Fortune 1 L', 2, 'liter', 16500, 18),
('MN004', 'Minyak Goreng Tropical 2 L', 2, 'liter', 33000, 10),
('MN005', 'Minyak Goreng Filma 1 L', 2, 'liter', 16800, 22),
('GL001', 'Gula Pasir Gulaku 1 Kg', 3, 'kg', 15500, 30),
('GL002', 'Gula Pasir Rose Brand 1 Kg', 3, 'kg', 15000, 28),
('GL003', 'Gula Kristal Putih 1 Kg', 3, 'kg', 14500, 35),
('GL004', 'Gula Merah Aren 500 gr', 3, 'pcs', 12000, 20),
('GL005', 'Gula Cair 500 ml', 3, 'botol', 14000, 15),
('MI001', 'Indomie Goreng', 4, 'pcs', 3500, 100),
('MI002', 'Indomie Soto', 4, 'pcs', 3400, 90),
('MI003', 'Mie Sedaap Goreng', 4, 'pcs', 3300, 85),
('MI004', 'Mie Sedaap Soto', 4, 'pcs', 3200, 80),
('MI005', 'Sarimi Ayam Bawang', 4, 'pcs', 3000, 75),
('TL001', 'Telur Ayam Negeri 1 Kg', 5, 'kg', 28000, 20),
('TL002', 'Telur Ayam Kampung 1 Kg', 5, 'kg', 42000, 10),
('TL003', 'Telur Ayam Negeri 1/2 Kg', 5, 'kg', 15000, 25),
('TL004', 'Telur Puyuh 1 Pack', 5, 'pack', 10000, 30),
('TL005', 'Telur Bebek 1 Kg', 5, 'kg', 38000, 8),
('SS001', 'Susu Indomilk UHT 1 L', 6, 'liter', 18000, 20),
('SS002', 'Susu Ultra Milk Coklat 1 L', 6, 'liter', 19000, 18),
('SS003', 'Susu Frisian Flag 800 ml', 6, 'ml', 16000, 22),
('SS004', 'Susu Dancow Bubuk 400 gr', 6, 'pcs', 42000, 12),
('SS005', 'Susu Milo Kotak 200 ml', 6, 'pcs', 7500, 40);

-- 5 Mengisinya
INSERT INTO supplier (nama, no_hp, alamat)
VALUES
('PT Sumber Pangan Jaya', '081234567890', 'Jakarta'),
('CV Berkah Sembako', '082233445566', 'Depok'),
('UD Makmur Sejahtera', '083344556677', 'Bogor');