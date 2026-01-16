<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Produk"%>
<%@page import="model.Kategori"%>

<%
    request.setAttribute("activeMenu", "produk");
    request.setAttribute("pageTitle", "Manajemen Produk - Toksem Satset");

    List<Produk> list = (List<Produk>) request.getAttribute("list");
    Produk produk = (Produk) request.getAttribute("produk");
    List<Kategori> kategoriList = (List<Kategori>) request.getAttribute("kategoriList");

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
                    <h3 class="mb-0">Manajemen Produk</h3>
                    <div class="text-muted">Kelola produk Toko Sembako Satset</div>
                </div>
                <a class="btn btn-sm btn-outline-info"
                   href="<%= request.getContextPath() %>/admin/dashboard">
                    <i class="bi bi-speedometer2 me-1"></i> Dashboard
                </a>
            </div>

            <% if (msg != null && !msg.trim().isEmpty()) { %>
                <div class="alert alert-<%= type %> alert-dismissible fade show" role="alert">
                    <i class="bi bi-info-circle me-1"></i> <%= msg %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>

            <!-- FILTER -->
            <div class="card card-satset shadow-sm mb-3 border-info">
                <div class="card-body">
                    <form class="row g-2 align-items-end" method="get" action="<%= request.getContextPath() %>/admin/produk">

                        <div class="col-md-5">
                            <label class="form-label">Cari</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white">
                                    <i class="bi bi-search"></i>
                                </span>
                                <input class="form-control" name="q" placeholder="Cari kode/nama..."
                                       value="<%= (q != null ? q : "") %>">
                            </div>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Kategori</label>
                            <select class="form-select" name="kategoriId">
                                <option value="">Semua kategori</option>
                                <% if (kategoriList != null) { 
                                    for (Kategori k : kategoriList) {
                                        int kid = k.getId();
                                        String knama = k.getNama();
                                        boolean selected = (kategoriIdStr != null && !kategoriIdStr.isBlank() && Integer.parseInt(kategoriIdStr) == kid);
                                %>
                                    <option value="<%= kid %>" <%= selected ? "selected" : "" %>><%= knama %></option>
                                <%  } } %>
                            </select>
                        </div>

                        <div class="col-md-3 d-flex gap-2">
                            <button class="btn btn-info w-100">
                                <i class="bi bi-funnel me-1"></i> Terapkan
                            </button>
                            <a class="btn btn-outline-danger w-100"
                               href="<%= request.getContextPath() %>/admin/produk">
                                <i class="bi bi-arrow-counterclockwise me-1"></i> Reset
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <div class="row g-3">

                <!-- FORM TAMBAH/EDIT -->
                <div class="col-lg-4">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body">
                            <div class="d-flex align-items-center justify-content-between mb-2">
                                <div>
                                    <h5 class="mb-0">
                                        <i class="bi bi-box-seam me-1"></i>
                                        <%= (produk != null ? "Edit Produk" : "Tambah Produk") %>
                                    </h5>
                                    <small class="text-muted">
                                        <%= (produk != null ? "Perbarui data produk yang dipilih" : "Tambahkan produk baru ke katalog") %>
                                    </small>
                                </div>
                                <span class="badge <%= (produk != null ? "text-bg-warning" : "text-bg-info") %>">
                                    <%= (produk != null ? "Mode Edit" : "Mode Tambah") %>
                                </span>
                            </div>

                            <hr class="my-3">

                            <form method="post" action="<%= request.getContextPath() %>/admin/produk">
                                <% if (produk != null) { %>
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="id" value="<%= produk.getId() %>">
                                <% } else { %>
                                    <input type="hidden" name="action" value="add">
                                <% } %>

                                <div class="mb-3">
                                    <label class="form-label">Kode</label>
                                    <input class="form-control" name="kode" required
                                           value="<%= (produk != null ? produk.getKode() : "") %>"
                                           placeholder="Contoh: brs01">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Nama Produk</label>
                                    <input class="form-control" name="nama" required
                                           value="<%= (produk != null ? produk.getNama() : "") %>"
                                           placeholder="Contoh: Beras Ramos 5Kg">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Kategori</label>
                                    <select class="form-select" name="kategori_id" required>
                                        <option value="">-- pilih kategori --</option>
                                        <% if (kategoriList != null) {
                                            for (Kategori k : kategoriList) {
                                                int kid = k.getId();
                                                String knama = k.getNama();
                                                boolean selected = false;
                                                if (produk != null) {
                                                    selected = (produk.getKategoriId() == kid);
                                                }
                                        %>
                                            <option value="<%= kid %>" <%= selected ? "selected" : "" %>><%= knama %></option>
                                        <%  } } %>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Satuan</label>
                                    <input class="form-control" name="satuan"
                                           value="<%= (produk != null && produk.getSatuan()!=null ? produk.getSatuan() : "") %>"
                                           placeholder="Contoh: kg / liter / pcs">
                                </div>

                                <div class="row g-2">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Harga</label>
                                            <div class="input-group">
                                                <span class="input-group-text">Rp</span>
                                                <input type="number" class="form-control" name="harga" min="0" required
                                                       value="<%= (produk != null ? produk.getHarga() : 0) %>">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Stok</label>
                                            <input type="number" class="form-control" name="stok" min="0" required
                                                   value="<%= (produk != null ? produk.getStok() : 0) %>">
                                        </div>
                                    </div>
                                </div>

                                <button class="btn btn-info w-100">
                                    <i class="bi bi-save me-1"></i> <%= (produk != null ? "Update" : "Tambah") %>
                                </button>

                                <% if (produk != null) { %>
                                    <a class="btn btn-outline-secondary w-100 mt-2"
                                       href="<%= request.getContextPath() %>/admin/produk">
                                        <i class="bi bi-x-circle me-1"></i> Batal
                                    </a>
                                <% } %>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- TABEL PRODUK -->
                <div class="col-lg-8">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body">
                            <div class="d-flex flex-wrap gap-2 align-items-center justify-content-between mb-2">
                                <h5 class="mb-0">
                                    <i class="bi bi-list-ul me-1"></i> Daftar Produk
                                </h5>
                                <span class="badge text-bg-secondary">
                                    Total: <%= (list != null ? list.size() : 0) %>
                                </span>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-info">
                                        <tr>
                                            <th style="width:80px;">ID</th>
                                            <th style="width:120px;">Kode</th>
                                            <th>Nama</th>
                                            <th style="width:90px;">Satuan</th>
                                            <th class="text-center" style="width:90px;">Stok</th>
                                            <th class="text-end" style="width:140px;">Harga</th>
                                            <th style="width:190px;">Aksi</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (list != null && !list.isEmpty()) { %>
                                            <% for (Produk p : list) { %>
                                                <tr>
                                                    <td>#<%= p.getId() %></td>
                                                    <td class="fw-semibold"><%= p.getKode() %></td>
                                                    <td><%= p.getNama() %></td>
                                                    <td><%= (p.getSatuan() != null ? p.getSatuan() : "-") %></td>

                                                    <td class="text-center">
                                                        <% if (p.getStok() <= 5) { %>
                                                            <span class="badge text-bg-warning"><%= p.getStok() %></span>
                                                        <% } else { %>
                                                            <span class="badge text-bg-success"><%= p.getStok() %></span>
                                                        <% } %>
                                                    </td>

                                                    <td class="text-end">Rp <%= p.getHarga() %></td>

                                                    <td>
                                                        <div class="d-flex gap-2">
                                                            <a class="btn btn-sm btn-outline-warning"
                                                               href="<%= request.getContextPath() %>/admin/produk?action=edit&id=<%= p.getId() %>">
                                                                <i class="bi bi-pencil-square me-1"></i> Edit
                                                            </a>

                                                            <form method="post" action="<%= request.getContextPath() %>/admin/produk"
                                                                  onsubmit="return confirm('Yakin hapus produk ini?');">
                                                                <input type="hidden" name="action" value="delete">
                                                                <input type="hidden" name="id" value="<%= p.getId() %>">
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
                                                <td colspan="7" class="text-center text-muted py-4">Data produk kosong</td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
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
