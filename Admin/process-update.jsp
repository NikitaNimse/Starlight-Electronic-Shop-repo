

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%
String id=request.getParameter("id");
String company=request.getParameter("company");
String name=request.getParameter("name");
String price=request.getParameter("price");
String description=request.getParameter("description");
String image=request.getParameter("image");


PreparedStatement ps = null;



try
{
           Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");  
            // creating connection toth data base  
            Connection con = DriverManager.getConnection("jdbc:odbc:ElectronicShopDB");
           Statement st=con.createStatement();
           String sql="Update Product set company=?,name=?,price=?,description=?,image=? where id="+id;
            ps = con.prepareStatement(sql);
            ps.setString(1,id);
            ps.setString(2, company);
            ps.setString(3, name);
            ps.setString(4,price);
            ps.setString(5, description);
            ps.setString(6, image);
            int i = ps.executeUpdate();
            if(i > 0)
            {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Product Edit Successfully');");
                out.println("location='./manage-product';");
                out.println("</script>");
            }
            else
            {
                out.println("<script type=\"text/javascript\">");
                             out.println("alert('Product Not Edit');");
                             out.println("location='./update-product';");
                             out.println("</script>");
            } 
                            
        }
        catch(Exception e)
        {
        System.out.print(e);
        e.printStackTrace();
        }
 %>