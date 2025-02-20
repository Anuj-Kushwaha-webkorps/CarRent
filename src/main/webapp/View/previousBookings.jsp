<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.carmanagement.connection.GetJDBCConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Previous Bookings</title>
    <link rel="stylesheet" href="styles.css">
    <style>
    	body{
    	    background: linear-gradient(230deg, rgba(11, 141, 234, 0.469), rgba(227, 19, 126, 0.403));
    	
    	}
    
        .booking-card {
        background : white;
            border: 1px solid #ccc;
            padding: 15px;
            margin: 10px 0;
            border-radius: 8px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 20px;
        }
        .error-message {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>

<h2>My Previous Bookings</h2>

<div class="container">

<%
    String customerId = null;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("customer_id".equals(cookie.getName())) {
                customerId = cookie.getValue();
                break;
            }
        }
    }

    if (customerId == null) {
%>
    <p class="error-message">Error: Customer ID not found. Please log in.</p>
<%
    } else {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = GetJDBCConnection.getConnection();

            String sql = "SELECT pb.booking_id, v.Vehicle_name, v.Rental_price_per_hr, pb.start_date, pb.end_date, pb.total_cost " +
                         "FROM previousbookings pb INNER JOIN vehicles v ON pb.vehicle_id = v.vehicle_id " +
                         "WHERE pb.customer_id = ? ORDER BY pb.start_date DESC";

            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(customerId));
            rs = stmt.executeQuery();

            boolean hasBookings = false;
            
            while (rs.next()) {
                hasBookings = true;
%>
<div class="booking-card">
    <h3><%= rs.getString("Vehicle_name") %></h3>
    <p><strong>Start Date:</strong> <%= rs.getString("start_date") %></p>
    <p><strong>End Date:</strong> <%= rs.getString("end_date") %></p>
    <p><strong>Price per Day:</strong> ₹<%= rs.getDouble("Rental_price_per_hr") %></p>
    <p><strong>Total Cost:</strong> ₹<%= rs.getDouble("total_cost") %></p>
</div>
<%
            }

            if (!hasBookings) {
%>
    <p>No previous bookings found.</p>
<%
            }
        } catch (Exception e) {
            e.printStackTrace();
%>
    <p class="error-message">Error fetching previous bookings.</p>
<%
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }
%>

</div>

</body>
</html>
