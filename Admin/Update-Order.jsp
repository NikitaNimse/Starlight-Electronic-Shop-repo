<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String OrderId = request.getParameter("id");
    String productCompany = "";
    String productName = "";
    String productPrice = "";
    String productquantity = "";
    String producttoprice = "";
    boolean isUpdated = false;

    // Fetch product details from the database
    if (OrderId != null) {
        try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");
            String query = "SELECT * FROM Booking WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, OrderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                productCompany = rs.getString("prcompany");
                productName = rs.getString("prname");
                productPrice = rs.getString("prprice");
                productquantity = rs.getString("prquantity");
                producttoprice = rs.getString("prtotalprice");
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
        String updatedCompany = request.getParameter("prcompany");
        String updatedName = request.getParameter("prname");
        String updatedPrice = request.getParameter("prprice");
        String updatedQuantity = request.getParameter("prquantity");
        String updatedToprice = request.getParameter("prtotalprice");

        try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");
            String updateQuery = "UPDATE Booking SET prcompany = ?, prname = ?, prprice = ?, prquantity = ?, prtotalprice = ? WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(updateQuery);

            ps.setString(1, updatedCompany);
            ps.setString(2, updatedName);
            ps.setString(3, updatedPrice);
            ps.setString(4, updatedQuantity);
            ps.setString(5, updatedToprice);
            ps.setString(6, OrderId);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                isUpdated = true;
                productCompany = updatedCompany;
                productName = updatedName;
                productPrice = updatedPrice;
                productquantity = updatedQuantity;
                producttoprice = updatedToprice;
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
    <link rel="stylesheet" href="css/Dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script>
        <% if (isUpdated) { %>
        window.onload = function () {
            alert("Order Updated successfully!");
            window.location.href = "./manage-order.jsp";
        };
        <% } %>
    </script>
</head>
<body>
<header class="header">
    <div class="container">
        <div class="logo"><a href="#">E-Shop</a></div>
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

<main>
    <div class="register-container">
        <h1>Update Order</h1>
        <form action="./Update-Order.jsp?id=<%= OrderId %>" method="POST">
            <div class="form-group">
                <label for="prcompany">Product Company</label>
                <select id="prcompany" name="prcompany" required class="form-control" style="padding: 10px; font-size: 14px; border-radius: 5px; border: 1px solid #ccc; width: 100%;">
                    <option value="Apple" <%= "Apple".equals(productCompany) ? "selected" : "" %>>Apple</option>
                    <option value="Lenovo" <%= "Lenovo".equals(productCompany) ? "selected" : "" %>>Lenovo</option>
                    <option value="Croma" <%= "Croma".equals(productCompany) ? "selected" : "" %>>Croma</option>
                    <option value="Haier" <%= "Haier".equals(productCompany) ? "selected" : "" %>>Haier</option>
                    <option value="Sony" <%= "Sony".equals(productCompany) ? "selected" : "" %>>Sony</option>
                    <option value="Samsung" <%= "Samsung".equals(productCompany) ? "selected" : "" %>>Samsung</option>
                </select>
            </div>
            <div class="form-group">
                <label for="prname">Product Name</label>
                <input type="text" id="prname" name="prname" value="<%= productName %>" required class="form-control">
            </div>
            <div class="form-group">
                <label for="prprice">Price</label>
                <input type="text" id="prprice" name="prprice" value="<%= productPrice %>" required class="form-control">
            </div>
            <div class="form-group">
                <label for="prquantity">Quantity</label>
                <textarea id="prquantity" name="prquantity" required class="form-control"><%= productquantity %></textarea>
            </div>
            <div class="form-group">
                <label for="prtotalprice">Total Price</label>
                <input type="text" id="prtotalprice" name="prtotalprice" value="<%= producttoprice %>" required class="form-control">
            </div>
            <button type="submit" class="register-btn">Save Changes</button>
        </form>
    </div>
</main>

<!-- Footer -->
<footer class="footer">
    <div class="footer-content">
       
    </div>
    <div class="footer-bottom">
        <p style="text-align: center;">&copy; 2026 eshop@gmail.com. All rights reserved.</p>
    </div>
</footer>
</body>
</html>
