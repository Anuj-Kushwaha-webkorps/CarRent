<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SignUp</title>
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

    <main>
        <form style="height:52vh;" method="post" action="/CarManagement/addUser" >
            <h1 style="margin: 0px; padding: 0px;">Customer</h1>
            <i class="fa-solid fa-user left"></i><input type="text" placeholder="Enter your Name" id="username" name = "name" ><br>
            <i class="fa-solid fa-envelope left"></i><input type="text" placeholder="Enter your email " name= "email"><br>
            <i class="fa-solid fa-lock left"></i><input type="password" placeholder="Enter password" id="password" name="password"><br>
            
            <button type="submit">SignUP</button>
        </form>
    </main>
</body>
</html>