<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="com.carmanagement.DBoperations.JdbcOperations"%>
<%@page import=" com.carmanagement.entity.Customer"%>
    
 <jsp:useBean id="admin"
class="com.carmanagement.entity.Customer" scope="page">
</jsp:useBean>

<jsp:setProperty property="*" name="admin"/>

<%
JdbcOperations jdOperation = new JdbcOperations();

if(jdOperation.addCustomer(admin)){
	response.sendRedirect("/CarManagement/View/login.jsp");
}else{
	response.sendRedirect("/CarManagement/View/index.jsp");
}

 %>