<%@page import="java.util.Random"%>
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

    <style>
        A {COLOR: #0000FF; TEXT-DECORATION: none}
        A:hover{COLOR: #0000FF; TEXT-DECORATION: none;}

    </style>

    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<%
    Integer i = (Integer) session.getAttribute("login");
    if (i == null) {
        session.setAttribute("login", 0);
    }
%>
<body style="margin: 0 0 0 0">
    <table valign=top border=0 style="border-color:#ffffff" width="100%" cellspacing=0 cellpadding=0>
        <tr>
            <td align="left" valign=top>
                <table width="100%" valign="top"  bgcolor="#0100FE">
                    <tr>

                        <td align="left"><input type="image" src="images/pqr.jpg" alt="My Electric Zone"  bgcolor="#0100FE"></td>
                        <td align="right"  bgcolor="#0100FE">
                            <%@include file="adLogic.jsp" %>
                        </td>
                    </tr>
                </table>
                <table border="0" width="100%">
                    <tr>
                        <td bgcolor="#0000FF" width="16.66%">
                            <a class="fontclass" href="index.jsp" style="text-decoration:none"><font color="#ffffff" face="Arial" style="font-size:12;"><center><b>Home</b></center></font></a></td>
                        <td bgcolor="#0000FF" width="16.67%"><a href="about.jsp" style="text-decoration:none"><font color="#ffffff" face="Arial" style="font-size:12;"><center><b>About
                                        Us</b></center></font></a></td>
                        <td bgcolor="#0000FF" width="16.67%">
                            <a href="shopcart.jsp" style="text-decoration:none"><font color="#ffffff" face="Arial" style="font-size:12;"><center><b>View
                                        Cart</b></center></font></a></td>
                        <td bgcolor="#0000FF" width="16.67%">
                            <% if ((Integer) session.getAttribute("login") == 1) {%><a class="fontclass" href="policy.jsp" style="text-decoration:none"><font color="#ffffff" face="Arial" style="font-size:12;"><center><b>Policy</b></center></font></a><% } else {%><a class="fontclass" href="rego.jsp" style="text-decoration:none"><font color="#ffffff" face="Arial" style="font-size:12;"><center><b>Register</b></center></font></a><% }%></td>
                        <td bgcolor="#0000FF" width="16.67%">
                            <a class="fontclass" href="contact.jsp" style="text-decoration:none"><font color="#ffffff" face="Arial" style="font-size:12;"><center><b>Contact Us</b></center></font></a></td>
                        <td bgcolor="#0000FF" width="16.66%">
                            <% if ((Integer) session.getAttribute("login") == 1) {%><a href="logoutpage.jsp" style="text-decoration:none"><font color="#ffffff" face="Arial" style="font-size:12;"><center><b>Logout</b></center></font></a><% } else {%><a href="loginhere.jsp" style="text-decoration:none"><font color="#ffffff" face="Arial" style="font-size:12;"><center><b>Login</b></center></font></a><% }%></td>
                    </tr>
                </table>
                <table border="0" width="100%">
                    <tr>
                        <td bgcolor="#FFFFFF" align="center" width="50%">
                            <font face="Verdana,Arial" color="#0000ff" style="font-size:12;">
                            <b><%= session.getAttribute("sPageCaption")%></font></b></td>
                    </tr>
                </table>
                <table border="0" width="100%">
                    <tr>
                        <td bgcolor="#FFFFFF" width="100%" align="right" width="50%">
                            <% if ((Integer) session.getAttribute("login") == 1) {%><b><font face="Verdana,Arial" color="#0000ff" style="font-size:12;">[ <%= session.getAttribute("user")%> ]</font></b><% }%></td>
                    </tr>
                </table>
