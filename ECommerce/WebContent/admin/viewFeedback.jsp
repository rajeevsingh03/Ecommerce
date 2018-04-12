
<%@page import="java.sql.PreparedStatement"%>
<%@page import="database.MyConnection"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%

    session.setAttribute("sPageHead", "Admin FeebBack Page");

    Connection db1con = null;
    String sql = "";
    ResultSet rsFeebBack = null;
%>

<%@include file="header4.jsp"%>

<table border="0" width="100%">
    <tr>
        <td bgcolor="#0000FF"><p align="center"><font face="Verdana,Arial" color="#ffffff" style="font-size:12;">
                <b>Latest FeedBack</b></font></p></td>
    </tr>
</table>

<%
    db1con = MyConnection.getConnection();
    if (db1con.isClosed()) {
    }

    sql = "SELECT Feedback.* FROM Feedback Order by ID desc";
    PreparedStatement preparedStatement = db1con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
            ResultSet.CONCUR_READ_ONLY);
    //preparedStatement.setDate(1, new java.sql.Date(new java.util.Date().getTime()));
    //preparedStatement.setDate(2, new java.sql.Date(new java.util.Date().getTime()));
    rsFeebBack = preparedStatement.executeQuery();

    if (rsFeebBack.next()) {
%>
<table width="75%" border="1" align="center">
    <tr bgcolor="#0000FF">
        <th><font face="Verdana,Arial" color="#ffff00" size="-1">
            Name</font></th>
        <th><font face="Verdana,Arial" color="#ffff00" size="-1">
            Mobile No.</font></th>
        <th><font face="Verdana,Arial" color="#ffff00" size="-1">
            Email</font></th>
        <th><font face="Verdana,Arial" color="#ffff00" size="-1">
            Message</font></th>        
    </tr>
    <%
        do {
            //Write a table row for the current record of rsProducts
            out.write("<tr>");

            out.write("<td align=\"center\">");
            out.write(rsFeebBack.getString("F_Name"));
            out.write(" ");
            out.write(rsFeebBack.getString("L_Name"));
            out.write("</td>");

            out.write("<td align=\"center\">");
            out.write(rsFeebBack.getString("Mobile"));
            out.write("</td>");

            out.write("<td align=\"center\">");
            out.write(rsFeebBack.getString("Email"));
            out.write("</td>");

            out.write("<td align=\"center\">");
            out.write(rsFeebBack.getString("Message"));
            out.write("</td>");

            out.write("</tr>");
        } while (rsFeebBack.next());
    %>
</table>




<% } else {%>
<table border="0" width="100%">
    <tr>
        <td bgcolor="#0000FF">
            <p align="center"><b><font face="Verdana,Arial" color="#FFFFFF">Unfortunately, No Feedback Found</font></b></p></td>
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