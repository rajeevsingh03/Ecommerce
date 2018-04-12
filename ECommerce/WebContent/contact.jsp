<%

    session.setAttribute("loginFailure", false);
    session.setAttribute("out", false);


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

%>
<HTML>
    <script type=text/javascript>

    </script>
    <%@include file="header4.jsp" %>
    <FORM ACTION="contactsubmit.jsp" METHOD=post onsubmit="return">

        <TABLE WIDTH="80%" BORDER="0" CELLSPACING="0" CELLPADDING="1" ALIGN="center" style="border-style: solid; border-color: #0000CC">
            <TR> 
                <TD BGCOLOR="#0000FF" CLASS="hea" HEIGHT="20"> 
                    <DIV ALIGN="center"><font face="Verdana,Arial" color="#ffffff"><b>Contact
                            Us</b></font></DIV>
                </TD>
            </TR>
            <TR> 
                <TD BGCOLOR="#33ccff"> 
                    <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="8" BGCOLOR="#EFEFEF">
                        <TR> 
                            <TD CLASS="small" COLSPAN="2"> 
                                <%//System.out.print(session.getAttribute("FNkhali"));%>
                                <% if ((Boolean) session.getAttribute("FNkhali") == true) {%>
                                <p align="center">
                                    <b>
                                        <font color="#FF0000" size="2">
                                        Please enter your First name</font></b>
                                </p>
                                <% }%>
                                <% if ((Boolean) session.getAttribute("illegalF_Name") == true) {%>
                                <p align="center">
                                    <b>
                                        <font color="#FF0000" size="2">
                                        Your first may not contain hyphen(-) ,@ and spaces</font></b>
                                </p>
                                <% }%>

                                <% if ((Boolean) session.getAttribute("LNkhali") == true) {%>
                                <p align="center">
                                    <b>
                                        <font color="#FF0000" size="2">
                                        Please enter your Last name</font></b>
                                </p>
                                <% }%>
                                <% if ((Boolean) session.getAttribute("illegalL_Name") == true) {%>
                                <p align="center">
                                    <b>
                                        <font color="#FF0000" size="2">
                                        Your last name may not contain hyphen(-) ,@ and spaces</font></b>
                                </p>
                                <% }%>

                                <% if ((Boolean) session.getAttribute("MBkhali") == true) {%>
                                <p align="center">
                                    <b>
                                        <font color="#FF0000" size="2">
                                        Please enter valid mobile number</font></b>
                                </p>
                                <% }%>
                                <% if ((Boolean) session.getAttribute("EMkhali") == true) {%>
                                <p align="center">
                                    <b>
                                        <font color="#FF0000" size="2">
                                        Please enter your email address</font></b>
                                </p>
                                <% }%>
                                <% if ((Boolean) session.getAttribute("tapal") == true) {%>
                                <p align="center">
                                    <b>
                                        <font color="#FF0000" size="2">
                                        Invalid e-mail address</font></b>
                                </p>
                                <% }%>
                                <% if ((Boolean) session.getAttribute("MSkhali") == true) {%>
                                <p align="center">
                                    <b>
                                        <font color="#FF0000" size="2">
                                        Please enter your message</font></b>
                                </p>
                                <% }%>

                                <% if ((Boolean) session.getAttribute("MesLen") == true) {%>
                                <p align="center">
                                    <b>
                                        <font color="#FF0000" size="2">
                                        Message must be only 250 characters long.</font></b>
                                </p>
                                <% }%>

                                <% if ((Boolean) session.getAttribute("Contact") == true) {%>
                                <p align="center">
                                    <b>
                                        <font color="#FF0000" size="2">
                                        You have successfully submitted your information.</font> </b></p>
                                <p align="center">
                                    &nbsp;</p>
                                    <% }%>

                            </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="small" COLSPAN="2"> 
                                <DIV ALIGN="center" CLASS="text"><font size="2" color="#0000FF">Please enter
                                    the following information</font></DIV>
                            </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <DIV ALIGN="center">
                                    <p align="right"><B><font size="2" color="#0000FF">First
                                            Name :</font> </B></DIV>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=20 NAME=F_Name value="<%= session.getAttribute("FName")%>" CLASS="TextBox" size="20" style="border-style: solid; border-color: #0000FF">
                                </FONT> </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%"> 
                                <DIV ALIGN="center">
                                    <p align="right"><B><font size="2" color="#0000FF">Last
                                            Name :</font></B></DIV>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=20 NAME=L_Name value="<%= session.getAttribute("LName")%>" CLASS="TextBox" size="20" style="border-style: solid; border-color: #0000FF">
                                </FONT> </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%" align="right"> 
                                <p align="right"><b><font size="2" color="#0000FF">Street/town
                                        :&nbsp;</font></b>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=50 NAME=Street value="<%= session.getAttribute("St")%>" CLASS="TextBox" size="20" style="border-style: solid; border-color: #0000FF">
                                </FONT> </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%" align="right"> 
                                <B><font size="2" color="#0000FF">State :</font></B>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=15 NAME=City value="<%= session.getAttribute("Cty")%>" CLASS="TextBox" size="20" style="border-style: solid; border-color: #0000FF">
                                </FONT> </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%" align="right"> 
                                <B><font size="2" color="#0000FF">Country :</font></B>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=15 NAME=Country value="<%= session.getAttribute("Cntry")%>" CLASS="TextBox" size="20" style="border-style: solid; border-color: #0000FF">
                                </FONT> </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%" align="right"> 
                                <B><font size="2" color="#0000FF">Home Phone :</font></B>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=20 NAME=Home_Phone value="<%= session.getAttribute("HomePhone")%>" CLASS="TextBox" size="20" style="border-style: solid; border-color: #0000FF">
                                </FONT> </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%" align="right"> 
                                <B><font size="2" color="#0000FF">Mobile :</font></B>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=20 NAME=Mobile value="<%= session.getAttribute("Mob")%>" CLASS="TextBox" size="20" style="border-style: solid; border-color: #0000FF">
                                </FONT> </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%" align="right"> 
                                <B><font size="2" color="#0000FF">Email :</font></B>
                            </TD>
                            <TD WIDTH="59%"><FONT FACE="Arial" SIZE="2"> 
                                <INPUT MAXLENGTH=30 NAME=Email value="<%= session.getAttribute("Emailaddress")%>" CLASS="TextBox" size="20" style="border-style: solid; border-color: #0000FF">
                                </FONT> </TD>
                        </TR>
                        <TR> 
                            <TD CLASS="text" WIDTH="41%" align="right"> 
                                <B><font size="2" color="#0000FF">Message :</font></B>
                            </TD>
                            <TD WIDTH="59%"><textarea rows="5" name="Message" cols="32" style="border: 1 solid #0000FF"><%= session.getAttribute("Mes")%></textarea> </TD>
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
                    </TABLE>
                </TD>
            </TR>
        </TABLE>


    </FORM>
    <% session.setAttribute("Contact", false);%>
    <%@include  file="footer.jsp" %>

</BODY></HTML>