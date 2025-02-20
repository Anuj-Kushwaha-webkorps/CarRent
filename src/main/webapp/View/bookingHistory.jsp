<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat" %>
<%@ page import="com.carmanagement.connection.GetJDBCConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking History</title>
    
    <!-- Bootstrap for Styling -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<style>
	
	body{
	    background: linear-gradient(230deg, rgba(11, 141, 234, 0.469), rgba(227, 19, 126, 0.403));
	
	}
	
	</style>
    <script>
    $(document).ready(function() {
        // Handle Cancel Booking
        $(".cancel-booking").click(function() {
            var bookingId = $(this).data("booking-id");
            var card = $(this).closest(".card");  // Get card element

            if (confirm("Are you sure you want to cancel this booking?")) {
                $.ajax({
                    url: "/CarManagement/controller/cancelBooking.jsp",
                    type: "POST",
                    data: { booking_id: bookingId },
                    success: function(response) {
                        if (response.trim() === "success") {
                            alert("Booking Cancelled Successfully!");
                            card.fadeOut(500, function() { $(this).remove(); }); // Remove card smoothly
                        } else {
                            alert("Error Cancelling Booking!");
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("AJAX Error:", status, error);
                        alert("Failed to cancel booking!");
                    }
                });
            }
        });
    });
    </script>
</head>
<body class="container mt-4">
    <h2 class="text-center">Booking History</h2>
    <div class="row">
        
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            
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

            try {
                conn = GetJDBCConnection.getConnection();
                String sql = "SELECT b.booking_id, b.start_date,b.total_cost, b.end_date, v.Vehicle_name,v.Brand " +
                        "FROM bookings b " +
                        "INNER JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                        "WHERE v.admin_id = ? " +
                        "ORDER BY b.start_date DESC";
				 stmt = conn.prepareStatement(sql);
                stmt.setInt(1, adminId);
                rs = stmt.executeQuery();

                while (rs.next()) {
                    int bookingId = rs.getInt("booking_id");
                    String vehicleName = rs.getString("Vehicle_name");
                    double totalCost = rs.getDouble("total_cost");
                    String startDate = rs.getString("start_date");
                    String endDate = rs.getString("end_date");
                    String brand = rs.getString("Brand");
        %>

        <!-- Booking Card -->
        <div class="col-md-4">
            <div class="card mb-3">
                <div class="card-body" style=" box-shadow: 1px 1px;">
                    <h5 class="card-title"><%= vehicleName %></h5>
                    <p class="card-text">
                        <strong>Brand :</strong> <%= brand %><br>
                        <strong>Start Date:</strong> <%= startDate %> <br>
                        <strong>End Date:</strong> <%= endDate %> <br>
                        <strong>Total cost:</strong> ₹<%= totalCost %>
                    </p>
                   <!-- <button class="btn btn-danger cancel-booking" data-booking-id="<%= bookingId %>">Cancel Booking</button> -->
                </div>
            </div>
        </div>

        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>

    </div>
</body>
</html>
