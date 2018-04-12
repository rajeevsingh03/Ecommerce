<%
    session.setAttribute("loginFailure", false);
    session.setAttribute("out", false);

    session.setAttribute("notfull", false);
    session.setAttribute("email", false);
    session.setAttribute("Forgot", false);
    session.setAttribute("Remember", false);
    session.setAttribute("fpdirect", false);

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

    session.setAttribute("sPageHead", "Change your Password");
    session.setAttribute("sPageCaption", "Change Password");
%>
<HTML>
    <%@include file="header4.jsp" %>
    <FORM ACTION="cp.jsp" METHOD=post>

        <TABLE WIDTH="80%" BORDER="0" CELLSPACING="0" CELLPADDING="1" ALIGN="center" style="border-style: solid; border-color: #0000CC">
            <TR> 
                <TD BGCOLOR="#0000FF" CLASS="hea" HEIGHT="20"> 
                    <DIV ALIGN="center"><font face="Verdana,Arial" color="#ffffff"><b>Change Password</b></font></DIV>
                </TD>
            </TR>

            <TR> 
                <TD BGCOLOR="#33ccff"> 
                    <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="8" BGCOLOR="#EFEFEF">
                        <TR> 
                            <TD CLASS="small" COLSPAN="2"><b>
                                    <% if ((Boolean) session.getAttribute("empty") == true) {%>
                                    <font SIZE="2" COLOR="red">
                                    <p align="center">&nbsp;</p>
                                    <p align="center">You must enter all the required field</p>
                                    <p align="center"></font>
                                        <% }%>  
                                        <% if ((Boolean) session.getAttribute("notequal") == true) {%>
                                        <font SIZE="2" COLOR="red">
                                    <p align="center">Both Password fields must have the same value</p>
                                    <p align="center"></font>
                                        <% }%> 

                                        <% if ((Boolean) session.getAttribute("len") == true) {%>
                                        <font SIZE="2" COLOR="red">
                                    <p align="center">&nbsp;</p>
                                    <p align="center">Password must be atleast 6 and maximum 20 characters long</p>
                                    <p align="center"></font>
                                        <% }%>  



                                        <% if ((Boolean) session.getAttribute("Fail") == true) {%>
                                        <font SIZE="2" COLOR="red">
                                    <p align="center">Invalid Password</p>
                                    <p align="center"></font><% }%> 
                                        <% if ((Boolean) session.getAttribute("PC") == true) {%>
                                        <font SIZE="2" COLOR="red">
                                    <p align="center">You have successfully changed your password</p>
                                    <p></font>
                                        <% }%>
                                </b>
                            </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="small" COLSPAN="2"> 
                                <DIV ALIGN="center" CLASS="text"><font size="2" color="#0000FF">Please enter your username 
                                    and password</font></DIV>
                            </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <DIV ALIGN="center">
                                    <p align="right"><B><font size="2" color="#0000FF">E-mail ID :</font> </B></DIV>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=50 NAME=loginid CLASS="TextBox" size="22" style="border-style: solid; border-color: #0000FF">
                                </FONT> </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <DIV ALIGN="center">
                                    <p align="right"><B><font size="2" color="#0000FF">&nbsp; Old Password :</font></B></DIV>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=20 NAME=submit_login TYPE=password CLASS="TextBox" size="22" style="border-style: solid; border-color: #0000FF">
                                </FONT> </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <p align="right"><B><font size="2" color="#0000FF">New Password :</font></B>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"><INPUT MAXLENGTH=20 NAME=pass1 CLASS="TextBox" size="22" style="border-style: solid; border-color: #0000FF" type="password">
                                </FONT> </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <p align="right"><B><font size="2" color="#0000FF">Re-type
                                        new Password :</font></B>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"><INPUT MAXLENGTH=20 NAME=pass2 CLASS="TextBox" size="22" style="border-style: solid; border-color: #0000FF" type="password">
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
                                <DIV ALIGN="CENTER" CLASS="text">
                                    <p align="left"><font size="2"><font color="#000000">Forgot your password ??</font> 
                                        <a href="f1.jsp"><font color="#0000FF" size="2">Click 
                                            here</font></a><font color="#0000FF">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </font></font> 
                                    <p align="left"><font size="2"><font color="#000000">New User ??</font>  <a HREF="rego.jsp"><font color="#0000FF" size="2">Click 
                                            here</font></a></font> </DIV>
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


    </FORM>
    <%@include file="footer.jsp" %>
</BODY></HTML>


