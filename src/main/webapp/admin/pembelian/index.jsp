<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Supplier"%>
<%@page import="model.Produk"%>
<%@page import="model.CartItemBeli"%>

<%
    request.setAttribute("activeMenu", "pembelian");
    request.setAttribute("pageTitle", "Pembelian - Toksem Satset");

    List<Supplier> suppliers = (List<Supplier>) request.getAttribute("suppliers");
    List<Produk> produkList = (List<Produk>) request.getAttribute("produkList");
    List<CartItemBeli> cart = (List<CartItemBeli>) request.getAttribute("cart");
    Integer total = (Integer) request.getAttribute("total");
    if (total == null) total = 0;

    String msg = request.getParameter("msg");
    String type = request.getParameter("type");
    if (type == null || type.trim().isEmpty()) type = "info";

    String q = request.getParameter("q");
    String kategoriIdStr = request.getParameter("kategoriId");
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
                    <h3 class="mb-0">Transaksi Pembelian</h3>
                    <div class="text-muted">Tambah item ke keranjang, lalu checkout untuk menyimpan pembelian</div>
                </div>
                <div class="d-flex gap-2">
                    <a class="btn btn-sm btn-outline-info"
                       href="<%= request.getContextPath() %>/admin/pembelian/riwayat">
                        <i class="bi bi-clock-history me-1"></i> Riwayat Pembelian
                    </a>
                </div>
            </div>

            <% if (msg != null && !msg.trim().isEmpty()) { %>
                <div class="alert alert-<%= type %> alert-dismissible fade show" role="alert">
                    <i class="bi bi-info-circle me-1"></i> <%= msg %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>

            <!-- FILTER PRODUK -->
            <div class="card card-satset shadow-sm mb-3 border-info">
                <div class="card-body">
                    <form class="row g-2 align-items-end" method="get" action="<%= request.getContextPath() %>/admin/pembelian">
                        <div class="col-md-8">
                            <label class="form-label">Cari Produk</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white">
                                    <i class="bi bi-search"></i>
                                </span>
                                <input class="form-control" name="q" placeholder="Cari kode/nama produk..."
                                       value="<%= (q != null ? q : "") %>">
                            </div>
                        </div>

                        <input type="hidden" name="kategoriId" value="<%= (kategoriIdStr != null ? kategoriIdStr : "") %>">

                        <div class="col-md-4 d-flex gap-2">
                            <button class="btn btn-info w-100">
                                <i class="bi bi-search me-1"></i> Cari
                            </button>
                            <a class="btn btn-outline-warning w-100"
                               href="<%= request.getContextPath() %>/admin/pembelian">
                                <i class="bi bi-arrow-counterclockwise me-1"></i> Reset
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <div class="row g-3">

                <!-- KIRI: Tambah item -->
                <div class="col-lg-5">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body">

                            <div class="d-flex align-items-center justify-content-between mb-2">
                                <h5 class="mb-0">
                                    <i class="bi bi-cart-plus me-1"></i> Tambah Item
                                </h5>
                                <span class="badge text-bg-secondary">
                                    Keranjang: <%= (cart != null ? cart.size() : 0) %>
                                </span>
                            </div>

                            <hr class="my-3">

                            <form method="post" action="<%= request.getContextPath() %>/admin/pembelian">
                                <input type="hidden" name="action" value="addItem">

                                <div class="mb-3">
                                    <label class="form-label">Produk</label>
                                    <select class="form-select" name="produkId" required>
                                        <option value="">-- pilih produk --</option>
                                        <% if (produkList != null) { 
                                            for (Produk p : produkList) { %>
                                                <option value="<%= p.getId() %>">
                                                    <%= p.getKode() %> - <%= p.getNama() %>
                                                </option>
                                        <%  } } %>
                                    </select>
                                    <div class="form-text">Pilih produk dari daftar hasil pencarian.</div>
                                </div>

                                <div class="row g-2">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Qty</label>
                                            <input type="number" class="form-control" name="qty" min="1" value="1" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Harga Beli</label>
                                            <div class="input-group">
                                                <span class="input-group-text">Rp</span>
                                                <input type="number" class="form-control" name="hargaBeli" min="0" required
                                                       placeholder="contoh: 12000">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <button class="btn btn-info w-100">
                                    <i class="bi bi-plus-circle me-1"></i> Tambah ke Keranjang
                                </button>
                            </form>

                            <hr class="my-3">

                            <form method="post" action="<%= request.getContextPath() %>/admin/pembelian"
                                  onsubmit="return confirm('Kosongkan seluruh keranjang pembelian?');">
                                <input type="hidden" name="action" value="clear">
                                <button class="btn btn-outline-warning w-100">
                                    <i class="bi bi-trash3 me-1"></i> Kosongkan Keranjang
                                </button>
                            </form>

                        </div>
                    </div>
                </div>

                <!-- KANAN: Keranjang + checkout -->
                <div class="col-lg-7">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body">

                            <div class="d-flex align-items-center justify-content-between mb-2">
                                <h5 class="mb-0">
                                    <i class="bi bi-basket3 me-1"></i> Keranjang Pembelian
                                </h5>
                                <span class="badge text-bg-secondary">
                                    Item: <%= (cart != null ? cart.size() : 0) %>
                                </span>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-info">
                                        <tr>
                                            <th>Produk</th>
                                            <th class="text-center" style="width:80px;">Qty</th>
                                            <th class="text-end" style="width:140px;">Harga Beli</th>
                                            <th class="text-end" style="width:160px;">Subtotal</th>
                                            <th style="width:230px;">Aksi</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (cart != null && !cart.isEmpty()) { %>
                                            <% for (CartItemBeli i : cart) { %>
                                                <tr>
                                                    <td>
                                                        <div class="fw-semibold"><%= i.getNama() %></div>
                                                        <div class="text-muted small"><%= i.getKode() %></div>
                                                    </td>
                                                    <td class="text-center"><%= i.getQty() %></td>
                                                    <td class="text-end">Rp <%= i.getHargaBeli() %></td>
                                                    <td class="text-end fw-semibold">Rp <%= i.getSubtotal() %></td>
                                                    <td>
                                                        <div class="d-flex flex-wrap gap-2">

                                                            <form class="d-flex gap-2" method="post" action="<%= request.getContextPath() %>/admin/pembelian">
                                                                <input type="hidden" name="action" value="updateItem">
                                                                <input type="hidden" name="produkId" value="<%= i.getProdukId() %>">

                                                                <input type="number" class="form-control form-control-sm" name="qty" min="1"
                                                                       value="<%= i.getQty() %>" style="width:80px;">
                                                                <input type="number" class="form-control form-control-sm" name="hargaBeli" min="0"
                                                                       value="<%= i.getHargaBeli() %>" style="width:110px;">

                                                                <button class="btn btn-sm btn-outline-success">
                                                                    <i class="bi bi-check2-circle me-1"></i> Update
                                                                </button>
                                                            </form>

                                                            <form method="post" action="<%= request.getContextPath() %>/admin/pembelian"
                                                                  onsubmit="return confirm('Hapus item ini dari keranjang?');">
                                                                <input type="hidden" name="action" value="removeItem">
                                                                <input type="hidden" name="produkId" value="<%= i.getProdukId() %>">
                                                                <button class="btn btn-sm btn-outline-danger">
                                                                    <i class="bi bi-trash me-1"></i> Hapus
                                                                </button>
                                                            </form>

                                                        </div>
                                                    </td>
                                                </tr>
                                            <% } %>
                                        <% } else { %>
                                            <tr>
                                                <td colspan="5" class="text-center text-muted py-4">
                                                    Keranjang masih kosong
                                                </td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>

                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <div class="text-muted">Total</div>
                                <div class="fs-5 fw-bold">Rp <%= total %></div>
                            </div>

                            <hr class="my-3">

                            <form method="post" action="<%= request.getContextPath() %>/admin/pembelian"
                                  onsubmit="return confirm('Simpan transaksi pembelian ini?');">
                                <input type="hidden" name="action" value="checkout">

                                <div class="mb-2">
                                    <label class="form-label">Supplier (wajib saat checkout)</label>
                                    <select class="form-select" name="supplierId" required>
                                        <option value="">-- pilih supplier --</option>
                                        <% if (suppliers != null) { 
                                            for (Supplier s : suppliers) { %>
                                                <option value="<%= s.getId() %>"><%= s.getNama() %></option>
                                        <%  } } %>
                                    </select>
                                    <div class="form-text">Pilih supplier untuk transaksi ini.</div>
                                </div>

                                <button class="btn btn-info w-100"
                                        <%= (cart == null || cart.isEmpty()) ? "disabled" : "" %>>
                                    <i class="bi bi-check2-square me-1"></i> Checkout & Simpan
                                </button>
                            </form>

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
