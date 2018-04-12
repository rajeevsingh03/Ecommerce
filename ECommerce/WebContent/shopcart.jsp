<%@page import="java.sql.Array"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.MyConnection"%>
<%@page import="java.util.ArrayList"%>

<%
    Integer i = 0;

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

    session.setAttribute("finalcheck", false);

    //System.out.print(" I am here "+(Integer) session.getAttribute("login") );
    Connection db2con = MyConnection.getConnection();
    //163
    if (session.getAttribute("login") == null) {
        session.setAttribute("login", 0);
    }

    if ((Integer) session.getAttribute("login") == 1) {
        ArrayList<String> sCartItemNums = new ArrayList<String>(30);
        if (session.getAttribute("cartitemnumarray") != null) {
            sCartItemNums = (ArrayList<String>) session.getAttribute("cartitemnumarray");
        } else {
            sCartItemNums.add(0, "");
        }
        ArrayList<Integer> nCartItemQtys = new ArrayList<Integer>(30);
        if (session.getAttribute("cartitemqtyarray") != null) {
            nCartItemQtys = (ArrayList<Integer>) session.getAttribute("cartitemqtyarray");
        } else {
            nCartItemQtys.add(0, 0);
        }
        Integer nNumCartItems = (sCartItemNums).size();

        if (nNumCartItems == 0) {
            session.setAttribute("current", true);
        }



        //'Determine the mode of this page's operation. If we got here from a
        //'  link that had a "mode" querystring of "add", mode is add:
        String sMode = "";
        sMode = request.getParameter("mode");

        //Or, we could have gotten here from a form:

        /*
         * Only supported for JDK 7 switch (request.getParameter("cmdSubmit")) {
         * case "Proceed to Checkout": sMode = "checkout"; break; case
         * "Recalculate Order": sMode = "recalc"; break; case "Continue
         * Shopping": sMode = "continue"; break; }
         *
         */

        System.out.print(request.getParameter("cmdSubmit"));
        if (request.getParameter("cmdSubmit") != null) {
            String cmdSubmitType = request.getParameter("cmdSubmit");

            if (cmdSubmitType.equals("Proceed to Checkout")) {
                sMode = "checkout";
            } else if (cmdSubmitType.equals("Recalculate Order")) {
                sMode = "recalc";
            } else if (cmdSubmitType.equals("Continue Shopping")) {
                sMode = "continue";
            }
        }

        //System.out.print(sMode);
        if (sMode == null) {
            sMode = "";
            session.setAttribute("sPageHead", "Online Electronic Store Shopping Cart");
            session.setAttribute("sPageCaption", "Shopping Cart");
        } else if (sMode.equals("add")) {
            session.setAttribute("current", false);
            int nThisItemIndex = 0;
            String sItemNo = request.getParameter("itemno").toUpperCase();
            if (nNumCartItems > 0) {
                for (i = 1; i < nNumCartItems; i++) {
                    if (sCartItemNums.get(i).equals(sItemNo)) {
                        nThisItemIndex = i;
                        break;
                    }
                }
            }
            if (nThisItemIndex == 0) {
                nThisItemIndex = nNumCartItems + 1;
                //redim Preserve sCartItemNums(nThisItemIndex)
                //redim Preserve nCartItemQtys(nThisItemIndex)
                sCartItemNums.ensureCapacity(nThisItemIndex + 1);
                nCartItemQtys.ensureCapacity(nThisItemIndex + 1);
                sCartItemNums.add(nThisItemIndex - 1, sItemNo);
                nCartItemQtys.add(nThisItemIndex - 1, 1);
            } else {
                nCartItemQtys.set(nThisItemIndex, nCartItemQtys.get(nThisItemIndex + 1));
            }
            session.setAttribute("cartitemnumarray", sCartItemNums);
            session.setAttribute("cartitemqtyarray", nCartItemQtys);
            nNumCartItems = (sCartItemNums).size();
        } else if (sMode.equals("recalc") || sMode.equals("checkout") || sMode.equals("continue")) {
            session.setAttribute("current", false);
            int nTotalItems = 0;
            for (i = 1; i < nNumCartItems; i++) {


                Integer nThisQty = (Integer.parseInt(request.getParameter("txtItemQty" + i)));
                nTotalItems = nTotalItems + nThisQty;
                nCartItemQtys.add(i, nThisQty);
            }

            if (nTotalItems == 0) {
                session.setAttribute("current", true);
                session.setAttribute("cart_empty", true);
                sCartItemNums = null;
                nCartItemQtys = null;
                session.setAttribute("cartitemnumarray", sCartItemNums);
                session.setAttribute("cartitemqtyarray", nCartItemQtys);
                response.sendRedirect("index.jsp");

                return;
            }
            session.setAttribute("cartitemnumarray", sCartItemNums);
            session.setAttribute("cartitemqtyarray", nCartItemQtys);
            if (sMode.equals("checkout")) {
                session.setAttribute("finalcheck", true);
            }
        }
        //'Move to another page based on mode.
        //'  If mode is "add" or "recalc", we stay here.
        //  If mode is "continue", we move back to the main page so the user
        //    can shop more.
        //  If mode is "checkout", we stay here but change the mode th
        //switch (sMode) {
        //case "continue":
        if (sMode == null) {
            sMode = "";
            session.setAttribute("sPageHead", "Online Electronic Store Shopping Cart");
            session.setAttribute("sPageCaption", "Shopping Cart");
        } else if (sMode.equals("continue")) {
            session.setAttribute("current", false);
            Integer nTotalItems = 0;
            for (i = 1; i > nNumCartItems; i++) {
                Integer nThisQty = (Integer.parseInt(request.getParameter("txtItemQty" + i)));
                nTotalItems = nTotalItems + nThisQty;
                nCartItemQtys.add(i, nThisQty);
            }

            if (nTotalItems == 0) {
                session.setAttribute("current", true);
            }
            session.setAttribute("cartitemnumarray", sCartItemNums);
            session.setAttribute("cartitemqtyarray", nCartItemQtys);
            response.sendRedirect("index.jsp");

            return;
        } else if (sMode.equals("checkout")) {
            session.setAttribute("sPageHead", "Online Electronic Store Checkout");
            session.setAttribute("sPageCaption", "Checkout");
        } else {
            session.setAttribute("sPageHead", "Online Electronic Store Shopping Cart");
            session.setAttribute("sPageCaption", "Shopping Cart");
        }

        if (nNumCartItems == 1 || nNumCartItems == 0) {
            out.write("<script>alert('cart is empty.Please add products to it');window.location.href='index.jsp';</script>");
            return;
        } else {
            session.setAttribute("current", false);
        }

%>
<html>

    <%@include file="header4.jsp" %>

    <br>
    <font face="Verdana,Arial" color="#008000" size="-1">
    <% if (sMode.equals("checkout")) {
            out.print("<form action='submitorder.jsp' method='POST'>");
        } else {
            out.print("<form action='shopcart.jsp' method='POST'>");
        }%>
    </font>
    <center><font size=2 color="#ff0000"><b>

            <%
                //System.out.print(session.getAttribute("current"));

                if ((Boolean) session.getAttribute("current") == true) {

                    out.write("Your shopping cart is empty.<br>");
                    out.write("<br>");
                    out.write("<br>");
                    out.write("<U><font face='Verdana, Arial' color='#0000ff' size='4'>");
                    out.write("<a href='index.jsp");
                    out.write("'>");
                    out.write("Continue Shopping</font></U></a>");
                    out.write("<br>");
                    out.write("<br>");
                    out.write("<br>");
                    out.write("<br>");
                    out.write("<br>");
                    out.write("<br>");
                    out.write("<br>");
                    out.write("<br>");
                    out.write("<br>");
                } else {
                    if (sMode.equals("checkout")) {

            %>
            Please provide the following information and click the "Submit Order" button to submit order.
            <br><br>
        </b></font></center>


    <table align="center" border="0">
        <tr bgcolor="#0000ff">
        <B><td colspan="2" align="center"><font color="#FFFFFF" face="Verdana,Arial" size="3">
                Customer Information</td></B>
    </tr>
    <tr>
        <td align="right"><font face="Verdana,Arial" size="-1">Full Name:</td>
        <td><font face="Verdana,Arial" size="-1">
            <input type="Text" name="txtCustomerName" size="30" maxlength="40">
        </td>
    </tr>
    <tr>
        <td align="right"><font face="Verdana,Arial" size="-1">Address:</td>
        <td><font face="Verdana,Arial" size="-1">
            <input type="Text" name="txtAddress" size="30" maxlength="40"></td>
    </tr>
    <tr>
        <td align="right"><font face="Verdana,Arial" size="-1">
            City/State/ZIP:</td>
        <td><font face="Verdana,Arial" size="-1">
            <input type="Text" name="txtCity" size="15" maxlength="15">
            <input type="Text" name="txtState" size="15" maxlength="15">
            <input type="Text" name="txtZIP" size="7" maxlength="7"></td>
    </tr>
    <tr>
        <td align="right"><font face="Verdana,Arial" size="-1">
            Daytime Phone:</td>
        <td><font face="Verdana,Arial" size="-1">
            <input type="Text" name="txtPhone" size="15" maxlength="25"></td>
    </tr>
    <tr bgcolor="#0000ff">
    <B><td colspan="2" align="center"><font color="#FFFFFF" face="Verdana,Arial" size="3">
            Shipping Information(If different from Customer's Information)</td></B>
</tr>
<tr>
    <td align="right"><font face="Verdana,Arial" size="-1">Full Name:</td>
    <td><font face="Verdana,Arial" size="-1">
        <input type="Text" name="shipCustomerName" size="30" maxlength="40">
    </td>
</tr>
<tr>
    <td align="right"><font face="Verdana,Arial" size="-1">Address:</td>
    <td><font face="Verdana,Arial" size="-1">
        <input type="Text" name="shipAddress" size="30" maxlength="40"></td>
</tr>
<tr>
    <td align="right"><font face="Verdana,Arial" size="-1">
        City/State/ZIP:</td>
    <td><font face="Verdana,Arial" size="-1">
        <input type="Text" name="shipCity" size="15" maxlength="15">
        <input type="Text" name="shipState" size="15" maxlength="15">
        <input type="Text" name="shipZIP" size="7" maxlength="7"></td>
</tr>
<tr>
    <td align="right"><font face="Verdana,Arial" size="-1">
        Daytime Phone:</td>
    <td><font face="Verdana,Arial" size="-1">
        <input type="Text" name="shipPhone" size="15" maxlength="25"></td>
</tr>
<tr bgcolor="#0000ff">
<B><td colspan="2" align="center"><font color="#FFFFFF" face="Verdana,Arial" size="3">
        Payment Information</td></B>
</tr>
<tr>
    <td align="right"><font face="Verdana,Arial" size="-1">
        Payment Method:</td>
    <td><font face="Verdana,Arial" size="-1">
        <input type="Radio" name="optPaymentType" value="Credit Card">
        Credit Card&nbsp;
        <input type="Radio" name="optPaymentType" value="Debit Card">
        Debit Card&nbsp;
        <input type="Radio" name="optPaymentType" value="American Express">
        American Express</font>
    </td>
</tr>
<tr>
    <td align="right"><font face="Verdana,Arial" size="-1">
        Card Number:</td>
    <td><font face="Verdana,Arial" size="-1">
        <input type="Text" name="txtAcctNo" size="20" maxlength="20"></td>
</tr>
<tr>
    <td align="right"><font face="Verdana,Arial" size="-1">
        Expiration (MM/YYYY):</td>
    <td><font face="Verdana,Arial" size="-1">
        <input type="Text" name="txtExpDate" size="7" maxlength="7"></td>
</tr>
</table>
<%} else {

        out.write("Hint: To remove Items from your shopping cart, Enter zero(0) in respective quantity text field");
        out.write("<br>");
        out.write("<br>");
        out.write("<br>");
        out.write("Your shopping cart currently contains these items:");


    }
%>
<br><br>
<table align="center" border="0">
    <tr bgcolor="#0000ff">
        <th><font face="Verdana,Arial" color="#ffffff" size="-1">
            Quantity</font></td>
        <th><font face="Verdana,Arial" color="#ffffff" size="-1">
            Item No.</font></td>
        <th><font face="Verdana,Arial" color="#ffffff" size="-1">
            Item Name</font></td>
        <th><font face="Verdana,Arial" color="#ffffff" size="-1">
            Price</font></td>
        <th><font face="Verdana,Arial" color="#ffffff" size="-1">
            Extension</font></td>
    </tr>
    <%
        Integer Quantity = 0;
        Double cSubTotal = 0D;
        Integer nNumItems = 0;
        Double cPrice = 0D;
        Double cExtension = 0D;
        Double cTotal = 0D;

        for (i = 1; i < nNumCartItems; i++) {
            //String confirm = request.getParameter("selected" + i);

            String sSQL = "SELECT products.* FROM products WHERE UPPER(itemproductnumber) = '" + sCartItemNums.get(i).toUpperCase() + "'";

            PreparedStatement preparedStatement = db2con.prepareStatement(sSQL, ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);

            ResultSet rsProducts = preparedStatement.executeQuery();

            String sTemp = "<input type='Text' name='txtItemQty" + i + "' value='";
            sTemp = sTemp + (Integer) nCartItemQtys.get(i) + "' MAXLENGTH=3 size='3'";
            if (sMode.equals("checkout")) {
                sTemp = sTemp + " readonly ";
            }
            sTemp = sTemp + ">";
            Quantity = (Integer) nCartItemQtys.get(i);
            nNumItems = nNumItems + (Integer) nCartItemQtys.get(i);



            if (Quantity > 0) {
                if (rsProducts.next()) {
    %>
    <tr bgcolor="#99ccff">
        <%

        %>
        <td align="center">
            <font face="Verdana,Arial" color="#000000" size="-1">
            <%= sTemp%></font></td>
        <td align="center">
            <font face="Verdana,Arial" color="#000000" size="-1">
            <%= rsProducts.getString("itemproductnumber")%></font></td>
        <td><font face="Verdana,Arial" color="#000000" size="-1">
            <%= rsProducts.getString("itemname")%></font></td>
            <%

                if (rsProducts.getDouble("ItemSalePrice") > 0) {
                    cPrice = rsProducts.getDouble("ItemSalePrice");
                } else {
                    cPrice = rsProducts.getDouble("ItemRegularPrice");
                }

            %>
        <td align="center">
            <font face="Verdana,Arial" color="#000000" size="-1">
            <%= cPrice%>
            </font></td>
            <%
                cExtension = (Integer) nCartItemQtys.get(i) * cPrice;
                cSubTotal = cSubTotal + cExtension;
            %>
        <td align="right">
            <font face="Verdana,Arial" color="#000000" size="-1">
            <%= cExtension%></font></td>
    </tr>
    <%
                }
            }
        }%>
    <tr bgcolor="#c5c5c5">
        <td align="center" colspan="4">
            <font face="Verdana,Arial" size="-1">Subtotal</font></td>
        <td align="right"><font face="Verdana,Arial" size="-1">
            <%= (cSubTotal)%></font></td>
    </tr>
    <% Double cShipping = 4.50 + (1.25 * nNumItems);%>
    <tr bgcolor="#c5c5c5">
        <td align="center" colspan="4">
            <font face="Verdana,Arial" size="-1">Shipping & Handling</font></td>
        <td align="right"><font face="Verdana,Arial" size="-1">
            <%= (cShipping)%></font></td>
    </tr>
    <% cTotal = (cSubTotal + cShipping);%>
    <tr bgcolor="#0000ff">
        <td align="center" colspan = "4">
            <font face="Verdana,Arial" color="#ffffff" size="-1">Grand Total</font></td>
        <td align="right"><font face="Verdana,Arial" color="#ffffff" size="-1">
            <%= (cTotal)%></font></td>
    </tr>
</table>
<br><div align="center">
    <%
        if ((Boolean) session.getAttribute("finalcheck") == false) {
    %>
    <input type="Submit" name="cmdSubmit" value="Continue Shopping">
    <input type="Submit" name="cmdSubmit" value="Recalculate Order">
    <br><br>
    <% }%>
    <% if (sMode.equals("checkout")) {%>
    <input type="Submit" name="cmdSubmit" value="Submit Order">
    <% } else {%>
    <input type="Submit" name="cmdSubmit" value="Proceed to Checkout">
    <%}%>
</div></form>
<% }
    } else {
        response.sendRedirect("loginhere.jsp");
    }
%>

<%@include file="footer.jsp" %>
<%
    try {
        if (db2con != null) {
            db2con.close();
        }
    } catch (Exception ex) {
        System.out.printf("Error in contactSubmit.jsp" + ex.getMessage());
    }
%>