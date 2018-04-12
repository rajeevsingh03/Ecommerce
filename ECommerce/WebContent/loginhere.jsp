<%
    session.setAttribute("notfull", false);
    session.setAttribute("email", false);
    session.setAttribute("Forgot", false);
    session.setAttribute("Remember", false);
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

    session.setAttribute("sPageHead", "Login Page");

    session.setAttribute("sPageCaption", "Registered User");

%>
<HTML>
    <%@include file="header4.jsp" %>
    <FORM ACTION="submitlogin.jsp" METHOD=post>

        <TABLE WIDTH="80%" BORDER="0" CELLSPACING="0" CELLPADDING="1" ALIGN="center" style="border-style: solid; border-color: #0000CC">
            <TR> 
                <TD BGCOLOR="#0000FF" CLASS="hea" HEIGHT="20"> 
                    <DIV ALIGN="center"><font face="Verdana,Arial" color="#ffffff"><b>Registered User</b></font></DIV>
                </TD>
            </TR>

            <TR> 
                <TD BGCOLOR="#33ccff"> 
                    <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="8" BGCOLOR="#EFEFEF">
                        <TR> 
                            <TD CLASS="small" COLSPAN="2"> 


                                <p align="left"><font size="3" face="Verdana,Arial" color="#0000ff"><B>Welcome to our electronic store
                                    </B></font>
                            </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="small" COLSPAN="2"> 
                                <%
                                    if (session.getAttribute("loginFailure") == null) {
                                        session.setAttribute("loginFailure", false);
                                    }
                                %>
                                <% if ((Boolean) session.getAttribute("loginFailure") == true) {%>
                                <p align="center"><font size="2" color="#FF0000"><b>Invalid Password</b></font>
                                    <% }%>  
                                    <%
                                        session.setAttribute("loginFailure", false);
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
                                <DIV ALIGN="center" CLASS="text"><font size="2" color="#0000FF">Please enter your E-mail ID 
                                    and password</font></DIV>
                            </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <DIV ALIGN="center">
                                    <p align="right"><B><font size="2" color="#0000FF">E-mail ID :</font> </B></DIV>
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
                        <TR> 
                            <TD COLSPAN="2" CLASS="small"> 
                                <DIV ALIGN="CENTER" CLASS="text">
                                    <p align="left"><font size="2"><font color="#000000">Forgot your password ??</font> <A HREF="f1.jsp"><font color="#0000FF" size="2">Click 
                                            here</font></A> </font> </DIV>
                            </TD>
                        </TR>
                        <tr>
                            <TD COLSPAN="2" CLASS="small"> 
                                <DIV ALIGN="CENTER" CLASS="text">
                                    <p align="left"><font size="2"><font color="#000000">Change your password ??</font> 
                                        <a HREF="changepwd.jsp"><font color="#0000FF" size="2">Click 
                                            here</font></a><font color="#0000FF">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font><font color="#000000">New User ??</font> <A HREF="rego.jsp"><font color="#0000FF" size="2">Click 
                                            here</font></A> </font> </DIV>
                            </TD>
                        </tr>
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