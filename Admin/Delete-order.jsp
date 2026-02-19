<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Product</title>
</head>
<body>
<%
    String id = request.getParameter("id"); // Retrieve the product ID from the query parameter
    if (id != null && !id.trim().isEmpty()) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            // Database connection
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");

            // SQL query to delete the product
            String query = "DELETE FROM Booking WHERE Id = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, id);

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                out.println("<script>alert('Order deleted successfully!');</script>");
            } else {
                out.println("<script>alert('Failed to delete Order!');</script>");
            }

            // Redirect to the main page
            out.println("<script>window.location.href='./manage-order.jsp';</script>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('An error occurred while deleting the Order!');</script>");
            out.println("<script>window.location.href='./manage-order.jsp';</script>");
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    } else {
        out.println("<script>alert('Invalid Feedback ID!');</script>");
        out.println("<script>window.location.href='./manage-order.jsp';</script>");
    }
%>
</body>
</html>
