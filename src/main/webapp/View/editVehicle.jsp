<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="com.carmanagement.entity.Vehicle" %>
<%@ page import="com.carmanagement.DBoperations.JdbcOperations" %>
<%@ page import="com.carmanagement.connection.GetJDBCConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page language="java" %>
<%
    // Get the vehicle_id from the request parameter
    String vehicleId = request.getParameter("vehicle_id");
    Vehicle vehicle = null;

    if (vehicleId != null && !vehicleId.isEmpty()) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Establish a database connection
            conn = GetJDBCConnection.getConnection();

            // Prepare SQL query to fetch the vehicle details
            String sql = "SELECT * FROM vehicles WHERE vehicle_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(vehicleId));

            // Execute the query and get the result set
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Create a Vehicle object with the data from the result set
                vehicle = new Vehicle();
                vehicle.setName(rs.getString("Vehicle_name"));
                vehicle.setBrand(rs.getString("Brand"));
                vehicle.setModel(rs.getString("Model"));
                vehicle.setRental_price_per_hr(rs.getInt("Rental_price_per_hr"));
                vehicle.setFuel_type(rs.getString("Fuel_type"));
                vehicle.setAvailability(rs.getString("Availability"));
                vehicle.setVehicle_id(rs.getInt("Vehicle_id"));
                // Add more fields as needed
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // please handle anuj
    if (vehicle == null) {
        // If vehicle not found, redirect to the list page with an error
        response.sendRedirect("vehicleList.jsp?message=Vehicle+not+found");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Vehicle</title>
 <link rel="stylesheet" href="<%= request.getContextPath() %>/View/login.css">

     <!-- google font - Mulish -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Mulish:wght@200;300;400;500;600;700;800&family=Nunito:wght@200;300;400;600;700&display=swap" rel="stylesheet">
  
  <!-- fontawsome link -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body>

    <header>
        <div class="logo flex">
            <div>
              <img src="<%= request.getContextPath() %>/View/logo.png" alt="house_logo">
            </div>
            <h3>CarRent</h3>
          </div>
    </header>

    <!-- Display form pre-filled with vehicle details -->
<form style="height: 74vh;" method="post" action="/CarManagement/editVehicle" >
            <h1 style="margin: 0px; padding: 0px;"> Edit Vehicle</h1>
             <input type="hidden" name="vehicle_id" value="<%= vehicle.getVehicle_id() %>" />
            
            <i class="fa-solid fa-car left"></i><input type="text" name="name" value="<%= vehicle.getName() %>" placeholder="Enter vehicle name " required><br>

            <i class="fa-solid fa-copyright left"></i><input type="text" name="brand" value="<%= vehicle.getBrand() %>" placeholder="Enter brand name " required><br>

            <i class="fa-solid fa-hexagon-nodes"></i><input type="text" name="model" value="<%= vehicle.getModel() %>" placeholder="Enter model " required><br>

            <i class="fa-solid fa-indian-rupee-sign left"></i><input type="number" name="rental_price_per_hr" value="<%= vehicle.getRental_price_per_hr() %>" placeholder="Enter rental price per hour" required><br>

            <label class="form-label">Fuel Type:</label>
			<select class="form-select" name="availability" required>
                    <option  value="Available" <%= "Available".equals(vehicle.getAvailability()) ? "selected" : "" %>>Available</option>
                    <option value="Not_Available" <%= "Not_Available".equals(vehicle.getAvailability()) ? "selected" : "" %>>Not Available</option>
            </select><br>
            
             <!-- Fuel Type -->
            <div class="mb-3">
                <label class="form-label">Fuel Type:</label>
                <select class="form-select" name="fuel_type" required>
                    <option value="Petrol" <%= "Petrol".equals(vehicle.getFuel_type()) ? "selected" : "" %>>Petrol</option>
                    <option value="Diesel" <%= "Diesel".equals(vehicle.getFuel_type()) ? "selected" : "" %>>Diesel</option>
                    <option value="Electric" <%= "Electric".equals(vehicle.getFuel_type()) ? "selected" : "" %>>Electric</option>
                    <option value="Hybrid" <%= "Hybrid".equals(vehicle.getFuel_type()) ? "selected" : "" %>>Hybrid</option>
                </select>
            </div>
                        
            <button type="submit">Submit</button>
        </form>
  

</body>
</html>
