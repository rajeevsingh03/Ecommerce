<%@page import="java.util.ArrayList"%>
<%
    Integer nNumCartItems = null;
    ArrayList sItemNums = new ArrayList();
    ArrayList nItemQtys = new ArrayList();

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


    if ((Integer) session.getAttribute("login") == 1) {

        session.setAttribute("loginFailure", false);

        session.setAttribute("login", -1);

        nNumCartItems = 0;

        sItemNums.add(0, 0);

        nItemQtys.add(0, 0);

        session.setAttribute("CartItemNumArray", sItemNums);

        session.setAttribute("CartItemQtyArray", nItemQtys);

        response.sendRedirect("loginhere.jsp");

    } else {

        response.sendRedirect("loginhere.jsp");
    }
%>
