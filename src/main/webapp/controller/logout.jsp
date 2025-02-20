<%@ page contentType="text/html;charset=UTF-8" %>
<%
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("admin_id".equals(cookie.getName()) || "customer_id".equals(cookie.getName())) {
                cookie.setMaxAge(0);
                cookie.setPath("/"); // Ensure deletion across the app
                response.addCookie(cookie);
            }
        }
    }
    response.sendRedirect("/CarManagement"); // Redirect to login page
%>
