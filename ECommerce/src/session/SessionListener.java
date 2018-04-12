/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import database.MyConnection;
import java.util.ArrayList;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 *
 * @author Santosh Kumar Singh
 */
@WebListener
public class SessionListener implements HttpSessionListener {

    /**
     * Receives notification that a session has been created.
     */
    public void sessionCreated(HttpSessionEvent se) {
        HttpSession session = se.getSession(); //handle to HttpSession Object

        ArrayList sItemNums = new ArrayList();
        ArrayList nItemQtys = new ArrayList();
        sItemNums.add(0, "");
        nItemQtys.add(0, 0);

        session.setAttribute("CartItemNumArray", sItemNums);
        session.setAttribute("CartItemQtyArray", nItemQtys);
        session.setAttribute("DBLogin", "DSN=Project_Database");
        session.setAttribute("shipbasecharge", 4.50);
        session.setAttribute("shipitemcharge", 1.25);

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

        session.setAttribute("sPageHead", "Login Page");

        session.setAttribute("sPageCaption", "Registered User");

        System.out.println("sessionCreated");
    }

    /**
     * Receives notification that a session is about to be invalidated.
     */
    public void sessionDestroyed(HttpSessionEvent se) {
    }
}
