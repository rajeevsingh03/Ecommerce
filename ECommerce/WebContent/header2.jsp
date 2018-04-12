<head>
    <title><%= session.getAttribute("sPageHead")%></title>
    <style>




    </style>
    <link rel="stylesheet" type="text/css" href="css/style.css">

</head>
<%
    Integer i = (Integer) session.getAttribute("login");
    if (i == null) {
        session.setAttribute("login", 0);
    }
%>
<body>
    <table border="0" width="100%">
        <tr>
            <td align="left"><a href="index.jsp"><img src="images/pqr.jpg" border="0" alt="Home"></a></td>
            <td align="Right">
                <font color="#0000ff"><b>Phone:</b>   +91 9999999999</font><br>
                <font color="#0000ff"><b>Fax:</b>  +91 9999999999</font><br>
                <font color="#0000ff"><b>E-mail:</b>  xyz@hotmail.com</font><br>
            </td>

        </tr>
    </table>
    <br>

    <table border="0" width="100%">
        <tr>
            <% if ((Integer) session.getAttribute("login") == 1) {%>
            <td bgcolor="#FFFFFF" align="Right">
                <b><font face="Verdana,Arial" color="#0000ff" size="2">[ <%= session.getAttribute("user")%> ]</font></b></td>
        <font color="#FFFF00">
        <% }%>
        </tr>
        <tr>
            <td bgcolor="#0000FF" align="center">
                <font face="Verdana,Arial" color="#ffffff">
                <b><%= session.getAttribute("sPageCaption")%></font></b></td>

        </tr>
    </table>
