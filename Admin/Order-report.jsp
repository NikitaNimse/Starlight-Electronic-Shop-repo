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
            <div class="header-icons">
<!--                <a href="#"><i class="fas fa-search"></i></a>
                <a href="#"><i class="fas fa-shopping-cart"></i></a>-->
            </div>
        </div>
    </header>
    
    <%
        String uid = (String) session.getAttribute("uid");
        try {  
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");  
            Connection con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB", "", "");
            Statement st = con.createStatement();
            String query = "SELECT * FROM Booking ORDER BY ID DESC";
            ResultSet rs = st.executeQuery(query);
    %>

    <td width="1124" bgcolor="#ffcccc" valign="top">
       
        <p align="center">
            
            
            
             <div class="containers">
    <h2> Order Report</h2>
    <table class="product-table" >
            
            
          <!--  <div id="export" align="center">
                <table width="1028" border="1" align="center" bordercolor="#e60073"> -->
                    <thead>
                        <tr>
                            
                            <th width="219" class="style4">Product Name</th>
                            <th width="233" class="style4">Company</th>
                              <th width="70" class="style4">Price</th>
                            <th width="219" class="style4">Quantity</th>
                            <th width="233" class="style4">Total Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            while (rs.next()) {
                        %>
                        <tr>
                           
                            <td align="center" class="style4"><%= rs.getString(2) %></td>
                            <td align="center" class="style4"><%= rs.getString(3) %></td>
                              <td align="center" class="style4"><%= rs.getString(4) %></td>
                            <td align="center" class="style4"><%= rs.getString(5) %></td>
                            <td align="center" class="style4"><%= rs.getString(6) %></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </p>
    </td>

    <%
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <script type="text/javascript">
        function myFunction() {
            var divToPrint = document.getElementById('export');
            var popupWin = window.open('', '_blank');
            popupWin.document.open();
            popupWin.document.write('<html><body onload="window.print()"><center>' + divToPrint.innerHTML + '</center></body></html>');
            popupWin.document.close();
        }

        $(document).ready(function () {
            $('#example').DataTable();
        });
    </script>

   
    <!-- Footer -->
    <footer class="footer">
        
        <div class="footer-bottom">
            <p>&copy; 2026 eshop@gmail.cpm. All rights reserved.</p>
               
        </div>
    </footer>
</body>
</html>