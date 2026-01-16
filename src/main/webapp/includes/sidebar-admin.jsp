<%-- 
    Document   : sidebar-admin
    Created on : Dec 30, 2025
    Author     : muham
--%>

<%
    String active = (String) request.getAttribute("activeMenu");
    if (active == null) active = "dashboard";
    String cp = request.getContextPath();

    String aDashboard = "dashboard".equals(active) ? "active" : "";
    String aProduk    = "produk".equals(active) ? "active" : "";
    String aKategori  = "kategori".equals(active) ? "active" : "";
    String aSupplier  = "supplier".equals(active) ? "active" : "";
    String aPembelian = "pembelian".equals(active) ? "active" : "";
    String aRiwayat   = "riwayat".equals(active) ? "active" : "";
    String aLaporan   = "laporan".equals(active) ? "active" : "";
    String aUser      = "user".equals(active) ? "active" : "";
%>

<!-- Sidebar (desktop) -->
<aside class="app-sidebar d-none d-lg-flex flex-column bg-light border-end">
    <div class="px-3 py-3 border-bottom">
        <div class="d-flex align-items-center gap-2">
            <div class="brand-badge">A</div>
            <div>
                <div class="fw-bold lh-1">Toko Sembako Satset</div>
                <small class="text-muted">Admin Panel</small>
            </div>
        </div>
    </div>

    <nav class="p-2">
        <div class="nav nav-pills flex-column gap-1">

            <a class="nav-link <%= aDashboard %>" href="<%= cp %>/admin/dashboard">
                <i class="bi bi-speedometer2 me-2"></i> Dashboard
            </a>

            <a class="nav-link <%= aProduk %>" href="<%= cp %>/admin/produk">
                <i class="bi bi-box-seam me-2"></i> Produk
            </a>

            <a class="nav-link <%= aKategori %>" href="<%= cp %>/admin/kategori">
                <i class="bi bi-tags me-2"></i> Kategori
            </a>

            <a class="nav-link <%= aSupplier %>" href="<%= cp %>/admin/supplier">
                <i class="bi bi-truck me-2"></i> Supplier
            </a>

            <a class="nav-link <%= aPembelian %>" href="<%= cp %>/admin/pembelian">
                <i class="bi bi-cart-plus me-2"></i> Pembelian
            </a>

            <!-- Riwayat -->
            <div class="mt-2 px-2 text-uppercase text-muted small fw-semibold">
                Riwayat
            </div>

            <a class="nav-link <%= aPembelian %>" href="<%= cp %>/admin/pembelian/riwayat">
                <i class="bi bi-clock-history me-2"></i> Riwayat Pembelian
            </a>

            <a class="nav-link <%= aRiwayat %>" href="<%= cp %>/admin/penjualan/riwayat">
                <i class="bi bi-receipt me-2"></i> Riwayat Penjualan
            </a>

            <%-- Kalau nanti dipakai, tinggal aktifkan
            <a class="nav-link <%= aLaporan %>" href="<%= cp %>/admin/laporan">
                <i class="bi bi-file-earmark-text me-2"></i> Laporan
            </a>

            <a class="nav-link <%= aUser %>" href="<%= cp %>/admin/users">
                <i class="bi bi-people me-2"></i> User
            </a>
            --%>

        </div>
    </nav>

    <div class="mt-auto p-2">
        <a class="btn btn-outline-danger w-100" href="<%= cp %>/logout">
            <i class="bi bi-box-arrow-right me-2"></i> Logout
        </a>
    </div>
</aside>

<!-- Sidebar offcanvas (mobile) -->
<div class="offcanvas offcanvas-start" tabindex="-1" id="sidebarMobile" aria-labelledby="sidebarMobileLabel">
    <div class="offcanvas-header border-bottom">
        <div>
            <h5 class="offcanvas-title mb-0" id="sidebarMobileLabel">Toksem Satset</h5>
            <small class="text-muted">Admin Panel</small>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>

    <div class="offcanvas-body p-2">
        <nav class="d-grid gap-1">

            <a class="nav-link <%= aDashboard %>" href="<%= cp %>/admin/dashboard">
                <i class="bi bi-speedometer2 me-2"></i> Dashboard
            </a>

            <a class="nav-link <%= aProduk %>" href="<%= cp %>/admin/produk">
                <i class="bi bi-box-seam me-2"></i> Produk
            </a>

            <a class="nav-link <%= aKategori %>" href="<%= cp %>/admin/kategori">
                <i class="bi bi-tags me-2"></i> Kategori
            </a>

            <a class="nav-link <%= aSupplier %>" href="<%= cp %>/admin/supplier">
                <i class="bi bi-truck me-2"></i> Supplier
            </a>

            <a class="nav-link <%= aPembelian %>" href="<%= cp %>/admin/pembelian">
                <i class="bi bi-cart-plus me-2"></i> Pembelian
            </a>

            <hr class="my-2">

            <a class="nav-link <%= aRiwayat %>" href="<%= cp %>/admin/pembelian/riwayat">
                <i class="bi bi-clock-history me-2"></i> Riwayat Pembelian
            </a>

            <a class="nav-link <%= aRiwayat %>" href="<%= cp %>/admin/penjualan/riwayat">
                <i class="bi bi-receipt me-2"></i> Riwayat Penjualan
            </a>

            <div class="pt-2">
                <a class="btn btn-outline-danger w-100" href="<%= cp %>/logout">
                    <i class="bi bi-box-arrow-right me-2"></i> Logout
                </a>
            </div>

        </nav>
    </div>
</div>
