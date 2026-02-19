<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Admins</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 30px;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        .admin-table {
            margin: 20px auto;
            border-collapse: collapse;
            width: 95%;
            background-color: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

           .admin-table th {
            background-color: #007bff;
            color: white;
        }
        .admin-table th, .admin-table td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }

/*        .admin-table th {
            background-color: #333;
            color: white;
        }*/

        tr:hover {
            background-color: #f1f1f1;
        }

        .Delete-button {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 6px 12px;
            cursor: pointer;
            border-radius: 5px;
        }

        .Update-button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 6px 12px;
            cursor: pointer;
            border-radius: 5px;
        }

        .back-btn {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 10px;
            background-color: #333;
            color: white;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
        }
    </style>
</head>

<body>

<h1>Manage Admin Registration</h1>

<table class="admin-table">
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Email</th>
    <th>Password</th>
    <th>Action</th>
</tr>

<%
Connection con = null;
Statement stmt = null;
ResultSet rs = null;

try {
    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
    con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");

    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT * FROM AdminRegistration");

    boolean hasData = false;

    while(rs.next()) {
        hasData = true;
        String adminId = rs.getString("id");
%>

<tr>
    <td><%= adminId %></td>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getString("email") %></td>
    <td><%= rs.getString("password") %></td>

    <td>
        <a href="EditAdmin.jsp?id=<%= adminId %>">
            <button class="Update-button">Edit</button>
        </a>

        <a href="DeleteAdmin.jsp?id=<%= adminId %>"
           onclick="return confirm('Are you sure you want to delete this admin?');">
            <button class="Delete-button">Delete</button>
        </a>
    </td>
</tr>

<%
    }

    if(!hasData) {
%>
<tr>
    <td colspan="5">No Admins Found</td>
</tr>
<%
    }

} catch(Exception e) {
%>
<tr>
    <td colspan="5">Error: <%= e.getMessage() %></td>
</tr>
<%
    e.printStackTrace();
} finally {
    if(rs != null) rs.close();
    if(stmt != null) stmt.close();
    if(con != null) con.close();
}
%>

</table>

<a href="Dashboard.jsp" class="back-btn">Back to Dashboard</a>

</body>
</html>

