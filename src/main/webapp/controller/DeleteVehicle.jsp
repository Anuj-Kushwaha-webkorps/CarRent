<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="com.carmanagement.connection.GetJDBCConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page language="java" %>
<%
    // Get the vehicle_id from the request parameter
    String vehicleId = request.getParameter("vehicle_id");
    
    if (vehicleId != null && !vehicleId.isEmpty()) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            // Assuming you have a method for getting the DB connection
			 conn = GetJDBCConnection.getConnection();
            // Prepare SQL query to delete the vehicle
            String sql = "DELETE FROM vehicles WHERE vehicle_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(vehicleId));

            // Execute the delete query
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // Redirect to the list page with a success message
                response.sendRedirect("/CarManagement/View/adminDashboard.jsp");
            } else {
                // Redirect to the list page with an error message
                response.sendRedirect("/CarManagement/View/login.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle any SQL errors
            response.sendRedirect("/CarManagement/View/login.jsp");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        // If no vehicle_id is provided, redirect to the list with an error
        response.sendRedirect("/CarManagement/View/login.jsp");
    }
%>
