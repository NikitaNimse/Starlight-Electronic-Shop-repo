<% 
    // Check if the user is logged in by verifying the session attribute
    String userEmail = (String) session.getAttribute("email");
    if (userEmail == null) {
        // If the user is not logged in, redirect to the login page
        response.sendRedirect("./Login.jsp");
        return; // Stop further execution
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electronic Shop</title>
    <link rel="stylesheet" href="./css/Dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="logo">
                <a href="#">E-Shop</a>
            </div>
            <nav class="navbar">
                <ul>
                    <li><a href="./Dashboard.jsp">Dashboard</a></li>
                    <li><a href="./report-dashboard.jsp">Reports</a></li>
                   
                </ul>
            </nav>
            <div class="header-icons">
<!--                <a href="#"><i class="fas fa-search"></i></a>
                <a href="#"><i class="fas fa-shopping-cart"></i></a>-->
            </div>
        </div>
    </header>

  

 <!--- Main Content --->
 <main>
      
    <div class="container">

    <h1 style="justify-content:center;text-align:center; color:#007bff">Admin Dashboard</h1>
        <div class="row">

            <!-- Card 1 -->
            <div class="col-md-6 col-lg-4">
                <div class="card">
                    <img src="../Images/AdminDashboard/product-manage.jpeg" alt="product 1">
                   <a href="./manage-product.jsp"><button class="product-button">Manage Products</button></a>
                </div>
            </div>
            
            <!-- Card 2 -->
            <div class="col-md-6 col-lg-4">
                <div class="card">
                    <img src="../Images/AdminDashboard/register-manage.jpg" alt="product2">
                    <a href="./manage-registration.jsp"> <button class="product-button">Manage User Registration</button> </a>
                </div>
            </div>

            <!-- Card 3 -->
            <div class="col-md-6 col-lg-4">
                <div class="card">
                    <img src="../Images/AdminDashboard/manage-feedback.png" alt="product 3">
                    <a href="./manage-feedback.jsp"> <button class="product-button">Manage User Feedback</button> </a>
                </div>
            </div> 
        </div>

        <div class="row">
            <!-- Card 4 -->
            <div class="col-md-6 col-lg-4">
                <div class="card">
                    <img src="../Images/AdminDashboard/manage-payment.jpeg" alt="product 1">
                    <a href="./manage-payment.jsp">  <button class="product-button">Manage Payment</button> </a>
                </div>
            </div>
              <!-- Card 5 -->
           <div class="col-md-6 col-lg-4">
                <div class="card">
                    <img src="../Images/AdminDashboard/order.jpg" alt="product 3">
                       <a href="./manage-order.jsp"> <button class="product-button">Manage Order</button></a>
                </div>
            </div> 
            
            <!-- Card 6 -->
            <div class="col-md-6 col-lg-4">
                <div class="card">
                    <img src="../Images/AdminDashboard/report.jpeg" alt="product 2">
                    <a href="./report-dashboard.jsp"> <button class="product-button">View All Reports</button></a>
                </div>
            </div>

          
        </div>

    </div>

    </main>






    <!-- Footer -->
    <footer class="footer">
        <p>Developed By  "Gaikwad Rutuja"  &  "Nimse Nikita" .</p>
        <div class="footer-bottom">
            <p>&copy; 2026 eshop@gmail.cpm. All rights reserved.</p>
               
        </div>
    </footer>
</body>
</html>