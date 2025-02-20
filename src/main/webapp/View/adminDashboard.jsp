<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="icon" href="logo.ico" type="image/x-icon">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/View/login.css">

     <!-- google font - Mulish -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Mulish:wght@200;300;400;500;600;700;800&family=Nunito:wght@200;300;400;600;700&display=swap" rel="stylesheet">
  
  <!-- fontawsome link -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
  
  <style>
  
  	main{
  		width : 25%;
    height : 30vh;
    flex-direction: column;
    background-color: white;
    margin: auto;
    margin-top : 30px;
    border-radius: 20px;
    gap : 5px;
    text-align: center;
    padding-top : 25px;
    box-shadow: 0px 0px 2px 2px gray;
  	}
  	.adminDashboard{
  		display : flex;
		flex-direction: column;
    	align-items: center;
    	justify-content : center;
    	text-align: center;  		
  		list-style: none;
  		text-decoration : none;
  		padding : 0px;
  	}
  	.adminDashboard li{
  		padding : 5px;
  	}
  	.adminDashboard li a{
  		font-size : 20px;
  		text-decoration : none;
  		padding : 5px;
  	}
  </style>
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
    	<ul class ="adminDashboard">
    		<li><a href="/CarManagement/View/addVehicle.jsp" >Add Vehicle</a> </li> 
        
    		<li><a href="/CarManagement/viewVehicle" >View Vehicle</a> </li> 
        
    		<li><a href="/CarManagement/View/bookingHistory.jsp" >Booking List</a> </li> 
    	</ul>
        
    </main>
</body>
</html>