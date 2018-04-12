<%@page import="java.util.concurrent.CountDownLatch"%>
<%@page import="java.util.Random"%>
<%@page import="database.MyConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
    try {

        Connection adRConn = MyConnection.getConnection();

        String adsql = "SELECT AD_MASTER.* FROM AD_MASTER Where ACTIVE=1";

        PreparedStatement preparedStatementad = adRConn.prepareStatement(adsql, ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
        ResultSet rsad = preparedStatementad.executeQuery(adsql);

        rsad.last();

        Integer count = rsad.getRow();
        if (count > 0) {
            Random random = new Random();
            int iAdd = random.nextInt(count);

            if (iAdd == 0) {
                iAdd = 1;
            }

            String strImage = "";

            rsad.beforeFirst();

            for (int itemp = 1; itemp <= iAdd; itemp++) {
                rsad.next();
            }

            strImage = rsad.getString("AD_IMAGE");

%>
<input type="image" src="images/add/<%= strImage%>" alt="firstchoice logo">
<%} else {%>
<input type="image" src="images/add/a01.jpg" alt="firstchoice logo">
<%        }
} catch (Exception ex) {%>
<input type="image" src="images/add/a01.jpg" alt="firstchoice logo">
<%    }
%>