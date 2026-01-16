<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login - Toksem Satset</title>

    <link href="<%= request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath()%>/css/style.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body{
            background: radial-gradient(1200px 600px at 20% 10%, rgba(13,202,240,.20), transparent 60%),
                        radial-gradient(900px 500px at 90% 30%, rgba(13,110,253,.15), transparent 55%),
                        #f4f6f9;
            min-height:100vh;
        }
        .login-card{
            border: 0;
            border-radius: 18px;
            overflow:hidden;
        }
        .brand-panel{
            background: linear-gradient(145deg, rgba(13,202,240,.18), rgba(13,110,253,.12));
            border-right: 1px solid rgba(0,0,0,.06);
        }
        .brand-badge{
            width:48px;height:48px;border-radius:14px;
            display:grid;place-items:center;
            background: #0dcaf0;
            color:#fff;
            box-shadow: 0 10px 24px rgba(13,202,240,.25);
            font-size:22px;
        }
        .muted{
            color: rgba(0,0,0,.60);
        }
        .form-wrap{
            background:#fff;
        }
        .btn-eye{
            width:44px;
            height:44px;
            border-radius:12px;
        }
        @media (max-width: 991.98px){
            .brand-panel{ border-right:0; border-bottom:1px solid rgba(0,0,0,.06); }
        }
    </style>
</head>

<body>
<%
    String error = (String) request.getAttribute("error");
%>

<div class="container d-flex align-items-center justify-content-center py-4" style="min-height:100vh;">
    <div class="card login-card shadow-sm w-100" style="max-width: 920px;">
        <div class="row g-0">

            <!-- LEFT BRAND -->
            <div class="col-lg-5 d-none d-lg-flex brand-panel p-4 p-xl-5 flex-column">
                <div class="d-flex align-items-center gap-3 mb-4">
                    <div class="brand-badge">
                        <i class="bi bi-basket3"></i>
                    </div>
                    <div>
                        <div class="fw-bold fs-4 lh-1">Toksem Satset</div>
                        <small class="muted">Website Manajemen Toko Sembako</small>
                    </div>
                </div>

                <div class="muted mb-4">
                    Kelola produk, pembelian, penjualan, dan laporan dengan cepat dan rapi.
                </div>

                <div class="text-center my-3">
                    <img src="<%= request.getContextPath()%>/images/logo-toksem.png"
                         alt="Toksem Satset"
                         style="max-width:190px; opacity:.95;">
                </div>

                <div class="mt-auto small muted">
                    <i class="bi bi-shield-check me-1"></i>
                    Sistem login aman • © <%= java.time.Year.now()%> Toksem Satset
                </div>
            </div>

            <!-- RIGHT FORM -->
            <div class="col-lg-7 form-wrap p-4 p-lg-5">
                <div class="mb-4">
                    <div class="d-flex align-items-center gap-2 mb-1">
                        <span class="badge text-bg-info">
                            <i class="bi bi-box-arrow-in-right me-1"></i> Login
                        </span>
                    </div>
                    <h3 class="mb-1 fw-bold">Masuk</h3>
                    <div class="text-muted">Silakan masuk untuk melanjutkan</div>
                </div>

                <% if (error != null && !error.isBlank()) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle me-1"></i>
                        <%= error %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>

                <form method="post" action="<%= request.getContextPath()%>/login">

                    <label class="form-label fw-semibold">Username</label>
                    <div class="input-group mb-3">
                        <span class="input-group-text bg-white">
                            <i class="bi bi-person"></i>
                        </span>
                        <input type="text" class="form-control"
                               id="username" name="username"
                               placeholder="Masukkan username" required autofocus>
                    </div>

                    <label class="form-label fw-semibold">Password</label>
                    <div class="input-group mb-3">
                        <span class="input-group-text bg-white">
                            <i class="bi bi-lock"></i>
                        </span>
                        <input type="password" class="form-control"
                               id="password" name="password"
                               placeholder="Masukkan password" required>

                        <button type="button" class="btn btn-outline-secondary btn-eye"
                                onclick="togglePassword()" aria-label="Tampilkan password">
                            <i id="eyeIcon" class="bi bi-eye"></i>
                        </button>
                    </div>

                    <button class="btn btn-info w-100 py-2 fw-semibold">
                        <i class="bi bi-box-arrow-in-right me-1"></i> Masuk
                    </button>

                    <div class="text-center small text-muted mt-3">
                        Pastikan username & password benar.
                    </div>
                </form>

            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function togglePassword() {
        const input = document.getElementById("password");
        const icon = document.getElementById("eyeIcon");

        if (input.type === "password") {
            input.type = "text";
            icon.classList.remove("bi-eye");
            icon.classList.add("bi-eye-slash");
        } else {
            input.type = "password";
            icon.classList.remove("bi-eye-slash");
            icon.classList.add("bi-eye");
        }
    }
</script>

</body>
</html>
