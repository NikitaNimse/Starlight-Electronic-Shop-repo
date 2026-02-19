<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String id = request.getParameter("id");

Connection con = null;
PreparedStatement pstmt = null;

boolean deleted = false;
String message = "";

if(id != null) {
    try {
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
        con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");

        pstmt = con.prepareStatement("DELETE FROM AdminRegistration WHERE id=?");
        pstmt.setInt(1, Integer.parseInt(id));

        int rows = pstmt.executeUpdate();

        if(rows > 0) {
            deleted = true;
            message = "Admin Deleted Successfully!";
        } else {
            message = "Record Not Found!";
        }

    } catch(Exception e) {
        message = "Error: " + e.getMessage();
        e.printStackTrace();
    } finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
} else {
    message = "Invalid Request!";
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Admin</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .box {
            background: white;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            text-align: center;
            width: 400px;
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
        }

        .msg {
            font-size: 16px;
            margin: 15px 0;
            color: #555;
        }

        .success {
            color: green;
        }

        .error {
            color: red;
        }

        .btn {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #333;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #555;
        }
    </style>
</head>

<body>

<div class="box">
    <h2>Delete Admin</h2>

    <div class="msg <%= deleted ? "success" : "error" %>">
        <%= message %>
    </div>

    <button class="btn" onclick="window.location.href='admin_reg_fetch.jsp'">
        Back to Admin List
    </button>
</div>

<% if(deleted) { %>
<script>
    setTimeout(function() {
        window.location.href = "admin_reg_fetch.jsp";
    }, 1500);   // Auto redirect after 1.5 sec
</script>
<% } %>

</body>
</html>
