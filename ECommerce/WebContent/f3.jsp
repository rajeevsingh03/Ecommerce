<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.MyConnection"%>
<%
    String Name = (String) session.getAttribute("Name");
    Connection PConn = MyConnection.getConnection();
%>
<% if ((Boolean) session.getAttribute("fpdirect") == true) {%>
<%@include file="header.jsp" %>

<%
    session.setAttribute("sPageCaption", "Forgot Password Page");
%>
<HTML>
    <%



        String sql = "select Register.* from Register where User_Name = '" + Name + "'";

        //System.out.print(sql);

        PreparedStatement preparedStatement = PConn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = preparedStatement.executeQuery(sql);

    %>
    <HEAD>
        <TITLE>Online Electonic Store Change Password Page</TITLE>


    </HEAD>
    <BODY bgColor=#ffffff  marginheight=0 >
        <TABLE WIDTH="80%" BORDER="0" CELLSPACING="0" CELLPADDING="1" ALIGN="center" style="border-style: solid; border-color: #0000CC">
            <TR> 
                <TD BGCOLOR="#0000FF" CLASS="hea" HEIGHT="20"> 
                    <DIV ALIGN="center"><font face="Verdana,Arial" color="#ffff00"><b>Your User Name and Password</b></font></DIV>
                </TD>
            </TR>
            <TR> 
                <TD BGCOLOR="#33ccff"> 
                    <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="8" BGCOLOR="#EFEFEF">
                        <TR> 
                            <TD CLASS="small" COLSPAN="2"> 
                                <DIV ALIGN="center" CLASS="text">&nbsp;
                                    <p><font size="2" color="#0000FF">Your User Name 
                                        and Password</font>
                                    </p>
                                    <p>&nbsp;</DIV>
                            </TD>
                        </TR>
                        <%while (rs.next()) {%>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <DIV ALIGN="center">
                                    <p align="right"><B><font size="2" color="#0000FF">Username :</font> </B></DIV>
                            </TD>
                            <TD CLASS="text" WIDTH="59%"><B><font size="2" color="#0000FF"> 
                                    <%= rs.getString("User_Name")%>
                                    </FONT></B></TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <DIV ALIGN="center">
                                    <p align="right"><B><font size="2" color="#0000FF">&nbsp; Password :</font></B></DIV>
                            </TD>
                            <TD CLASS="text" WIDTH="59%"><B><font size="2" color="#0000FF"> 
                                    <%= rs.getString("Password_")%>
                                    </FONT></B></TD>
                        </TR>
                        <tr>
                            <td width="174">
                                <%
                                    }
                                    session.setAttribute("Name", "");
                                %>
                            </td>
                        </tr>

                        <TR> 
                            <TD COLSPAN="2" CLASS="small"> 
                                &nbsp;
                            </TD>
                        </TR>

                        <TR> 
                            <TD COLSPAN="2" CLASS="small"> 
                                <DIV ALIGN="CENTER" CLASS="text">
                                    <p align="left"><font size="2"><font color="#000000">Change your password ??</font> 
                                        <a href="changepwd.jsp"><font color="#0000FF" size="2">Click 
                                            here</font></a><font color="#0000FF">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font><font color="#000000">New User ??</font>  <a HREF="rego.jsp"><font color="#0000FF" size="2">Click 
                                            here</font></a></font> </DIV>
                            </TD>
                        </TR>
                        <TR> 
                            <TD COLSPAN="2" CLASS="small"> 
                                <DIV ALIGN="CENTER" CLASS="text">
                                    <p align="left"><font size="2"><font color="#000000">Login here ?</font> <A HREF="loginhere.jsp"><font color="#0000FF" size="2">Click 
                                            here</font></A> </font> </DIV>
                            </TD>
                        </TR>
                        <TR> 
                            <TD COLSPAN="2" CLASS="small"> 
                                &nbsp;
                            </TD>
                        </TR>
                        <TR> 
                            <TD COLSPAN="2" CLASS="small"> 
                                &nbsp;
                            </TD>
                        </TR>
                    </TABLE>
                </TD>
            </TR>
        </TABLE>
        <%@include file="footer.jsp" %>
    </BODY></HTML>

<%
    } else {
        response.sendRedirect("f1.jsp");
    }
%>
<%
    try {
        if (PConn != null) {
            PConn.close();
        }
    } catch (Exception ex) {
        System.out.printf("Error in contactSubmit.jsp" + ex.getMessage());
    }
%>