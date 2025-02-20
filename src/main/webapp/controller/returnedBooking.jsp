<%@ page import="java.sql.*" %>
<%@ page import="com.carmanagement.connection.GetJDBCConnection" %>
<%@ page import="java.math.BigDecimal" %>
<%
    int bookingId = Integer.parseInt(request.getParameter("booking_id"));
    Connection conn = null;
    PreparedStatement insertStmt = null;
    PreparedStatement deleteStmt = null;
    ResultSet rs = null;

    try {
        conn = GetJDBCConnection.getConnection();
        
        // 🔹 Fetch Booking Details Before Deleting
        String fetchSQL = "SELECT customer_id, vehicle_id, start_date, end_date, total_cost, admin_id FROM bookings WHERE booking_id = ?";
        PreparedStatement fetchStmt = conn.prepareStatement(fetchSQL);
        fetchStmt.setInt(1, bookingId);
        rs = fetchStmt.executeQuery();

        if (rs.next()) {
            int customerId = rs.getInt("customer_id");
            int vehicleId = rs.getInt("vehicle_id");
            String startDate = rs.getString("start_date");
            String endDate = rs.getString("end_date");
            BigDecimal totalCost = rs.getBigDecimal("total_cost");
            int admin_id = rs.getInt("admin_Id");


            // 🔹 Fetch Vehicle Name
            //String vehicleSQL = "SELECT Vehicle_name FROM vehicles WHERE vehicle_id = ?";
            //PreparedStatement vehicleStmt = conn.prepareStatement(vehicleSQL);
            //vehicleStmt.setInt(1, vehicleId);
            //ResultSet vehicleRs = vehicleStmt.executeQuery();
            //String vehicleName = vehicleRs.next() ? vehicleRs.getString("Vehicle_name") : "Unknown";

            // 🔹 Insert into `previous_bookings`
            String insertSQL = "INSERT INTO previousbookings (customer_id, vehicle_id, start_date, end_date, total_cost, admin_id) VALUES (?, ?, ?, ?,?, ?)";
            insertStmt = conn.prepareStatement(insertSQL);
            insertStmt.setInt(1, customerId);
            insertStmt.setInt(2, vehicleId);
            insertStmt.setString(3, startDate);
            insertStmt.setString(4, endDate);
            insertStmt.setBigDecimal(5, totalCost);
            insertStmt.setInt(6, admin_id);
            insertStmt.executeUpdate();
        }

        // 🔹 Now delete the booking
        String deleteSQL = "DELETE FROM bookings WHERE booking_id = ?";
        deleteStmt = conn.prepareStatement(deleteSQL);
        deleteStmt.setInt(1, bookingId);
        int rows = deleteStmt.executeUpdate();

        if (rows > 0) {
            out.print("Booking returned successfully and moved to history!");
        } else {
            out.print("Error: Unable to return booking.");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.print("Error occurred.");
    } finally {
        if (rs != null) rs.close();
        if (insertStmt != null) insertStmt.close();
        if (deleteStmt != null) deleteStmt.close();
        if (conn != null) conn.close();
    }
%>
