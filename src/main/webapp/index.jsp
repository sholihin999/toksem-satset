<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toksem Satset | Aplikasi Kasir & Toko Sembako</title>

    <!-- Bootswatch Flatly (Bootstrap 5) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.3/dist/flatly/bootstrap.min.css">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        :root{
            --satset-navy:#2C3E50;
            --satset-blue:#3498DB;
            --satset-soft:#f8f9fa;
        }

        html { scroll-behavior: smooth; }
        body { background: var(--satset-soft); }
        section { scroll-margin-top: 90px; }

        .satset-navbar{
            background: rgba(255,255,255,.92);
            backdrop-filter: blur(8px);
        }

        .hero{
            background: radial-gradient(1200px circle at 10% 10%, rgba(52,152,219,.25), transparent 60%),
                        linear-gradient(135deg, var(--satset-navy), #1f2d3a);
            color:#fff;
            padding: 6rem 0 4.5rem;
            position: relative;
            overflow: hidden;
        }
        .hero-card{
            background: rgba(255,255,255,.06);
            border: 1px solid rgba(255,255,255,.16);
            border-radius: 18px;
        }
        .hero .btn-primary{
            background: var(--satset-blue);
            border-color: var(--satset-blue);
        }
        .hero .btn-outline-light{ border-color: rgba(255,255,255,.6); }

        .section{ padding: 4.5rem 0; }
        .section-title{ letter-spacing: -0.5px; }

        .feature-card{
            border: 1px solid rgba(0,0,0,.06);
            border-radius: 16px;
            transition: transform .15s ease, box-shadow .15s ease;
        }
        .feature-card:hover{
            transform: translateY(-2px);
            box-shadow: 0 12px 30px rgba(0,0,0,.08);
        }
        .icon-pill{
            width: 44px; height: 44px;
            border-radius: 14px;
            display:flex; align-items:center; justify-content:center;
            background: rgba(52,152,219,.12);
            color: var(--satset-blue);
        }

        /* TEAM CARD */
        .team-card{
            border: 1px solid rgba(0,0,0,.06);
            border-radius: 16px;
        }
        .avatar{
            width: 44px; height: 44px;
            border-radius: 14px;
            display:flex; align-items:center; justify-content:center;
            background: rgba(44,62,80,.08);
            color: var(--satset-navy);
        }

        .gallery-card{
            border-radius: 18px;
            overflow: hidden;
            border: 1px solid rgba(0,0,0,.06);
        }
        .gallery-thumb{
            width:100%;
            aspect-ratio: 16/10;
            object-fit: cover;
            background: #e9ecef;
        }

        .footer{
            background: var(--satset-navy);
            color: #dfe6ee;
            padding: 2.2rem 0;
        }

        .nav-link.active{
            font-weight: 700;
            color: var(--satset-blue) !important;
        }
    </style>
</head>

<body>

<!-- NAVBAR (Fixed) -->
<nav class="navbar navbar-expand-lg satset-navbar fixed-top border-bottom">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center gap-2" href="#home">
            <img
                src="<%= request.getContextPath()%>/images/logo-toksem.png"
                alt="Logo Toksem Satset"
                style="height:48px; width:auto;"
            >
            <div class="lh-1">
                <div class="fw-bold">Manajemen Toko Sembako Satset</div>
            </div>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navSatset">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navSatset">
            <ul class="navbar-nav ms-auto align-items-lg-center gap-lg-2">
                <li class="nav-item"><a class="nav-link" href="#home"><i class="bi bi-house"></i> Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#about"><i class="bi bi-info-circle"></i> About</a></li>
                <li class="nav-item"><a class="nav-link" href="#gallery"><i class="bi bi-images"></i> Gallery</a></li>

                <li class="nav-item ms-lg-2">
                    <a class="btn btn-outline-primary btn-sm" href="<%=ctx%>/login">
                        <i class="bi bi-box-arrow-in-right"></i> Login
                    </a>
                </li>
                <li class="nav-item">
                    <a class="btn btn-primary btn-sm" href="<%=ctx%>/kasir/penjualan">
                        <i class="bi bi-cart-check"></i> Mulai Transaksi
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- HERO / HOME -->
<header id="home" class="hero">
    <div class="container">
        <div class="row align-items-center g-4">
            <div class="col-lg-7">

                <h1 class="mt-5 display-5 fw-bold mb-3 section-title">
                    Kelola toko sembako dengan <span style="color:var(--satset-blue)">satset</span>, cepat, dan rapi.
                </h1>
                <p class="lead text-white-50 mt-5 mb-5">
                    Aplikasi manajemen toko sembako berbasis web untuk mengelola produk, transaksi, dan laporan keuangan dengan UI responsif dan alur kerja yang jelas.
                </p>

                <div class="d-flex flex-wrap gap-2 mt-5 mb-5">
                    <a class="btn btn-primary" href="<%=ctx%>/login">
                        <i class="bi bi-shield-lock"></i> Masuk ke Sistem
                    </a>
                    <a class="btn btn-outline-light" href="#about">
                        <i class="bi bi-arrow-down"></i> About 
                    </a>
                </div>

                <div class="row g-3 mt-4">
                    <div class="col-md-4">
                        <div class="p-3 hero-card">
                            <div class="fw-semibold"><i class="bi bi-speedometer2"></i> Cepat</div>
                            <div class="text-white-50 small">Transaksi kasir cepat ringkas</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="p-3 hero-card">
                            <div class="fw-semibold"><i class="bi bi-diagram-3"></i> Terstruktur</div>
                            <div class="text-white-50 small">Data dikelola dengan terstruktur.</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="p-3 hero-card">
                            <div class="fw-semibold"><i class="bi bi-phone"></i> Responsif</div>
                            <div class="text-white-50 small">Nyaman di desktop & mobile.</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="card shadow-lg border-0" style="border-radius: 20px;">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-center justify-content-between mb-3">
                            <div class="fw-bold">Ringkasan Fitur</div>
                            <span class="badge bg-success">Ready</span>
                        </div>

                        <div class="d-grid gap-2">
                            <div class="d-flex gap-2">
                                <div class="icon-pill"><i class="bi bi-person-gear"></i></div>
                                <div>
                                    <div class="fw-semibold">Role Admin & Kasir</div>
                                    <div class="text-muted small">Akses sesuai peran untuk keamanan.</div>
                                </div>
                            </div>

                            <div class="d-flex gap-2">
                                <div class="icon-pill"><i class="bi bi-box-seam"></i></div>
                                <div>
                                    <div class="fw-semibold">Produk & Stok</div>
                                    <div class="text-muted small">Pantau stok menipis dan kelola data.</div>
                                </div>
                            </div>

                            <div class="d-flex gap-2">
                                <div class="icon-pill"><i class="bi bi-receipt"></i></div>
                                <div>
                                    <div class="fw-semibold">Pembelian & Penjualan</div>
                                    <div class="text-muted small">Keranjang + checkout + struk transaksi.</div>
                                </div>
                            </div>

                            <hr class="my-3">

                            <div class="d-flex gap-2">
                                <a class="btn btn-outline-primary w-100" href="#gallery">
                                    <i class="bi bi-images"></i> Lihat Gallery
                                </a>
                                <a class="btn btn-primary w-100" href="<%=ctx%>/kasir/penjualan">
                                    <i class="bi bi-cart-check"></i> Mulai
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- ABOUT -->
<!-- ABOUT -->
<section id="about" class="section">
    <div class="container">
        <!-- Row 1: About kiri + fitur kanan -->
        <div class="row g-4 align-items-start">
            <!-- LEFT -->
            <div class="col-lg-6">
                <h2 class="fw-bold section-title mt-3 mb-4">About Toksem Satset</h2>
                <p class="text-muted mb-4">
                    Toksem Satset adalah project aplikasi manajemen toko sembako berbasis web yang dibuat untuk membantu toko sembako agar mengoptimalkan
                    proses transaksi dan pengelolaan stok toko sembako secara terstruktur, cepat, dan efisien.
                </p>

                <div class="d-flex gap-2 mt-3">
                    <a class="btn btn-outline-primary" href="<%=ctx%>/login">
                        <i class="bi bi-box-arrow-in-right"></i> Login Sekarang
                    </a>
                    <a class="btn btn-outline-secondary" href="#gallery">
                        <i class="bi bi-images"></i> Lihat Gallery
                    </a>
                </div>
            </div>

            <!-- RIGHT -->
            <div class="col-lg-6">
                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="card feature-card h-100">
                            <div class="card-body p-4">
                                <div class="d-flex gap-3">
                                    <div class="icon-pill"><i class="bi bi-shield-check"></i></div>
                                    <div>
                                        <div class="fw-bold">Aman & Terstruktur</div>
                                        <div class="text-muted small">Akses dibedakan berdasarkan role admin dan kasir.</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card feature-card h-100">
                            <div class="card-body p-4">
                                <div class="d-flex gap-3">
                                    <div class="icon-pill"><i class="bi bi-layout-sidebar"></i></div>
                                    <div>
                                        <div class="fw-bold">UI Konsisten</div>
                                        <div class="text-muted small">Sidebar + topbar konsisten & responsif.</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card feature-card h-100">
                            <div class="card-body p-4">
                                <div class="d-flex gap-3">
                                    <div class="icon-pill"><i class="bi bi-lightning-charge"></i></div>
                                    <div>
                                        <div class="fw-bold">Cepat untuk Kasir</div>
                                        <div class="text-muted small">Keranjang, validasi stok, checkout ringkas.</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card feature-card h-100">
                            <div class="card-body p-4">
                                <div class="d-flex gap-3">
                                    <div class="icon-pill"><i class="bi bi-journal-text"></i></div>
                                    <div>
                                        <div class="fw-bold">Riwayat & Detail</div>
                                        <div class="text-muted small">Riwayat pembelian/penjualan disertai detail & struk.</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div><!-- row -->
            </div><!-- col -->
        </div><!-- row -->

        <!-- Row 2: Tim Pengembang FULL WIDTH -->
        <div class="row g-4 mt-2">
            <div class="col-12 border-primary">
                <div class="card team-card shadow-sm">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-center justify-content-between flex-wrap gap-2 mb-3">
                            <div class="fw-bold">
                                <i class="bi bi-people"></i> Tim Pengembang
                            </div>
                            <span class="badge bg-primary">5 Orang</span>
                        </div>

                        <div class="row g-3">
                            <div class="col-md-6 col-lg-4">
                                <div class="d-flex align-items-center gap-3 p-3 border rounded-3 bg-light h-100">
                                    <div class="avatar"><i class="bi bi-person"></i></div>
                                    <div class="lh-1">
                                        <div class="fw-semibold">Muhamad Solihin</div>
                                        <small class="text-muted">Frontend & Backend</small>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6 col-lg-4">
                                <div class="d-flex align-items-center gap-3 p-3 border rounded-3 bg-light h-100">
                                    <div class="avatar"><i class="bi bi-person"></i></div>
                                    <div class="lh-1">
                                        <div class="fw-semibold">Ariq Jamhari</div>
                                        <small class="text-muted">Frontend</small>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6 col-lg-4">
                                <div class="d-flex align-items-center gap-3 p-3 border rounded-3 bg-light h-100">
                                    <div class="avatar"><i class="bi bi-person"></i></div>
                                    <div class="lh-1">
                                        <div class="fw-semibold">Eshi Aulia</div>
                                        <small class="text-muted">Backend</small>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6 col-lg-4">
                                <div class="d-flex align-items-center gap-3 p-3 border rounded-3 bg-light h-100">
                                    <div class="avatar"><i class="bi bi-person"></i></div>
                                    <div class="lh-1">
                                        <div class="fw-semibold">Eka Vitaloka</div>
                                        <small class="text-muted">Database / PostgreSQL</small>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6 col-lg-4">
                                <div class="d-flex align-items-center gap-3 p-3 border rounded-3 bg-light h-100">
                                    <div class="avatar"><i class="bi bi-person"></i></div>
                                    <div class="lh-1">
                                        <div class="fw-semibold">Ananda Tasya</div>
                                        <small class="text-muted">Database / PostgreSQL</small>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6 col-lg-4">
                                <div class="d-flex align-items-center gap-3 p-3 border rounded-3 bg-light h-100">
                                    <div class="avatar"><i class="bi bi-person"></i></div>
                                    <div class="lh-1">
                                        <div class="fw-semibold">Kelompok 25</div>
                                        <small class="text-muted">Solid Solid Solid</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</section>


<!-- GALLERY -->
<section id="gallery" class="section bg-white border-top">
    <div class="container">
        <div class="d-flex flex-wrap align-items-end justify-content-between gap-2 mb-4 text-center">
            <div>
                <h2 class="fw-bold section-title mb-1 ">Gallery</h2>
            </div>
        </div>

        <div class="row g-3">
            <div class="col-md-6">
                <div class="card gallery-card shadow-sm h-100">
                    <img class="gallery-thumb" src="<%=ctx%>/images/erd.png" alt="ERD Database">
                    <div class="card-body">
                        <div class="fw-bold"><i class="bi bi-diagram-3"></i> ERD Database</div>
                        <div class="text-muted small">Gambar ERD relasi tabel Toksem Satset.</div>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card gallery-card shadow-sm h-100">
                    <img class="gallery-thumb" src="<%=ctx%>/images/kerkom.png" alt="Dokumentasi Kelompok">
                    <div class="card-body">
                        <div class="fw-bold"><i class="bi bi-people"></i> Dokumentasi Kelompok</div>
                        <div class="text-muted small">Foto kerja kelompok / momen pengembangan.</div>
                    </div>
                </div>
            </div>
        </div>
                    <!-- DATABASE STRUCTURE -->
<div class="row g-4 mt-4">
    <div class="col-12">
        <div class="card team-card shadow-sm">
            <div class="card-body p-4">

                <!-- Header -->
                <div class="d-flex align-items-center justify-content-between flex-wrap gap-2 mb-3">
                    <div class="fw-bold">
                        <i class="bi bi-diagram-3"></i> Struktur Database Toksem Satset
                    </div>
                    <span class="badge bg-primary">PostgreSQL</span>
                </div>

                <p class="text-muted mb-4">
                    Database Toksem Satset dirancang secara relasional untuk mendukung
                    transaksi penjualan, pembelian, manajemen stok, serta kontrol user berbasis role.
                </p>

                <!-- GRID TABLE CARD -->
                <div class="row g-3">

                    <!-- USERS -->
                    <div class="col-md-6 col-lg-4">
                        <div class="d-flex align-items-start gap-3 p-3 border rounded-3 bg-light h-100">
                            <div class="avatar"><i class="bi bi-people"></i></div>
                            <div>
                                <div class="fw-semibold">Users</div>
                                <small class="text-muted">
                                    Menyimpan data akun admin & kasir, termasuk role dan autentikasi login.
                                </small>
                            </div>
                        </div>
                    </div>

                    <!-- PRODUK -->
                    <div class="col-md-6 col-lg-4">
                        <div class="d-flex align-items-start gap-3 p-3 border rounded-3 bg-light h-100">
                            <div class="avatar"><i class="bi bi-box-seam"></i></div>
                            <div>
                                <div class="fw-semibold">Produk</div>
                                <small class="text-muted">
                                    Data produk sembako, harga jual, stok, dan relasi ke kategori.
                                </small>
                            </div>
                        </div>
                    </div>

                    <!-- KATEGORI -->
                    <div class="col-md-6 col-lg-4">
                        <div class="d-flex align-items-start gap-3 p-3 border rounded-3 bg-light h-100">
                            <div class="avatar"><i class="bi bi-tags"></i></div>
                            <div>
                                <div class="fw-semibold">Kategori</div>
                                <small class="text-muted">
                                    Klasifikasi produk agar pengelolaan stok lebih terstruktur.
                                </small>
                            </div>
                        </div>
                    </div>

                    <!-- SUPPLIER -->
                    <div class="col-md-6 col-lg-4">
                        <div class="d-flex align-items-start gap-3 p-3 border rounded-3 bg-light h-100">
                            <div class="avatar"><i class="bi bi-truck"></i></div>
                            <div>
                                <div class="fw-semibold">Supplier</div>
                                <small class="text-muted">
                                    Menyimpan data pemasok barang untuk proses pembelian.
                                </small>
                            </div>
                        </div>
                    </div>

                    <!-- PENJUALAN -->
                    <div class="col-md-6 col-lg-4">
                        <div class="d-flex align-items-start gap-3 p-3 border rounded-3 bg-light h-100">
                            <div class="avatar"><i class="bi bi-receipt"></i></div>
                            <div>
                                <div class="fw-semibold">Penjualan</div>
                                <small class="text-muted">
                                    Header transaksi penjualan yang dilakukan oleh kasir.
                                </small>
                            </div>
                        </div>
                    </div>

                    <!-- DETAIL PENJUALAN -->
                    <div class="col-md-6 col-lg-4">
                        <div class="d-flex align-items-start gap-3 p-3 border rounded-3 bg-light h-100">
                            <div class="avatar"><i class="bi bi-list-check"></i></div>
                            <div>
                                <div class="fw-semibold">Detail Penjualan</div>
                                <small class="text-muted">
                                    Item produk per transaksi: qty, harga, subtotal.
                                </small>
                            </div>
                        </div>
                    </div>

                    <!-- PEMBELIAN -->
                    <div class="col-md-6 col-lg-4">
                        <div class="d-flex align-items-start gap-3 p-3 border rounded-3 bg-light h-100">
                            <div class="avatar"><i class="bi bi-bag-plus"></i></div>
                            <div>
                                <div class="fw-semibold">Pembelian</div>
                                <small class="text-muted">
                                    Data pembelian barang dari supplier oleh admin.
                                </small>
                            </div>
                        </div>
                    </div>

                    <!-- DETAIL PEMBELIAN -->
                    <div class="col-md-6 col-lg-4">
                        <div class="d-flex align-items-start gap-3 p-3 border rounded-3 bg-light h-100">
                            <div class="avatar"><i class="bi bi-clipboard-data"></i></div>
                            <div>
                                <div class="fw-semibold">Detail Pembelian</div>
                                <small class="text-muted">
                                    Rincian item pembelian: qty, harga beli, subtotal.
                                </small>
                            </div>
                        </div>
                    </div>
                    <!-- DETAIL Lain -->
                    <div class="col-md-6 col-lg-4">
                        <div class="d-flex align-items-start gap-3 p-3 border rounded-3 bg-light h-100">
                            <div class="avatar"><i class="bi bi-database"></i></div>
                            <div>
                                <div class="fw-semibold">Dibuat dengan Postgre sql</div>
                                <small class="text-muted">
                                    Database aman dan rapih
                                </small>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- NOTE -->
                <div class="alert alert-info mt-4 mb-0">
                    <i class="bi bi-info-circle"></i>
                    Relasi antar tabel divisualisasikan dalam ERD untuk menjaga konsistensi data
                    dan integritas transaksi.
                </div>

            </div>
        </div>
    </div>
</div>

    </div>
                    
</section>

<!-- FOOTER -->
<footer class="footer">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-between gap-2">
            <div>
                <div class="fw-bold">Manajemen Toko Sembako Satset</div>
            </div>
            <div class="small text-white-50">
                © <%= java.time.Year.now() %> Tim 25 — All rights reserved.
            </div>
        </div>
    </div>
</footer>

<button id="btnTop" class="btn btn-primary rounded-circle shadow"
        style="position:fixed; right:16px; bottom:16px; width:46px; height:46px; display:none;">
    <i class="bi bi-arrow-up"></i>
</button>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.querySelectorAll('a[href^="#"]').forEach(a => {
        a.addEventListener('click', (e) => {
            const id = a.getAttribute('href');
            const el = document.querySelector(id);
            if (!el) return;

            e.preventDefault();
            el.scrollIntoView({ behavior: 'smooth' });

            const nav = document.getElementById('navSatset');
            if (nav && nav.classList.contains('show')) {
                new bootstrap.Collapse(nav).hide();
            }
        });
    });

    const sections = ['#home','#about','#gallery'].map(s => document.querySelector(s));
    const navLinks = Array.from(document.querySelectorAll('.navbar .nav-link'))
        .filter(l => l.getAttribute('href') && l.getAttribute('href').startsWith('#'));

    const obs = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (!entry.isIntersecting) return;
            const id = '#' + entry.target.id;
            navLinks.forEach(l => l.classList.toggle('active', l.getAttribute('href') === id));
        });
    }, { root: null, threshold: 0.35 });

    sections.forEach(s => s && obs.observe(s));

    const btnTop = document.getElementById('btnTop');
    window.addEventListener('scroll', () => {
        btnTop.style.display = (window.scrollY > 500) ? 'inline-flex' : 'none';
    });
    btnTop.addEventListener('click', () => window.scrollTo({ top: 0, behavior: 'smooth' }));
</script>

</body>
</html>
