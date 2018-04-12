<%
    session.setAttribute("sPageHead", "Admin Order Page");

    if (session.getAttribute("adminlogin") == null) {
        session.setAttribute("adminlogin", 0);
    }

    if ((Integer) session.getAttribute("adminlogin") == 0) {
        response.sendRedirect("viewFeedback.jsp");
        return;
    }

%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="database.MyConnection"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%
    Connection db1con = null;
    String sql = "";
    ResultSet rsOrders = null;
%>

<%@include file="header4.jsp"%>

<table border="0" width="100%">
    <tr>
        <td bgcolor="#0000FF"><p align="center"><font face="Verdana,Arial" color="#ffffff" style="font-size:12;">
                <b>Latest FeedBack</b></font></p></td>
    </tr>
</table>

<%
    db1con = MyConnection.getConnection();
    if (db1con.isClosed()) {
    }

    sql = "SELECT Orders.* FROM Orders Order by OrderID desc";
    PreparedStatement preparedStatement = db1con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
            ResultSet.CONCUR_READ_ONLY);
    //preparedStatement.setDate(1, new java.sql.Date(new java.util.Date().getTime()));
    //preparedStatement.setDate(2, new java.sql.Date(new java.util.Date().getTime()));
    rsOrders = preparedStatement.executeQuery();

    if (rsOrders.next()) {
%>
<table width="75%" border="1" align="center">
    <tr bgcolor="#0000FF">
        <th><font face="Verdana,Arial" color="#ffff00" size="-1">
            Order ID</font></th>
        <th><font face="Verdana,Arial" color="#ffff00" size="-1">
            Order Date</font></th>
        <th><font face="Verdana,Arial" color="#ffff00" size="-1">
            Customer Name</font></th>
        <th><font face="Verdana,Arial" color="#ffff00" size="-1">
            Amount</font></th>
        <th><font face="Verdana,Arial" color="#ffff00" size="-1">
            PayMent Method</font></th>        
        <th><font face="Verdana,Arial" color="#ffff00" size="-1">
            </font></th>        
    </tr>
    <%
        do {
            //Write a table row for the current record of rsProducts
            out.write("<tr>");

            out.write("<td align=\"center\">");
            out.write(rsOrders.getString("OrderID"));
            out.write("</td>");

            out.write("<td align=\"center\">");
            out.write(rsOrders.getString("OrderDate"));
            out.write("</td>");

            out.write("<td align=\"center\">");
            out.write(rsOrders.getString("CustomerName"));
            out.write("</td>");

            out.write("<td align=\"center\">");
            out.write(rsOrders.getString("OrderAmount"));
            out.write("</td>");

            String sTemp = "";
            //switch (rsOrders.getString("paymentmethod").toString().toLowerCase()) {
            String payType = rsOrders.getString("PaymentMethod").toString().toLowerCase();
            if (payType.equals("visa")) {
                sTemp = "Visa";
            } else if (payType.equals("mastercard")) {
                sTemp = "MasterCard";
            } else if (payType.equals("amex")) {
                sTemp = "American Express";
            }

            out.write("<td align=\"center\">");
            out.write(sTemp);
            out.write("</td>");

            out.write("<td align=\"center\">");
            out.write("<a href='viewOrderDetails.jsp?ID="+rsOrders.getString("OrderID")+"'>View Details</a>");
            out.write("</td>");

            out.write("</tr>");
        } while (rsOrders.next());
    %>
</table>




<% } else {%>
<table border="0" width="100%">
    <tr>
        <td bgcolor="#0000FF">
            <p align="center"><b><font face="Verdana,Arial" color="#FFFFFF">Unfortunately, No Feedback Found</font></b></p></td>
    </tr>
</table>
<% }%>
<%@include file="footer.jsp" %>
</html>
<%
    try {
        if (db1con != null) {
            db1con.close();
        }
    } catch (Exception ex) {
        System.out.printf("Error in contactSubmit.jsp" + ex.getMessage());
    }
%>