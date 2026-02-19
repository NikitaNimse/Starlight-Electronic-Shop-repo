<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String RegId = request.getParameter("id");
    String Name = "";
    String Email = "";
    String Password = "";
    String ConfPassword = "";
    boolean isUpdated = false;

    // Fetch registration details from the database
    if (RegId != null && !RegId.isEmpty()) {
        try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");
            String query = "SELECT * FROM Registration WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, RegId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Name = rs.getString("name");
                Email = rs.getString("email");
                Password = rs.getString("password");
                ConfPassword = rs.getString("confirm_password");
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
        }
    }

    // Handle registration update
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String updatedName = request.getParameter("name");
        String updatedEmail = request.getParameter("email");
        String updatedPassword = request.getParameter("password");
        String updatedConfPassword = request.getParameter("confirm_password");

        try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");
            String updateQuery = "UPDATE Registration SET name = ?, email = ?, password = ?, confirm_password = ? WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(updateQuery);
            ps.setString(1, updatedName);
            ps.setString(2, updatedEmail);
            ps.setString(3, updatedPassword);
            ps.setString(4, updatedConfPassword);
            ps.setString(5, RegId);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                isUpdated = true;
                Name = updatedName;
                Email = updatedEmail;
                Password = updatedPassword;
                ConfPassword = updatedConfPassword;
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
    <title>Update Registration</title>
    <link rel="stylesheet" href="css/Dashboard.css">
    <link rel="stylesheet" href="css/add-product.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script>
        function showPopup() {
            alert("Registration updated successfully!");
            window.location.href = "./manage-registration.jsp";
        }
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
    </div>
</header>

<main>
    <div class="register-container">
        <h1>Update Registration</h1>
        <% if (isUpdated) { %>
            <script>
                showPopup();
            </script>
        <% } %>
        <form action="./Update-Registration.jsp?id=<%= RegId %>" method="POST">
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" value="<%= Name %>" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="text" id="email" name="email" value="<%= Email %>" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" value="<%= Password %>" required>
            </div>
            <div class="form-group">
                <label for="confirm_password">Confirm Password</label>
                <input type="password" id="confirm_password" name="confirm_password" value="<%= ConfPassword %>" required>
            </div>
            <button type="submit" class="register-btn">Save Changes</button>
        </form>
    </div>
</main>

<!-- Footer -->
<footer class="footer">
    <div class="footer-content">
        <p style="text-align: center;">Developed By "Gaikwad Rutuja" & "Nimse Nikita"</p>
    </div>
    <div class="footer-bottom">
        <p style="text-align: center;">&copy; 2026 eshop@gmail.com. All rights reserved.</p>
    </div>
</footer>
</body>
</html>
