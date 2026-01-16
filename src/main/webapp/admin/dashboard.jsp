<%-- 
    Document   : admin dashboard
    Created on : Dec 28, 2025, 9:44:28 AM
    Author     : muham
--%>

<%@page import="java.util.List"%>
<%@page import="model.DashboardSummary"%>
<%@page import="model.PenjualanRow"%>
<%@page import="model.StokMenipisRow"%>
<%@page import="model.PembelianSummary"%>

<%@include file="/includes/format.jsp"%>
<%@include file="/includes/alert.jsp"%>

<%
    // Untuk topbar (judul halaman di header)
    request.setAttribute("pageTitle", "Dashboard Admin");
    request.setAttribute("activeMenu", "dashboard");

    DashboardSummary summary = (DashboardSummary) request.getAttribute("summary");
    List<PenjualanRow> terbaru = (List<PenjualanRow>) request.getAttribute("terbaru");
    List<StokMenipisRow> stokMenipis = (List<StokMenipisRow>) request.getAttribute("stokMenipis");

    String range = (String) request.getAttribute("range");
    if (range == null) range = "today";

    PembelianSummary pembelianSummary = (PembelianSummary) request.getAttribute("pembelianSummary");

    Integer totalKeuntungan = (Integer) request.getAttribute("totalKeuntungan");
    if (totalKeuntungan == null) totalKeuntungan = 0;
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <%@ include file="/includes/head.jsp" %>
</head>

<body>
<div class="app-shell">

    <%@ include file="/includes/sidebar-admin.jsp" %>

    <div class="app-content">
        <%@ include file="/includes/topbar.jsp" %>

        <main class="p-3 p-lg-4">

            <!-- Header page -->
            <div class="d-flex flex-wrap align-items-end justify-content-between gap-2 mb-3">
                <div>
                    <h3 class="mb-0">Dashboard Admin</h3>
                </div>
                <div class="d-flex gap-2">
                    <a class="btn btn-sm btn-outline-info" href="<%= request.getContextPath()%>/admin/produk">
                        <i class="bi bi-box-seam me-1"></i> Kelola Produk
                    </a>
                    <a class="btn btn-sm btn-outline-info" href="<%= request.getContextPath()%>/admin/pembelian">
                        <i class="bi bi-cart-plus me-1"></i> Pembelian
                    </a>
                </div>
            </div>

            <!-- Filter range -->
            <div class="card card-satset mb-3 bg-light border-info">
                <div class="card-body d-flex flex-wrap gap-2 align-items-center justify-content-between">
                    <div class="fw-semibold">
                        <i class="bi bi-bar-chart-line me-2"></i> Laporan Penjualan
                    </div>

                    <div class="d-flex flex-wrap gap-2">
                        <div class="btn-group" role="group" aria-label="Filter range">
                            <a class="btn btn-sm <%= "today".equals(range) ? "btn-info" : "btn-outline-info"%>"
                               href="<%= request.getContextPath()%>/admin/dashboard?range=today">Hari ini</a>

                            <a class="btn btn-sm <%= "week".equals(range) ? "btn-info" : "btn-outline-info"%>"
                               href="<%= request.getContextPath()%>/admin/dashboard?range=week">7 hari</a>

                            <a class="btn btn-sm <%= "month".equals(range) ? "btn-info" : "btn-outline-info"%>"
                               href="<%= request.getContextPath()%>/admin/dashboard?range=month">Bulan ini</a>

                            <a class="btn btn-sm <%= "year".equals(range) ? "btn-info" : "btn-outline-info"%>"
                               href="<%= request.getContextPath()%>/admin/dashboard?range=year">Tahun ini</a>
                        </div>

                        <a class="btn btn-sm btn-outline-info"
                           href="<%= request.getContextPath()%>/admin/laporan/download?range=<%= range %>">
                            <i class="bi bi-download me-1"></i> Download
                        </a>
                    </div>
                </div>
            </div>

            <!-- Summary cards (Penjualan) -->
            <div class="row g-3 mb-3">
                <div class="col-md-4">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body d-flex align-items-center justify-content-between">
                            <div>
                                <div class="text-muted">Total Pendapatan</div>
                                <div class="fs-4 fw-bold">Rp <%= nf.format(summary != null ? summary.getTotalPendapatan() : 0) %></div>
                            </div>
                            <div class="fs-3 text-info">
                                <i class="bi bi-cash-coin"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body d-flex align-items-center justify-content-between">
                            <div>
                                <div class="text-muted">Total Transaksi Penjualan</div>
                                <div class="fs-4 fw-bold"><%= (summary != null ? summary.getTotalTransaksi() : 0) %></div>
                            </div>
                            <div class="fs-3 text-info">
                                <i class="bi bi-receipt"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body d-flex align-items-center justify-content-between">
                            <div>
                                <div class="text-muted">Total Item Terjual</div>
                                <div class="fs-4 fw-bold"><%= (summary != null ? summary.getTotalItem() : 0) %></div>
                            </div>
                            <div class="fs-3 text-info">
                                <i class="bi bi-box2"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Summary cards (Pembelian) -->
            <div class="row g-3 mb-3">
                <div class="col-md-4">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body d-flex align-items-center justify-content-between">
                            <div>
                                <div class="text-muted">Total Pengeluaran</div>
                                <div class="fs-4 fw-bold">Rp <%= nf.format(pembelianSummary != null ? pembelianSummary.getTotalPengeluaran() : 0) %></div>
                            </div>
                            <div class="fs-3 text-info">
                                <i class="bi bi-credit-card"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body d-flex align-items-center justify-content-between">
                            <div>
                                <div class="text-muted">Total Transaksi Pembelian</div>
                                <div class="fs-4 fw-bold"><%= (pembelianSummary != null ? pembelianSummary.getTotalTransaksi() : 0) %></div>
                            </div>
                            <div class="fs-3 text-info">
                                <i class="bi bi-cart-plus"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body d-flex align-items-center justify-content-between">
                            <div>
                                <div class="text-muted">Total Item Dibeli</div>
                                <div class="fs-4 fw-bold"><%= (pembelianSummary != null ? pembelianSummary.getTotalItem() : 0) %></div>
                            </div>
                            <div class="fs-3 text-info">
                                <i class="bi bi-bag-check"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Total keuntungan -->
            <div class="row g-3 mb-3">
                <div class="col-12">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body d-flex flex-wrap align-items-center justify-content-between gap-2">
                            <div>
                                <div class="text-muted">
                                    <i class="bi bi-graph-up-arrow me-1"></i> Total Keuntungan
                                </div>
                                <div class="fs-3 fw-bold">Rp <%= nf.format(totalKeuntungan) %></div>
                            </div>

                            <div class="text-end">
                                <span class="badge <%= (totalKeuntungan >= 0 ? "text-bg-success" : "text-bg-danger") %>">
                                    <%= (totalKeuntungan >= 0 ? "Profit" : "Rugi") %>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-3">
                <!-- Transaksi terbaru -->
                <div class="col-lg-8">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h5 class="mb-0">
                                    <i class="bi bi-clock-history me-1"></i> Transaksi Penjualan Terbaru
                                </h5>
                                <a class="btn btn-sm btn-outline-info" href="<%= request.getContextPath()%>/admin/penjualan/riwayat">
                                    <i class="bi bi-list-ul me-1"></i> Lihat Riwayat
                                </a>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-info">
                                    <tr>
                                        <th style="width:90px;">ID</th>
                                        <th style="width:220px;">Tanggal</th>
                                        <th style="width:140px;">Kasir</th>
                                        <th style="width:140px;">Total</th>
                                        <th style="width:160px;">Aksi</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <% if (terbaru != null && !terbaru.isEmpty()) { %>
                                        <% for (PenjualanRow r : terbaru) { %>
                                            <tr>
                                                <td>#<%= r.getId() %></td>
                                                <td><%= r.getTanggal() %></td>
                                                <td><%= r.getKasirNama() %></td>
                                                <td>Rp <%= nf.format(r.getTotal()) %></td>
                                                <td>
                                                    <a class="btn btn-sm btn-outline-info w-100"
                                                       href="<%= request.getContextPath()%>/kasir/penjualan/struk?id=<%= r.getId() %>">
                                                        <i class="bi bi-receipt-cutoff me-1"></i> Struk
                                                    </a>
                                                </td>
                                            </tr>
                                        <% } %>
                                    <% } else { %>
                                        <tr>
                                            <td colspan="5" class="text-center text-muted py-4">Belum ada transaksi</td>
                                        </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>
                </div>

                <!-- Stok menipis -->
                <div class="col-lg-4">
                    <div class="card card-satset shadow-sm border-warning">
                        <div class="card-body">
                            <h5 class="mb-2">
                                <i class="bi bi-exclamation-triangle me-1"></i> Stok Menipis (? 5)
                            </h5>

                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-warning">
                                    <tr>
                                        <th>Kode</th>
                                        <th>Produk</th>
                                        <th class="text-center" style="width:70px;">Stok</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <% if (stokMenipis != null && !stokMenipis.isEmpty()) { %>
                                        <% for (StokMenipisRow s : stokMenipis) { %>
                                            <tr>
                                                <td><%= s.getKode() %></td>
                                                <td><%= s.getNama() %></td>
                                                <td class="text-center">
                                                    <span class="badge badge-stock"><%= s.getStok() %></span>
                                                </td>
                                            </tr>
                                        <% } %>
                                    <% } else { %>
                                        <tr>
                                            <td colspan="3" class="text-center text-muted py-4">Aman</td>
                                        </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>

                            <div class="mt-3">
                                <a class="btn btn-sm btn-outline-warning w-100" href="<%= request.getContextPath()%>/admin/produk">
                                    <i class="bi bi-search me-1"></i> Cek Produk
                                </a>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

        </main>

        <%@ include file="/includes/scripts.jsp" %>
    </div>
</div>
</body>
</html>
