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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .product-table {
            margin: 30px auto;
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

        .button-edit {
             background-color: #4CAF50;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
        }

        .button-edit:hover {
            background-color: #18ed83;
        }

        .button-delete {
           background-color: #f44336;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
        }

        .button-delete:hover {
            background-color: #ed3838;
        }

        .add-product-button {
            background-color: #3b37e6;
            color: white;
            border: none;
            width:150px;
            padding: 15px 30px;
            cursor: pointer;
            border-radius: 5px;
            float: right;
            margin-right: 5%;
        }

        .add-product-button:hover {
            background-color: #4a82e5;
        }

        .table-header {
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .table-header h2 {
            margin: 0 auto;
            text-align: center;
        }

        .table-header a {
            position: absolute;
            right: 5%;
        }

        .navbar ul {
            display: flex;
            justify-content: center;
            list-style: none;
            padding: 0;
        }

        .navbar ul li {
            margin: 0 15px;
        }

        .navbar ul li a {
            text-decoration: none;
            color: black;
        }

        .navbar ul li a:hover {
            color: #6293f5;
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
    </div>
</header>
    
<%
    try {
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
        Connection con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");
        Statement st = con.createStatement();
        String query = "SELECT * FROM Product ORDER BY id DESC"; // Newest record first
        ResultSet rs = st.executeQuery(query);
%>

<div class="containers">
    <div class="table-header">
        <h2>Manage Product</h2>
        <a href="./add-product.jsp">
            <button class="add-product-button">Add Product</button>
        </a>
    </div>
    <table class="product-table">
        <thead>
            <tr>
                <th>Company Name</th>
                <th>Name</th>
                <th>Price</th>
                <th>Description</th>
                <th>Image</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                while (rs.next()) {
                    String productId = rs.getString(1); // Fetch the product ID
            %>
            <tr>
                <td><%= rs.getString(2) %></td>
                <td><%= rs.getString(3) %></td>
                <td><%= rs.getString(4) %></td>
                <td><%= rs.getString(5) %></td>
                <td>
                    <img src="./../Admin/Image/<%= rs.getString(6) %>" alt="Product Image" style="width:100px; height:100px;">
                </td>
                <td>
                    <a href="./update-product.jsp?id=<%= productId %>">
                        <button class="button-edit">Edit</button>
                    </a>
                    <a href="./Delete-product.jsp?id=<%= productId %>" onclick="return confirm('Are you sure you want to delete this record?');">
                        <button class="button-delete">Delete</button>
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
    
<footer class="footer">
    
    <div class="footer-bottom">
        <p>&copy; 2026 eshop@gmail.com. All rights reserved.</p>
    </div>
</footer>
</body>
</html>
