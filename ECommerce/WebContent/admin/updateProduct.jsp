<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.MyConnection"%>
<%
    Connection db5con = null;

    ResultSet rsProducts = null;

    session.setAttribute("sPageHead", "Admin Product Details Page");

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
        String ProductItemNumber = "";
        Integer j = 0;
        String sSQL = "";

        if (request.getParameter("itemNumber") == null) {
            response.sendRedirect("viewProduct.jsp");
            return;
        } else {
            ProductItemNumber = request.getParameter("itemNumber");
        }

        session.setAttribute("sPageHead", "Admin Product # " + ProductItemNumber + " Details Page");
    %>  

    <%@include file="header4.jsp" %>

    <center><font face="Verdana,Arial" color="#ff0000" size="-1"><b>
            <%

                db5con = MyConnection.getConnection();

                sSQL = "SELECT products.* FROM products WHERE ItemProductNumber = '" + ProductItemNumber + "'";

                PreparedStatement preparedStatement = db5con.prepareStatement(sSQL, ResultSet.TYPE_SCROLL_INSENSITIVE,
                        ResultSet.CONCUR_READ_ONLY);
                rsProducts = preparedStatement.executeQuery(sSQL);

                if (!rsProducts.next()) {
                    response.sendRedirect("viewProduct.jsp");
                    return;
                } else {
                }


            %>

        </b></font> </center>

    <FORM action="updateProductSubmit.jsp" method="post" >

        <TABLE WIDTH="80%" BORDER="0" CELLSPACING="0" CELLPADDING="1" ALIGN="center" style="border-style: solid; border-color: #0000CC">
            <TR> 
                <TD BGCOLOR="#0000FF" CLASS="hea" HEIGHT="20"> 
                    <DIV ALIGN="center"><font face="Verdana,Arial" color="#ffffff"><b>Update Product Details</b></font></DIV>
                </TD>
            </TR>

            <TR> 
                <TD BGCOLOR="#33ccff"> 
                    <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="8" BGCOLOR="#EFEFEF">


                        <TR> 
                            <TD CLASS="small" COLSPAN="2"> 
                                &nbsp;
                            </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="small" COLSPAN="2"> 
                                <DIV ALIGN="center" CLASS="text"><font size="2" color="#0000FF">Please enter new product details</font></DIV>
                            </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <DIV ALIGN="center">
                                    <p align="right"><B><font size="2" color="#0000FF">Item Product Number :</font> </B></DIV>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=50 NAME=itemProductNumber CLASS="TextBox" size="20" style="border-style: solid; border-color: #0000FF" value='<%= rsProducts.getString("ItemProductNumber")%>' readonly>
                                </FONT> </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <DIV ALIGN="center">
                                    <p align="right"><B><font size="2" color="#0000FF">Item Name :</font></B></DIV>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=20 NAME=itemName TYPE=text CLASS="TextBox" size="20" style="border-style: solid; border-color: #0000FF" value="<%= rsProducts.getString("ItemName")%>">
                                </FONT> </TD>
                        </TR>

                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <DIV ALIGN="center">
                                    <p align="right"><B><font size="2" color="#0000FF">Item Description :</font></B></DIV>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=500 NAME=itemDescription TYPE=text CLASS="TextBox" size="20" style="border-style: solid; border-color: #0000FF" value="<%= rsProducts.getString("ItemDescription")%>">
                                </FONT> </TD>
                        </TR>

                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <DIV ALIGN="center">
                                    <p align="right"><B><font size="2" color="#0000FF">Item Regular Price :</font></B></DIV>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=20 NAME=itemRegularPrice TYPE=text CLASS="TextBox" size="20" style="border-style: solid; border-color: #0000FF" value="<%= rsProducts.getString("ItemRegularPrice")%>">
                                </FONT> </TD>
                        </TR>

                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <DIV ALIGN="center">
                                    <p align="right"><B><font size="2" color="#0000FF">Item Sales Price :</font></B></DIV>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=20 NAME=itemSalesPrice TYPE=text CLASS="TextBox" size="20" style="border-style: solid; border-color: #0000FF" value="<%= rsProducts.getString("ItemSalePrice")%>">
                                </FONT> </TD>
                        </TR>

                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <DIV ALIGN="center">
                                    <p align="right"><B><font size="2" color="#0000FF">Item Picture File :</font></B></DIV>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=20 NAME=itemPictureFile TYPE=text CLASS="TextBox" size="20" style="border-style: solid; border-color: #0000FF" value="<%= rsProducts.getString("ItemPictureFile")%>">
                                </FONT> </TD>
                        </TR>

                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <DIV ALIGN="center">
                                    <p align="right"><B><font size="2" color="#0000FF">Item Location :</font></B></DIV>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=100 NAME=itemLocation TYPE=text CLASS="TextBox" size="20" style="border-style: solid; border-color: #0000FF" value="<%= rsProducts.getString("Location")%>">
                                </FONT> </TD>
                        </TR>

                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <DIV ALIGN="center">
                                    <p align="right"><B><font size="2" color="#0000FF">Item Category :</font></B></DIV>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2">
                                <%
                                    Connection CatConn = MyConnection.getConnection();
                                    String strTemp = "SELECT CATE_TYPE FROM CATEGORY";
                                    PreparedStatement preparedStatementCat = CatConn.prepareStatement(strTemp, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                                    ResultSet rsCat = preparedStatementCat.executeQuery(strTemp);
                                %>
                                <select NAME=itemCategory style="border-style: solid; border-color: #0000FF">

                                    <%
                                        while (rsCat.next()) {
                                    %>
                                    <option
                                        <%
                                            if (rsCat.getString("CATE_TYPE").toString().equals(rsProducts.getString("CAT_TYPE"))) {
                                        %> selected <%                                                    }
                                        %>
                                        ><%= rsCat.getString("CATE_TYPE")%></option>
                                    <%
                                        }
                                    %>

                                </select>
                                </FONT> </TD>
                        </TR>

                        <TR> 
                            <TD WIDTH="41%"> 
                                <DIV ALIGN="center">
                                </DIV>
                            </TD>
                            <TD WIDTH="59%"> 
                                <INPUT TYPE="SUBMIT" Name="Submit" VALUE="Update" CLASS="button" OnMouseOver='this.className = "buttonOver"' OnMouseOut='this.className = "button"' style="color: #0000FF; border: 1 solid #0000FF">
                            </TD>
                        </TR>
                        <TR> 
                            <TD COLSPAN="2" CLASS="small"> 
                                &nbsp;
                            </TD>
                        </TR>


                        <tr>
                            <TD COLSPAN="2" CLASS="small"> 
                                &nbsp; 
                            </TD>
                        </tr>
                    </TABLE>
                </TD>
            </TR>
        </TABLE>


    </FORM>
    <%@include file="footer.jsp" %>

