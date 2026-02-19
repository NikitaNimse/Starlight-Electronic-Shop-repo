<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="./css/Login.css">
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
        </div>
    </header>
<%
    String errorMessage = null;
    String emailInput = request.getParameter("email");
    String passwordInput = request.getParameter("password");

    if (emailInput != null && passwordInput != null) {
        try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");
            String query = "SELECT * FROM AdminRegistration WHERE email = ? AND password = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, emailInput);
            pstmt.setString(2, passwordInput);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // Set session attribute on successful login
                session.setAttribute("email", emailInput);
                response.sendRedirect("./Dashboard.jsp");
                return;
            } else {
                errorMessage = "Invalid email or password.";
            }

            rs.close();
            pstmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            errorMessage = "An error occurred while processing your request.";
        }
    }
%>

    <!-- Login Form -->
    <div class="login-container" style="text-align: center; margin-left:600px; margin-top:100px; margin-bottom: 100px;">
        <h1>Login</h1>
      
        <form method="POST" action="">
           
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" >
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password">
            </div>
            <button type="submit" class="login-btn">Login</button>
              <% if (errorMessage != null) { %>
                <p style="color:red; margin-bottom: 15px;"><%= errorMessage %></p>
            <% } %>
            
            <p style="color: blue">If you are not registered, register first:   
                <a href="./Registration.jsp">
                    <button type="button" style="color: brown">Register</button>
                </a>
            </p>
        </form>
    </div>
    
   <!-- Footer -->
    <footer class="footer">
      
        <div class="footer-bottom">
            <p>&copy; 2025 eshop@gmail.com. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
