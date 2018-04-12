<%@page import="java.util.ArrayList"%>
<%
    if (session.getAttribute("adminlogin") == null) {
        session.setAttribute("adminlogin", 0);
    }

    if ((Integer) session.getAttribute("adminlogin") == 1) {

        session.setAttribute("adminloginFailure", false);

        session.setAttribute("adminlogin", -1);

        response.sendRedirect("adminlogin.jsp");

    } else {

        response.sendRedirect("adminlogin.jsp");
    }
%>
