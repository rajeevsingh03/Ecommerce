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

    sql = "SELECT user_master.* FROM user_master Where User_Name='" + request.getParameter("id") + "'";
    System.out.print(sql);
    Statement stmt = Conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
    rs = stmt.executeQuery(sql);

    while (rs.next()) {

        if ((request.getParameter("id").toLowerCase().equals(rs.getString("User_Name").toLowerCase()))
                && (request.getParameter("pwd").equals(rs.getString("Password").toLowerCase()))) {

            session.setAttribute("adminloginfailure", false);

            session.setAttribute("adminlogin", 1);

            session.setAttribute("adminuser", request.getParameter("id"));

            response.sendRedirect("adminlogin.jsp");

            return;
        }
    }

    session.setAttribute("adminloginfailure", true);

    session.setAttribute("adminlogin", -1);

    session.setAttribute("adminout", false);    
    
    response.sendRedirect("adminlogin.jsp");
    
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