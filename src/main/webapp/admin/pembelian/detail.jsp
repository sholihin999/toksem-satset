<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.PembelianHeader"%>
<%@page import="model.PembelianDetailRow"%>

<%
    request.setAttribute("activeMenu", "pembelian");
    request.setAttribute("pageTitle", "Detail Pembelian - Toksem Satset");

    PembelianHeader header = (PembelianHeader) request.getAttribute("header");
    List<PembelianDetailRow> detail = (List<PembelianDetailRow>) request.getAttribute("detail");
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <%@ include file="/includes/head.jsp" %>

    <style>
        /* Mode cetak: sembunyikan UI admin */
        @media print {
            .no-print { display: none !important; }
            .app-shell, .app-content { display: block !important; }
            body { padding: 0 !important; }
            main { padding: 0 !important; }
            .card { box-shadow: none !important; border: 1px solid #ddd !important; }
            .table { font-size: 12px; }
        }
    </style>
</head>

<body>
<div class="app-shell">

    <div class="no-print">
        <%@ include file="/includes/sidebar-admin.jsp" %>
    </div>

    <div class="app-content d-flex flex-column w-100">

        <div class="no-print">
            <%@ include file="/includes/topbar.jsp" %>
        </div>

        <main class="container-fluid p-3 p-lg-4">

            <!-- Header page -->
            <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-3 no-print">
                <div>
                    <h3 class="mb-0">
                        <i class="bi bi-receipt-cutoff me-1"></i>
                        Detail Pembelian #<%= header.getId() %>
                    </h3>
                    <div class="text-muted">Bukti & rincian transaksi pembelian</div>
                </div>
                <div class="d-flex gap-2">
                    <a class="btn btn-outline-secondary"
                       href="<%= request.getContextPath() %>/admin/pembelian">
                        <i class="bi bi-arrow-left me-1"></i> Kembali
                    </a>
                    <button class="btn btn-info" onclick="window.print()">
                        <i class="bi bi-printer me-1"></i> Cetak Bukti
                    </button>
                </div>
            </div>

            <!-- Info ringkas (ikut tercetak) -->
            <div class="card card-satset shadow-sm mb-3 border-info">
                <div class="card-body">

                    <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-2">
                        <div>
                            <div class="text-muted small">Dokumen</div>
                            <div class="fw-semibold">Pembelian (Purchase Receipt)</div>
                        </div>
                        <span class="badge text-bg-info">
                            ID #<%= header.getId() %>
                        </span>
                    </div>

                    <hr class="my-3">

                    <div class="row g-3">
                        <div class="col-md-4">
                            <div class="text-muted small">
                                <i class="bi bi-calendar-event me-1"></i> Tanggal
                            </div>
                            <div class="fw-semibold"><%= header.getTanggal() %></div>
                        </div>
                        <div class="col-md-4">
                            <div class="text-muted small">
                                <i class="bi bi-truck me-1"></i> Supplier
                            </div>
                            <div class="fw-semibold"><%= header.getSupplierNama() %></div>
                        </div>
                        <div class="col-md-4">
                            <div class="text-muted small">
                                <i class="bi bi-person-badge me-1"></i> Admin
                            </div>
                            <div class="fw-semibold"><%= header.getAdminNama() %></div>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mt-3">
                        <div class="text-muted small">Total Pembelian</div>
                        <div class="fs-5 fw-bold text-dark">
                            Rp <%= header.getTotal() %>
                        </div>
                    </div>

                </div>
            </div>

            <!-- Tabel detail -->
            <div class="card card-satset shadow-sm border-info">
                <div class="card-body">

                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <h5 class="mb-0">
                            <i class="bi bi-list-check me-1"></i> Rincian Item
                        </h5>
                        <span class="badge text-bg-secondary">
                            Item: <%= (detail != null ? detail.size() : 0) %>
                        </span>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover table-bordered align-middle mb-0">
                            <thead class="table-info">
                                <tr>
                                    <th style="width:140px;">Kode</th>
                                    <th>Nama Produk</th>
                                    <th class="text-center" style="width:90px;">Qty</th>
                                    <th class="text-end" style="width:160px;">Harga Beli</th>
                                    <th class="text-end" style="width:170px;">Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (detail != null && !detail.isEmpty()) { %>
                                    <% for (PembelianDetailRow r : detail) { %>
                                        <tr>
                                            <td class="fw-semibold"><%= r.getKode() %></td>
                                            <td><%= r.getNama() %></td>
                                            <td class="text-center"><%= r.getQty() %></td>
                                            <td class="text-end">Rp <%= r.getHargaBeli() %></td>
                                            <td class="text-end fw-semibold">Rp <%= r.getSubtotal() %></td>
                                        </tr>
                                    <% } %>
                                <% } else { %>
                                    <tr>
                                        <td colspan="5" class="text-center text-muted py-4">
                                            Detail pembelian kosong
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th colspan="4" class="text-end">TOTAL</th>
                                    <th class="text-end fs-6">Rp <%= header.getTotal() %></th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                    <div class="text-muted small mt-3">
                        <i class="bi bi-shield-check me-1"></i>
                        Dokumen ini dapat digunakan sebagai bukti transaksi pembelian.
                    </div>
                </div>
            </div>

        </main>

        <div class="no-print">
            <%@ include file="/includes/scripts.jsp" %>
        </div>

    </div>
</div>
</body>
</html>
