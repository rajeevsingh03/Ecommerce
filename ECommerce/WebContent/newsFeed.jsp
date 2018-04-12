<%@page import="java.util.concurrent.CountDownLatch"%>
<%@page import="java.util.Random"%>
<%@page import="database.MyConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
    String strNewsFeed = "*";

    try {

        Connection nfRConn = MyConnection.getConnection();

        String nf_sql = "SELECT NEWS_MASTER.* FROM NEWS_MASTER Where NEWS_ACTIVE=1";

        PreparedStatement preparedStatement_nf = nfRConn.prepareStatement(nf_sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
        ResultSet rs_nf = preparedStatement_nf.executeQuery(nf_sql);

        while (rs_nf.next()) {
            strNewsFeed = strNewsFeed + "<a href='"+ rs_nf.getString("news_url") +"' target='_blank'><font color='white'><b>"+ rs_nf.getString("news_text") +"</b></font></a> &nbsp;&nbsp;*&nbsp;&nbsp;";
        }

        if (strNewsFeed.equals("*")) {
            strNewsFeed = strNewsFeed + "*************";
        }
    } catch (Exception ex) {
        strNewsFeed = strNewsFeed + "*************";
    }
%>
<marquee><%= strNewsFeed%></marquee>
