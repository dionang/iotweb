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
import java.util.Date;
import java.util.HashMap;
import java.util.TreeMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author moses
 */
public class AnalyticsDAO {
    public static ArrayList<String> getAllEvents(){
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
    
    public static ArrayList<String> getAllLocations(){
        ArrayList<String> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select distinct location from beacon;");
            rs = stmt.executeQuery();
            while(rs.next()){
                String location = rs.getString("location");
                result.add(location);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return result;
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        
        return result;
    }
    
    public static TreeMap<Date, HashMap<String, Integer>> analyticsByTime(Date startDate, Date endDate){
        TreeMap<Date, HashMap<String, Integer>> result = new TreeMap<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH"); //2019-03-18 12:00:16
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select location, datetime, concat(year(datetime),'-',month(datetime),'-',day(datetime),' ',HOUR(datetime)) as date, count(distinct email) as num from reading where datetime >= '" + new java.sql.Timestamp(startDate.getTime()) + "' and datetime <= '" + new java.sql.Timestamp(endDate.getTime()) + "' group by location, date");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            while(rs.next()){
                String location = rs.getString("location");
                Date date = sdf.parse(rs.getString("date"));
                int num = rs.getInt("num");
                
                if(result.containsKey(date)){
                    HashMap<String, Integer> locationCount = result.get(date);
                    locationCount.put(location, num);
                }else{
                    HashMap<String, Integer> tempMap = new HashMap<>();
                    tempMap.put(location, num);
                    result.put(date, tempMap);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            
        } catch (ParseException ex) {
            Logger.getLogger(AnalyticsDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        
        return result;
        
    }
}
