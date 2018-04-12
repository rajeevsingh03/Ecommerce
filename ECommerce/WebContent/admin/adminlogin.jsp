<%
    session.setAttribute("sPageHead", "Admin Login Page");

    session.setAttribute("sPageCaption", "Admin User Only");

    if (session.getAttribute("adminlogin") == null) {
        session.setAttribute("adminlogin", 0);
    }

    if ((Integer) session.getAttribute("adminlogin") == 1) {
        response.sendRedirect("viewFeedback.jsp");
        return;
    }

%>
<HTML>
    <%@include file="header4.jsp" %>
    <FORM ACTION="submitadminlogin.jsp" METHOD=post>

        <TABLE WIDTH="80%" BORDER="0" CELLSPACING="0" CELLPADDING="1" ALIGN="center" style="border-style: solid; border-color: #0000CC">
            <TR> 
                <TD BGCOLOR="#0000FF" CLASS="hea" HEIGHT="20"> 
                    <DIV ALIGN="center"><font face="Verdana,Arial" color="#ffffff"><b>Admin User</b></font></DIV>
                </TD>
            </TR>

            <TR> 
                <TD BGCOLOR="#33ccff"> 
                    <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="8" BGCOLOR="#EFEFEF">
                        <TR> 
                            <TD CLASS="small" COLSPAN="2"> 


                                <p align="left"><font size="3" face="Verdana,Arial" color="#0000ff"><B>Welcome to our electric product store
                                    </B></font>
                            </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="small" COLSPAN="2"> 
                                <%
                                    if (session.getAttribute("adminloginFailure") == null) {
                                        session.setAttribute("adminloginFailure", false);
                                    }
                                %>
                                <% if ((Boolean) session.getAttribute("adminloginFailure") == true) {%>
                                <p align="center"><font size="2" color="#FF0000"><b>Invalid Password</b></font>
                                    <% }%>  
                                    <%
                                        session.setAttribute("adminloginFailure", false);
                                    %>
                            </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="small" COLSPAN="2"> 
                                &nbsp;
                            </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="small" COLSPAN="2"> 
                                <DIV ALIGN="center" CLASS="text"><font size="2" color="#0000FF">Please enter your user name and password</font></DIV>
                            </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <DIV ALIGN="center">
                                    <p align="right"><B><font size="2" color="#0000FF">User Name :</font> </B></DIV>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=50 NAME=id CLASS="TextBox" size="20" style="border-style: solid; border-color: #0000FF">
                                </FONT> </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <DIV ALIGN="center">
                                    <p align="right"><B><font size="2" color="#0000FF">Password :</font></B></DIV>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=20 NAME=pwd TYPE=password CLASS="TextBox" size="20" style="border-style: solid; border-color: #0000FF">
                                </FONT> </TD>
                        </TR>
                        <TR> 
                            <TD WIDTH="41%"> 
                                <DIV ALIGN="center">
                                </DIV>
                            </TD>
                            <TD WIDTH="59%"> 
                                <INPUT TYPE="SUBMIT" Name="Login" VALUE="Submit" CLASS="button" OnMouseOver='this.className = "buttonOver"' OnMouseOut='this.className = "button"' style="color: #0000FF; border: 1 solid #0000FF">
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
</BODY></HTML>