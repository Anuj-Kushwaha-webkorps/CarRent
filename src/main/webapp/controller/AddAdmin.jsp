<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%@page import="com.carmanagement.DBoperations.JdbcOperations"%>
<%@page import=" com.carmanagement.entity.Admin"%>
    
 <jsp:useBean id="admin"
class="com.carmanagement.entity.Admin" scope="page">
</jsp:useBean>

<jsp:setProperty property="*" name="admin"/>

<%
JdbcOperations jdOperation = new JdbcOperations();

int adminId = jdOperation.addAdmin(admin);

if(adminId>0){
	//set session
    session.setAttribute("admin_id", adminId);

    // Set cookie (7 days)
    Cookie adminCookie = new Cookie("admin_id", String.valueOf(adminId));
    adminCookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
    adminCookie.setPath("/"); // Available for entire application
    response.addCookie(adminCookie);

    System.out.println("Admin created successfully! Admin ID: " + adminId);
	response.sendRedirect("/CarManagement/View/adminDashboard.jsp");
}else{
	response.sendRedirect("login.jsp");
}

 %>