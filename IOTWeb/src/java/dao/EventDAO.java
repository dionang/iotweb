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
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;

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
    
    public static boolean createEvent(String eventName, String location, Timestamp startDateTime, Timestamp endDateTime, String[] eventCategories) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = ConnectionManager.getConnection();
            
            // check overlap schedules
            boolean overlap = checkOverlappingSchedules(location, startDateTime, endDateTime);
            if (overlap) {
                throw new IllegalArgumentException("Schedules overlap!");
            }
            
            // create an event
            stmt = conn.prepareStatement("insert into event values (?, ?)");
            stmt.setNull(1, Types.INTEGER);
            stmt.setString(2, eventName);
            stmt.executeUpdate();
            
            // get event id of created event
            stmt = conn.prepareStatement("select max(eid) as last_eid FROM `event`");
            rs = stmt.executeQuery();
            int eid = 0;
            if (rs.next()) {
                eid = rs.getInt("last_eid");
            }
            // System.out.println("Eid: " + eid);
            
            // create schedule and add event categories and return success status
            if(createSchedule(eid, location, startDateTime, endDateTime)){
                return addEventCategories(eid, eventCategories);
            } else {
                return false;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
    }
    
    public static boolean checkOverlappingSchedules(String location, Timestamp startDateTime, Timestamp endDateTime) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from schedule where location = ?");
            stmt.setString(1, location);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Timestamp otherStart = rs.getTimestamp("startDateTime");
                Timestamp otherEnd   = rs.getTimestamp("endDateTime");

                // checking overlap
                if (startDateTime.before(otherEnd) && otherStart.before(endDateTime)) {
                    return true;
                }
            }
            
            // if no overlaps, return false
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return true;
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
    }
    
    public static boolean createSchedule(int eid, String location, Timestamp startDateTime, Timestamp endDateTime) throws IllegalArgumentException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("insert into schedule values (?, ?, ?, ?)");
            stmt.setInt(1, eid);
            stmt.setString(2, location);
            stmt.setTimestamp(3, startDateTime);
            stmt.setTimestamp(4, endDateTime);
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
    }
    
    public static boolean addEventCategories(int eid, String[] eventCategories) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String statement = "insert into eventcategory values ";
            for(String category : eventCategories){
                statement += "(" + eid + ",'" + category + "'),"; 
            }
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement(statement.substring(0, statement.length()-1));
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
    }
}
