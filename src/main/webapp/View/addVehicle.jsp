<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Vehicle</title>
    <link rel="icon" href="logo.ico" type="image/x-icon">
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

    <main >
        <form style="height: 74vh;" method="post" action="/CarManagement/addAdmin" >
            <h1 style="margin: 0px; padding: 0px;">Vehicle</h1>
            <i class="fa-solid fa-car left"></i><input type="text" name="vehicle_name" placeholder="Enter vehicle name " required><br>

            <i class="fa-solid fa-copyright left"></i><input type="text" name="brand" placeholder="Enter brand name " required><br>

            <i class="fa-solid fa-hexagon-nodes"></i><input type="text" name="model" placeholder="Enter model " required><br>

            <i class="fa-solid fa-indian-rupee-sign left"></i><input type="number" name="rental_price_per_hour" placeholder="Enter rental price per hour" required><br>

            <label class="form-label">Fuel Type:</label>
			<select class="form-select" name="availability_status" required>
                    <option value="true">Available</option>
                    <option value="false">Not Available</option>
            </select><br>
            
             <!-- Fuel Type -->
            <div class="mb-3">
                <label class="form-label">Fuel Type:</label>
                <select class="form-select" name="fuel_type" required>
                    <option value="Petrol">Petrol</option>
                    <option value="Diesel">Diesel</option>
                    <option value="Electric">Electric</option>
                    <option value="Hybrid">Hybrid</option>
                </select>
            </div>
                        
            <button type="submit">Add Vehicle</button>
        </form>
    </main>
</body>
</html>