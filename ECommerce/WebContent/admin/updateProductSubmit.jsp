<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.MyConnection"%>
<%@page import="java.sql.Connection"%>
<%

// JSP to handle  uploading

    /*
     * // Create a new file upload handler DiskFileUpload upload = new
     * DiskFileUpload();
     *
     * // parse request List items = upload.parseRequest(request);
     *
     * // get uploaded file FileItem file = (FileItem) items.get(0); String
     * source = file.getName();
     *
     * // get taget filename FileItem name = (FileItem) items.get(1); String
     * target = name.getString();
     *
     *
     * File outfile = new
     * File(getServletContext().getRealPath("/").replace('\\', '/') + target);
     * file.write(outfile);
     *
     * out.println("Upload Is Successful!");
     */
%>

<%
    /*
     * File file; int maxFileSize = 5000 * 1024; int maxMemSize = 5000 * 1024;
     * String relativeWebPath = "/images/product"; String filePath =
     * getServletContext().getRealPath(relativeWebPath);
     *
     *
     * // Verify the content type String contentType = request.getContentType();
     * if ((contentType.indexOf("multipart/form-data") >= 0)) {
     *
     * DiskFileItemFactory factory = new DiskFileItemFactory(); // maximum size
     * that will be stored in memory factory.setSizeThreshold(maxMemSize); //
     * Location to save data that is larger than maxMemSize.
     * factory.setRepository(new File(filePath)); // Create a new file upload
     * handler ServletFileUpload upload = new ServletFileUpload(factory); //
     * maximum file size to be uploaded. upload.setSizeMax(maxFileSize); try {
     * // Parse the request to get file items. List fileItems =
     * upload.parseRequest(request);
     *
     * // Process the uploaded file items Iterator i = fileItems.iterator();
     *
     * while (i.hasNext()) { FileItem fi = (FileItem) i.next(); if
     * (!fi.isFormField()) {
     *
     * //Get the uploaded file parameters String fieldName = fi.getFieldName();
     * String fileName = fi.getName(); boolean isInMemory = fi.isInMemory();
     * long sizeInBytes = fi.getSize(); // Write the file if
     * (fileName.lastIndexOf("\\") >= 0) { file = new File(filePath +
     * fileName.substring(fileName.lastIndexOf("\\"))); } else { file = new
     * File(filePath + fileName.substring(fileName.lastIndexOf("\\") + 1)); }
     * fi.write(file);
     *
     * }
     * }
     *
     * } catch (Exception ex) { System.out.println(ex); } } else {
     *
     * }
     *
     */
%>

<%!
    public String CheckErrors(String sField, String sItemName, HttpServletRequest request) {
        if (request.getParameter(sField) == null) {
            return "The " + sItemName + " field cannot be blank.<br>";
        }
        if ((request.getParameter(sField).trim()).equals("")) {
            return "The " + sItemName + " field cannot be blank.<br>";
        }
        return "";
    }

    public String CheckNumbers(String sField, String sItemName, HttpServletRequest request) {
        if ((common.CommonUtils.isNumeric(request.getParameter(sField)) == false) || request.getParameter(sField).equals("")) {
            return "The " + sItemName + " field must be a number.<br>";
        }
        return "";
    }
%>

<%
    Connection db5con = null;
    String sql = "";
    String ProductNumber, Name, Description, PictureFile, Location;
    String Category;
    String dRegularPrice, dSalesPrice;
    db5con = MyConnection.getConnection();
    String sErrorString = "";

    //sErrorString = sErrorString + CheckErrors("itemProductNumber", "Product Number", request);
    sErrorString = sErrorString + CheckErrors("itemName", "Product Name", request);
    sErrorString = sErrorString + CheckErrors("itemDescription", "Description", request);
    sErrorString = sErrorString + CheckErrors("itemRegularPrice", "Regular Price", request);
    sErrorString = sErrorString + CheckErrors("itemSalesPrice", "Sales Price", request);
    sErrorString = sErrorString + CheckErrors("itemPictureFile", "Picture File", request);
    sErrorString = sErrorString + CheckErrors("itemLocation", "Item Location", request);
    //sErrorString = sErrorString + CheckNumbers("itemRegularPrice", "Regular Price", request);
    //sErrorString = sErrorString + CheckNumbers("itemSalesPrice", "Sales Price", request);




    db5con = MyConnection.getConnection();

    ProductNumber = request.getParameter("itemProductNumber");
    Name = request.getParameter("itemName");
    Description = request.getParameter("itemDescription");
    dRegularPrice = request.getParameter("itemRegularPrice");
    dSalesPrice = request.getParameter("itemSalesPrice");
    PictureFile = request.getParameter("itemPictureFile");
    Location = request.getParameter("itemLocation");
    Category = request.getParameter("itemCategory");

    sql = "SELECT products.* FROM products WHERE itemproductnumber = '" + ProductNumber.replace("'", "") + "'";

    PreparedStatement preparedStatement = db5con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
            ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = preparedStatement.executeQuery(sql);

    if (!rs.next()) {
        sErrorString = sErrorString + "Product Not Number found.<br>";
    }

    if (dSalesPrice == null || dRegularPrice == null) {
        sErrorString = sErrorString + "Price are mandatory fields.<br>";
    } else {

        try {
            Double.parseDouble(dSalesPrice);
            Double.parseDouble(dRegularPrice);


            if (Double.parseDouble(dSalesPrice) > Double.parseDouble(dRegularPrice)) {
                sErrorString = sErrorString + "Sales Price is greater than Regular Price.<br>";
            }

            if (Double.parseDouble(dSalesPrice) <= 0D || Double.parseDouble(dRegularPrice) <= 0D) {
                sErrorString = sErrorString + "Price are must in positive decimal only.<br>";
            }
        } catch (Exception ex) {
            sErrorString = sErrorString + "Price are must in decimal only.<br>";
        }
    }


    if (sErrorString.equals("")) {
        //rs.moveToInsertRow();

        //rs.updateString("ItemProductNumber", ProductNumber);
        rs.updateString("ItemName", Name);

        rs.updateString("ItemDescription", Description);
        rs.updateString("ItemPictureFile", PictureFile);
        rs.updateString("Location", Location);
        rs.updateString("CAT_TYPE", Category);

        rs.updateDouble("ItemRegularPrice", Double.parseDouble(dRegularPrice));
        rs.updateDouble("ItemSalePrice", Double.parseDouble(dSalesPrice));

        rs.updateRow();

        session.setAttribute("product_update", true);

        response.sendRedirect("viewProduct.jsp");

        return;

    } else {%>
<center><font face="Verdana,Arial" color="#FF0000" size="-1"><b>
        The following error(s) occurred while processing the information 
        you provided:<br></b></font></center>
<p align="center"><font face="Verdana,Arial" color="#FF0000" size="-1"><b><br>
        <%= sErrorString%>
        <br></b></font></p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center"><font face="Verdana,Arial" color="#FF0000" size="-1"><b>Please press your browser's BACK button and correct this 
        information, then save product details.</b>
        <% }%>

    </font>
    <font face="Verdana,Arial" color="#008000" size="-1">
    <br>
    <%@include file="footer.jsp" %>

    </font>
