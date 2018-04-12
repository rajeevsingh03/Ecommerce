<head>
    <title><%= session.getAttribute("sPageHead")%></title>
    <meta name="description" content="Shopping Cart for Online Shopping.">
    <meta name="keywords" content="Shopping Cart, Shop Cart, Shopping Carts, , Shop Carts, shopcart, shopcarts">
    <meta name="rating" content="general">
    <meta name="copyright" content="2003, firstchoice">
    <meta name="revisit-after" content="31 Days">
    <meta name="expires" content="never"> 
    <meta name="distribution" content="global"> 
    <meta name="robots" content="index">
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <style>


        -->
    </style>
</head>
<%
    Integer iLogin = (Integer) session.getAttribute("adminlogin");
    if (iLogin == null) {
        session.setAttribute("adminlogin", 0);
    }   
%>
<body>
    <table valign=top width="100%" cellspacing=0 border="0" cellpadding=0>
        <tr>
            <td align="left" valign=top>
                <table width="100%" valign=top>
                    <tr>

                        <td align="left"  bgcolor="#0100FE"><input type="image" src="../images/pqr.jpg" 
                                                alt="firstchoice logo"></td>

                    </tr>
                </table>

                <table border="0" width="100%">
                    <tr>
                        <td bgcolor="#0000FF" width="16.66%">
                            <a class="fontclass" href="index.jsp" style="text-decoration:none"><font color="#ffffff" face="Arial" style="font-size:12;"><center><b>Home</b></center></font></a></td>
                        <td bgcolor="#0000FF" width="16.67%">
                            <a class="fontclass" href="viewFeedback.jsp" style="text-decoration:none"><font color="#ffffff" face="Arial" style="font-size:12;"><center><b>View FeedBack</b></center></font></a>
                        </td>
                        <td bgcolor="#0000FF" width="16.67%">
                            <a class="fontclass" href="viewOrder.jsp" style="text-decoration:none"><font color="#ffffff" face="Arial" style="font-size:12;"><center><b>View Order</b></center></font></a></td>
                        <td bgcolor="#0000FF" width="16.67%">
                            <a class="fontclass" href="viewProduct.jsp" style="text-decoration:none"><font color="#ffffff" face="Arial" style="font-size:12;"><center><b>View Product</b></center></font></a></td>
                        <td bgcolor="#0000FF" width="16.67%">
                            <a class="fontclass" href="addProduct.jsp" style="text-decoration:none"><font color="#ffffff" face="Arial" style="font-size:12;"><center><b>Add Product</b></center></font></a></td>
                        <td bgcolor="#0000FF" width="16.66%">
                            <% if ((Integer) session.getAttribute("adminlogin") == 1) {%><a href="adminlogoutpage.jsp" style="text-decoration:none"><font color="#ffffff" face="Arial" style="font-size:12;"><center><b>Logout</b></center></font></a><% } else {%><a href="adminlogin.jsp" style="text-decoration:none"><font color="#ffffff" face="Arial" style="font-size:12;"><center><b>Login</b></center></font></a><% }%></td>
                    </tr>
                </table>


                <table border="0" width="100%">
                    <tr>
                        <% if ((Integer) session.getAttribute("adminlogin") == 1) {%>
                        <td bgcolor="#FFFFFF" width="100%" align="right">
                            <b><font face="Verdana,Arial" color="#0000ff" style="font-size:12;">[ <%= session.getAttribute("adminuser")%> ]</font></b>
                        </td>
                        <% }%>
                    </tr>
                </table>
