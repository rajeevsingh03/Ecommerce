<%@page import="java.sql.PreparedStatement"%>
<%@page import="database.MyConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%
    Connection RConn = null;
    String sql = "";
    ResultSet rs, rs2;
    String UName, Pass, Pass2, Sec_Qsn, answer = "";
    UName = "";
    Pass = "";
    Sec_Qsn = "";

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



    session.setAttribute("RConn", RConn);

    //System.out.print(request.getParameter("User_Name") != null);

    if (request.getParameter("User_Name") != null) {

        UName = (request.getParameter("User_Name").toLowerCase());
        Pass = request.getParameter("Password");
        Pass2 = request.getParameter("Password2");
        Sec_Qsn = (request.getParameter("Sec_Qsn").toLowerCase());
        answer = (request.getParameter("answer").toLowerCase());


        session.setAttribute("User_Name", request.getParameter("User_Name"));
        session.setAttribute("Sec_Qsn", request.getParameter("Sec_Qsn"));
        session.setAttribute("answer", request.getParameter("answer"));

        if (UName.equals("") || Pass.equals("") || Pass2.equals("") || Sec_Qsn.equals("") || answer.equals("")) {

            session.setAttribute("empt", true);
            session.setAttribute("noteq", false);
            session.setAttribute("RC", false);
            session.setAttribute("exist", false);
            session.setAttribute("register", false);
            session.setAttribute("illegalusername", false);
            session.setAttribute("illegalpass", false);


            response.sendRedirect("rego.jsp");

            return;
        } else {

            //System.out.print(request.getParameter("Password").equals(request.getParameter("Password2")));
            
            if (!request.getParameter("Password").equals(request.getParameter("Password2"))) {

                session.setAttribute("empt", false);
                session.setAttribute("noteq", true);
                session.setAttribute("RC", false);
                session.setAttribute("exist", false);
                session.setAttribute("register", false);
                session.setAttribute("illegalusername", false);
                session.setAttribute("illegalpass", false);
                response.sendRedirect("rego.jsp");
                return;
            }

            if (common.CommonUtils.InStr(request.getParameter("User_Name"), "@") != 0 || common.CommonUtils.InStr(request.getParameter("User_Name"), ".") != 0 || (UName).length() < 6) {

                session.setAttribute("illegalusername", true);
                session.setAttribute("illegalpass", false);
                session.setAttribute("empt", false);
                session.setAttribute("noteq", false);
                session.setAttribute("RC", false);
                session.setAttribute("exist", false);
                session.setAttribute("register", false);

                response.sendRedirect("rego.jsp");

                return;

            }


            if (common.CommonUtils.InStr(request.getParameter("Password"), "-") == 0 || common.CommonUtils.InStr(request.getParameter("Password"), " ") == 0 || common.CommonUtils.InStr(request.getParameter("Password"), "@") == 0 || (Pass).length() < 6) {

                session.setAttribute("illegalpass", true);
                session.setAttribute("illegalusername", false);
                session.setAttribute("empt", false);
                session.setAttribute("noteq", false);
                session.setAttribute("RC", false);
                session.setAttribute("exist", false);
                session.setAttribute("register", false);


                response.sendRedirect("rego.jsp");
                return;
            }

            //System.out.print("Register is set to true " + session.getAttribute("register"));

            session.setAttribute("illegalusername", false);
            session.setAttribute("illegalpass", false);
            session.setAttribute("empt", false);
            session.setAttribute("noteq", false);
            session.setAttribute("RC", false);
            session.setAttribute("exist", false);
            session.setAttribute("register", true);

        }

    }


    if ((Boolean) session.getAttribute("register") == true) {

        RConn = MyConnection.getConnection();

        sql = "SELECT Register.* FROM Register Where User_Name='" + request.getParameter("User_Name").toString().replace("'", "") + "'";

        PreparedStatement preparedStatement = RConn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
        rs = preparedStatement.executeQuery(sql);

        while (rs.next()) {

            if (request.getParameter("User_Name").equals(rs.getString("User_Name"))) {

                session.setAttribute("empt", false);
                session.setAttribute("noteq", false);
                session.setAttribute("mail", false);
                session.setAttribute("RC", false);
                session.setAttribute("exist", true);
                session.setAttribute("register", false);
                session.setAttribute("illegalusername", false);
                session.setAttribute("illegalpass", false);


                response.sendRedirect("rego.jsp");

                return;

            }


        }

        RConn = MyConnection.getConnection();

        sql = "SELECT Register.* FROM Register";
        preparedStatement = RConn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
        rs = preparedStatement.executeQuery(sql);

        rs.moveToInsertRow();

        rs.updateString("User_Name", UName);
        rs.updateString("Password_", Pass);

        rs.updateString("Sec_Qsn", Sec_Qsn);
        rs.updateString("answer", answer);

        rs.insertRow();

        session.setAttribute("empt", false);
        session.setAttribute("mail", false);
        session.setAttribute("noteq", false);
        session.setAttribute("RC", true);
        session.setAttribute("exist", false);
        session.setAttribute("register", false);
        session.setAttribute("illegalusername", false);
        session.setAttribute("illegalpass", false);


        session.setAttribute("User_Name", "");
        session.setAttribute("Sec_Qsn", "");
        session.setAttribute("answer", "");

        response.sendRedirect("rego.jsp");

        return;

    }

%>

<html>
    <%@include file="header4.jsp" %>
    <center>
        <form method="post" action="rego.jsp" name="theForm">
            <div align="center" style="width: 750; height: 543"><center>
                    <table width="745" cellpadding="2" cellspacing="0" border="0"  style="height:55;border-collapse: collapse;border-color:#111111">
                        <tr bgcolor="0000ff">
                            <td colspan="2" height="21" width="740"><strong>
                                    <font face="Arial" color="#FFFFFF" style="font-size:12;">Free Sign me Up</font></strong></td>
                        </tr>
                        <tr bgcolor="0000ff">
                            <td colspan="2" height="21" width="740" bgcolor="#FFFFFF"><b>
                                    <font face="Arial" color="#0000FF" style="font-size:12;">Use your E-mail ID and 
                                    Password for Online S;hopping&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    Already User? <a href="loginhere.jsp">Click here</a> </font></b></td>
                        </tr>
                        <tr bgcolor="0000ff">
                            <td colspan="2" height="21" width="740"><strong>
                                    <font face="Arial" color="#FFFFFF" style="font-size:12;">Account
                                    Information</font></strong></td>
                        </tr>
                        <tr>
                            <td colspan="2" height="8" width="740">
                                <% if ((Boolean) session.getAttribute("empt") == true) {%>
                                <p align="center">
                                    <font size="3" color="#FF0000"><b>You must fill all the required field to register with our site</b></font>
                                </p>
                                <% }
                                    session.setAttribute("empt", false);
                                %>
                                <% if ((Boolean) session.getAttribute("noteq") == true) {%>
                                <p align="center">
                                    <font SIZE="3" color="#FF0000">
                                    <b>
                                        Both Password fields must have the same value</b></font>
                                </p>
                                <% }
                                    session.setAttribute("noteq", false);
                                %>
                                <% if ((Boolean) session.getAttribute("illegalusername") == true) {%>
                                <p align="center">
                                    <font SIZE="3" color="#FF0000">
                                    <b>
                                        E-mail ID must be atleast 5 characters long, must contain dot(.) and @ but no spaces.</b></font>
                                </p>
                                <% }
                                    session.setAttribute("illegalusername", false);
                                %>
                                <% if ((Boolean) session.getAttribute("illegalpass") == true) {%>
                                <p align="center">
                                    <font SIZE="3" color="#FF0000"><b>
                                        Password must be atleast 6 character long but may not contain hyphen(-) ,@ and spaces.</b></font>
                                </p>
                                <% }
                                    session.setAttribute("illegalpass", false);
                                %>
                                <% if ((Boolean) session.getAttribute("exist") == true) {%>
                                <p align="center">
                                    <font SIZE="3" color="#FF0000"><b>
                                        E-mail ID already exists. Choose another E-mail ID</b></font>
                                </p>
                                <% }
                                    session.setAttribute("exist", false);
                                %>
                                <% if ((Boolean) session.getAttribute("RC") == true) {%>
                                <p align="center">
                                    <font SIZE="3" color="#FF0000"><b>
                                        You have successfully registered with our site</b></font></p>
                                <p align="center">
                                    &nbsp;</p>
                                    <% }
                                        session.setAttribute("RC", false);%>

                            </td>
                        </tr>
                        <tr>
                            <td height="1" width="420"><table width="405" border="0">
                                    <tr>
                                        <td width="112" align="right"><font face="Arial" size="-1" color="#0000FF">E-mail
                                            ID:</font></td>
                                        <td width="279"><input type="text" name="User_Name" size="22" maxlength="50" value="<%= session.getAttribute("User_Name")%>" style="border: 1 solid #0000FF"><font face="Arial" size="-1">&nbsp; </font></td>
                                    </tr>
                                    <tr>
                                        <td width="112" align="right"><font face="Arial" size="-1" color="#0000FF">Password:</font></td>
                                        <td width="279"><input type="password" name="Password" value autocomplete="off" size="22"
                                                               maxlength="20" style="border: 1 solid #0000FF"></td>
                                    </tr>
                                    <tr>
                                        <td width="112" align="right"><font face="Arial" size="-1" color="#0000FF">Re-type Password:</font></td>
                                        <td width="279"><input type="password" name="Password2" value autocomplete="off" size="22"
                                                               maxlength="20" style="border: 1 solid #0000FF"></td>
                                    </tr>
                                </table>
                            </td>
                            <td bgcolor="0000ff" valign="top" height="1" width="355">
                                <table width="100%" border="0" style="height:173">
                                    <tr bgcolor="0000ff">
                                        <td valign="top" bgcolor="#0000ff" height="169"><div align="center"><p><strong><b>
                                                            <font face="Arial" color="#FFFFFF" style="font-size:12;">Your E-mail ID</font></b></strong></p>
                                            </div><p><font face="arial" color="#FFFFFF" style="font-size:12;">Must be <b>at least five
                                                    (6) and maximum 50 characters
                                                    long</b>,may contain dot(.) and @, letters(a-z), numbers (0-9), the underscore (_) but&nbsp; <b>no spaces</b>.</font></p>
                                            <div align="center"><p><strong>
                                                        <font face="Arial" color="#FFFFFF" style="font-size:12;">Your Password </font></strong></p>
                                            </div><p><font face="arial" color="#FFFFFF" style="font-size:12;">Must be <b>at least
                                                    (6) and maximum 20 characters long</b>, may contain numbers (0-9) and upper and lowercase letters (A-Z, a-z), but <b>no hyphen(-),@ and 
                                                    spaces</b>. Your password is <b>Case Sensitive</b>. Make sure it is difficult for others to guess!</font></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" height="11" width="740"></td>
                        </tr>
                        <tr bgcolor="0000ff">
                            <td colspan="2" height="10" width="740"><strong>
                                    <font face="Arial" color="#FFFFFF" style="font-size:12;">Secret
                                    Information</font></strong></td>
                        </tr>
                        <tr>
                            <td colspan="2" height="9" width="740"></td>
                        </tr>
                        <tr>
                            <td height="1" width="425"><font face="Arial" color="#0000FF" style="font-size:12;">If you forget your password, we
                                would identify you with this information.</font>
                                <table width="99%" border="0">
                                    <tr>
                                        <td width="29%" align="right" nowrap><font face="Arial" size="-1" color="#0000FF">Security Question:</font></td>
                                        <td width="71%"><input type="text" name="Sec_Qsn" value="<%= session.getAttribute("Sec_Qsn")%>" maxlength="50" size="22" style="border: 1 solid #0000FF"></td>
                                    </tr>
                                    <tr>
                                        <td width="29%" align="right"><font face="Arial" size="-1" color="#0000FF">Your Answer:</font></td>
                                        <td width="71%"><input type="text" name="answer" value="<%= session.getAttribute("answer")%>" maxlength="30" size="22" style="border: 1 solid #0000FF"></td>
                                    </tr>


                                </table>
                            </td>
                            <td bgcolor="0000ff" valign="top" height="4" width="312">
                                <table width="100%" border="0" style="height:93">
                                    <tr bgcolor="0000ff">
                                        <td valign="top" bgcolor="0000ff" height="89"><div align="center"><p><strong>
                                                        <font
                                                            face="Arial" color="#FFFFFF" style="font-size:12;">Recalling your password</font></strong></p>
                                            </div><p><font face="arial" color="#FFFFFF" style="font-size:12;">This is our only way to verify your
                                                identity. To protect your account, make sure &quot;your Security question&quot; and &quot;your answer&quot; are <b>memorable for
                                                    you</b> but <b>hard for others</b> to guess or find!</font></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>

                        <tr>
                            <td height="1" width="737" colspan="2" align="center"><HR>
                            </td>
                        </tr>

                        <tr>
                            <td height="1" width="737" colspan="2" align="center">

                                <INPUT TYPE="SUBMIT" name="B1" value="Submit this Form" CLASS="button" OnMouseOver='this.className = "buttonOver"' OnMouseOut='this.className = "button"' style="color: #0000FF; border: 1 solid #0000FF">

                            </td>
                        </tr>

                    </table>
                    <table style="height:1">
                        <tr>
                            <td height="1" width="740">
                                <p align="center"></td>
                            <td height="1">&nbsp;</tr>

                        <%@include file="footer.jsp" %>
                    </table>
                    <%
    try {
        if (RConn != null) {
            RConn.close();
        }
    } catch (Exception ex) {
        System.out.printf("Error in contactSubmit.jsp" + ex.getMessage());
    }
%>