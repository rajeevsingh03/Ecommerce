<%@page import="java.sql.PreparedStatement"%>
<%@page import="database.MyConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%
    Connection FConn = null;
    String sql = "";
    ResultSet rs = null;
    String UName, Q1, ans1 = "";

    if (request.getParameter("loginid") == null) {

        UName = (request.getParameter("loginid")).toLowerCase();
        Q1 = (request.getParameter("Qsn")).toLowerCase();
        ans1 = (request.getParameter("ans")).toLowerCase();

        session.setAttribute("Name", UName);

        if (UName.equals("") || Q1.equals("") || ans1.equals("")) {

            session.setAttribute("notfull", true);
            session.setAttribute("email", false);
            session.setAttribute("Forgot", false);
            session.setAttribute("Remember", false);
            response.sendRedirect("f1.jsp");
            return;
        }

        if (common.CommonUtils.InStr(UName, "@") == 0 || common.CommonUtils.InStr(UName, ".") == 0) {

            session.setAttribute("notfull", false);
            session.setAttribute("email", true);
            session.setAttribute("Forgot", false);
            session.setAttribute("Remember", false);
            response.sendRedirect("f1.jsp");
            return;
        }


    }

    FConn = MyConnection.getConnection();

    sql = "SELECT Register.* FROM Register where User_Name='" + request.getParameter("loginid").replace("'", "") + "'";

    System.out.println(sql);

    PreparedStatement preparedStatement = FConn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
            ResultSet.CONCUR_READ_ONLY);
    rs = preparedStatement.executeQuery(sql);

    while (rs.next()) {
        if ((request.getParameter("loginid").toLowerCase().equals(rs.getString("User_Name")) && (request.getParameter("Qsn")).equals(rs.getString("Sec_Qsn"))) && (request.getParameter("ans").toLowerCase()).equals(rs.getString("answer"))) {
            session.setAttribute("notfull", false);
            session.setAttribute("email", false);
            session.setAttribute("Remember", false);
            session.setAttribute("Forgot", false);
            session.setAttribute("fpdirect", true);
            session.setAttribute("Name", request.getParameter("loginid").toLowerCase());
            response.sendRedirect("f3.jsp");
            return;
        } else {
        }

    }
    session.setAttribute("notfull", false);
    session.setAttribute("email", false);
    session.setAttribute("Remember", false);
    session.setAttribute("Forgot", true);
    response.sendRedirect("f1.jsp");
%>

<%
    try {
        if (FConn != null) {
            FConn.close();
        }
    } catch (Exception ex) {
        System.out.printf("Error in contactSubmit.jsp" + ex.getMessage());
    }
%>