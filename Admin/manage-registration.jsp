<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.util.*" %>
<%@ page import="java.text.SimpleDateFormat,java.util.Date" %>
<%@ page import="java.lang.String.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electronic Shop</title>
    <link rel="stylesheet" href="./../Admin/css/product-report.css">
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
        try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");
            Statement st = con.createStatement();
            // Query to fetch the last inserted record first
            String query = "SELECT * FROM Registration ORDER BY ID DESC";
            ResultSet rs = st.executeQuery(query);
    %>

    <div class="containers">
        <h2>Manage Registration</h2>
        <table class="product-table">
            <thead>
                <tr>
                    <th width="150" class="style4">User Name</th> <!-- Increased width of User Name column -->
                    <th width="219" class="style4">Email</th>
                    <th width="180" class="style4">Password</th> <!-- Reduced width of Password column -->
                    <th width="180" class="style4">Confirm Password</th> <!-- Reduced width of Confirm Password column -->
                    <th width="180" class="style4">Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (rs.next()) {
                        String RegId = rs.getString(1); // Fetch the product ID
                %>
                <tr>
                    <td align="center" class="style4"><%= rs.getString(2) %></td>
                    <td align="center" class="style4"><%= rs.getString(3) %></td>
                    <td align="center" class="style4"><%= rs.getString(4) %></td>
                    <td align="center" class="style4"><%= rs.getString(5) %></td>
                    <td>
                        <a href="./Update-Registration.jsp?id=<%= RegId %>" class="action-btn edit-btn">Edit</a>
                        <a href="./Delete-registration.jsp?id=<%= RegId %>" class="action-btn delete-btn" onclick="return confirm('Are you sure you want to delete this record?');">Delete</a>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <%
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <p style="text-align: center;">Developed By "Gaikwad Rutuja" & "Nimse Nikita"</p>
        </div>
        <div class="footer-bottom">
            <p style="text-align: center;">&copy; 2025 eshop@gmail.com. All rights reserved.</p>
        </div>
    </footer>

    <style>
        .action-btn {
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 5px;
            font-weight: bold;
            text-align: center;
            display: inline-block;
            margin: 5px;
        }
        .edit-btn {
            background-color: #4CAF50;
            color: white;
        }
        .delete-btn {
            background-color: #f44336;
            color: white;
        }
        .edit-btn:hover,
        .delete-btn:hover {
            opacity: 0.8;
        }
    </style>
</body>
</html>
