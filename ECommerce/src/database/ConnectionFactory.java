/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

/**
 *
 * @author 
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
 
public class ConnectionFactory {
    //static reference to itself
    private static ConnectionFactory instance =
                new ConnectionFactory();
    //String url = "jdbc:mysql://localhost/project_database";
    //change connection here
    String user = "ecomm";
    String password = "ecomm";
    //String driverClass = "com.mysql.jdbc.Driver";
    String driverClass = "oracle.jdbc.driver.OracleDriver";
    String url = "jdbc:oracle:thin:@localhost:1521:xe";
    //String driverClass="sun.jdbc.odbc.JdbcOdbcDriver";
    //private static String URL = "jdbc:odbc:Project_Database";
 
    //private constructor
    private ConnectionFactory() {
        try {
            Class.forName(driverClass);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
 
    public static ConnectionFactory getInstance()   {
        return instance;
    }
 
    public Connection getConnection() throws SQLException,
    ClassNotFoundException {
        Connection connection = DriverManager.getConnection(url, user, password);
        //Connection connection = DriverManager.getConnection(URL);
        return connection;
    }
}
