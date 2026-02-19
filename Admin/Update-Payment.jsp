<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String PayId = request.getParameter("id");
    String Name = "";
    String MobileNo = "";
    String ProductName = "";
    String PaymentMode = "";
    String CardNo = "";
    String TotalPrice = "";
    boolean isUpdated = false;

    // Fetch existing product details from the database
    if (PayId != null && !PayId.isEmpty()) {
        try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");
            String query = "SELECT * FROM Payment WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, PayId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Name = rs.getString("name");
                MobileNo = rs.getString("mobileno");
                ProductName = rs.getString("productname");
                PaymentMode = rs.getString("paymentmode");
                CardNo = rs.getString("cardno");
                TotalPrice = rs.getString("totalprice");
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
        }
    }

    // Handle the update operation
    if ("POST".equalsIgnoreCase(request.getMethod()) && PayId != null && !PayId.isEmpty()) {
        String updatedName = request.getParameter("name");
        String updatedMobileNo = request.getParameter("mobileno");
        String updatedProductName = request.getParameter("productname");
        String updatedPaymentMode = request.getParameter("paymentmode");
        String updatedCardNo = request.getParameter("cardno");
        String updatedTotalPrice = request.getParameter("totalprice");

        try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");
            String updateQuery = "UPDATE Payment SET name = ?, mobileno = ?, productname = ?, paymentmode = ?, cardno = ?, totalprice = ? WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(updateQuery);

            ps.setString(1, updatedName);
            ps.setString(2, updatedMobileNo);
            ps.setString(3, updatedProductName);
            ps.setString(4, updatedPaymentMode);
            ps.setString(5, updatedCardNo);
            ps.setString(6, updatedTotalPrice);
            ps.setString(7, PayId);

            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                isUpdated = true;
                Name = updatedName;
                MobileNo = updatedMobileNo;
                ProductName = updatedProductName;
                PaymentMode = updatedPaymentMode;
                CardNo = updatedCardNo;
                TotalPrice = updatedTotalPrice;
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
    <title>Update Payment</title>
    
    <link rel="stylesheet" href="css/add-product.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .form-group select {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f9f9f9;
            margin-top: 5px;
            margin-bottom: 15px;
            box-sizing: border-box;
        }
    </style>
    <script>
        <% if (isUpdated) { %>
            alert("Payment details Updated successfully!");
            window.location.href = "./manage-payment.jsp";
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
        </div>
    </div>
</header>

<main>
    <div class="register-container">
        <h1>Update Payment</h1>
        <form action="./Update-Payment.jsp?id=<%= PayId %>" method="POST">
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" value="<%= Name %>" required>
            </div>
            <div class="form-group">
                <label for="mobileno">Mobile No</label>
                <input type="text" id="mobileno" name="mobileno" value="<%= MobileNo %>" required>
            </div>
            <div class="form-group">
                <label for="productname">Product Name</label>
                <input type="text" id="productname" name="productname" value="<%= ProductName %>" required>
            </div>
            <div class="form-group">
                <label for="paymentmode">Payment Mode</label>
                <select id="paymentmode" name="paymentmode" required>
                    <option value="Credit" <%= "Credit".equals(PaymentMode) ? "selected" : "" %>>Credit</option>
                    <option value="Debit" <%= "Debit".equals(PaymentMode) ? "selected" : "" %>>Debit</option>
                </select>
            </div>
            <div class="form-group">
                <label for="cardno">Card No</label>
                <input type="text" id="cardno" name="cardno" value="<%= CardNo %>" required>
            </div>
            <div class="form-group">
                <label for="totalprice">Total Price</label>
                <input type="text" id="totalprice" name="totalprice" value="<%= TotalPrice %>" required>
            </div>
            <button type="submit" class="register-btn">Save Changes</button>
        </form>
    </div>
</main>
<!-- Footer -->
<footer class="footer" style="text-align: center;">
    
    <div class="footer-bottom">
        <p>&copy; 2026 eshop@gmail.com. All rights reserved.</p>
    </div>
</footer>
</body>
</html>
