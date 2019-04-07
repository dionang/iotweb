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
    
    public static boolean registerAdmin(String email, String password) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String hash = BCrypt.hashpw(password, BCrypt.gensalt());
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("insert into admin values (?, ?, ?)");
            stmt.setString(1, email);
            stmt.setString(2, email);
            stmt.setString(3, hash);
            stmt.executeUpdate();
            return true;
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
    
    public static String getLocationFromBeacon(String beaconId){
        String location = null;
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select location from beacon where bid = '" + beaconId + "';");
            rs = stmt.executeQuery();
            while(rs.next()){
                location = rs.getString("location");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return location;
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return location;
    }
    
    public static boolean registerVisitorLocation(String email, String beaconId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String location = getLocationFromBeacon(beaconId);
            System.out.println("L: " + location);
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("insert into reading values (?, ?, ?)");
            
            stmt.setString(1, location);
            java.util.Date date = new java.util.Date();
            String osName = System.getProperty("os.name");
            if (osName.equals("Linux")) {
                Calendar c = Calendar.getInstance(); 
                c.add(Calendar.HOUR, 8);
                date = c.getTime();
            }
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
    
//    public static boolean registerVisitorLocation2(String email, String beaconId, java.util.Date startDate, java.util.Date endDate) {
//        Connection conn = null;
//        PreparedStatement stmt = null;
//        ResultSet rs = null;
//        try {
//            String location = getLocationFromBeacon(beaconId);
//            conn = ConnectionManager.getConnection();
//            String statement = ("insert into reading values");
//            statement += "('" + location + "', '" + new java.sql.Timestamp(startDate.getTime()) + "', '" + email + "'),";
//            while(startDate.before(endDate)){
//                Calendar c = Calendar.getInstance();
//                c.setTime(startDate);
//                c.add(Calendar.MINUTE, 5);
//                startDate = c.getTime();
//                statement += "('" + location + "', '" + new java.sql.Timestamp(startDate.getTime()) + "', '" + email + "'),";
//            }
//            statement = statement.substring(0, statement.length()-1);
//            System.out.println(statement);
//            stmt = conn.prepareStatement(statement);
//            stmt.executeUpdate();
//            return true;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        } finally {
//            ConnectionManager.close(conn, stmt, rs);
//        }
//    }
}
