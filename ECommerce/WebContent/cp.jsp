<%@page import="com.sun.rowset.internal.InsertRow"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="database.MyConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%
    Connection CConn = null;
    String sql = "";
    ResultSet rs = null;
    String Login_Name, p2, LName, ps, password1, password2 = "";

    LName = "";

    try {
        if (CConn != null) {
            CConn.close();
        }
    } catch (Exception ex) {
        System.out.printf("Error in contactSubmit.jsp" + ex.getMessage());
    }

    CConn = MyConnection.getConnection();
    ps = "";


    if (request.getParameter("loginid") != null) {

        LName = (request.getParameter("loginid").toLowerCase());
        ps = request.getParameter("submit_login");
        password1 = request.getParameter("pass1");
        password2 = request.getParameter("pass2");

        if (LName.equals("") || ps.equals("") || password1.equals("") || password2.equals("")) {

            session.setAttribute("empty", true);
            session.setAttribute("notequal", false);
            session.setAttribute("Fail", false);
            session.setAttribute("PC", false);
            session.setAttribute("len", false);
            session.setAttribute("continue", false);
            response.sendRedirect("changepwd.jsp");
            return;
        }

        if (request.getParameter("pass1").length() < 6 || request.getParameter("pass2").length() < 6) {

            session.setAttribute("len", true);
            session.setAttribute("empty", false);
            session.setAttribute("notequal", false);
            session.setAttribute("Fail", false);
            session.setAttribute("PC", false);
            session.setAttribute("continue", false);
            response.sendRedirect("changepwd.jsp");
            return;
        }



        if (request.getParameter("pass1").equals(request.getParameter("pass2"))) {

            session.setAttribute("empty", false);
            session.setAttribute("notequal", false);
            session.setAttribute("Fail", false);
            session.setAttribute("PC", false);
            session.setAttribute("len", false);
            session.setAttribute("continue", true);

        } else {

            session.setAttribute("empty", false);
            session.setAttribute("notequal", true);
            session.setAttribute("Fail", false);
            session.setAttribute("PC", false);
            session.setAttribute("continue", false);
            session.setAttribute("len", false);
            response.sendRedirect("changepwd.jsp");
            return;



        }

    }

    if (session.getAttribute("continue") == null) {
        session.setAttribute("continue", false);
    }

    if ((Boolean) session.getAttribute("continue") == true) {

        try {
            if (CConn != null) {
                CConn.close();
            }
        } catch (Exception ex) {
            System.out.printf("Error in contactSubmit.jsp" + ex.getMessage());
        }
        CConn = MyConnection.getConnection();
        sql = "SELECT Register.* FROM Register WHERE User_Name='" + LName.replace("'", "") + "'";
        PreparedStatement preparedStatement = CConn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
        rs = preparedStatement.executeQuery(sql);


        while (rs.next()) {

            if (LName.equals(rs.getString("User_Name")) && ps.equals(rs.getString("Password_"))) {

                rs.updateString("User_Name", LName);
                rs.updateString("Password_", password2);
                rs.updateRow();

                session.setAttribute("empty", false);
                session.setAttribute("notequal", false);
                session.setAttribute("Fail", false);
                session.setAttribute("PC", true);
                session.setAttribute("len", false);
                session.setAttribute("continue", false);
                response.sendRedirect("changepwd.jsp");
                return;
            }

        }

        session.setAttribute("Fail", true);
        session.setAttribute("PC", false);
        session.setAttribute("empty", false);
        session.setAttribute("notequal", false);
        session.setAttribute("len", false);
        session.setAttribute("continue", false);

        response.sendRedirect("changepwd.jsp");
    }
%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
</head>

<%
    try {
        if (CConn != null) {
            CConn.close();
        }
    } catch (Exception ex) {
        System.out.printf("Error in contactSubmit.jsp" + ex.getMessage());
    }
%>