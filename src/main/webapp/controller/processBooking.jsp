<%@ page import="java.sql.*" %>
<%@ page import="com.carmanagement.connection.GetJDBCConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String vehicleId = request.getParameter("vehicle_id");
    String customerId = "1"; // Assume user is logged in (Replace with session-based user ID)
    String startDate = request.getParameter("start_date");
    String endDate = request.getParameter("end_date");
    String totalCost = request.getParameter("total_cost");
    String admin_id = request.getParameter("admin_id");

    // int adminId = -1; // Default invalid value
    Cookie[] cookies = request.getCookies();

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("customer_id")) { // Ensure the cookie name matches
                customerId = cookie.getValue();
                break;
            }
        }
    }
    
    
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        
        conn = GetJDBCConnection.getConnection();

        String sql = "INSERT INTO bookings (vehicle_id, customer_id, start_date, end_date, total_cost, admin_id) VALUES (?, ?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, Integer.parseInt(vehicleId));
        stmt.setInt(2, Integer.parseInt(customerId));
        stmt.setString(3, startDate);
        stmt.setString(4, endDate);
        stmt.setDouble(5, Double.parseDouble(totalCost));
        stmt.setInt(6, Integer.parseInt(admin_id));
        

        int rowsInserted = stmt.executeUpdate();
        if (rowsInserted > 0) {
            //response.sendRedirect("success.jsp");
            response.sendRedirect("/CarManagement/View/customerDashboard.jsp");
        } else {
            response.sendRedirect("error.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
