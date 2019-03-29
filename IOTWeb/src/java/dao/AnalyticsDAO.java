/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.AnalyticsEntity;
import entity.Visitor;
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
            stmt = conn.prepareStatement("Select distinct location from beacon order by location;");
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
    
    public static ArrayList<ArrayList<String>> analyticsByTime(Date startDate, Date endDate){ // [[labels (time)], [label (location list)], [count in location 1 by time], [count in location 2 by time] ... ]
        ArrayList<ArrayList<String>> result = new ArrayList<>();
        
        Date actualStartDate = startDate;
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH"); //2019-03-18 12:00:16
        Calendar c = Calendar.getInstance();
        c.setTime(startDate);
        ArrayList<String> dateList = new ArrayList<>();
        c.set(Calendar.MINUTE, 0);
        c.set(Calendar.SECOND, 0);
        startDate = c.getTime();
        while(startDate.before(endDate)){
            dateList.add(sdf.format(startDate));
            c.add(Calendar.HOUR, 1);
            startDate = c.getTime();
            System.out.println(startDate);
        }
        result.add(dateList);
        
        ArrayList<String> locationList = getAllLocations();
        result.add(locationList);
        
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        HashMap<Date,HashMap<String,Integer>> tempResult = new HashMap<>();
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select location, datetime, concat(year(datetime),'-',month(datetime),'-',day(datetime),' ',HOUR(datetime)) as date, count(distinct email) as num from reading where datetime >= '" + new java.sql.Timestamp(actualStartDate.getTime()) + "' and datetime <= '" + new java.sql.Timestamp(endDate.getTime()) + "' group by location, date");
            rs = stmt.executeQuery();
            while(rs.next()){
                String location = rs.getString("location");
                Date date = sdf.parse(rs.getString("date"));
                int num = rs.getInt("num");
                
                if(tempResult.containsKey(date)){
                    HashMap<String, Integer> locationCount = tempResult.get(date);
                    locationCount.put(location, num);
                    tempResult.put(date, locationCount);
                }else{
                    HashMap<String, Integer> tempMap = new HashMap<>();
                    tempMap.put(location, num);
                    tempResult.put(date, tempMap);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            
        } catch (ParseException ex) {
            Logger.getLogger(AnalyticsDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        
        ArrayList<ArrayList<String>> dataList = new ArrayList<>();
        for(int i = 0; i < locationList.size(); i++){
            dataList.add(new ArrayList<>());
        }
        for(String dateString : result.get(0)){
            for (String locationName : result.get(1)){
                for(Date date : tempResult.keySet()){
                    try {
                        if(date.equals(sdf.parse(dateString))){
                            if(tempResult.get(date).containsKey(locationName)){
                                if(("" + tempResult.get(date).get(locationName)).length() != 0){
                                    dataList.get(locationList.indexOf(locationName)).add(("" + tempResult.get(date).get(locationName)));
                                }
                            }else{
                                dataList.get(locationList.indexOf(locationName)).add(("0"));
                            }
                        }
                    } catch (ParseException ex) {
                        Logger.getLogger(AnalyticsDAO.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
        }
        
        result.addAll(dataList);
        
        return result;
        
    }
}
