<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title><%= request.getAttribute("pageTitle") != null ? request.getAttribute("pageTitle") : "Toksem Satset" %></title>

<!-- Bootstrap CSS dulu -->
<link href="<%= request.getContextPath() %>/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Icons CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<!-- Custom CSS terakhir (override di sini) -->
<link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
