<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String FeedbackId = request.getParameter("id");
    String Name = "";
    String Email = "";
    String Message = "";
    boolean isUpdated = false;

    // Fetch feedback details from the database
    if (FeedbackId != null && !FeedbackId.isEmpty()) {
        try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");
            String query = "SELECT * FROM Feedback WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, FeedbackId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Name = rs.getString("name");
                Email = rs.getString("email");
                Message = rs.getString("message");
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
        }
    }

    // Handle feedback update
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String updatedName = request.getParameter("name");
        String updatedEmail = request.getParameter("email");
        String updatedMessage = request.getParameter("message");

        try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");
            String updateQuery = "UPDATE Feedback SET name = ?, email = ?, message = ? WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(updateQuery);
            ps.setString(1, updatedName);
            ps.setString(2, updatedEmail);
            ps.setString(3, updatedMessage);
            ps.setString(4, FeedbackId);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                isUpdated = true;
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
    <title>Update Feedback</title>
    <link rel="stylesheet" href="css/add-product.css">
    <link rel="stylesheet" href="css/Dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script>
        function showPopup() {
            alert("Feedback updated successfully!");
            window.location.href = "./manage-feedback.jsp";
        }
    </script>
</head>
<body onload="<%= isUpdated ? "showPopup()" : "" %>">
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
            <!-- <a href="#"><i class="fas fa-search"></i></a>
            <a href="#"><i class="fas fa-shopping-cart"></i></a> -->
        </div>
    </div>
</header>

<main>
    <div class="register-container">
        <h1>Update Feedback</h1>
        <form action="./Update-feedback.jsp?id=<%= FeedbackId %>" method="POST">
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" value="<%= Name %>" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="text" id="email" name="email" value="<%= Email %>" required>
            </div>
            <div class="form-group">
                <label for="message">Message</label>
                <textarea id="message" name="message" required><%= Message %></textarea>
            </div>
            <button type="submit"  class="register-btn">Update</button> 
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
