<%
    session.setAttribute("loginFailure", false);
    session.setAttribute("out", false);

    session.setAttribute("fpdirect", false);

    session.setAttribute("empty", false);
    session.setAttribute("notequal", false);
    session.setAttribute("Fail", false);
    session.setAttribute("PC", false);
    session.setAttribute("len", false);
    session.setAttribute("continue", false);

    session.setAttribute("empt", false);
    session.setAttribute("noteq", false);
    session.setAttribute("RC", false);
    session.setAttribute("exist", false);
    session.setAttribute("register", false);
    session.setAttribute("illegalusername", false);
    session.setAttribute("illegalpass", false);
    session.setAttribute("User_Name", "");
    session.setAttribute("Sec_Qsn", "");
    session.setAttribute("answer", "");

    session.setAttribute("illegalL_Name", false);
    session.setAttribute("illegalF_Name", false);
    session.setAttribute("FNkhali", false);
    session.setAttribute("ContactFail", false);
    session.setAttribute("Contact", false);
    session.setAttribute("send", false);
    session.setAttribute("tapal", false);
    session.setAttribute("LNkhali", false);
    session.setAttribute("EMkhali", false);
    session.setAttribute("MBkhali", false);
    session.setAttribute("MSkhali", false);
    session.setAttribute("MesLen", false);
    session.setAttribute("khali", false);
    session.setAttribute("defaultMes", false);
    session.setAttribute("FName", "");
    session.setAttribute("LName", "");
    session.setAttribute("St", "");
    session.setAttribute("Cty", "");
    session.setAttribute("Cntry", "");
    session.setAttribute("HomePhone", "");
    session.setAttribute("Mob", "");
    session.setAttribute("Emailaddress", "");
    session.setAttribute("Mes", "");

    session.setAttribute("sPageHead", "Forgot Your Password");
    session.setAttribute("sPageCaption", "Forgot Password");
%>
<HTML>
    <%@include file="header4.jsp" %>
    <FORM ACTION="f2.jsp" METHOD=post>

        <TABLE WIDTH="80%" BORDER="0" CELLSPACING="0" CELLPADDING="1" ALIGN="center" style="border-style: solid; border-color: #0000CC">
            <TR> 
                <TD BGCOLOR="#0000FF" CLASS="hea" HEIGHT="20"> 
                    <DIV ALIGN="center"><font face="Verdana,Arial" color="#ffffff"><b>Forgot Password</b></font></DIV>
                </TD>
            </TR>
            <TR> 

                <TD BGCOLOR="#EFEFEF" CLASS="hea" HEIGHT="20" align="center" style="border-color:#FFFFFF"> 
            <center>
                <%
                    if (session.getAttribute("notfull") == null) {
                        session.setAttribute("notfull", false);
                    }
                    if ((Boolean) session.getAttribute("notfull") == true) {
                %>
                <p><b>
                        <font size="2" COLOR="red" face="Arial">
                        You must enter all the required fields</font>
                    </b> </p>
                <p><b><font size="2" face="Arial">
                        <% }
                            session.setAttribute("notfull", false);
                        %> 
                        <%
                            if (session.getAttribute("email") == null) {
                                session.setAttribute("email", false);
                            }
                            if ((Boolean) session.getAttribute("email") == true) {
                        %>
                        </font></b>
                <p><b>
                        <font size="2" COLOR="red" face="Arial">
                        Please enter valid e-mail address</font>
                    </b></p>
                <p><b><font size="2" face="Arial">
                        <% }
                            session.setAttribute("email", false);
                        %> 
                        <%
                            if (session.getAttribute("Forgot") == null) {
                                session.setAttribute("Forgot", false);
                            }
                            if ((Boolean) session.getAttribute("Forgot") == true) {%>
                        </font></b>

                <p><b>
                        <font size="2" COLOR="red" face="Arial">

                        Attempt failed, please try again

                        </font>

                    </b> </p>
                <font SIZE="4" COLOR="red">

                <%                    }
                    session.setAttribute("Forgot", false);
                    if (session.getAttribute("Remember") == null) {
                        session.setAttribute("Remember", false);
                    }
                    if ((Boolean) session.getAttribute("Remember") == true) {%>

                </font>

                <p><b>
                        <font size="2" COLOR="red" face="Arial">

                        Your password will be sent by e-mail

                        </font></b></p>

                <font SIZE="4" COLOR="red">

                <% }
                    session.setAttribute("Remember", false);
                %> 


                </font>
                <p>
                    &nbsp;
                </p>
                <table BORDER="0">
                    <tr>
                        <td align="right"><font face="Arial" size="2" color="#0000FF"><b>E-mail ID:</b></font></td>
                    <font SIZE="4" COLOR="red">

                    <td>
                        <input TYPE="text" MAXLENGTH=50 class=field NAME="loginid" size="22" style="border: 1px solid #0000FF"> </td>
                    </tr>
                    </font>
                    <tr>
                        <td align="right"><font face="Arial" size="2" color="#0000FF"><b>Security Question:</b></font></td>
                    <font SIZE="4" COLOR="red">

                    <td>

                        <input TYPE="text" MAXLENGTH=50 class=field NAME="Qsn" size="22" style="border: 1px solid #0000FF">
                    </td>
                    </tr>
                    </font>
                    <tr>
                        <td align="right"><font face="Arial" size="2" color="#0000FF"><b>Answer:</b></font></td>
                    <font SIZE="4" COLOR="red">

                    <td>
                        <input TYPE="text" class=field MAXLENGTH=30 NAME="ans" size="22" style="border: 1px solid #0000FF"></td>
                    </tr>
                    </font>


                    <tr>
                        <td></td>
                        <td ALIGN="LEFT">
                            <INPUT TYPE="SUBMIT" ID="login1" NAME="login1" VALUE="Submit" CLASS="button" OnMouseOver='this.className = "buttonOver"' OnMouseOut='this.className = "button"' style="color: #0000FF; border: 1 solid #0000FF">
                        </td>
                    </tr>
                </table>
            </center>



            </font>



            </TD>
            </TR>

            <TR> 
                <TD CLASS="small" BGCOLOR="#EFEFEF"> 
                    <DIV ALIGN="CENTER" CLASS="text">
                        <p align="left"><font size="2"><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;
                            <font face="Verdana, Arial">Change your password ??</font></font> 
                            <font face="Verdana, Arial"> 
                            <a href="changepwd.jsp"><font color="#0000FF" size="2">Click 
                                here</font></a><font color="#0000FF">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </font></font></font> 
                        <p align="left"><font size="2" face="Verdana, Arial"><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;
                            Login ??</font>  <a HREF="loginhere.jsp"><font color="#0000FF" size="2">Click 
                                here</font></a></font> 
                        <p align="left">&nbsp; </DIV>
                </TD>
            </TR>
        </TABLE>


    </FORM>
    <%@include file="footer.jsp" %>
</BODY></HTML>

