/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.sql.ResultSet;

/**
 *
 * @author Rajeev Singh
 */
public class Product {

    private static StringBuffer strTempData = null;

    public static String WriteProductRow(ResultSet rsProducts) {
        strTempData = new StringBuffer();
        try {
            //Write a table row for the current record of rsProducts        
            strTempData.append("<tr>");

            //First cell for picture
            String sTemp = rsProducts.getString("itempicturefile");
            if (sTemp == "") {
                sTemp = "Picture Not  Available";
            } else {
                sTemp = "<img src='images/products/" + sTemp + "' border=0 alt=''>";
            }
            strTempData.append("    <td align='center'>");
            strTempData.append("<font face='Verdana, Arial' color='#008000' size='-1'>");
            strTempData.append(sTemp + "</font></td>");

            //Second cell for Item #, name, description
            strTempData.append("    <td valign='top'>");
            strTempData.append("<font face='Verdana, Aria' color='#000000' size='-1'>");
            strTempData.append("<i><u>Item #" + rsProducts.getString("itemproductnumber"));
            strTempData.append("</u></i></font><br>");
            strTempData.append("<font face='Verdana, Arial' color='#0000ff' size='-1'>");
            strTempData.append("<b>" + rsProducts.getString("itemname") + "</b> - ");
            strTempData.append("<font face='Verdana, Arial' color='#008000' size='-1'>");
            strTempData.append(rsProducts.getString("itemdescription") + "<br><br>");
            strTempData.append("</font></td>");

            //Third cell for price and "add to cart" link
            if (rsProducts.getDouble("itemsaleprice") > 0) {
                sTemp = "SALE: <span class=\"WebRupee\">Rs.</span> " + rsProducts.getDouble("itemsaleprice")
                        + "<br>(Regular <span class=\"WebRupee\">Rs.</span> "
                        + rsProducts.getDouble("itemregularprice") + ")";
            } else {
                sTemp = "Price: <span class=\"WebRupee\">Rs.</span> " + rsProducts.getDouble("itemregularprice");
            }
            strTempData.append("    <td align='center' valign='middle' nowrap>");
            strTempData.append("<font face='Verdana, Arial' color='#0000ff' size='-1'>");
            strTempData.append(sTemp + "<br><br>");
            strTempData.append("<a href='shopcart.jsp?mode=add&itemno=");
            strTempData.append(rsProducts.getString("itemproductnumber") + "'></font>");
            strTempData.append("<img src='images/addtocart.jpg' border='0'></a></td>");


            strTempData.append("</tr>");
        } catch (Exception e) {
        }
        
        return strTempData.toString();         
    }
}
