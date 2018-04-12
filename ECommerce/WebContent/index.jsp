
<%@page import="java.sql.PreparedStatement"%>
<%@page import="database.MyConnection"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%
    Connection db1con = null;
    String sql = "";
    ResultSet rsProducts = null;

    session.setAttribute("empty", false);
    session.setAttribute("notequal", false);
    session.setAttribute("Fail", false);
    session.setAttribute("PC", false);
    session.setAttribute("continue", false);

    session.setAttribute("notfull", false);
    session.setAttribute("email", false);
    session.setAttribute("Forgot", false);
    session.setAttribute("Remember", false);

    session.setAttribute("empt", false);
    session.setAttribute("mail", false);
    session.setAttribute("noteq", false);
    session.setAttribute("RFail", false);
    session.setAttribute("RC", false);
    session.setAttribute("exist", false);
    session.setAttribute("register", false);
    session.setAttribute("illegalusername", false);
    session.setAttribute("illegalpass", false);

    session.setAttribute("loginFailure", false);
    session.setAttribute("out", false);

    session.setAttribute("khali", false);
    session.setAttribute("tapal", false);
    session.setAttribute("Contact", false);
    session.setAttribute("send", false);
    session.setAttribute("illegalF_Name", false);
    session.setAttribute("illegalL_Name", false);
    session.setAttribute("FNkhali", false);
    session.setAttribute("LNkhali", false);
    session.setAttribute("EMkhali", false);
    session.setAttribute("MBkhali", false);
    session.setAttribute("MSkhali", false);
    session.setAttribute("MesLen", false);

    session.setAttribute("FName", "");
    session.setAttribute("LName", "");
    session.setAttribute("St", "");
    session.setAttribute("Cty", "");
    session.setAttribute("Cntry", "");
    session.setAttribute("HomePhone", "");
    session.setAttribute("Mob", "");
    session.setAttribute("Emailaddress", "");
    session.setAttribute("Mes", "");

    session.setAttribute("User_Name", "");
    session.setAttribute("Sec_Qsn", "");
    session.setAttribute("answer", "");
    session.setAttribute("Month", "");
    session.setAttribute("Day", "");
    session.setAttribute("Year", "");
    session.setAttribute("emailaddress", "");
    session.setAttribute("First_Name", "");
    session.setAttribute("Last_Name", "");
    session.setAttribute("Language", "");
    session.setAttribute("zipcode", "");
    session.setAttribute("Gender", "");
    session.setAttribute("Occupation", "");
    session.setAttribute("Industry", "");


    session.setAttribute("sPageHead", "Pune Electric Zone - Online Electric Store Home Page");
    session.setAttribute("sPageCaption", new Date().toString());
    session.setAttribute("redirectto", "indsx.jsp");
    session.setAttribute("salecomplete", false);



    Integer hitsCount =
            (Integer) application.getAttribute("hitCounter");
    if (hitsCount == null || hitsCount == 0) {
        /*
         * First visit
         */
        //out.println("Welcome to my website!");
        hitsCount = 1;
    } else {
        /*
         * return visit
         */
        //out.println("Welcome back to my website!");
        hitsCount += 1;
    }
    application.setAttribute("hitCounter", hitsCount);


%>

<%@include file="header.jsp"%>

<table border="0" width="100%">
    <tr>

        <td width="100%">
            <table border="0" width="100%" bgcolor="#c0c0c0" cellspacing="0">
                <tr>
                    <td align="center" bgcolor=#0000FF>
                        <font face="Verdana,Arial" color="FFFFFF" style="font-size:12;">
                        <b style="float: left;"> Visitors <%=hitsCount%> &nbsp;&nbsp;&nbsp;&nbsp;</b>
                        <strong>Search Electrical Item</strong></font></td>
                </tr>
                <tr>
                    <td align="center">
                        <form action="prodsearch.jsp" method="POST">
                            <table border="0">
                                <tr>
                                    <%
                                        Connection CatConn = MyConnection.getConnection();
                                        String strTemp = "SELECT CATE_TYPE FROM CATEGORY";
                                        PreparedStatement preparedStatementCat = CatConn.prepareStatement(strTemp, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                                        ResultSet rsCat = preparedStatementCat.executeQuery(strTemp);
                                    %>

                                    <td><b>Category : </b>
                                        <SELECT name="cate_type">
                                            <option>--Select--</option>
                                            <%
                                                while (rsCat.next()) {
                                            %>
                                            <option><%= rsCat.getString("CATE_TYPE")%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                        &nbsp;&nbsp;&nbsp;
                                        <b>Key Word(Name, Description,etc) : </b><input name="txtSearch" size="15" 
                                                                                        maxlength="100" style="border-style: solid; border-color: #0000FF">
                                        &nbsp;&nbsp;&nbsp;
                                        <b>Region : </b><input name="txtLocation" size="15" 
                                                               maxlength="100" style="border-style: solid; border-color: #0000FF">
                                    </td>
                                    <td><input type="image" src="images/go.gif" alt="Click to begin search"></td>

                                </tr>
                            </table>
                        </form>
                    </td>
                </tr>
                <tr>
                    <td><font face="Verdana,Arial" color="#000000" size="-2">
                        Enter one keyword (Product type OR Company Name OR Brand Name) and click Go.</font></td>
                </tr>
            </table>
        </td>

    </tr>
</table>
<table border="0" width="100%">
    <tr>
        <td bgcolor="#0000FF"><p align="center"><font face="Verdana,Arial" color="#ffffff" style="font-size:12;">
                <b>
                    <%@include file="newsFeed.jsp" %>
                </b></font></p></td>
    </tr>
</table>

<%
    db1con = MyConnection.getConnection();
    if (db1con.isClosed()) {
    }

    //sql = "SELECT * FROM products WHERE beginspecial <= ? and endspecial >=?";
    sql = "SELECT products.* FROM products";
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
                sTemp = "<img src='images/products/" + sTemp + "' style=\"width:80px;height:100px;\" border=0 alt=''>";
            }
            out.write("    <td align='center'>");
            out.write("<font face='Verdana, Arial' color='#008000' size='-1'>");
            out.write(sTemp + "</font></td>");

            //Second cell for Item #, name, description
            out.write("    <td valign='top'>");
            out.write("<font face='Verdana, Aria' color='#000000' size='-1'>");
            out.write("<i><u>Item #" + rsProducts.getString("itemproductnumber"));
            out.write(" (" + rsProducts.getString("location") + ")");
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