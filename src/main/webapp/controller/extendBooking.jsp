<%@ page import="java.sql.*" %>
<%@ page import="com.carmanagement.connection.GetJDBCConnection" %>
<%
    int bookingId = Integer.parseInt(request.getParameter("booking_id"));
    String newEndDate = request.getParameter("new_end_date");
    String totalCost = request.getParameter("total_cost");

    System.out.println("anuj" + totalCost);

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        conn = GetJDBCConnection.getConnection();
        String sql = "UPDATE bookings SET end_date = ?, total_cost = ? WHERE booking_id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, newEndDate);
        stmt.setDouble(2, Double.parseDouble(totalCost));
        stmt.setInt(3, bookingId);
        int rows = stmt.executeUpdate();

        if (rows > 0) {
            out.print("Booking extended successfully!");
        } else {
            out.print("Error: Unable to extend booking.");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.print("Error occurred.");
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
