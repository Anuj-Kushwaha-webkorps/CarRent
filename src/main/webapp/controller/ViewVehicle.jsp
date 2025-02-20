<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.carmanagement.entity.Vehicle" %>
<%@ page import="com.carmanagement.DBoperations.JdbcOperations" %>

<%

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
	
    // Fetching vehicle list from the database
    JdbcOperations jdOperation = new JdbcOperations();
    List<Vehicle> vehicleList = jdOperation.getAllVehicles(adminId); 
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle List</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/View/style.css">
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(230deg, rgba(11, 141, 234, 0.469), rgba(227, 19, 126, 0.403));
            text-align: center;
        }
        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 20px;
        }
        .card {
            width: 300px;
            background: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            text-align: left;
        }
        .card h3 {
            margin: 0;
            color: #333;
        }
        .card p {
            margin: 5px 0;
            color: #555;
        }
        .card .actions {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }
        .btn {
            padding: 8px 12px;
            text-decoration: none;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
        }
        .edit-btn {
            background-color: #28a745;
        }
        .delete-btn {
            background-color: #dc3545;
        }
    </style>
</head>
<body>

    <h2>Vehicle List</h2>
    <div class="container">
        <%
            if (vehicleList != null && !vehicleList.isEmpty()) {
                for (Vehicle vehicle : vehicleList) {
        %>
            <div class="card">
                <h3><%= vehicle.getName() %></h3>
                <p><strong>Brand:</strong> <%= vehicle.getBrand() %></p>
                <p><strong>Model:</strong> <%= vehicle.getModel() %></p>
                <p><strong>Rental Price:</strong> ₹<%= vehicle.getRental_price_per_hr() %> per hour</p>
                <p><strong>Availability:</strong> <%= vehicle.getAvailability() %></p>
                <p><strong>Fuel Type:</strong> <%= vehicle.getFuel_type() %></p>

                <div class="actions">
                    <a href="/CarManagement/View/editVehicle.jsp?vehicle_id=<%= vehicle.getVehicle_id() %>" class="btn edit-btn">Edit</a>
                    <a href="/CarManagement/deleteVehicle?vehicle_id=<%= vehicle.getVehicle_id() %>" class="btn delete-btn" 
                       onclick="return confirm('Are you sure you want to delete this vehicle?');">
                        Delete
                    </a>
                </div>
            </div>
        <%
                }
            } else {
        %>
            <p>No vehicles found.</p>
        <%
            }
        %>
    </div>

</body>
</html>
