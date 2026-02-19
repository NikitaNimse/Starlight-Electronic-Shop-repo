<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electronic Shop - Registration</title>
    <link rel="stylesheet" href="./css/Registration.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
</head>
<body>

<% 
String errorMessage = ""; // Variable to hold the error message
if (request.getMethod().equalsIgnoreCase("POST")) {
    // Fetching form data
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirm_password = request.getParameter("confirm_password");

    // Check if password and confirm password match
    if (!password.equals(confirm_password)) {
        errorMessage = "Password and Confirm Password do not match.";
    } else {
        // Proceed with database operation
        try {
            // Load JDBC driver
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");

            // Create database connection
            Connection con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");

            // Check if the number of records in AdminReg table is less than 2
            String countQuery = "SELECT COUNT(*) AS recordCount FROM AdminRegistration";
            Statement countStmt = con.createStatement();
            ResultSet countRs = countStmt.executeQuery(countQuery);

            if (countRs.next() && countRs.getInt("recordCount") >= 4) {
                errorMessage = "Only four registrations are allowed in the AdminRegistration table.";
            } else {
                // Check if email already exists
                String checkQuery = "SELECT email FROM AdminRegistration WHERE email = ?";
                PreparedStatement checkStmt = con.prepareStatement(checkQuery);
                checkStmt.setString(1, email);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    errorMessage = "This email ID is already registered.";
                } else {
                    // Insert data into database
                    String query = "INSERT INTO AdminRegistration (name, email, password, confirm_password) VALUES (?, ?, ?, ?)";
                    PreparedStatement pstmt = con.prepareStatement(query);
                    pstmt.setString(1, name);
                    pstmt.setString(2, email);
                    pstmt.setString(3, password);
                    pstmt.setString(4, confirm_password);

                    int rowsInserted = pstmt.executeUpdate();

                    if (rowsInserted > 0) {
                        out.println("<script>");
                        out.println("alert('Data successfully inserted!');");
                        out.println("window.location.href = './Login.jsp';");
                        out.println("</script>");
                    } else {
                        errorMessage = "Failed to insert data.";
                    }

                    pstmt.close();
                }

                checkStmt.close();
            }

            // Close resources
            countStmt.close();
            con.close();
        } catch (Exception e) {
            errorMessage = "An error occurred: " + e.getMessage();
            e.printStackTrace();
        }
    }
}
%>

<!-- Header Section -->
  <!-- Header -->
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

<!-- Main Content -->
<main>
    <div class="register-container">
        <h1>Register</h1>
        <form action="" method="POST">
            <div class="form-group">
                <label for="fullname">Full Name</label>
                <input type="text" id="fullname" name="name" placeholder="Enter your full name" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Create a password" required>
            </div>
            <div class="form-group">
                <label for="confirm_password">Confirm Password</label>
                <input type="password" id="confirm_password" name="confirm_password" placeholder="Confirm your password" required>
                <% if (!errorMessage.isEmpty()) { %>
                    <div class="error-message"><%= errorMessage %></div>
                <% } %>
            </div>
            <button type="submit" class="register-btn">Register</button>
            <a href="./Login.jsp" class="login-link">Already have an account? Login here</a>
        </form>
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
