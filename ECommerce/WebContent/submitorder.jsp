<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="database.MyConnection"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%
    String sErrorString = "";
    Connection db5con = null;
    String sSQL = "";
    ResultSet rsProducts, rsOrderLines, rsOrders = null;
    String mystring, lsNumber, lsChar, lnTotal, lnDigit, lnPosition, lnSum, Number, CardType, Reminder = "";

    sErrorString = "";
    ArrayList<Double> cItemPrice = new ArrayList<Double>(30);
    ArrayList<String> sItemName = new ArrayList<String>(30);
    sItemName.add(0, "");
    cItemPrice.add(0, 0D);
    Double cOrderTotal = 0D;
    cItemPrice.add(0, 0D);
    sItemName.add(0, "");
    cOrderTotal = 0D;
    Integer nNumItems = 0;
    Double cShipping = 0D;
    Integer nOrderID = 0;
    Integer j = 0;

    if (session.getAttribute("salecomplete") == null) {
        session.setAttribute("salecomplete", false);
    }
    if ((Boolean) session.getAttribute("salecomplete") == true) {
        session.setAttribute("salecomplete", false);
        response.sendRedirect("index.jsp");
        return;
    }

    //ArrayList sCartItemNums = (ArrayList) session.getAttribute("cartitemnumarray");
    //ArrayList nCartItemQtys = (ArrayList) session.getAttribute("cartitemqtyarray");
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

    for (j = 1; j < nNumCartItems; j++) {
        int nThisQty = Integer.parseInt(request.getParameter("txtItemQty" + j));
        nCartItemQtys.add(j, nThisQty);
    }
    session.setAttribute("cartitemnumarray", sCartItemNums);
    session.setAttribute("cartitemqtyarray", nCartItemQtys);
%>

<%!
    public String CheckErrors(String sField, String sItemName, HttpServletRequest request) {
        if (request.getParameter(sField) == null) {
            return "The " + sItemName + " field cannot be blank.<br>";
        }
        if ((request.getParameter(sField).trim()).equals("")) {
            return "The " + sItemName + " field cannot be blank.<br>";
        }
        return "";
    }

    public String CheckNumbers(String sField, String sItemName, HttpServletRequest request) {
        if ((common.CommonUtils.isNumeric(request.getParameter(sField)) == false) || request.getParameter(sField).equals("")) {
            return "The " + sItemName + " field must be a number.<br>";
        }
        return "";
    }

    public String IsCreditCard(String sField1, String sItemName1, String sField2, String sItemName2, HttpServletRequest request, HttpSession session) {

        String Number = request.getParameter(sField1);
        String CardType = request.getParameter(sField2);

        session.setAttribute("creditcard", false);

        String lsChar = "";
        String lsNumber = "";
        //' Loop through each character inthe card number submited
        for (Integer lnPosition = 0; lnPosition < (Number).length() - 1; lnPosition++) {
            //' Grab the current character
            //lsChar = Mid(Number, lnPosition, 1)
            lsChar = String.valueOf(Number.charAt(lnPosition));
            //' If the character is a number, append it to our new number
            if (common.CommonUtils.isNumeric(lsChar) == true) {
                lsNumber = lsNumber + lsChar;

            }
        }// ' lnPosition


        //' The credit card number must be between 13 and 16 digits.

        //' If the length of the number is less then 13 digits but not more than 16 digits then exit the routine

        if ((Number).length() != 16) {

            return "The " + sItemName1 + " field must be 16 digits.<br>";

        }

        //' The credit card number must start with: 
        //'	4 for Visa Cards 
        //'	37 for American Express Cards 
        //'	5 for MasterCards 
        //'	6 for Discover Cards 
        //' ====

        //' Choose action based on type of card
        //switch (CardType.toLowerCase()) {
        //' VISA
        String cardType = CardType.toUpperCase();

        //if (cardType.equals("visa") || cardType.equals("v")) {
        //' If first digit not 4, exit function
        //if (!String.valueOf(lsNumber.charAt(0)).toString().equals("4")) {

        //return "The " + sItemName1 + " field(Visa Card Number) must start with 4.<br>";
        //}
        //break;

        // }
        //' American Express


        //if (cardType.equals("american express") || cardType.equals("americanexpress") || cardType.equals("american") || cardType.equals("ax") || cardType.equals("a")) {
        //' If first 2 digits not 37, exit function
        //if (lsNumber.toString().substring(lsNumber.length() - 2, lsNumber.length()).equals("37")) {

        //return "The " + sItemName1 + " field(American Express Card Number) must start with 37.<br>";
        //}

        //break;
        //}

        //' Mastercard
        //if (cardType.equals("mastercard") || cardType.equals("master card") || cardType.equals("master") || cardType.equals("m")) {
        //{
        //' If first digit not 5, exit function

        //if (!String.valueOf(lsNumber.charAt(0)).toString().equals("5")) {

        //return "The " + sItemName1 + " field(Master Card Number) must start with 5.<br>";

        //}
        //break;
        //}


        // Discover
        //if (cardType.equals("discover") || cardType.equals("discovercard") || cardType.equals("discover card") || cardType.equals("d")) {
        //' If first digit not 6, exit function
        //if (!String.valueOf(lsNumber.charAt(1)).toString().equals("5")) {

        //return "The " + sItemName1 + " field(Discover Card Number) must start with 6.<br>";
        //}
        //break;

        //}

        session.setAttribute("creditcard", true);

        return "";
    }

    public String CheckDate(String sField, String sItemName, HttpServletRequest request) {

        if (common.CommonUtils.InStr(request.getParameter(sField), "/") == 1) {
            return "The " + sItemName + " field must be in the mm/yyyy format.<br>";
        }

        if (request.getParameter(sField) == null) {
            return "The " + sItemName + " field must be in the mm/yyyy format.<br>";
        }


        String mystring = (request.getParameter(sField));

        if (mystring.length() != 7) {
            return "The " + sItemName + " field must be in the mm/yyyy format.<br>";
        }

        String Month1 = mystring.substring(0, 2);

        String Year1 = mystring.substring(3);

        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());

        int Month2 = cal.get(Calendar.MONTH);

        int Year2 = cal.get(Calendar.YEAR);

        if ((common.CommonUtils.isNumeric(Month1) != true) || (common.CommonUtils.isNumeric(Year1) != true)) {

            return "The " + sItemName + " field must be valid expiry date.<br>";

        }

        if ((common.CommonUtils.isNumeric(Month1) == true) && (common.CommonUtils.isNumeric(Year1) == true)) {


            if ((Integer.parseInt(Month1) > 12) || (Integer.parseInt(Year1) > 2025) || (Integer.parseInt(Year1) < 2000)) {

                return "The " + sItemName + " field must be valid expiry date.<br>";

            }

            if (Integer.parseInt(Year1) < Year2) {

                return "The " + sItemName + " has already gone.<br>";

            }

            if (Integer.parseInt(Year1) == (Year2)) {

                if (Integer.parseInt(Month1) < (Month2)) {

                    return "The " + sItemName + " has already gone.<br>";

                }
            }

        }
        return "";
    }

%>
<%


    sErrorString = "";
    sErrorString = sErrorString + "";

    sErrorString = sErrorString + CheckErrors("txtCustomerName", "Customer Name", request);
    sErrorString = sErrorString + CheckErrors("txtAddress", "Customer Address", request);
    sErrorString = sErrorString + CheckErrors("txtCity", "City", request);
    sErrorString = sErrorString + CheckErrors("txtState", "State", request);
    sErrorString = sErrorString + CheckErrors("txtZIP", "ZIP", request);
    sErrorString = sErrorString + CheckErrors("txtPhone", "Telephone", request);
    sErrorString = sErrorString + CheckNumbers("txtZIP", "ZIP", request);
    sErrorString = sErrorString + CheckNumbers("txtPhone", "Telephone", request);

    sErrorString = sErrorString + CheckErrors("shipCustomerName", "Shipping Customer Name", request);
    sErrorString = sErrorString + CheckErrors("shipAddress", "Shipping Customer Address", request);
    sErrorString = sErrorString + CheckErrors("shipCity", "Shipping City", request);
    sErrorString = sErrorString + CheckErrors("shipState", "Shipping State", request);
    sErrorString = sErrorString + CheckErrors("shipZIP", "Shipping ZIP", request);
    sErrorString = sErrorString + CheckErrors("shipPhone", "Shipping Telephone", request);

    sErrorString = sErrorString + CheckNumbers("shipZIP", "Shipping ZIP", request);
    sErrorString = sErrorString + CheckNumbers("shipPhone", "Shipping Telephone", request);

    sErrorString = sErrorString + CheckErrors("optPaymentType", "Payment Type", request);
    sErrorString = sErrorString + CheckErrors("txtAcctNo", "Account Number", request);
    sErrorString = sErrorString + CheckErrors("txtExpDate", "Expiration Date", request);

    sErrorString = sErrorString + CheckNumbers("txtAcctNo", "Account Number", request);
    sErrorString = sErrorString + IsCreditCard("txtAcctNo", "Account Number", "optPaymentType", "Payment Type", request, session);
    sErrorString = sErrorString + CheckDate("txtExpDate", "Expiration Date", request);

    if (sErrorString.equals("")) {

        db5con = MyConnection.getConnection();



        for (j = 1; j < nNumCartItems; j++) {
            sItemName.add(0, "");
            cItemPrice.add(0, 0D);
        }

        for (j = 1; j < nNumCartItems; j++) {
            sSQL = "SELECT products.* FROM products WHERE UPPER(itemproductnumber) = '" + sCartItemNums.get(j).toUpperCase() + "'";
            cItemPrice.ensureCapacity(nNumCartItems + 1);
            sItemName.ensureCapacity(nNumCartItems + 1);
            PreparedStatement preparedStatement = db5con.prepareStatement(sSQL, ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            rsProducts = preparedStatement.executeQuery(sSQL);
            while (rsProducts.next()) {

                if (rsProducts.getDouble("itemsaleprice") > 0) {
                    cItemPrice.set(j, rsProducts.getDouble("itemsaleprice"));
                } else {
                    cItemPrice.set(j, rsProducts.getDouble("itemregularprice"));
                }
                sItemName.set(j, rsProducts.getString("itemname"));
                cOrderTotal = (Double) cOrderTotal + ((Integer) nCartItemQtys.get(j) * (Double) cItemPrice.get(j));
                nNumItems = nNumItems + (Integer) nCartItemQtys.get(j);
            }
        }
        cShipping = (Double) session.getAttribute("shipbasecharge") + (nNumItems * (Double) session.getAttribute("shipitemcharge"));
        cOrderTotal = cOrderTotal + cShipping;

        db5con = MyConnection.getConnection();

        //try {
        db5con.setAutoCommit(false);


        //String OrderDate="";
        //String OrderTime="";
        //,CustomerName,CustomerAddress,CustomerCity,CustomerState,CustomerZIP,CustomerPhone,shipCustomerName,shipCustomerAddress,shipCustomerCity,shipCustomerState,shipCustomerZIP,shipCustomerPhone,OrderAmount,PaymentMethod,PaymentAccount,ExpDate,user_name


        sSQL = "INSERT INTO Orders (OrderDate,OrderTime,CustomerName,CustomerAddress,CustomerCity,CustomerState,CustomerZIP,CustomerPhone,shipCustomerName,shipCustomerAddress,shipCustomerCity,shipCustomerState,shipCustomerZIP,shipCustomerPhone,OrderAmount,PaymentMethod,PaymentAccount,ExpDate,user_name)"
                + " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";



        //PreparedStatement statement = db5con.prepareStatement(sSQL, Statement.RETURN_GENERATED_KEYS);
        PreparedStatement statement = db5con.prepareStatement(sSQL);

        statement.setString(1, new SimpleDateFormat("dd-MMM-yyy").format(new Date()).toString());
        statement.setString(2, new SimpleDateFormat("KK:mm:ss a").format(new Date()).toString());

        statement.setString(3, request.getParameter("txtCustomerName"));
        statement.setString(4, request.getParameter("txtAddress"));
        statement.setString(5, request.getParameter("txtCity"));
        statement.setString(6, request.getParameter("txtState"));
        statement.setString(7, request.getParameter("txtZIP"));
        statement.setString(8, request.getParameter("txtPhone"));

        statement.setString(9, request.getParameter("shipCustomerName"));
        statement.setString(10, request.getParameter("shipAddress"));
        statement.setString(11, request.getParameter("shipCity"));
        statement.setString(12, request.getParameter("shipState"));
        statement.setString(13, request.getParameter("shipZIP"));
        statement.setString(14, request.getParameter("shipPhone"));

        statement.setDouble(15, cOrderTotal);
        statement.setString(16, request.getParameter("optPaymentType"));
        statement.setString(17, request.getParameter("txtAcctNo"));
        statement.setString(18, request.getParameter("txtExpDate"));

        statement.setString(19, (String) session.getAttribute("user"));


        int affectedRows = statement.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Creating user failed, no rows affected.");
        }

        //ResultSet generatedKeys = statement.getGeneratedKeys();
        //if (generatedKeys.next()) {
        //    nOrderID = generatedKeys.getInt(1);
        //} else {
        //   throw new SQLException("Ordering failed, no generated key obtained.");
        //}

        sSQL = "SELECT MAX(ORDERID) ORDERID FROM orders WHERE UPPER(USER_NAME) = '" + session.getAttribute("user").toString().toUpperCase() + "'";
        PreparedStatement preparedStatement_gekey = db5con.prepareStatement(sSQL, ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_READ_ONLY);

        rsOrders = preparedStatement_gekey.executeQuery();

        if (rsOrders.next()) {
            nOrderID = rsOrders.getInt("ORDERID");
        }

        rsOrders = null;
        sSQL = "SELECT orders.* FROM orders WHERE orderid = " + nOrderID;
        PreparedStatement preparedStatement = db5con.prepareStatement(sSQL, ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_READ_ONLY);
        rsOrders = preparedStatement.executeQuery(sSQL);

        if (!rsOrders.next()) {
            throw new SQLException("Ordering failed.");

        }


//        rsOrders.insertRow();
        //rsOrders.moveToCurrentRow();

        //nOrderID = rsOrders.getInt("orderid");


        rsOrderLines = null;
        sSQL = "SELECT orderdetails.* FROM orderdetails WHERE orderid = " + nOrderID;
        preparedStatement = db5con.prepareStatement(sSQL, ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
        rsOrderLines = preparedStatement.executeQuery(sSQL);

        for (j = 1; j < nNumCartItems; j++) {
            rsOrderLines.moveToInsertRow();
            rsOrderLines.updateInt("orderid", nOrderID);
            rsOrderLines.updateString("Itemproductnumber", (String) sCartItemNums.get(j));
            rsOrderLines.updateInt("quantity", (Integer) nCartItemQtys.get(j));
            rsOrderLines.updateDouble("price", (Double) cItemPrice.get(j));
            rsOrderLines.insertRow();
        }

        session.setAttribute("salecomplete", true);

        //} catch (Exception ex) {
        //if (db5con != null) {
        //try {
        // System.err.print("Transaction is being rolled back");
        //db5con.rollback();
        //} catch (Exception excep) {
        //}
        // }
        //} finally {

        db5con.setAutoCommit(true);
    }



    session.setAttribute("sPageHead", "Online Electronic Store Order Confirmation");
    session.setAttribute("sPageCaption", "Order Confirmation");

%>
<html>

    <%@include file="header2.jsp" %>
    <center><font face="Verdana,Arial" color="#ff0000" size="-1"><b>
            <%
                if (sErrorString.equals("")) {
                    out.write("Order # " + nOrderID + " has been entered. Use "
                            + " your browser's PRINT function to print a copy of this order."
                            + "<br><br>");
                    sSQL = "SELECT orders.* FROM orders WHERE orderid = " + nOrderID;

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
                    } else {
                        sTemp=payType;
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
        Statement preparedStatement = db5con.prepareStatement(sSQL, ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_READ_ONLY);
        rsOrderLines = preparedStatement.executeQuery(sSQL);

        rsOrderLines.last();
        nNumCartItems = rsOrderLines.getRow();

        Integer Plus = 0;
        Double cSubTotal = 0D;
        nNumItems = 0;

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
        cShipping = (Double) session.getAttribute("shipbasecharge") + (nNumItems * (Double) session.getAttribute("shipitemcharge"));
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

<div align="center"><font face="Verdana,Arial" size="+1">
    <br></font><font face="Verdana,Arial" color="#FF0000" size="2">Thank you for your order<br>
    We always welcome you to visit our site again, come soon
    </font></div>
<font face="Verdana,Arial" color="#008000" size="-1"></font>
<p align="center"></p>
<% } else {%>
<center><font face="Verdana,Arial" color="#FF0000" size="-1"><b>
        The following error(s) occurred while processing the information 
        you provided:<br></b></font></center>
<p align="center"><font face="Verdana,Arial" color="#FF0000" size="-1"><b><br>
        <%= sErrorString%>
        <br></b></font></p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center"><font face="Verdana,Arial" color="#FF0000" size="-1"><b>Please press your browser's BACK button and correct this 
        information, then resubmit your order.</b>
        <% }%>

    </font>
    <font face="Verdana,Arial" color="#008000" size="-1">
    <br>
    <%
        if ((Boolean) session.getAttribute("salecomplete") == true) {
            ArrayList sItemNums = new ArrayList();
            ArrayList nItemQtys = new ArrayList();
            sItemNums.add(0, "");
            nItemQtys.add(0, 0);
            session.setAttribute("CartItemNumArray", sItemNums);
            session.setAttribute("CartItemQtyArray", nItemQtys);
            session.setAttribute("salecomplete", false);
        }
    %>
    <%@include file="footer.jsp" %>
</p>
</font>
