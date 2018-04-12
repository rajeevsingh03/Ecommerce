<%@page import="java.sql.Statement"%>
<%@page import="database.MyConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page errorPage="" %>
<%

    Connection FeedConn = null;
    String sql = "";
    ResultSet rs, rs2 = null;
    String F_Name, FName, LName, L_Name, St, Street, Cty, City, Cntry, Country, HomePhone, Home_Phone, Mob, Mobile, Email, Emailaddress, Mes, Message = "";

    FeedConn = MyConnection.getConnection();

    F_Name = request.getParameter("F_Name").toString().trim();
    L_Name = request.getParameter("L_Name");
    Street = request.getParameter("Street");
    City = request.getParameter("City");
    Country = request.getParameter("Country");
    Home_Phone = request.getParameter("Home_Phone");
    Mobile = request.getParameter("Mobile");
    Email = request.getParameter("Email");
    Message = request.getParameter("Message");

    //System.out.print("Text" + F_Name + "Text");

    session.setAttribute("FName", F_Name);
    session.setAttribute("LName", L_Name);
    session.setAttribute("St", Street);
    session.setAttribute("Cty", City);
    session.setAttribute("Cntry", Country);
    session.setAttribute("HomePhone", Home_Phone);
    session.setAttribute("Mob", Mobile);
    session.setAttribute("Emailaddress", Email);
    session.setAttribute("Mes", Message);

    //System.out.print(F_Name.equals(""));

    if (F_Name.equals("")) {

        session.setAttribute("illegalL_Name", false);
        session.setAttribute("illegalF_Name", false);
        session.setAttribute("FNkhali", true);
        session.setAttribute("ContactFail", false);
        session.setAttribute("Contact", false);
        session.setAttribute("send", false);
        session.setAttribute("tapal", false);
        session.setAttribute("LNkhali", false);
        session.setAttribute("EMkhali", false);
        session.setAttribute("MBkhali", false);
        session.setAttribute("MSkhali", false);
        session.setAttribute("MesLen", false);


        response.sendRedirect("contact.jsp");

        return;

    }

    if (request.getParameter("F_Name").toString().contains("@")
            || request.getParameter("F_Name").toString().trim().contains("-")) {

        session.setAttribute("illegalL_Name", false);
        session.setAttribute("illegalF_Name", true);
        session.setAttribute("khali", false);
        session.setAttribute("ContactFail", false);
        session.setAttribute("Contact", false);
        session.setAttribute("send", false);
        session.setAttribute("tapal", false);
        session.setAttribute("FNkhali", false);
        session.setAttribute("LNkhali", false);
        session.setAttribute("EMkhali", false);
        session.setAttribute("MBkhali", false);
        session.setAttribute("MSkhali", false);
        session.setAttribute("MesLen", false);

        response.sendRedirect("contact.jsp");

        return;

    }


    if (L_Name.equals("")) {

        session.setAttribute("illegalL_Name", false);
        session.setAttribute("illegalF_Name", false);
        session.setAttribute("LNkhali", true);
        session.setAttribute("ContactFail", false);
        session.setAttribute("Contact", false);
        session.setAttribute("send", false);
        session.setAttribute("tapal", false);
        session.setAttribute("FNkhali", false);
        session.setAttribute("EMkhali", false);
        session.setAttribute("MBkhali", false);
        session.setAttribute("MSkhali", false);
        session.setAttribute("MesLen", false);


        response.sendRedirect("contact.jsp");

        return;

    }



    if (request.getParameter("L_Name").toString().contains("@")
            || request.getParameter("L_Name").toString().trim().contains("-")) {

        session.setAttribute("illegalL_Name", true);
        session.setAttribute("illegalF_Name", false);
        session.setAttribute("khali", false);
        session.setAttribute("ContactFail", false);
        session.setAttribute("Contact", false);
        session.setAttribute("send", false);
        session.setAttribute("tapal", false);
        session.setAttribute("FNkhali", false);
        session.setAttribute("LNkhali", false);
        session.setAttribute("EMkhali", false);
        session.setAttribute("MBkhali", false);
        session.setAttribute("MSkhali", false);
        session.setAttribute("MesLen", false);

        response.sendRedirect("contact.jsp");

        return;
    }

    if ((common.CommonUtils.isNumeric(Mobile) == false) || (Mobile == "")) {

        session.setAttribute("illegalL_Name", false);
        session.setAttribute("illegalF_Name", false);
        session.setAttribute("MBkhali", true);
        session.setAttribute("ContactFail", false);
        session.setAttribute("Contact", false);
        session.setAttribute("send", false);
        session.setAttribute("tapal", false);
        session.setAttribute("FNkhali", false);
        session.setAttribute("LNkhali", false);
        session.setAttribute("EMkhali", false);
        session.setAttribute("MSkhali", false);
        session.setAttribute("MesLen", false);

        response.sendRedirect("contact.jsp");

        return;
    }

    if (Email.equals("") || (common.CommonUtils.isValidEmail(Email) == false)) {
        session.setAttribute("illegalL_Name", false);
        session.setAttribute("illegalF_Name", false);
        session.setAttribute("EMkhali", true);
        session.setAttribute("ContactFail", false);
        session.setAttribute("Contact", false);
        session.setAttribute("send", false);
        session.setAttribute("tapal", false);
        session.setAttribute("FNkhali", false);
        session.setAttribute("LNkhali", false);
        session.setAttribute("MBkhali", false);
        session.setAttribute("MSkhali", false);
        session.setAttribute("MesLen", false);

        response.sendRedirect("contact.jsp");

        return;
    }



    if (request.getParameter("L_Name").toString().contains("@")
            || request.getParameter("L_Name").toString().trim().contains("-")) {

        session.setAttribute("illegalF_Name", false);
        session.setAttribute("illegalL_Name", false);
        session.setAttribute("khali", false);
        session.setAttribute("Contact", false);
        session.setAttribute("send", false);
        session.setAttribute("tapal", true);
        session.setAttribute("FNkhali", false);
        session.setAttribute("LNkhali", false);
        session.setAttribute("EMkhali", false);
        session.setAttribute("MBkhali", false);
        session.setAttribute("MSkhali", false);
        session.setAttribute("MesLen", false);

        response.sendRedirect("contact.jsp");

        return;
    }

    if (Message.equals("")) {

        session.setAttribute("illegalL_Name", false);
        session.setAttribute("illegalF_Name", false);
        session.setAttribute("MSkhali", true);
        session.setAttribute("ContactFail", false);
        session.setAttribute("Contact", false);
        session.setAttribute("send", false);
        session.setAttribute("tapal", false);
        session.setAttribute("FNkhali", false);
        session.setAttribute("LNkhali", false);
        session.setAttribute("EMkhali", false);
        session.setAttribute("MBkhali", false);
        session.setAttribute("MesLen", false);
        session.setAttribute("defaultMes", true);

        response.sendRedirect("contact.jsp");

        return;
    }

    if (Message.length() > 250) {

        session.setAttribute("illegalL_Name", false);
        session.setAttribute("illegalF_Name", false);
        session.setAttribute("MSkhali", false);
        session.setAttribute("ContactFail", false);
        session.setAttribute("Contact", false);
        session.setAttribute("send", false);
        session.setAttribute("tapal", false);
        session.setAttribute("FNkhali", false);
        session.setAttribute("LNkhali", false);
        session.setAttribute("EMkhali", false);
        session.setAttribute("MBkhali", false);
        session.setAttribute("MesLen", true);
        session.setAttribute("defaultMes", false);


        response.sendRedirect("contact.jsp");

        return;

    }

    session.setAttribute("illegalF_Name", false);
    session.setAttribute("illegalL_Name", false);
    session.setAttribute("khali", false);
    session.setAttribute("noteq", false);
    session.setAttribute("tapal", false);
    session.setAttribute("Contact", false);
    session.setAttribute("send", true);
    session.setAttribute("FNkhali", false);
    session.setAttribute("LNkhali", false);
    session.setAttribute("EMkhali", false);
    session.setAttribute("MBkhali", false);
    session.setAttribute("MSkhali", false);
    session.setAttribute("MesLen", false);



    try {

        try {
            if (FeedConn != null) {
                FeedConn.close();
            }
        } catch (Exception ex) {
            System.out.printf("Error in contactSubmit.jsp" + ex.getMessage());
        }
//if (session.setAttribute("send").toString() == "true"){
        FeedConn = MyConnection.getConnection();
        sql = "SELECT Feedback.* FROM Feedback";

        Statement stmt = FeedConn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        rs = stmt.executeQuery(sql);

        rs.moveToInsertRow();

        rs.updateString("F_Name", F_Name);
        rs.updateString("L_Name", L_Name);
        rs.updateString("Street", Street);
        rs.updateString("City", City);
        rs.updateString("Country", Country);
        rs.updateString("Home_Phone", Home_Phone);
        rs.updateString("Mobile", Mobile);
        rs.updateString("Email", Email);
        rs.updateString("Message", Message);

// Store the insert into database
        rs.insertRow();

// Move the cursor back to the current row
        //rs.moveToCurrentRow();

        rs.close();
        stmt.close();

        FeedConn.close();

    } catch (Exception ex) {
        System.err.println("contactsubmit.jsp Exception: " + ex.getMessage());
        ex.printStackTrace();
    }

    session.setAttribute("khali", false);
    session.setAttribute("tapal", false);
    session.setAttribute("Contact", true);
    session.setAttribute("send", false);
    session.setAttribute("illegalF_Name", false);
    session.setAttribute("illegalL_Name", false);
    session.setAttribute("FNkhali", false);
    session.setAttribute("LNkhali", false);
    session.setAttribute("EMkhali", false);
    session.setAttribute("MBkhali", false);
    session.setAttribute("MSkhali", false);
    session.setAttribute("MesLen", false);

    session.setAttribute("FName", "");
    session.setAttribute("LName", "");
    session.setAttribute("St", "");
    session.setAttribute("Cty", "");
    session.setAttribute("Cntry", "");
    session.setAttribute("HomePhone", "");
    session.setAttribute("Mob", "");
    session.setAttribute("Emailaddress", "");
    session.setAttribute("Mes", "");
    response.sendRedirect("contact.jsp");

    //}

%>
<%
    try {
        if (FeedConn != null) {
            FeedConn.close();
        }
    } catch (Exception ex) {
        System.out.printf("Error in contactSubmit.jsp" + ex.getMessage());
    }
%>
