<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String productId = request.getParameter("id");
    String productCompany = "";
    String productName = "";
    String productPrice = "";
    String productDescription = "";
    String productImage = "";
    boolean isUpdated = false;

    // Fetch product details from the database
    if (productId != null) {
        try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");
            String query = "SELECT * FROM Product WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                productCompany = rs.getString("company");
                productName = rs.getString("name");
                productPrice = rs.getString("price");
                productDescription = rs.getString("description");
                productImage = rs.getString("img");
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
        }
    }

    // Handle product update
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String updatedCompany = request.getParameter("company");
        String updatedName = request.getParameter("name");
        String updatedPrice = request.getParameter("price");
        String updatedDescription = request.getParameter("description");
        String updatedImg = request.getParameter("img");

        try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");
            String updateQuery = "UPDATE Product SET company = ?, name = ?, price = ?, description = ?, img = ? WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(updateQuery);
            ps.setString(1, updatedCompany);
            ps.setString(2, updatedName);
            ps.setString(3, updatedPrice);
            ps.setString(4, updatedDescription);
            ps.setString(5, updatedImg);
            ps.setString(6, productId);
            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                isUpdated = true;
                productCompany = updatedCompany;
                productName = updatedName;
                productPrice = updatedPrice;
                productDescription = updatedDescription;
                productImage = updatedImg;
            }
            ps.close();
            con.close();
        } catch (Exception e) {
            out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product</title>
    <link rel="stylesheet" href="css/add-product.css">
    <link rel="stylesheet" href="./css/Dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Custom dropdown styling */
        select {
            width: 100%;
            padding: 12px 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            background-color: #f9f9f9;
            color: #333;
            margin-bottom: 15px;
            transition: all 0.3s ease;
        }

        select:focus {
            border-color: #4CAF50;
            outline: none;
        }

        /* Style the option elements inside the dropdown */
        option {
            padding: 10px;
            font-size: 16px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .register-btn {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            font-size: 16px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        .register-btn:hover {
            background-color: #45a049;
        }
        header .logo a {
    font-size: 24px; /* Increased font size for logo */
    font-weight: bold;
}

nav.navbar ul li a {
    font-size: 50px; /* Increased font size for navigation links */
    font-weight: bold;
}
    </style>
</head>
<body>
<header class="header" >
    <div class="container">
        <div class="logo"><a href="#">E-Shop</a></div>
          <nav class="navbar">
                <ul>
                    <li><a href="./Dashboard.jsp">Dashboard</a></li>
                    <li><a href="./report-dashboard.jsp">Reports</a></li>
                </ul>
            </nav>
        <div class="header-icons">
        </div>
    </div>
</header>

<main>
    <div class="register-container">
        <h1>Update Product</h1>
        <% if (isUpdated) { %>
            <script>
                alert('Product updated successfully!');
                window.location.href = './manage-product.jsp';
            </script>
        <% } %>
        <form action="./update-product.jsp?id=<%= productId %>" method="POST">
            <div class="form-group">
                <label for="company">Company Name</label>
                <select id="company" name="company" required>
                    <option value="" disabled>Select company</option>
                    <option value="Apple" <%= productCompany.equals("Apple") ? "selected" : "" %>>Apple</option>
                    <option value="Lenovo" <%= productCompany.equals("Lenovo") ? "selected" : "" %>>Lenovo</option>
                    <option value="Croma" <%= productCompany.equals("Croma") ? "selected" : "" %>>Croma</option>
                    <option value="Haier" <%= productCompany.equals("Haier") ? "selected" : "" %>>Haier</option>
                    <option value="Sony" <%= productCompany.equals("Sony") ? "selected" : "" %>>Sony</option>
                    <option value="Samsung" <%= productCompany.equals("Samsung") ? "selected" : "" %>>Samsung</option>
                </select>
            </div>
            <div class="form-group">
                <label for="name">Product Name</label>
                <input type="text" id="name" name="name" value="<%= productName %>" required>
            </div>
            <div class="form-group">
                <label for="price">Price</label>
                <input type="text" id="price" name="price" value="<%= productPrice %>" required>
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" required><%= productDescription %></textarea>
            </div>
            <div class="form-group">
                <label for="image">Product Image URL</label>
                <input type="text" id="image" name="img" value="<%= productImage %>" required>
            </div>
            <button type="submit" class="register-btn">Save Changes</button>
        </form>
    </div>
</main>

<!-- Footer -->
<footer class="footer">
    
    <div class="footer-bottom">
        <p>&copy; 2026 eshop@gmail.com. All rights reserved.</p>
    </div>
</footer>
</body>
</html>
