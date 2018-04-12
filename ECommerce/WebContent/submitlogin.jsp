<%@page import="java.sql.Statement"%>
<%@page import="database.MyConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%
    Connection Conn = null;
    String sql = "";
    ResultSet rs = null;


    Conn = MyConnection.getConnection();

    session.setAttribute("Conn", Conn);


    sql = "SELECT Register.* FROM Register Where User_Name='" + request.getParameter("id").toLowerCase() + "'";
    System.out.print(sql);
    Statement stmt = Conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
    rs = stmt.executeQuery(sql);

    while (rs.next()) {

        if ((request.getParameter("id").toLowerCase().equals(rs.getString("User_Name").toLowerCase()))
                && (request.getParameter("pwd").equals(rs.getString("Password_").toLowerCase()))) {

            session.setAttribute("loginfailure", false);

            session.setAttribute("login", 1);

            session.setAttribute("user", request.getParameter("id"));


            response.sendRedirect("between.jsp");

            return;
        }
    }

    session.setAttribute("loginFailure", true);

    session.setAttribute("login", -1);

    session.setAttribute("out", false);

    response.sendRedirect("loginhere.jsp");
    
    
%>
<%
    try {
        if (Conn != null) {
            Conn.close();
        }
    } catch (Exception ex) {
        System.out.printf("Error in contactSubmit.jsp" + ex.getMessage());
    }
%>