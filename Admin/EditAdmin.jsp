<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
/* جلوگیری browser caching */
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires", 0);

String id = request.getParameter("id");

Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String name = "";
String email = "";
String password = "";
String message = "";

try {
    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
    con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");

    /* ---------- UPDATE LOGIC ---------- */
    if(request.getMethod().equalsIgnoreCase("POST")) {

        String newName = request.getParameter("name");
        String newEmail = request.getParameter("email");
        String newPassword = request.getParameter("password");

        pstmt = con.prepareStatement(
            "UPDATE AdminRegistration SET name=?, email=?, password=? WHERE id=?"
        );

        pstmt.setString(1, newName);
        pstmt.setString(2, newEmail);
        pstmt.setString(3, newPassword);
        pstmt.setInt(4, Integer.parseInt(id));

        int rows = pstmt.executeUpdate();

        if(rows > 0) {
            response.sendRedirect("admin_reg_fetch.jsp?success=updated");
            return; // VERY IMPORTANT
        } else {
            message = "Update failed. Record not found.";
        }
    }

    /* ---------- FETCH EXISTING DATA ---------- */
    pstmt = con.prepareStatement("SELECT * FROM AdminRegistration WHERE id=?");
    pstmt.setInt(1, Integer.parseInt(id));
    rs = pstmt.executeQuery();

    if(rs.next()) {
        name = rs.getString("name");
        email = rs.getString("email");
        password = rs.getString("password");
    } else {
        message = "Admin record not found!";
    }

} catch(Exception e) {
    message = "Error: " + e.getMessage();
    e.printStackTrace();
} finally {
    if(rs != null) rs.close();
    if(pstmt != null) pstmt.close();
    if(con != null) con.close();
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Admin</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;

            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background: white;
            width: 400px;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }

        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .btn {
            width: 100%;
            padding: 10px;
            margin-top: 20px;
            background-color: #4CAF50;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #45a049;
        }

        .back-btn {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            background-color: #333;
            border: none;
            color: white;
            font-size: 15px;
            border-radius: 5px;
            cursor: pointer;
        }

        .back-btn:hover {
            background-color: #555;
        }

        .message {
            text-align: center;
            color: red;
            margin-bottom: 10px;
            font-size: 14px;
        }
    </style>
</head>

<body>

<div class="form-container">
    <h2>Edit Admin</h2>

    <% if(!message.isEmpty()) { %>
        <div class="message"><%= message %></div>
    <% } %>

    <form method="post">
        <label>Name</label>
        <input type="text" name="name" value="<%= name %>" required>

        <label>Email</label>
        <input type="email" name="email" value="<%= email %>" required>

        <label>Password</label>
        <input type="text" name="password" value="<%= password %>" required>

        <input type="submit" value="Update Admin" class="btn">
    </form>

    <button class="back-btn" onclick="window.location.href='admin_reg_fetch.jsp'">
        Back to Admin List
    </button>
</div>

</body>
</html>

