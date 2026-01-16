<%-- 
    Document   : index
    Author     : muham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Supplier"%>

<%
    request.setAttribute("activeMenu", "supplier");
    request.setAttribute("pageTitle", "Manajemen Supplier - Toksem Satset");

    List<Supplier> list = (List<Supplier>) request.getAttribute("list");
    Supplier supplier = (Supplier) request.getAttribute("supplier");

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
                    <h3 class="mb-0">Manajemen Supplier</h3>
                    <div class="text-muted">Kelola data pemasok barang Toko Sembako Satset</div>
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
                                        <i class="bi bi-truck me-1"></i>
                                        <%= (supplier != null ? "Edit Supplier" : "Tambah Supplier") %>
                                    </h5>
                                    <small class="text-muted">
                                        <%= (supplier != null ? "Perbarui data supplier" : "Tambahkan supplier baru") %>
                                    </small>
                                </div>

                                <span class="badge <%= (supplier != null ? "text-bg-warning" : "text-bg-info") %>">
                                    <%= (supplier != null ? "Mode Edit" : "Mode Tambah") %>
                                </span>
                            </div>

                            <hr class="my-3">

                            <form method="post" action="<%= request.getContextPath() %>/admin/supplier">
                                <% if (supplier != null) { %>
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="id" value="<%= supplier.getId() %>">
                                <% } else { %>
                                    <input type="hidden" name="action" value="add">
                                <% } %>

                                <div class="mb-3">
                                    <label class="form-label">Nama Supplier</label>
                                    <input class="form-control" name="nama" required
                                           placeholder="Contoh: UD Sumber Rezeki"
                                           value="<%= (supplier != null ? supplier.getNama() : "") %>">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">No HP</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white">
                                            <i class="bi bi-telephone"></i>
                                        </span>
                                        <input class="form-control" name="no_hp" required
                                               placeholder="Contoh: 08xxxxxxxxxx"
                                               value="<%= (supplier != null ? supplier.getNoHp() : "") %>">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Alamat</label>
                                    <textarea class="form-control" name="alamat" rows="3" required
                                              placeholder="Alamat supplier..."><%= (supplier != null ? supplier.getAlamat() : "") %></textarea>
                                </div>

                                <button class="btn btn-info w-100">
                                    <i class="bi bi-save me-1"></i> <%= (supplier != null ? "Update" : "Tambah") %>
                                </button>

                                <% if (supplier != null) { %>
                                    <a class="btn btn-outline-secondary w-100 mt-2"
                                       href="<%= request.getContextPath() %>/admin/supplier">
                                        <i class="bi bi-x-circle me-1"></i> Batal
                                    </a>
                                <% } %>
                            </form>

                            <hr class="my-3">
                            <div class="text-muted small">
                                <i class="bi bi-lightbulb me-1"></i>
                                Tips: pastikan nomor HP valid untuk komunikasi pemesanan barang.
                            </div>
                        </div>
                    </div>
                </div>

                <!-- DAFTAR SUPPLIER -->
                <div class="col-lg-8">
                    <div class="card card-satset shadow-sm border-info">
                        <div class="card-body">

                            <div class="d-flex flex-wrap gap-2 align-items-center justify-content-between mb-2">
                                <div class="d-flex align-items-center gap-2">
                                    <h5 class="mb-0">
                                        <i class="bi bi-list-ul me-1"></i> Daftar Supplier
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
                                        <input id="supplierSearch" class="form-control border-info"
                                               placeholder="Cari supplier...">
                                    </div>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0" id="supplierTable">
                                    <thead class="table-info">
                                        <tr>
                                            <th style="width: 90px;">ID</th>
                                            <th>Nama</th>
                                            <th style="width: 170px;">No HP</th>
                                            <th>Alamat</th>
                                            <th style="width: 190px;">Aksi</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (list != null && !list.isEmpty()) { %>
                                            <% for (Supplier s : list) { %>
                                                <tr>
                                                    <td>#<%= s.getId() %></td>
                                                    <td class="supplier-nama fw-semibold"><%= s.getNama() %></td>
                                                    <td><%= s.getNoHp() %></td>
                                                    <td class="text-muted"><%= s.getAlamat() %></td>
                                                    <td>
                                                        <div class="d-flex gap-2">
                                                            <a class="btn btn-sm btn-outline-warning"
                                                               href="<%= request.getContextPath() %>/admin/supplier?action=edit&id=<%= s.getId() %>">
                                                                <i class="bi bi-pencil-square me-1"></i> Edit
                                                            </a>

                                                            <form method="post"
                                                                  action="<%= request.getContextPath() %>/admin/supplier"
                                                                  onsubmit="return confirm('Yakin hapus supplier ini?');">
                                                                <input type="hidden" name="action" value="delete">
                                                                <input type="hidden" name="id" value="<%= s.getId() %>">
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
                                                    Data supplier kosong
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
                const input = document.getElementById('supplierSearch');
                const table = document.getElementById('supplierTable');
                if (!input || !table) return;

                input.addEventListener('input', function () {
                    const q = this.value.toLowerCase().trim();
                    const rows = table.querySelectorAll('tbody tr');
                    rows.forEach(r => {
                        const cell = r.querySelector('.supplier-nama');
                        if (!cell) return;
                        const text = cell.textContent.toLowerCase();
                        r.style.display = text.includes(q) ? '' : 'none';
                    });
                });
            })();
        </script>

    </div>
</div>
</body>
</html>
