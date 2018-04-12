<%@page import="database.MyConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%
    Connection db5con = null;

    ResultSet rsOrderLines, rsOrders = null;

    session.setAttribute("sPageHead", "Admin Order Details Page");

    session.setAttribute("sPageCaption", "Admin User Only");

    if (session.getAttribute("adminlogin") == null) {
        session.setAttribute("adminlogin", 0);
    }

    if ((Integer) session.getAttribute("adminlogin") == 0) {
        response.sendRedirect("viewFeedback.jsp");
        return;
    }

%>
<HTML>


    <%
        Integer nOrderID = 0;
        Integer j = 0;
        String sSQL = "";

        if (request.getParameter("ID") == null) {
            response.sendRedirect("viewOrderDetails.jsp");
            return;
        } else {
            nOrderID = Integer.parseInt(request.getParameter("ID"));
        }

        session.setAttribute("sPageHead", "Admin Order # " + nOrderID + " Details Page");
    %>  

    <%@include file="header4.jsp" %>

    <center><font face="Verdana,Arial" color="#ff0000" size="-1"><b>
            <%

                db5con = MyConnection.getConnection();

                sSQL = "SELECT orders.* FROM orders WHERE orderid = " + nOrderID;

                PreparedStatement preparedStatement = db5con.prepareStatement(sSQL, ResultSet.TYPE_SCROLL_INSENSITIVE,
                        ResultSet.CONCUR_READ_ONLY);
                rsOrders = preparedStatement.executeQuery(sSQL);

                if (!rsOrders.next()) {
                    response.sendRedirect("viewOrderDetails.jsp");
                    return;
                } else {


            %>
        </b></font> </center>

    <table align="center" border="0">
        <tr>
            <td valign="top">
                <table border="0">
                    <tr>
                        <td align="center" bgcolor="#0000FF">
                    <center><font color="#ffffff"><b>Order # <%= nOrderID%>
                        </b></font></center></td>
        </tr>
        <tr>
            <td align="center" bgcolor="#0000ff">
                <font color="#FFFFFF"><b>Order Date <%= rsOrders.getString("OrderDate")%> <%= rsOrders.getString("OrderTime")%>
                </b></font></td>
        </tr>
    </table>
</td>
<td>
    <table align="center" border="0">
        <tr bgcolor="#0000FF">
            <th colspan="2" align="center">
                <font face="Verdana,Arial" size="-1" color="#FFFFFF">
                Customer Information</th>
        </tr>
        <tr>
            <td align="right"><font face="Verdana,Arial" size="-1">
                Name:</td>
            <td><font face="Verdana,Arial" size="-1" color="#0000ff">
                <%= rsOrders.getString("customername")%></font></td>
        </tr>
        <tr>
            <td align="right"><font face="Verdana,Arial" size="-1">
                Address:</td>
            <td><font face="Verdana,Arial" size="-1" color="#0000ff">
                <%= rsOrders.getString("customeraddress")%></font></td>
        </tr>
        <tr>
            <td align="right"><font face="Verdana,Arial" size="-1">
                City/State/ZIP:</td>
            <td><font face="Verdana,Arial" size="-1" color="#0000ff">
                <%= rsOrders.getString("customercity") + " "%>
                <%= rsOrders.getString("customerstate")%>
                <%= " " + rsOrders.getString("customerzip")%></font></td>
        </tr>
        <tr>
            <td align="right"><font face="Verdana,Arial" size="-1">
                Daytime Phone:<font></td>
            <td><font face="Verdana,Arial" size="-1" color="#0000ff">
                <%= rsOrders.getString("customerphone")%></font></td>
        </tr>

        <tr bgcolor="#0000FF">
            <th colspan="2" align="center">
                <font face="Verdana,Arial" size="-1" color="#FFFFFF">
                Shipping Information(If different from customer Information)</th>
        </tr>
        <tr>
            <td align="right"><font face="Verdana,Arial" size="-1">
                Name:</td>
            <td><font face="Verdana,Arial" size="-1" color="#0000ff">
                <%= rsOrders.getString("shipCustomerName")%></font></td>
        </tr>
        <tr>
            <td align="right"><font face="Verdana,Arial" size="-1">
                Address:</td>
            <td><font face="Verdana,Arial" size="-1" color="#0000ff">
                <%= rsOrders.getString("shipCustomerAddress")%></font></td>
        </tr>
        <tr>
            <td align="right"><font face="Verdana,Arial" size="-1">
                City/State/ZIP:</td>
            <td><font face="Verdana,Arial" size="-1" color="#0000ff">
                <%= rsOrders.getString("shipCustomerCity") + " "%>
                <%= rsOrders.getString("shipCustomerState")%>
                <%= " " + rsOrders.getString("shipCustomerZIP")%></font></td>
        </tr>
        <tr>
            <td align="right"><font face="Verdana,Arial" size="-1">
                Daytime Phone:</td>
            <td><font face="Verdana,Arial" size="-1" color="#0000ff">
                <%= rsOrders.getString("shipCustomerPhone")%></font></td>
        </tr>




        <tr bgcolor="#0000FF">
            <th colspan="2" align="center">
                <font face="Verdana,Arial" size="-1" color="#FFFFFF">
                Payment Information</th>
        </tr>

        <tr>
            <td align="right"><font face="Verdana,Arial" size="-1">
                Payment Method:</td>
                <%
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
                    //}
%>    
            <td><font face="Verdana,Arial" size="-1" color="#0000ff">
                <%= sTemp%></font></td>
        </tr>
        <tr>
            <td align="right"><font face="Verdana,Arial" size="-1">
                Account Number:</td>
            <td><font face="Verdana,Arial" size="-1" color="#0000ff">
                <%= rsOrders.getString("PaymentAccount")%></font></td>
        </tr>

        <tr>
            <td align="right"><font face="Verdana,Arial" size="-1">
                Expiry Date(MM/YYYY):</td>
            <td><font face="Verdana,Arial" size="-1" color="#0000ff">
                <%= rsOrders.getString("ExpDate")%></font></td>
        </tr>
    </table>
</td>
</table>

<br><br>

<table align="center" border="0">
    <tr bgcolor="#0000FF">
        <th><font face="Verdana,Arial" color="#ffff00" size="-1">
            Quantity</font></th>
        <th><font face="Verdana,Arial" color="#ffff00" size="-1">
            Item No.</font></th>
        <th><font face="Verdana,Arial" color="#ffff00" size="-1">
            Item Name</font></th>
        <th><font face="Verdana,Arial" color="#ffff00" size="-1">
            Price</font></th>
        <th><font face="Verdana,Arial" color="#ffff00" size="-1">
            Extension</font></th>
    </tr>
    <%
        rsOrderLines = null;

        sSQL = "SELECT o.*,p.ItemName FROM orderdetails o left outer join products p on o.ItemProductNumber = p.ItemProductNumber WHERE orderid = " + nOrderID;
        preparedStatement = db5con.prepareStatement(sSQL, ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_READ_ONLY);
        rsOrderLines = preparedStatement.executeQuery(sSQL);

        rsOrderLines.last();
        Integer nNumCartItems = rsOrderLines.getRow();

        Integer Plus = 0;
        Double cSubTotal = 0D;
        Integer nNumItems = 0;

        rsOrderLines.beforeFirst();

        while (rsOrderLines.next()) {

            Plus = (Integer) rsOrderLines.getInt("Quantity");
            if (Plus > 0) {

    %> 
    <tr bgcolor="#99ccff">
        <td align="center">
            <font face="Verdana,Arial" color="#0000FF" size="-1">
            <%= rsOrderLines.getInt("Quantity")%></font></td>
        <td align="center">
            <font face="Verdana,Arial" color="#0000FF" size="-1">
            <%= rsOrderLines.getString("ItemProductNumber")%></font></td>
        <td><font face="Verdana,Arial" color="#0000FF" size="-1">
            <%= rsOrderLines.getString("ItemName")%></font></td>
        <td align="center">
            <font face="Verdana,Arial" color="#0000FF" size="-1">
            <%= rsOrderLines.getDouble("Price")%></font></td>
            <%
                nNumItems = nNumItems + rsOrderLines.getInt("Quantity");
                Double cExtension = rsOrderLines.getInt("Quantity") * rsOrderLines.getDouble("Price");
                cSubTotal = cSubTotal + cExtension;
            %>  
        <td align="right">
            <font face="Verdana,Arial" color="#0000FF" size="-1">
            <%= (cExtension)%></font></td>
    </tr>
    <%
            }
        }
    %>
    <tr bgcolor="#99ccff">
        <td align="center" colspan="4">
            <font face="Verdana,Arial" color="#0000FF" size="-1">Subtotal</font></td>
        <td align="right"><font face="Verdana,Arial" color="#0000FF" size="-1">
            <%= (cSubTotal)%></font></td>
    </tr>
    <%
        Double cShipping = (Double) session.getAttribute("shipbasecharge") + (nNumItems * (Double) session.getAttribute("shipitemcharge"));
    %>
    <tr bgcolor="#99ccff">
        <td align="center" colspan="4">
            <font face="Verdana,Arial" color="#0000FF" size="-1">Shipping & Handling</font></td>
        <td align="right"><font face="Verdana,Arial" color="#0000FF" size="-1">
            <%= (cShipping)%></font></td>
    </tr>

    <tr bgcolor="#0000ff">
        <td align="center" colspan = "4">
            <font face="Verdana,Arial" color="#FFFF00" size="-1">Grand Total</font></td>
        <td align="right"><font face="Verdana,Arial" color="#FFFF00" size="-1">
            <% Double cTotal = (cSubTotal + cShipping);%>
            <%= (cTotal)%></font></td>
    </tr>
</table>
<%
    }
%>
<%@include file="footer.jsp" %>
</BODY></HTML>