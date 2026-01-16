<%-- 
    Document   : riwayat
    Created on : Dec 28, 2025, 3:15:49 PM
    Author     : muham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.PenjualanRow"%>

<%
    request.setAttribute("activeMenu", "riwayat");
    request.setAttribute("pageTitleTopbar", "Riwayat Penjualan");

    String q = request.getParameter("q");
    String from = request.getParameter("from");
    String to = request.getParameter("to");
    if (q == null) q = "";

    List<PenjualanRow> list = (List<PenjualanRow>) request.getAttribute("list");
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

        <main class="container-fluid p-3 p-lg-4">

            <!-- Header -->
            <div class="d-flex flex-wrap align-items-end justify-content-between gap-2 mb-3">
                <div>
                    <h3 class="mb-0">Riwayat Penjualan</h3>
                    <div class="text-muted">Transaksi yang dilakukan oleh akun kasir ini</div>
                </div>
                <div class="d-flex gap-2">
                    <a class="btn btn-sm btn-info"
                       href="<%= request.getContextPath() %>/kasir/penjualan">
                        <i class="bi bi-plus-circle me-1"></i> Transaksi Baru
                    </a>
                </div>
            </div>

            <!-- Filter -->
            <div class="card card-satset shadow-sm border-info mb-3">
                <div class="card-body">
                    <form class="row g-2 align-items-end" method="get"
                          action="<%= request.getContextPath() %>/kasir/penjualan/riwayat">

                        <div class="col-md-4">
                            <label class="form-label">Cari ID Transaksi</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white">
                                    <i class="bi bi-search"></i>
                                </span>
                                <input class="form-control" name="q" placeholder="Contoh: 12"
                                       value="<%= q %>">
                            </div>
                        </div>

                        <div class="col-md-3">
                            <label class="form-label">Dari Tanggal</label>
                            <input type="date" class="form-control" name="from"
                                   value="<%= (from != null ? from : "") %>">
                        </div>

                        <div class="col-md-3">
                            <label class="form-label">Sampai Tanggal</label>
                            <input type="date" class="form-control" name="to"
                                   value="<%= (to != null ? to : "") %>">
                        </div>

                        <div class="col-md-2 d-flex gap-2">
                            <button class="btn btn-info w-100">
                                <i class="bi bi-funnel me-1"></i> Terapkan
                            </button>
                            <a class="btn btn-outline-info w-100"
                               href="<%= request.getContextPath() %>/kasir/penjualan/riwayat">
                                <i class="bi bi-arrow-counterclockwise me-1"></i> Reset
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Table -->
            <div class="card card-satset shadow-sm border-info">
                <div class="card-body">
                    <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-2">
                        <h5 class="mb-0">
                            <i class="bi bi-list-ul me-1"></i> Daftar Transaksi
                        </h5>
                        <span class="badge text-bg-secondary">
                            Total data: <%= (list != null ? list.size() : 0) %>
                        </span>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-info">
                                <tr>
                                    <th style="width:90px;">ID</th>
                                    <th style="width:260px;">Tanggal</th>
                                    <th class="text-end" style="width:140px;">Total</th>
                                    <th class="text-end" style="width:140px;">Bayar</th>
                                    <th class="text-end" style="width:140px;">Kembalian</th>
                                    <th style="width:170px;">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (list != null && !list.isEmpty()) { %>
                                    <% for (PenjualanRow r : list) { %>
                                        <tr>
                                            <td>#<%= r.getId() %></td>
                                            <td><%= r.getTanggal() %></td>
                                            <td class="text-end fw-semibold">Rp <%= r.getTotal() %></td>
                                            <td class="text-end">Rp <%= r.getBayar() %></td>
                                            <td class="text-end">Rp <%= r.getKembalian() %></td>
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
                                            Tidak ada transaksi
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
