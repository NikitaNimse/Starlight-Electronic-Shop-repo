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
    <link rel="stylesheet" href="./css/reoprt.css">
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

    <h1 style="justify-content:center;text-align:center; color:#007bff">Report</h1>
        <div class="row">

            <!-- Card 1 -->
            <div class="col-md-6 col-lg-4">
                <div class="card">
                    <img src="./../Images/admin-images/reg-report.webp " alt="product 1">
                   <a href="./Registration-report.jsp"><button class="product-button">Registration Report</button></a>
                </div>
            </div>
            
            <!-- Card 2 -->
            <div class="col-md-6 col-lg-4">
                <div class="card">
                    <img src="./../Images/admin-images/elpro-report.jpg" alt="product2">
                    <a href="./product-report.jsp"> <button class="product-button">Product Report</button> </a>
                </div>
            </div>

            <!-- Card 3 -->
            <div class="col-md-6 col-lg-4">
                <div class="card">
                    <img src="./../Images/admin-images/manage-feedback.png" alt="product 3">
                    <a href="./feedback-report.jsp"> <button class="product-button">Feedback Report</button> </a>
                </div>
            </div> 
        </div>

        <div class="row">
            <!-- Card 4 -->
            <div class="col-md-6 col-lg-4">
                <div class="card">
                    <img src="./../Images/admin-images/order-report.jpg" alt="product 1">
                    <a href="./Order-report.jsp">  <button class="product-button"> Order Report</button> </a>
                </div>
            </div>
            
            <!-- Card 5 -->
            <div class="col-md-6 col-lg-4">
                <div class="card">
                    <img src="./../Images/admin-images/payment.jpg" alt="product 1">
                    <a href="./payment-report.jsp">  <button class="product-button"> Payment Report</button> </a>
                </div>
            </div>

            <!-- Card 6 -->
           <div class="col-md-6 col-lg-4">
                <div class="card">
                    <img src="./../Images/admin-images/bill.avif" alt="product 2">
                     <a href="./Bill-report.jsp"><button class="product-button">Bill Report</button> </a>
                </div>
            </div> 
        </div>

    </div>

    </main>





    <!-- Footer -->
    <footer class="footer">
      
        <div class="footer-bottom">
            <p>&copy; 2026 eshop@gmail.cpm. All rights reserved.</p>
               
        </div>
    </footer>
</body>
</html>