<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat" %>
<%@ page import="com.carmanagement.connection.GetJDBCConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Current Bookings</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
    body{
        background: linear-gradient(230deg, rgba(11, 141, 234, 0.469), rgba(227, 19, 126, 0.403));
    
    }
    .booking-card {
        border: 1px solid #ccc;
        padding: 15px;
        margin: 10px 0;
        border-radius: 8px;
        box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        background : white;
    }
    .return-btn, .extend-btn {
        margin-top: 10px;
        padding: 8px 12px;
        border: none;
        cursor: pointer;
        font-size: 14px;
    }
    .return-btn {
        background-color: red;
        color: white;
    }
    .extend-btn {
        background-color: green;
        color: white;
    }
    .extend-section {
        margin-top: 10px;
        display: none;
    }
    .error-message {
        color: red;
        font-weight: bold;
    }
    .container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 20px;
        padding: 20px;
    }
    </style>
</head>
<body>

<h2>My Current Bookings</h2>

<div class="container">

<%
double totalCostTillNow = 0.00;

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

            String sql = "SELECT b.booking_id, v.Vehicle_name, v.Rental_price_per_hr, b.start_date, b.end_date,b.total_cost, b.vehicle_id " +
                         "FROM bookings b INNER JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                         "WHERE b.customer_id = ? ORDER BY b.start_date DESC";

            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(customerId));
            rs = stmt.executeQuery();

            boolean hasBookings = false;
            
            while (rs.next()) {
                hasBookings = true;
                int bookingId = rs.getInt("booking_id");
                int vehicleId = rs.getInt("vehicle_id");
                String vehicleName = rs.getString("Vehicle_name");
                double pricePerHour = rs.getDouble("Rental_price_per_hr");
                String startDate = rs.getString("start_date");
                String endDate = rs.getString("end_date");
                 totalCostTillNow = rs.getDouble("total_cost");
%>

<div class="booking-card" id="booking-<%= bookingId %>">
    <h3><%= vehicleName %></h3>
    <p><strong>Start Date:</strong> <%= startDate %></p>
    <p><strong>End Date:</strong> <%= endDate %></p>
    <p><strong>Price per Day:</strong> ₹<%= pricePerHour %></p>
    <p><strong>Total Cost till now:</strong> ₹<%= totalCostTillNow %></p>

    <button class="return-btn" data-booking-id="<%= bookingId %>">Return</button>
    <button class="extend-btn" data-booking-id="<%= bookingId %>" data-vehicle-id="<%= vehicleId %>" data-current-end="<%= endDate %>" data-current-start="<%= startDate %>" data-price="<%= pricePerHour %>">Extend Booking</button>

    <!-- Extend Booking Section -->
    <div class="extend-section" id="extend-section-<%= bookingId %>">
        <label>New End Date:</label>
        <input type="date" class="new-end-date" id="new-end-date-<%= bookingId %>">
        <p class="error-message" id="error-msg-<%= bookingId %>" style="display: none;"></p>
        <p><strong>Updated Total Cost: ₹<span id="total-cost-<%= bookingId %>">0</span></strong></p>
        <button class="confirm-extend-btn" data-booking-id="<%= bookingId %>">Confirm</button>
    </div>
</div>

<%
            }

            if (!hasBookings) {
%>
    <p>No current bookings found.</p>
<%
            }
        } catch (Exception e) {
            e.printStackTrace();
%>
    <p class="error-message">Error fetching bookings.</p>
<%
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }
%>


<script>

$(document).ready(function() {
    $(".return-btn").click(function() {
        var bookingId = $(this).data("booking-id");

        if (confirm("Are you sure you want to return this vehicle?")) {
            $.post("/CarManagement/controller/returnedBooking.jsp", { booking_id: bookingId }, function(response) {
                alert(response);
                location.reload();
            });
        }
    });

    $(".extend-btn").click(function() {
        var bookingId = $(this).data("booking-id");
        var vehicleId = $(this).data("vehicle-id");
        var currentEndDate = new Date($(this).data("current-end"));
        var nextDay = new Date(currentEndDate);
        nextDay.setDate(nextDay.getDate() + 1); // Min date is next day after current end date
        var nextDayString = nextDay.toISOString().split("T")[0];

        $("#extend-section-" + bookingId).toggle();
        $("#new-end-date-" + bookingId).attr("min", nextDayString); 

        $.get("/CarManagement/controller/getBookedDates.jsp", { vehicle_id: vehicleId }, function(response) {
            let bookedDates = response;
            var firstFutureBooking = bookedDates.find(date => new Date(date) > currentEndDate);
            if (firstFutureBooking) {
                $("#new-end-date-" + bookingId).attr("max", firstFutureBooking);
            }
        }, "json");
    });

    $(".confirm-extend-btn").click(function() {
        var bookingId = $(this).data("booking-id");
        var newEndDate = $("#new-end-date-" + bookingId).val();
        var errorMsg = $("#error-msg-" + bookingId);

        if (!newEndDate) {
            errorMsg.text("Please select a new end date.").show();
            return;
        }

        // Calculate totalCost directly here
        var pricePerHour = parseFloat($("#booking-" + bookingId + " .extend-btn").data("price"));
        var currentStartDate = new Date($("#booking-" + bookingId + " .extend-btn").data("current-start"));
        var newEndDateObj = new Date(newEndDate);

        var additionalDays = (newEndDateObj - currentStartDate) / (1000 * 60 * 60 * 24);
        var totalCost = additionalDays * pricePerHour;

        // Update the displayed total cost
        $("#total-cost-" + bookingId).text(totalCost.toFixed(2));

        // Send the totalCost along with the booking ID and new end date
        $.post("/CarManagement/controller/extendBooking.jsp", { 
            booking_id: bookingId, 
            new_end_date: newEndDate,
            total_cost: totalCost
        }, function(response) {
            alert(response);
            location.reload();
        });
    });

    $(".new-end-date").on("change", function() {
        var bookingId = $(this).closest(".booking-card").find(".confirm-extend-btn").data("booking-id");
        var pricePerHour = parseFloat($("#booking-" + bookingId + " .extend-btn").data("price"));
        var currentEndDate = new Date($("#booking-" + bookingId + " .extend-btn").data("current-end"));
        var newEndDate = new Date($(this).val());

        var additionalDays = (newEndDate - currentEndDate) / (1000 * 60 * 60 * 24);
        var totalCost = additionalDays * pricePerHour;

        $("#total-cost-" + bookingId).text(totalCost.toFixed(2));
    });
});
</script>


<script>


</script>
</body>
</html>
