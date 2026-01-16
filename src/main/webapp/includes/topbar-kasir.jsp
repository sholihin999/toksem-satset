<%-- 
    Document   : topbar-kasir
    Created on : Dec 30, 2025
    Author     : muham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>

<%
    String title = (String) request.getAttribute("pageTitleTopbar");
    if (title == null || title.isBlank()) title = "Dashboard Kasir";

    User userKasir = (User) session.getAttribute("user");
    String namaKasir = (userKasir != null && userKasir.getNama() != null) ? userKasir.getNama() : "Kasir";
%>

<header class="app-topbar border-bottom bg-light">
    <div class="d-flex align-items-center gap-2 px-3 py-2">

        <!-- Toggle sidebar (mobile) -->
        <button class="btn btn-outline-secondary d-lg-none"
                type="button"
                data-bs-toggle="offcanvas"
                data-bs-target="#sidebarMobile"
                aria-controls="sidebarMobile"
                aria-label="Buka menu">
            <i class="bi bi-list"></i>
        </button>

        <!-- Page title -->
        <div class="fw-semibold text-truncate">
            <%= title %>
        </div>

        <!-- Search (arahkan ke transaksi kasir) -->
        <form class="ms-auto d-none d-md-flex" role="search" method="get"
              action="<%= request.getContextPath() %>/kasir/penjualan">
            <div class="input-group input-group-sm">
                <span class="input-group-text bg-white">
                    <i class="bi bi-search"></i>
                </span>
                <input class="form-control border-info"
                       type="search"
                       name="q"
                       placeholder="Cari produk…"
                       autocomplete="off" />
            </div>
        </form>

        <!-- User dropdown -->
        <div class="dropdown">
            <button class="btn btn-sm btn-outline-info dropdown-toggle"
                    data-bs-toggle="dropdown"
                    aria-expanded="false">
                <i class="bi bi-person-circle me-1"></i> <%= namaKasir %>
            </button>

            <ul class="dropdown-menu dropdown-menu-end">
                <li>
                    <a class="dropdown-item" href="<%= request.getContextPath() %>/kasir/dashboard">
                        <i class="bi bi-speedometer2 me-2"></i> Dashboard
                    </a>
                </li>
                <li>
                    <a class="dropdown-item" href="<%= request.getContextPath() %>/kasir/penjualan">
                        <i class="bi bi-cart-check me-2"></i> Transaksi
                    </a>
                </li>
                <li>
                    <a class="dropdown-item" href="<%= request.getContextPath() %>/kasir/penjualan/riwayat">
                        <i class="bi bi-clock-history me-2"></i> Riwayat
                    </a>
                </li>
                <li><hr class="dropdown-divider"></li>
                <li>
                    <a class="dropdown-item text-danger" href="<%= request.getContextPath() %>/logout">
                        <i class="bi bi-box-arrow-right me-2"></i> Logout
                    </a>
                </li>
            </ul>
        </div>

    </div>
</header>
