<%@page import="java.util.ArrayList"%>
<%

    Integer nNumCartItems = null;
    ArrayList sItemNums = new ArrayList();
    ArrayList nItemQtys = new ArrayList();

    nNumCartItems = 0;

    sItemNums.add("");

    nItemQtys.add(0);

    session.setAttribute("CartItemNumArray", sItemNums);

    session.setAttribute("CartItemQtyArray", nItemQtys);

    response.sendRedirect("index.jsp");


%>
