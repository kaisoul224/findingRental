/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

/**
 *
 * @author Quoc Anh
 */
public class DBconnector {

    private String hostName = "localhost";
    private String dbName = "prj301_project";
    private String username = "root";
    private String password = "";

    protected Connection conn;

    public DBconnector() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String connectorURL = "jdbc:mysql://" + hostName + ":3306/" + dbName;
            conn = DriverManager.getConnection(connectorURL, username, password);
            System.out.println("Connect to database successfully!");
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Couldn't connect to database!");
            System.out.println(e);
        }
    }

    public void close() {
        try {
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(DBconnector.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    
}
