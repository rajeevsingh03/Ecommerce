<%@page import="java.sql.PreparedStatement"%>
<%@page import="database.MyConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%
    ResultSet rsProducts = null;
    String sSQL = "";
    Connection db3con = null;
    session.setAttribute("sPageHead", "Online Electronic Store Product Search Results");
    session.setAttribute("sPageCaption", "Product Search Results");
%>
<html>

    <%@include file="header.jsp" %>

    <br><center><b><font face="Verdana,Arial" color="#FF0000" size="-1">
            You searched for electronic containing the text 
            "<%= request.getParameter("txtSearch")%>"
            in their name or descriptions and location "<%= request.getParameter("txtLocation")%>".
            <br>
            <br>
            <br>
            <br>
            <%

                if (1 == 1) {


                    db3con = MyConnection.getConnection();


                    String sSearch = request.getParameter("txtSearch").toString().replace("'", " ").toUpperCase();
                    String sLocation = request.getParameter("txtLocation").toString().replace("'", " ").toUpperCase();
                    String sCat_type = request.getParameter("cate_type").toString().replace("'", " ").toUpperCase();
                    //sSQL = "SELECT * FROM products WHERE itemproductnumber LIKE '%" + sSearch + "%' OR itemname LIKE '%" + sSearch + "%' OR itemdescription LIKE '%" + sSearch + "%'";
                    //sSQL = "SELECT * FROM products WHERE itemproductnumber LIKE ? OR itemname LIKE ? OR itemdescription like ?";
                    //sSQL = "SELECT products.* FROM products WHERE itemproductnumber LIKE '%" + sSearch + "%' OR itemname LIKE '%" + sSearch + "%' OR itemdescription LIKE '%" + sSearch + "%'";

                    if (!sSearch.equals("")) {
                        sSearch = " AND (itemproductnumber) LIKE '%" + sSearch + "%' OR UPPER(itemname) LIKE '%" + sSearch + "%' OR UPPER(itemdescription) LIKE '%" + sSearch + "%' ";
                    }

                    if (!sLocation.equals("")) {
                        sLocation = " AND UPPER(LOCATION) LIKE  '%" + sLocation + "%'";
                    }

                    if (!sCat_type.equals("--SELECT--")) {
                        sCat_type = " AND UPPER(CAT_TYPE) LIKE  '%" + sCat_type + "%'";
                    } else {
                        sCat_type = "";
                    }

                    sSQL = "SELECT products.* FROM products WHERE 1=1 " + sSearch + sLocation + sCat_type;


                    PreparedStatement preparedStatement = db3con.prepareStatement(sSQL, ResultSet.TYPE_SCROLL_INSENSITIVE,
                            ResultSet.CONCUR_READ_ONLY);
                    //preparedStatement.setString(1, sSearch);
                    //preparedStatement.setString(2, sSearch);
                    //preparedStatement.setString(3, sSearch);
                    rsProducts = preparedStatement.executeQuery();

                    //System.out.print(sSQL);

                    if (!rsProducts.next()) {
                        out.print("No products matching that criteria were found.");
                        out.print("");
                    } else {
                        out.print("<table width='75%' border='1' align='center'>");
                        out.print("");
                        rsProducts.beforeFirst();
                        while (rsProducts.next()) {
                            //Write a table row for the current record of rsProducts
                            out.write("<tr>");

                            //First cell for picture
                            String sTemp = rsProducts.getString("itempicturefile");
                            if (sTemp == "") {
                                sTemp = "Picture Not  Available";
                            } else {
                                sTemp = "<img src='images/products/" + sTemp + "' border=0 alt=''>";
                            }
                            out.write("    <td align='center'>");
                            out.write("<font face='Verdana, Arial' color='#008000' size='-1'>");
                            out.write(sTemp + "</font></td>");

                            //Second cell for Item #, name, description
                            out.write("    <td valign='top'>");
                            out.write("<font face='Verdana, Aria' color='#000000' size='-1'>");
                            out.write("<i><u>Item #" + rsProducts.getString("itemproductnumber"));
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
                            out.write("<a href='shopcart.jsp?mode=add&itemno=");
                            out.write(rsProducts.getString("itemproductnumber") + "'></font>");
                            out.write("<img src='images/addtocart.jpg' border='0'></a></td>");


                            out.write("</tr>");
                        }
                        out.print("</table>");
                    }
                } else {

                    out.print("Attempt failed, Please enter a keyword and then click go.<br>");
                    out.print("Please press your browser's BACK button and keep searching your items.");
                    out.print("");
                }





            %>
            </font></b>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
    </center>
    <%@include file="footer.jsp" %>
</html>
<%
    try {
        if (db3con != null) {
            db3con.close();
        }
    } catch (Exception ex) {
        System.out.printf("Error in contactSubmit.jsp" + ex.getMessage());
    }
%>