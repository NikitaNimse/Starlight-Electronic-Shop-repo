<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electronic Shop</title>
    <link rel="stylesheet" href="./../Admin/css/product-report.css">
        <link rel="stylesheet" href="./../Admin/css/Dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .product-table {
            margin: 20px auto;
            border-collapse: collapse;
            width: 90%;
            background-color: #f9f9f9;
        }

        .product-table th, .product-table td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }

        .product-table th {
              background-color: #007bff;
            color: white;
        }

        .button {
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
            text-align: center;
            text-decoration: none;
            border: none;
        }

        .button-edit {
            background-color: #4CAF50;
            color: white;
        }

        .button-edit:hover {
            background-color: #45a049;
        }

        .button-delete {
            background-color: #f44336;
            color: white;
        }

        .button-delete:hover {
            background-color: #e53935;
        }
    </style>
</head>
<body>
    
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
    
    <%
        try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");
            Statement st = con.createStatement();
            String query = "SELECT * FROM Feedback ORDER BY ID DESC";
            ResultSet rs = st.executeQuery(query);
    %>

    <div class="containers">
        <h2 align="center">Manage Feedback</h2>
        <table class="product-table">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Message</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (rs.next()) {
                        String FeedbackId = rs.getString(1); // Fetch the product ID
                %>
                <tr>
                    <td><%= rs.getString(2) %></td>
                    <td><%= rs.getString(3) %></td>
                    <td><%= rs.getString(4) %></td>
                    <td>
                        <a href="./Update-feedback.jsp?id=<%= FeedbackId %>">
                            <button class="button button-edit">Edit</button>
                        </a>
                        <a href="./Delete-feedback.jsp?id=<%= FeedbackId %>" onclick="return confirm('Are you sure you want to delete this record?');">
                            <button class="button button-delete">Delete</button>
                        </a>
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
  
    <div class="footer-bottom">
        <p>&copy; 2026 eshop@gmail.com. All rights reserved.</p>
    </div>
</footer>
</body>
</html>
