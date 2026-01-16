<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.PenjualanRow"%>
<%@page import="model.User"%>

<%@include file="/includes/format.jsp"%>
<%@include file="/includes/alert.jsp"%>

<%
    request.setAttribute("activeMenu", "dashboard");
    request.setAttribute("pageTitle", "Dashboard Kasir");

    User u = (User) session.getAttribute("user");

    Integer totalTransaksi = (Integer) request.getAttribute("totalTransaksi");
    Integer omzet = (Integer) request.getAttribute("omzet");
    List<PenjualanRow> latest5 = (List<PenjualanRow>) request.getAttribute("latest5");

    if (totalTransaksi == null) totalTransaksi = 0;
    if (omzet == null) omzet = 0;

    int rata = (totalTransaksi > 0 ? (omzet / totalTransaksi) : 0);
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <%@ include file="/includes/head.jsp" %>
</head>

<body>
<div class="app-shell">

    <%@ include file="/includes/sidebar-kasir.jsp" %>

    <div class="app-content d-flex flex-column w-100">

        <%@ include file="/includes/topbar-kasir.jsp" %>

        <main class="p-3 p-lg-4">

            <div class="mb-3">
                <h3 class="mb-0">
                    Halo, <span class="fw-bold"><%= (u != null ? u.getNama() : "Kasir") %></span>
                </h3>
                <div class="text-muted">Ringkasan penjualan hari ini</div>
            </div>

            <!-- Cards -->
            <div class="row g-3 mb-3">
                <div class="col-12 col-md-6 col-xl-3">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body d-flex align-items-center justify-content-between">
                            <div>
                                <div class="text-muted">Transaksi Hari Ini</div>
                                <div class="fs-4 fw-bold"><%= totalTransaksi %></div>
                            </div>
                            <div class="fs-3 text-info">
                                <i class="bi bi-receipt"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-6 col-xl-3">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body d-flex align-items-center justify-content-between">
                            <div>
                                <div class="text-muted">Omzet Hari Ini</div>
                                <div class="fs-4 fw-bold">Rp <%= nf.format(omzet) %></div>
                            </div>
                            <div class="fs-3 text-info">
                                <i class="bi bi-cash-coin"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-6 col-xl-3">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body d-flex align-items-center justify-content-between">
                            <div>
                                <div class="text-muted">Rata-rata/Transaksi</div>
                                <div class="fs-4 fw-bold">Rp <%= nf.format(rata) %></div>
                            </div>
                            <div class="fs-3 text-info">
                                <i class="bi bi-bar-chart-line"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-6 col-xl-3">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body d-flex align-items-center justify-content-between">
                            <div>
                                <div class="text-muted">Transaksi Terbaru</div>
                                <div class="fs-4 fw-bold"><%= (latest5 != null ? latest5.size() : 0) %></div>
                            </div>
                            <div class="fs-3 text-info">
                                <i class="bi bi-clock-history"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Table latest 5 -->
            <div class="card card-satset shadow-sm border-info">
                <div class="card-body">
                    <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-2">
                        <h5 class="mb-0">
                            <i class="bi bi-clock-history me-1"></i> Transaksi Terbaru (5)
                        </h5>
                        <a class="btn btn-sm btn-outline-info"
                           href="<%= request.getContextPath() %>/kasir/penjualan/riwayat">
                            <i class="bi bi-list-ul me-1"></i> Lihat Semua
                        </a>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-info">
                                <tr>
                                    <th style="width:90px;">ID</th>
                                    <th style="width:260px;">Tanggal</th>
                                    <th class="text-end" style="width:160px;">Total</th>
                                    <th class="text-end" style="width:160px;">Bayar</th>
                                    <th class="text-end" style="width:160px;">Kembali</th>
                                    <th style="width:170px;">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (latest5 != null && !latest5.isEmpty()) { %>
                                    <% for (PenjualanRow r : latest5) { %>
                                        <tr>
                                            <td>#<%= r.getId() %></td>
                                            <td><%= r.getTanggal() %></td>
                                            <td class="text-end fw-semibold">Rp <%= nf.format(r.getTotal()) %></td>
                                            <td class="text-end">Rp <%= nf.format(r.getBayar()) %></td>
                                            <td class="text-end">Rp <%= nf.format(r.getKembalian()) %></td>
                                            <td>
                                                <a class="btn btn-sm btn-outline-info w-100"
                                                   href="<%= request.getContextPath() %>/kasir/penjualan/struk?id=<%= r.getId() %>">
                                                    <i class="bi bi-receipt-cutoff me-1"></i> Lihat Struk
                                                </a>
                                            </td>
                                        </tr>
                                    <% } %>
                                <% } else { %>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-4">
                                            Belum ada transaksi hari ini
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>

        </main>

        <%@ include file="/includes/scripts.jsp" %>
    </div>
</div>
</body>
</html>
