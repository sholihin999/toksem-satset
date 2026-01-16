<%-- 
    Document   : struk
    Created on : Dec 28, 2025
    Author     : muham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.PenjualanHeader"%>
<%@page import="model.PenjualanDetailRow"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
    String back = request.getParameter("back");
    if (back == null || back.isBlank()) {
        back = request.getContextPath() + "/kasir/penjualan";
    }
%>

<%@include file="/includes/format.jsp"%>

<%
    PenjualanHeader header = (PenjualanHeader) request.getAttribute("header");
    List<PenjualanDetailRow> detail = (List<PenjualanDetailRow>) request.getAttribute("detail");

    if (header == null) {
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Struk Penjualan</title>
    <%@ include file="/includes/head.jsp" %>
</head>
<body class="p-3 bg-light">
    <div class="alert alert-danger">
        <i class="bi bi-exclamation-triangle me-1"></i>
        Data struk tidak ditemukan.
    </div>
    <a class="btn btn-outline-secondary" href="<%= request.getContextPath()%>/kasir/penjualan">
        <i class="bi bi-arrow-left me-1"></i> Kembali
    </a>
</body>
</html>
<%
        return;
    }
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Struk Penjualan #<%= header.getId()%></title>

    <%-- pakai head.jsp supaya konsisten (Bootstrap/Bootswatch + Bootstrap Icons) --%>
    <%@ include file="/includes/head.jsp" %>

    <link href="https://fonts.googleapis.com/css2?family=Libre+Barcode+39&display=swap" rel="stylesheet">

    <style>
        body{
            background:#eef2f5;
            min-height:100vh;
            padding:24px 16px;
        }
        .receipt-wrap{
            max-width:420px;
            margin:0 auto;
        }
        .receipt{
            background:#fff;
            border:1px solid rgba(0,0,0,.08);
            border-radius:14px;
            overflow:hidden;
            box-shadow:0 10px 30px rgba(0,0,0,.08);
        }
        .receipt-head{
            background: var(--bs-info-bg-subtle, #d1ecf1);
            border-bottom:1px solid rgba(0,0,0,.08);
            padding:18px 16px;
        }
        .brand{
            display:flex;
            align-items:center;
            gap:12px;
        }
        .brand-badge{
            width:46px;
            height:46px;
            border-radius:12px;
            background: var(--bs-info, #0dcaf0);
            color:#fff;
            display:flex;
            align-items:center;
            justify-content:center;
            font-size:22px;
            box-shadow:0 6px 16px rgba(13,202,240,.25);
        }
        .brand-title{
            font-weight:800;
            letter-spacing:.4px;
            margin:0;
            line-height:1.1;
        }
        .brand-sub{
            margin:2px 0 0;
            color:rgba(0,0,0,.6);
            font-size:12px;
        }

        .receipt-body{ padding:16px; }
        .meta{
            background:#f8f9fa;
            border:1px dashed rgba(0,0,0,.15);
            border-radius:12px;
            padding:12px;
            margin-bottom:14px;
        }
        .meta .badge{
            font-size:12px;
            padding:.35rem .65rem;
        }
        .meta-row{
            display:flex;
            justify-content:space-between;
            gap:10px;
            font-size:13px;
            margin-top:8px;
        }
        .meta-row .label{ color:rgba(0,0,0,.55); }
        .meta-row .value{ font-weight:600; text-align:right; }

        .section-title{
            display:flex;
            align-items:center;
            gap:8px;
            font-weight:800;
            font-size:13px;
            letter-spacing:.6px;
            text-transform:uppercase;
            margin:14px 0 10px;
        }

        .items-table{
            width:100%;
            border-collapse:collapse;
            font-size:13px;
        }
        .items-table th{
            font-size:11px;
            text-transform:uppercase;
            letter-spacing:.4px;
            color:rgba(0,0,0,.55);
            border-bottom:1px solid rgba(0,0,0,.10);
            padding:8px 6px;
        }
        .items-table td{
            padding:10px 6px;
            border-bottom:1px solid rgba(0,0,0,.06);
            vertical-align:top;
        }
        .items-table .muted{ color:rgba(0,0,0,.55); font-size:11px; }
        .items-table .text-end{ text-align:right; }
        .items-table .text-center{ text-align:center; }

        .summary{
            background:#f8f9fa;
            border-radius:12px;
            padding:12px;
            margin-top:12px;
            border:1px solid rgba(0,0,0,.08);
        }
        .sum-row{
            display:flex;
            justify-content:space-between;
            font-size:13px;
            margin-bottom:8px;
        }
        .sum-row strong{ font-size:15px; }

        .pay{
            margin-top:12px;
            border-left:4px solid var(--bs-info, #0dcaf0);
            background:#eefbff;
            border-radius:12px;
            padding:12px;
        }

        .barcode{
            text-align:center;
            padding:14px 16px;
            border-top:1px dashed rgba(0,0,0,.15);
            background:#fff;
        }
        .barcode .code{
            font-family:'Libre Barcode 39', monospace;
            font-size:34px;
            line-height:1;
            letter-spacing:2px;
        }
        .barcode .text{
            margin-top:6px;
            font-size:11px;
            color:rgba(0,0,0,.55);
            letter-spacing:.6px;
        }

        .receipt-foot{
            background:#111827;
            color:#fff;
            text-align:center;
            padding:14px 16px;
        }
        .receipt-foot .thanks{
            font-weight:800;
            letter-spacing:.8px;
        }
        .receipt-foot .note{
            margin-top:8px;
            font-size:11px;
            color:rgba(255,255,255,.75);
            line-height:1.5;
        }

        .toolbar{
            max-width:420px;
            margin:0 auto 14px;
            display:flex;
            justify-content:center;
        }

        @media print{
            @page{ margin: 4mm 5mm; }
            body{ background:#fff !important; padding:0 !important; }
            .no-print{ display:none !important; }
            .receipt-wrap{ max-width:100% !important; }
            .receipt{ box-shadow:none !important; border:none !important; border-radius:0 !important; }
        }
    </style>
</head>

<body>
    <!-- tombol -->
    <div class="toolbar no-print">
        <div class="btn-group" role="group" aria-label="Aksi struk">
            <a class="btn btn-outline-secondary" href="<%= back %>">
                <i class="bi bi-arrow-left me-1"></i> Kembali
            </a>
            <button class="btn btn-info" onclick="window.print()">
                <i class="bi bi-printer me-1"></i> Cetak
            </button>
        </div>
    </div>

    <div class="receipt-wrap">
        <div class="receipt">

            <!-- HEADER -->
            <div class="receipt-head">
                <div class="brand">
                    <div class="brand-badge"><i class="bi bi-basket3"></i></div>
                    <div>
                        <h1 class="brand-title h5 mb-0">TOKO SEMBAKO SATSET</h1>
                        <div class="brand-sub">Sembako lengkap • Pelayanan cepat • Harga terjangkau</div>
                        <div class="brand-sub">
                            <i class="bi bi-geo-alt me-1"></i>Jl. Lenteng Agung No. 999, Jakarta Selatan
                            <span class="mx-2">•</span>
                            <i class="bi bi-telephone me-1"></i>0857-8989-9321
                        </div>
                    </div>
                </div>
            </div>

            <!-- BODY -->
            <div class="receipt-body">

                <!-- META -->
                <div class="meta">
                    <div class="d-flex align-items-center justify-content-between">
                        <span class="badge text-bg-danger">
                            <i class="bi bi-receipt-cutoff me-1"></i> TRANSAKSI #<%= header.getId()%>
                        </span>
                        <span class="badge text-bg-success">
                            <i class="bi bi-check-circle me-1"></i> LUNAS
                        </span>
                    </div>

                    <div class="meta-row">
                        <div class="label">Tanggal/Waktu</div>
                        <div class="value">
                            <i class="bi bi-calendar-event me-1"></i>
                            <%= header.getTanggal() != null ? header.getTanggal() : dateFormat.format(new java.util.Date()) %>
                        </div>
                    </div>

                    <div class="meta-row">
                        <div class="label">Kasir</div>
                        <div class="value"><i class="bi bi-person-badge me-1"></i><%= header.getKasirNama()%></div>
                    </div>

                    <div class="meta-row">
                        <div class="label">Pembeli</div>
                        <div class="value">
                            <i class="bi bi-people me-1"></i>
                            <%= (header.getNamaPembeli() == null || header.getNamaPembeli().isBlank()) ? "Pelanggan" : header.getNamaPembeli()%>
                        </div>
                    </div>
                </div>

                <!-- ITEMS -->
                <div class="section-title">
                    <i class="bi bi-list-ul text-info"></i> Daftar Produk
                </div>

                <div class="table-responsive">
                    <table class="items-table">
                        <thead>
                            <tr>
                                <th>Produk</th>
                                <th class="text-center" style="width:70px;">Qty</th>
                                <th class="text-end" style="width:110px;">Harga</th>
                                <th class="text-end" style="width:120px;">Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (detail != null && !detail.isEmpty()) { %>
                                <% for (PenjualanDetailRow r : detail) { %>
                                <tr>
                                    <td>
                                        <div class="fw-semibold"><%= r.getNama()%></div>
                                    </td>
                                    <td class="text-center"><%= r.getQty()%></td>
                                    <td class="text-end">Rp <%= nf.format(r.getHarga())%></td>
                                    <td class="text-end fw-semibold">Rp <%= nf.format(r.getSubtotal())%></td>
                                </tr>
                                <% } %>
                            <% } else { %>
                                <tr>
                                    <td colspan="4" class="text-center text-muted py-4">
                                        <i class="bi bi-box-seam me-1"></i> Tidak ada produk dalam transaksi ini
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <!-- SUMMARY -->
                <div class="summary">
                    <div class="sum-row">
                        <div class="text-muted">Total</div>
                        <strong>Rp <%= nf.format(header.getTotal())%></strong>
                    </div>
                </div>

                <!-- PAYMENT -->
                <div class="pay">
                    <div class="section-title mb-2" style="margin-top:0;">
                        <i class="bi bi-cash-coin text-info"></i> Pembayaran
                    </div>

                    <div class="sum-row">
                        <div class="text-muted">Tunai</div>
                        <div class="fw-semibold">Rp <%= nf.format(header.getBayar())%></div>
                    </div>
                    <div class="sum-row mb-0">
                        <div class="text-muted">Kembalian</div>
                        <div class="fw-bold text-success">
                            <i class="bi bi-coin me-1"></i>Rp <%= nf.format(header.getKembalian())%>
                        </div>
                    </div>
                </div>

            </div>

            <!-- BARCODE -->
            <div class="barcode">
                <div class="code">*<%= header.getId()%>000*</div>
                <div class="text">ID TRANSAKSI: <%= header.getId()%></div>
            </div>

            <!-- FOOTER -->
            <div class="receipt-foot">
                <div class="thanks">
                    <i class="bi bi-heart-fill text-info me-1"></i>
                    TERIMA KASIH
                </div>
                <div class="note">
                    Barang yang sudah dibeli tidak dapat dikembalikan.<br>
                    Simpan struk ini sebagai bukti pembayaran yang sah.<br>
                    <span class="d-none d-print-inline">Cetak: <%= dateFormat.format(new java.util.Date()) %></span>
                </div>
            </div>

        </div>
    </div>

    <script>
        // Auto print jika parameter print=true
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('print') === 'true') {
            setTimeout(() => window.print(), 500);
        }
    </script>
</body>
</html>
