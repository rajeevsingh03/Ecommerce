<%
    session.setAttribute("sPageHead", "Admin Product Page");

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
    ResultSet rsProducts = null;
%>

<%@include file="header4.jsp"%>

<table border="0" width="100%">
    <tr>
        <td bgcolor="#0000FF"><p align="center"><font face="Verdana,Arial" color="#ffffff" style="font-size:12;">
                <b>Best Electronics Product</b></font></p></td>
    </tr>
</table>

<%

    if (session.getAttribute("product_added") == null) {
        session.setAttribute("product_added", false);
    }

    if (session.getAttribute("product_update") == null) {
        session.setAttribute("product_update", false);
    }

    if (session.getAttribute("product_added") != null || session.getAttribute("product_update") != null) {
        if ((Boolean) session.getAttribute("product_added") == true) {
%>

<table border="0" width="100%">
    <tr>
        <td><p align="center"><font face="Verdana,Arial" color="#FF0000" style="font-size:09pt;">
                <b>Product has been added successfully.Please add image in the folder</b></font></p></td>
    </tr>
</table>

<%                    }

    if ((Boolean) session.getAttribute("product_update") == true) {
%>

<table border="0" width="100%">
    <tr>
        <td><p align="center"><font face="Verdana,Arial" color="#FF0000" style="font-size:09pt;">
                <b>Product has been updated successfully.Please update image in the folder</b></font></p></td>
    </tr>
</table>

<%                    }
    }
%>

<%
    session.setAttribute("product_added", false);
    session.setAttribute("product_update", false);
    db1con = MyConnection.getConnection();
    if (db1con.isClosed()) {
    }

    sql = "SELECT * FROM products WHERE beginspecial <= ? and endspecial >=?";
    sql = "SELECT * FROM products";
    PreparedStatement preparedStatement = db1con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
            ResultSet.CONCUR_READ_ONLY);
    //preparedStatement.setDate(1, new java.sql.Date(new java.util.Date().getTime()));
    //preparedStatement.setDate(2, new java.sql.Date(new java.util.Date().getTime()));
    rsProducts = preparedStatement.executeQuery();

    if (rsProducts.next()) {
%>
<table width="75%" border="1" align="center">
    <%
        do {
            //Write a table row for the current record of rsProducts
            out.write("<tr>");

            //First cell for picture
            String sTemp = rsProducts.getString("itempicturefile");
            if (sTemp == "") {
                sTemp = "Picture Not  Available";
            } else {
                sTemp = "<img src='../images/products/" + sTemp + "' style=\"width:80px;height:100px;\" border=0 alt=''>";
            }
            out.write("    <td align='center'>");
            out.write("<font face='Verdana, Arial' color='#008000' size='-1'>");
            out.write(sTemp + "</font></td>");

            //Second cell for Item #, name, description
            out.write("    <td valign='top'>");
            out.write("<font face='Verdana, Aria' color='#000000' size='-1'>");
            out.write("<i><u>Item #" + rsProducts.getString("itemproductnumber"));
            out.write(" (" +rsProducts.getString("location") +")");
            out.write("</u></i></font><br>");
            out.write("<font face='Verdana, Arial' color='#0000ff' size='-1'>");
            out.write("<b>" + rsProducts.getString("itemname") + "</b> - ");
            out.write("<font face='Verdana, Arial' color='#008000' size='-1'>");
            out.write(rsProducts.getString("itemdescription") + "<br><br>");
            out.write("</font></td>");

            //Third cell for price and "add to cart" link
            if (rsProducts.getDouble("itemsaleprice") > 0) {
                sTemp = "SALE: <span class=\"WebRupee\">Rs.</span> " + rsProducts.getDouble("itemsaleprice")
                        + "<br>(Regular <span class=\"WebRupee\">Rs.</span> "
                        + rsProducts.getDouble("itemregularprice") + ")";
            } else {
                sTemp = "Price: <span class=\"WebRupee\">Rs.</span> " + rsProducts.getDouble("itemregularprice");
            }
            out.write("    <td align='center' valign='middle' nowrap>");
            out.write("<font face='Verdana, Arial' color='#0000ff' size='-1'>");
            out.write(sTemp + "<br><br>");
            out.write("<a style='text-decoration:underline;' href='updateProduct.jsp?itemNumber=" + rsProducts.getString("itemproductnumber") + "'");
            out.write(rsProducts.getString("itemproductnumber") + "'>Update</a></font>");
            //out.write("<img src='../images/addtocart.jpg' border='0'></a></td>");
            out.write("</td>");


            out.write("</tr>");
        } while (rsProducts.next());

    %>
</table>




<% } else {%>
<table border="0" width="100%">
    <tr>
        <td bgcolor="#0000FF">
            <p align="center"><b><font face="Verdana,Arial" color="#FFFFFF">Unfortunately, No Product Match Found</font></b></p></td>
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