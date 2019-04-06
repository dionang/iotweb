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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author xuyin
 */
public class EventDAO {
    public static ArrayList<HashMap<String,String>> getAllEvents(){
        ArrayList<HashMap<String,String>> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ResultSet rs2 = null;
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select * from event;");
            rs = stmt.executeQuery();
            
            while(rs.next()){
                HashMap<String,String> eventsInfo = new HashMap<>();

                int eventId = rs.getInt("eid");
                
                String eventName = rs.getString("eventName");
                
                eventsInfo.put("eventName",eventName);
                stmt = conn.prepareStatement("Select category from eventcategory where eid = ?;");
                stmt.setInt(1,eventId);
                rs2=stmt.executeQuery();
                if(rs2.next()){
                    String category = rs2.getString("category");
                    eventsInfo.put("category",category);
                }
                
                stmt = conn.prepareStatement("Select location, startDateTime, endDateTime from schedule where eid = ?;");
                stmt.setInt(1,eventId);
                rs2=stmt.executeQuery();
                if(rs2.next()){
                    String location = rs2.getString("location");
                    String startDateTime = rs2.getString("startDateTime");
                    String endDateTime = rs2.getString("endDateTime");
                    eventsInfo.put("location",location);
                    eventsInfo.put("startDateTime",startDateTime);
                    eventsInfo.put("endDateTime",endDateTime);
                }
                result.add(eventsInfo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return result;
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        
        return result;
    }
    
    public static ArrayList<String> getAllEventNames(){
        ArrayList<String> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select distinct eventName from event;");
            rs = stmt.executeQuery();
            while(rs.next()){
                String eventName = rs.getString("eventName");
                result.add(eventName);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return result;
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        
        return result;
    }
    
    public static ArrayList<String> getAllEventCategories(){
        ArrayList<String> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select category from eventcategory;");
            rs = stmt.executeQuery();
            while(rs.next()){
                String eventName = rs.getString("eventName");
                result.add(eventName);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return result;
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        
        return result;
    }
}
