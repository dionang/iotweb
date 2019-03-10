/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.sql.Date;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Dion
 */
public class UserDAO {
    public static boolean authenticateVisitor(String email, String enteredPassword) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from visitor where email = ?");
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            
            if(rs.next()){
                String passwordHash = rs.getString("password");
                return BCrypt.checkpw(enteredPassword, passwordHash);
            } else {
                return false;
            }
    
        } catch (SQLException e) {
            return false;
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
    }
    
    public static boolean authenticateAdmin(String email, String enteredPassword) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from admin where email = ?");
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            
            if(rs.next()){
                String passwordHash = rs.getString("password");
                return BCrypt.checkpw(enteredPassword, passwordHash);
            } else {
                return false;
            }
    
        } catch (SQLException e) {
            return false;
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
    }
    
    public static boolean registerVisitor(String email, String name, int age, String gender, String password, ArrayList<String> preferences) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String hash = BCrypt.hashpw(password, BCrypt.gensalt());
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("insert into visitor values (?, ?, ?, ?, ?)");
            stmt.setString(1, email);
            stmt.setString(2, name);
            stmt.setInt(3, age);
            stmt.setString(4, gender);
            stmt.setString(5, hash);
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            return false;
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
    }
    
    public static boolean registerVisitorLocation(String email, String beaconId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("insert into reading values (?, ?, ?)");
            
            stmt.setString(1, beaconId);
            java.util.Date date = new java.util.Date();
            System.out.println(new java.sql.Timestamp(date.getTime()));
            stmt.setTimestamp(2, new java.sql.Timestamp(date.getTime()));

            stmt.setString(3, email);
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            return false;
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
    }
}
