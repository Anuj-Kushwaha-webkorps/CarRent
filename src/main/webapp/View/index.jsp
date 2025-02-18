<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CarRent</title>
    <link rel="icon" href="logo.ico" type="image/x-icon">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/View/index.css">

    <!-- google font - Mulish -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Mulish:wght@200;300;400;500;600;700;800&family=Nunito:wght@200;300;400;600;700&display=swap" rel="stylesheet">
  
  <!-- fontawsome link -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

  <!-- swiper -->
  <link rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"
/>
</head>
<body>
     
  <header class="flex nav">
    <div class="logo flex">
      <div>
        <img src="<%= request.getContextPath() %>/View/logo.png" alt="house_logo">
      </div>
      <h3>CarRent</h3>
    </div>
    
    <div class="navbar">
      <div>
        <a href="">Home</a>
        <a href="">FAQ</a>
        <a href="">Help</a>
        <a href="">About</a>
      </div>
     
      <div class="btn-nav">
      <button class="login btn"><a href="/CarManagement/View/login.jsp">Login</a></button>
      <button class = "signup btn"><a href="/CarManagement/View/registerAdmin.jsp">SignUp Admin</a></button>
      <button class = "signup btn"><a href="/CarManagement/View/registerUser.jsp">SignUp User</a></button>
      
      </div>
    </div>

    <div class="menu"><i class="fa-solid fa-bars"></i></div>

  </header>

<main>
    <section class="intro flex">
        <div class="detail flex">
            <h2>Introducing CarRent</h2>
            <p>Car Rent is an online platform that enables users to rent vehicles conveniently. 
                It offers a wide range of cars, bikes, and other vehicles for short-term and long-term rentals. 
              . The platform ensures a hassle-free rental experience with easy pickup and return options.
            </p>
            <button ><a href="http://localhost:8080/login">Get started</a></button>
        </div>

        <div class="img">
      
        </div>
    </section>

    <section class="features flex">
        <div class="image">
    
        </div>
          <div class="points">
              <h2> Why To Choose Us ?</h2>
              <p>Wide Vehicle Selection </p>
              <p> Affordable Pricing </p>
              <p>Easy Booking Process </p>
              <p> Flexible Rental Plans </p>
              <p>24/7 Customer Support </p>
              <p>Trusted by Thousands </p>
          </div>
    </section>

</main>
<footer>
    <div class="title">
      <div class="logo">
        <iconify-icon icon="noto-v1:wrapped-gift"></iconify-icon>
        <h3>CarRent</h3>
      </div>
      <p>CarRent is the world s 
        leading community for rent 
        and renter s document 
        management.</p>
    </div>
    <div class="location">
      <h3>Our Location</h3>
      <p>163, Chhatrachaya colony , Pithampur, Indore ( M. P )</p>
    </div>
    <div class="quickLinks">
      <h3>Quick Links</h3>
      <a href="">Home</a>
      <a href="">About</a>
      <a href="">Contact</a>
      <a href="">Get started</a>
    </div>
  </footer>


<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<script src="app.js"></script>
</body>
</html>