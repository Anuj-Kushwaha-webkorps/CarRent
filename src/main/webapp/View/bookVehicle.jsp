<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat" %>
<%@ page import="com.carmanagement.connection.GetJDBCConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Vehicle</title>
    <link rel="stylesheet" href="styles.css">
    
    <!-- jQuery & jQuery UI Datepicker -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <script>
    $(document).ready(function() {
        var vehicleId = $("#vehicle_id").val();

        // Fetch booked dates from database
        $.ajax({
            url: "/CarManagement/controller/getBookedDates.jsp",
            type: "GET",
            data: { vehicle_id: vehicleId },
            dataType: "json",  // 🔹 Expect JSON response
            success: function(bookedDates) {  
                console.log("Booked Dates:", bookedDates);

                // Apply Datepicker with disabled dates
                function disableBookedDates(date) {
                    var formatted = $.datepicker.formatDate('yy-mm-dd', date);
                    return [!bookedDates.includes(formatted)];
                }

                $("#start_date, #end_date").datepicker({
                    dateFormat: "yy-mm-dd",
                    beforeShowDay: disableBookedDates,
                    minDate: 0
                });
            },
            error: function(xhr, status, error) {
                console.error("AJAX Error:", status, error);
            }
        });

        // Calculate total cost
        $("#start_date, #end_date").on("change", function() {
            var startDate = new Date($("#start_date").val());
            var endDate = new Date($("#end_date").val());

            if (startDate && endDate && startDate <= endDate) {
                var days = (endDate - startDate) / (1000 * 60 * 60 * 24) + 1;
                var dailyRate = parseFloat($("#daily_rate").val());
                var totalCost = days * dailyRate;
                $("#total_cost").val(totalCost.toFixed(2));
            }
        });
    });
    </script>
</head>
<body>

<h2>Book a Vehicle</h2>

<%
    String vehicleId = request.getParameter("vehicle_id");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String vehicleName = "";
    double dailyRate = 0.0;
    int admin_id = -1;

    try {
        conn = GetJDBCConnection.getConnection();
        String sql = "SELECT Vehicle_name, Rental_price_per_hr, Admin_id FROM vehicles WHERE vehicle_id=?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, Integer.parseInt(vehicleId));
        rs = stmt.executeQuery();

        if (rs.next()) {
            vehicleName = rs.getString("Vehicle_name");
            dailyRate = rs.getDouble("Rental_price_per_hr");
            admin_id = rs.getInt("Admin_id");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>

<form action="/CarManagement/controller/processBooking.jsp" method="post">
    <input type="hidden" name="vehicle_id" id="vehicle_id" value="<%= vehicleId %>">
    <input type="hidden" name="daily_rate" id="daily_rate" value="<%= dailyRate %>">
    <input type="hidden" name="admin_id" value="<%= admin_id %>">

    <label>Vehicle Name:</label>
    <input type="text" value="<%= vehicleName %>" readonly><br>

    <label>Start Date:</label>
    <input type="text" id="start_date" name="start_date" required><br>

    <label>End Date:</label>
    <input type="text" id="end_date" name="end_date" required><br>

    <label>Total Cost:</label>
    <input type="text" id="total_cost" name="total_cost" readonly><br>

    <button type="submit">Book Now</button>
</form>

</body>
</html>
