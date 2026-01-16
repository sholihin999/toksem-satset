<%-- 
    Document   : index
    Created on : Dec 28, 2025, 10:01:07 AM
    Author     : muham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Kategori"%>

<%
    request.setAttribute("activeMenu", "kategori");
    request.setAttribute("pageTitle", "Manajemen Kategori - Toksem Satset");

    List<Kategori> list = (List<Kategori>) request.getAttribute("list");
    Kategori kategori = (Kategori) request.getAttribute("kategori");

    String msg = request.getParameter("msg");
    String type = request.getParameter("type");
    if (type == null || type.trim().isEmpty()) type = "info";
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
                    <h3 class="mb-0">Manajemen Kategori</h3>
                    <div class="text-muted">Kelola kategori barang untuk Toko Sembako Satset</div>
                </div>
                <div class="d-flex gap-2">
                    <a class="btn btn-sm btn-outline-info"
                       href="<%= request.getContextPath() %>/admin/dashboard">
                        <i class="bi bi-speedometer2 me-1"></i> Dashboard
                    </a>
                </div>
            </div>

            <% if (msg != null && !msg.trim().isEmpty()) { %>
                <div class="alert alert-<%= type %> alert-dismissible fade show" role="alert">
                    <i class="bi bi-info-circle me-1"></i> <%= msg %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>

            <div class="row g-3">

                <!-- FORM TAMBAH/EDIT -->
                <div class="col-lg-4">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body">

                            <div class="d-flex align-items-center justify-content-between mb-2">
                                <div>
                                    <h5 class="mb-0">
                                        <i class="bi bi-tags me-1"></i>
                                        <%= (kategori != null ? "Edit Kategori" : "Tambah Kategori") %>
                                    </h5>
                                    <small class="text-muted">
                                        <%= (kategori != null ? "Perbarui nama kategori" : "Tambahkan kategori baru") %>
                                    </small>
                                </div>

                                <span class="badge <%= (kategori != null ? "text-bg-warning" : "text-bg-info") %>">
                                    <%= (kategori != null ? "Mode Edit" : "Mode Tambah") %>
                                </span>
                            </div>

                            <hr class="my-3">

                            <form method="post" action="<%= request.getContextPath() %>/admin/kategori">
                                <% if (kategori != null) { %>
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="id" value="<%= kategori.getId() %>">
                                <% } else { %>
                                    <input type="hidden" name="action" value="add">
                                <% } %>

                                <div class="mb-3">
                                    <label class="form-label">Nama Kategori</label>
                                    <input class="form-control" name="nama" required
                                           placeholder="Contoh: Beras, Minyak, Gula"
                                           value="<%= (kategori != null ? kategori.getNama() : "") %>">
                                </div>

                                <button class="btn btn-info w-100">
                                    <i class="bi bi-save me-1"></i> <%= (kategori != null ? "Update" : "Tambah") %>
                                </button>

                                <% if (kategori != null) { %>
                                    <a class="btn btn-outline-secondary w-100 mt-2"
                                       href="<%= request.getContextPath() %>/admin/kategori">
                                        <i class="bi bi-x-circle me-1"></i> Batal
                                    </a>
                                <% } %>
                            </form>

                        </div>
                    </div>
                </div>

                <!-- DAFTAR KATEGORI -->
                <div class="col-lg-8">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body">

                            <div class="d-flex flex-wrap gap-2 align-items-center justify-content-between mb-2">
                                <div class="d-flex align-items-center gap-2">
                                    <h5 class="mb-0">
                                        <i class="bi bi-list-ul me-1"></i> Daftar Kategori
                                    </h5>
                                    <span class="badge text-bg-secondary">
                                        Total: <%= (list != null ? list.size() : 0) %>
                                    </span>
                                </div>

                                <div style="max-width: 260px; width: 100%;">
                                    <div class="input-group input-group-sm">
                                        <span class="input-group-text bg-white">
                                            <i class="bi bi-search"></i>
                                        </span>
                                        <input id="kategoriSearch" class="form-control"
                                               placeholder="Cari kategori...">
                                    </div>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0" id="kategoriTable">
                                    <thead class="table-info">
                                        <tr>
                                            <th style="width: 90px;">ID</th>
                                            <th>Nama</th>
                                            <th style="width: 190px;">Aksi</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (list != null && !list.isEmpty()) { %>
                                            <% for (Kategori k : list) { %>
                                                <tr>
                                                    <td>#<%= k.getId() %></td>
                                                    <td class="kategori-nama fw-semibold"><%= k.getNama() %></td>
                                                    <td>
                                                        <div class="d-flex gap-2">
                                                            <a class="btn btn-sm btn-outline-warning"
                                                               href="<%= request.getContextPath() %>/admin/kategori?action=edit&id=<%= k.getId() %>">
                                                                <i class="bi bi-pencil-square me-1"></i> Edit
                                                            </a>

                                                            <form method="post"
                                                                  action="<%= request.getContextPath() %>/admin/kategori"
                                                                  onsubmit="return confirm('Yakin hapus kategori ini?');">
                                                                <input type="hidden" name="action" value="delete">
                                                                <input type="hidden" name="id" value="<%= k.getId() %>">
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
                                                <td colspan="3" class="text-center text-muted py-4">
                                                    Data kosong
                                                </td>
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

        <!-- Search ringan -->
        <script>
            (function () {
                const input = document.getElementById('kategoriSearch');
                const table = document.getElementById('kategoriTable');
                if (!input || !table) return;

                input.addEventListener('input', function () {
                    const q = this.value.toLowerCase().trim();
                    const rows = table.querySelectorAll('tbody tr');
                    rows.forEach(r => {
                        const cell = r.querySelector('.kategori-nama');
                        const text = (cell ? cell.textContent : '').toLowerCase();
                        if (!cell) return;
                        r.style.display = text.includes(q) ? '' : 'none';
                    });
                });
            })();
        </script>

    </div>
</div>
</body>
</html>
