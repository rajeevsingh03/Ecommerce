/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Santosh Kumar Singh
 */
public class MyConnection {

    private static Connection connection = null;

    public static Connection getConnection() {
        try {
            connection = ConnectionFactory.
                    getInstance().getConnection();


        } catch (Exception ex) {
            System.out.println("MyConnection.java\n" + ex.getMessage());
        }
        return connection;
    }
}
