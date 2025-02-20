<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="com.carmanagement.DBoperations.JdbcOperations"%>
<%@page import="com.carmanagement.entity.Vehicle"%>

<jsp:useBean id="vehicle" class="com.carmanagement.entity.Vehicle" scope="page" />
<jsp:setProperty property="*" name="vehicle"/>

<%
    // Retrieve admin_id from cookies
    int adminId = -1; // Default invalid value
    Cookie[] cookies = request.getCookies();

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("admin_id")) { // Ensure the cookie name matches
                adminId = Integer.parseInt(cookie.getValue());
                break;
            }
        }
    }

    if (adminId != -1) { // If a valid admin_id is found
        vehicle.setAdmin_id(adminId); // Manually setting admin_id
    } else {
        response.sendRedirect("/CarManagement/View/login.jsp"); // Redirect if admin_id is not found
        return;
    }

    // Call the addVehicle method
    JdbcOperations jdOperation = new JdbcOperations();
    if (jdOperation.addVehicle(vehicle)) {
        response.sendRedirect("View/index.jsp");
    } else {
        response.sendRedirect("/CarManagement/View/login.jsp");
    }
%>
