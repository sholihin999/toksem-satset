<%-- 
    Document   : riwayat
    Created on : Dec 28, 2025, 12:12:53 PM
    Author     : muham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.PembelianHeader"%>

<%
    request.setAttribute("activeMenu", "pembelian");
    request.setAttribute("pageTitle", "Riwayat Pembelian - Toksem Satset");

    List<PembelianHeader> list = (List<PembelianHeader>) request.getAttribute("list");

    String from = request.getParameter("from");
    String to = request.getParameter("to");
    String supplier = request.getParameter("supplier");
    if (supplier == null) supplier = "";
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <%@ include file="/includes/head.jsp" %>
</head>

<body>
<div class="app-shell">

    <%@ include file="/includes/sidebar-admin.jsp" %>

    <div class="app-content d-flex flex-column w-100">
        <%@ include file="/includes/topbar.jsp" %>

        <main class="container-fluid p-3 p-lg-4">

            <!-- Header -->
            <div class="d-flex flex-wrap align-items-end justify-content-between gap-2 mb-3">
                <div>
                    <h3 class="mb-0">Riwayat Pembelian</h3>
                    <div class="text-muted">Filter berdasarkan tanggal & supplier</div>
                </div>
                <div class="d-flex gap-2">
                    <a class="btn btn-sm btn-outline-info"
                       href="<%= request.getContextPath() %>/admin/pembelian">
                        <i class="bi bi-plus-circle me-1"></i> Pembelian Baru
                    </a>
                </div>
            </div>

            <!-- Filter -->
            <div class="card card-satset shadow-sm mb-3 border-info">
                <div class="card-body">
                    <form class="row g-2 align-items-end" method="get" action="<%= request.getContextPath() %>/admin/pembelian/riwayat">

                        <div class="col-md-3">
                            <label class="form-label">Dari Tanggal</label>
                            <input type="date" class="form-control" name="from" value="<%= (from != null ? from : "") %>">
                        </div>

                        <div class="col-md-3">
                            <label class="form-label">Sampai Tanggal</label>
                            <input type="date" class="form-control" name="to" value="<%= (to != null ? to : "") %>">
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Supplier</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white">
                                    <i class="bi bi-truck"></i>
                                </span>
                                <input class="form-control" name="supplier" placeholder="Nama supplier (opsional)"
                                       value="<%= supplier %>">
                            </div>
                        </div>

                        <div class="col-md-2 d-flex gap-2">
                            <button class="btn btn-info w-100">
                                <i class="bi bi-funnel me-1"></i> Terapkan
                            </button>
                            <a class="btn btn-outline-info w-100"
                               href="<%= request.getContextPath() %>/admin/pembelian/riwayat">
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
                            <i class="bi bi-list-ul me-1"></i> Daftar Pembelian
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
                                    <th style="width:220px;">Tanggal</th>
                                    <th>Supplier</th>
                                    <th>Admin</th>
                                    <th class="text-end" style="width:160px;">Total</th>
                                    <th style="width:150px;">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (list != null && !list.isEmpty()) { %>
                                    <% for (PembelianHeader h : list) { %>
                                        <tr>
                                            <td>#<%= h.getId() %></td>
                                            <td><%= h.getTanggal() %></td>
                                            <td class="fw-semibold"><%= h.getSupplierNama() %></td>
                                            <td class="text-muted"><%= h.getAdminNama() %></td>
                                            <td class="text-end fw-semibold">Rp <%= h.getTotal() %></td>
                                            <td>
                                                <a class="btn btn-sm btn-outline-info w-100"
                                                   href="<%= request.getContextPath() %>/admin/pembelian/detail?id=<%= h.getId() %>">
                                                    <i class="bi bi-eye me-1"></i> Detail
                                                </a>
                                            </td>
                                        </tr>
                                    <% } %>
                                <% } else { %>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-4">
                                            Tidak ada data pembelian
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
