<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Produk"%>
<%@page import="model.CartItemJual"%>

<%
    request.setAttribute("activeMenu", "transaksi");
    request.setAttribute("pageTitleTopbar", "Transaksi Penjualan");

    String q = request.getParameter("q");
    if (q == null) q = "";

    List<Produk> produkList = (List<Produk>) request.getAttribute("produkList");
    List<CartItemJual> cart = (List<CartItemJual>) request.getAttribute("cart");
    Integer total = (Integer) request.getAttribute("total");
    if (total == null) total = 0;

    String flashType = (String) session.getAttribute("flashType");
    String flashMsg  = (String) session.getAttribute("flashMsg");
    if (flashType != null || flashMsg != null) {
        session.removeAttribute("flashType");
        session.removeAttribute("flashMsg");
    }
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <%@ include file="/includes/head.jsp" %>
    <style>
        .cart-sticky { position: sticky; top: 84px; }
        @media (max-width: 991.98px){
            .cart-sticky { position: static; }
        }
        .table-sm td, .table-sm th { padding: .55rem; }
        .qty-input { max-width: 90px; }
    </style>
</head>

<body>
<div class="app-shell">

    <%@ include file="/includes/sidebar-kasir.jsp" %>

    <div class="app-content d-flex flex-column w-100">
        <%@ include file="/includes/topbar-kasir.jsp" %>

        <main class="container-fluid p-3 p-lg-4">

            <%-- FLASH MESSAGE --%>
            <% if (flashMsg != null && !flashMsg.isBlank()) { %>
                <div class="alert alert-<%= (flashType != null ? flashType : "info") %> alert-dismissible fade show" role="alert">
                    <i class="bi bi-info-circle me-1"></i> <%= flashMsg %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>

            <div class="row g-3">

                <!-- LIST PRODUK -->
                <div class="col-lg-7">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body">

                            <div class="d-flex flex-wrap align-items-end justify-content-between gap-2 mb-2">
                                <div>
                                    <h5 class="mb-0">
                                        <i class="bi bi-grid-3x3-gap me-1"></i> Pilih Produk
                                    </h5>
                                    <div class="text-muted small">Cari produk lalu tambahkan ke keranjang</div>
                                </div>

                                <form class="d-flex gap-2" method="get"
                                      action="<%= request.getContextPath() %>/kasir/penjualan">
                                    <div class="input-group input-group-sm">
                                        <span class="input-group-text bg-white">
                                            <i class="bi bi-search"></i>
                                        </span>
                                        <input class="form-control"
                                               name="q"
                                               placeholder="Cari nama / kode..."
                                               value="<%= q %>">
                                    </div>
                                    <button class="btn btn-sm btn-outline-info">
                                        <i class="bi bi-search me-1"></i> Cari
                                    </button>
                                </form>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover table-sm align-middle mb-0">
                                    <thead class="table-info">
                                        <tr>
                                            <th style="width:110px;">Kode</th>
                                            <th>Nama</th>
                                            <th class="text-end" style="width:120px;">Harga</th>
                                            <th class="text-center" style="width:110px;">Stok</th>
                                            <th class="text-center" style="width:220px;">Tambah</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <% if (produkList != null && !produkList.isEmpty()) { %>
                                        <% for (Produk p : produkList) { %>
                                            <tr>
                                                <td class="text-muted"><%= p.getKode() %></td>
                                                <td class="fw-semibold"><%= p.getNama() %></td>
                                                <td class="text-end">Rp <%= p.getHarga() %></td>
                                                <td class="text-center">
                                                    <% if (p.getStok() <= 0) { %>
                                                        <span class="badge text-bg-danger">
                                                            <i class="bi bi-x-circle me-1"></i> Habis
                                                        </span>
                                                    <% } else if (p.getStok() <= 5) { %>
                                                        <span class="badge text-bg-warning">
                                                            <i class="bi bi-exclamation-triangle me-1"></i> Menipis
                                                        </span>
                                                    <% } else { %>
                                                        <span class="badge text-bg-success">
                                                            <i class="bi bi-check-circle me-1"></i> <%= p.getStok() %>
                                                        </span>
                                                    <% } %>
                                                </td>
                                                <td>
                                                    <form class="d-flex gap-2 justify-content-center" method="post"
                                                          action="<%= request.getContextPath() %>/kasir/penjualan">
                                                        <input type="hidden" name="action" value="add">
                                                        <input type="hidden" name="produkId" value="<%= p.getId() %>">

                                                        <input type="number" class="form-control form-control-sm qty-input"
                                                               name="qty" min="1" value="1"
                                                               <%= (p.getStok() <= 0 ? "disabled" : "") %>>

                                                        <button class="btn btn-sm btn-info"
                                                                <%= (p.getStok() <= 0 ? "disabled" : "") %>>
                                                            <i class="bi bi-plus-circle me-1"></i> Tambah
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        <% } %>
                                    <% } else { %>
                                        <tr>
                                            <td colspan="5" class="text-center text-muted py-4">
                                                Produk tidak ditemukan
                                            </td>
                                        </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>
                </div>

                <!-- KERANJANG -->
                <div class="col-lg-5">
                    <div class="card card-satset shadow-sm border-info cart-sticky">
                        <div class="card-body">

                            <div class="d-flex align-items-end justify-content-between mb-2">
                                <div>
                                    <h5 class="mb-0">
                                        <i class="bi bi-cart3 me-1"></i> Keranjang
                                    </h5>
                                    <div class="text-muted small">Item yang akan dibayar</div>
                                </div>
                                <div class="text-end">
                                    <div class="text-muted small">Total</div>
                                    <div class="fs-5 fw-bold">Rp <%= total %></div>
                                </div>
                            </div>

                            <div class="table-responsive mb-3">
                                <table class="table table-sm align-middle mb-0">
                                    <thead class="table-info">
                                        <tr>
                                            <th>Item</th>
                                            <th class="text-center" style="width:70px;">Qty</th>
                                            <th class="text-end" style="width:120px;">Subtotal</th>
                                            <th style="width:60px;"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <% if (cart != null && !cart.isEmpty()) { %>
                                        <% for (CartItemJual i : cart) { %>
                                            <tr>
                                                <td>
                                                    <div class="fw-semibold"><%= i.getNama() %></div>
                                                    <div class="text-muted small">
                                                        <%= i.getKode() %> • Rp <%= i.getHarga() %>
                                                    </div>
                                                </td>
                                                <td class="text-center"><%= i.getQty() %></td>
                                                <td class="text-end fw-semibold">Rp <%= i.getSubtotal() %></td>
                                                <td class="text-end">
                                                    <form method="post"
                                                          action="<%= request.getContextPath() %>/kasir/penjualan"
                                                          onsubmit="return confirm('Hapus item ini?')">
                                                        <input type="hidden" name="action" value="remove">
                                                        <input type="hidden" name="produkId" value="<%= i.getProdukId() %>">
                                                        <button class="btn btn-sm btn-outline-danger" title="Hapus">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        <% } %>
                                    <% } else { %>
                                        <tr>
                                            <td colspan="4" class="text-center text-muted py-4">
                                                Keranjang masih kosong
                                            </td>
                                        </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>

                            <!-- CHECKOUT -->
                            <form method="post"
                                  action="<%= request.getContextPath() %>/kasir/penjualan"
                                  class="border-top pt-3">
                                <input type="hidden" name="action" value="checkout">

                                <div class="mb-2">
                                    <label class="form-label">Nama Pembeli (opsional)</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white">
                                            <i class="bi bi-person"></i>
                                        </span>
                                        <input class="form-control" name="namaPembeli" placeholder="Misal: Budi">
                                    </div>
                                </div>

                                <div class="mb-2">
                                    <label class="form-label">Uang Bayar</label>
                                    <div class="input-group">
                                        <span class="input-group-text">Rp</span>
                                        <input class="form-control" name="bayar" type="number" min="0" required placeholder="Masukkan nominal bayar">
                                    </div>
                                </div>

                                <button class="btn btn-info w-100"
                                        <%= (cart == null || cart.isEmpty() ? "disabled" : "") %>>
                                    <i class="bi bi-check2-square me-1"></i> Simpan Transaksi
                                </button>

                                <div class="text-muted small mt-2">
                                    <i class="bi bi-shield-check me-1"></i>
                                    Pastikan uang bayar cukup
                                </div>
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
