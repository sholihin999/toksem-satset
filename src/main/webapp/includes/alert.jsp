<%-- 
    Document   : alert
    Created on : Dec 28, 2025, 2:37:33?PM
    Author     : muham
--%>

<%
    String msg = null;
    String type = null;

    if (session.getAttribute("flashMsg") != null) {
        msg = (String) session.getAttribute("flashMsg");
        type = (String) session.getAttribute("flashType");
        session.removeAttribute("flashMsg");
        session.removeAttribute("flashType");
    } else {
        msg = request.getParameter("msg");
        type = request.getParameter("type");
    }

    if (type == null || type.isBlank()) type = "info";
%>

<% if (msg != null && !msg.isBlank()) { %>
    <div class="alert alert-<%= type %>"><%= msg %></div>
<% } %>

