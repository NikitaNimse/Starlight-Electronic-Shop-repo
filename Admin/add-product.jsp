<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electronic Shop</title>
     <link rel="stylesheet" href="css/Dashboard.css">
    <link rel="stylesheet" href="css/add-product.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Dropdown styling for blue theme */
        .form-group select {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #007bff;
            border-radius: 4px;
            background-color: #e6f3ff;
            color: #007bff;
            appearance: none;
            outline: none;
        }

        .form-group select:focus {
            border-color: #0056b3;
            box-shadow: 0 0 5px #0056b3;
        }

        .register-btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
        }

        .register-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%-- Form Section --%>
<% if (request.getMethod().equalsIgnoreCase("POST")) { %>
    <% 
    // Fetching form data
    String company = request.getParameter("company");
    String name = request.getParameter("name");
    String price = request.getParameter("price");
    String description = request.getParameter("description");
    String img = request.getParameter("img");

    // Database operation
    try {
        // Load JDBC driver
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");

        // Create database connection
        Connection con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");

        // Insert data into database
        String query = "INSERT INTO Product (company,name,price,description,img) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, company);
        pstmt.setString(2, name);
        pstmt.setString(3, price);
        pstmt.setString(4, description);
        pstmt.setString(5, img);

        int rowsInserted = pstmt.executeUpdate();

        if (rowsInserted > 0) {
            out.println("<script>alert('Product successfully inserted!'); window.location='manage-product.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to insert data.');</script>");
        }

        // Close resources
        pstmt.close();
        con.close();
    } catch (Exception e) {
        out.println("<script>alert('An error occurred: " + e.getMessage() + "');</script>");
        e.printStackTrace();
    }
    %>
<% } %>

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
<!--            <a href="#"><i class="fas fa-search"></i></a>
            <a href="#"><i class="fas fa-shopping-cart"></i></a>-->
        </div>
    </div>
</header>

<!-- Main Content Placeholder -->
<main>
    <div class="register-container">
        <h1>Add Product</h1>
        
        <form action="" method="POST">
            <div class="form-group">
                <label for="company">Company Name</label>
                  <select id="company" name="company" required>
                    <option value="" disabled selected>Select company</option>
                    <option value="Apple">Apple</option>
                    <option value="Lenovo">Lenovo</option>
                    <option value="Croma">Croma</option>
                    <option value="Haier">Haier</option>
                    <option value="Sony">Sony</option>
                     <option value="Samsung">Samsung</option>
                </select>
            </div>
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="email" name="name" placeholder="Enter product name" required>
            </div>
            <div class="form-group">
                <label for="price">Price</label>
                <input type="text" id="price" name="price" placeholder="Enter price" required>
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea type="text" id="description" name="description" placeholder="Enter description" required></textarea>
            </div>
            <div class="form-group">
                <label for="img">Product Image</label>
                <input type="file" id="img" name="img" placeholder="Upload image" required>
            </div>
            <button type="submit" class="register-btn">Add Product</button>
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