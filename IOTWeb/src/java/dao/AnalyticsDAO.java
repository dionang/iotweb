/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Event;
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
    
    public static ArrayList<ArrayList<String>> analyticsByTime(Date startDate, Date endDate) throws ParseException{ // [[labels (time)], [label (location list)], [count in location 1 by time], [count in location 2 by time] ... ]
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
            System.out.println(stmt);
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
                if(tempResult.containsKey(sdf.parse(dateString)) && tempResult.get(sdf.parse(dateString)).get(locationName) != null){
                    dataList.get(locationList.indexOf(locationName)).add(("" + tempResult.get(sdf.parse(dateString)).get(locationName)));
                    System.out.println("added " + tempResult.get(sdf.parse(dateString)).get(locationName));
                }else{
                    dataList.get(locationList.indexOf(locationName)).add(("0"));
                    System.out.println("added 0");
                }
            }
        }
        
        result.addAll(dataList);
        
        
        SimpleDateFormat sdf1 = new SimpleDateFormat("dd MMM - ha");
        ArrayList<String> formattedDateList = new ArrayList<>();
        for(String date : result.get(0)){
            date = sdf1.format(sdf.parse(date));
            formattedDateList.add(date);
        }
        ArrayList<ArrayList<String>> formattedResult = new ArrayList<>();
        formattedResult.add(formattedDateList);
        result.remove(0);
        formattedResult.addAll(result);
        return formattedResult;
        
    }
    
    public static ArrayList<ArrayList<String>> analyticsByEvent(String eventName) throws ParseException{ // [[labels (time)], [count at event by time]]
        ArrayList<ArrayList<String>> result = new ArrayList<>();
        
        Event event = getEventDetails(eventName);
        
        Date startDate = event.getStartDate();
        Date endDate = event.getEndDate();
        
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
        }
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        
        HashMap<Date, Integer> tempMap = new HashMap<>();
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select concat(year(datetime),'-',month(datetime),'-',day(datetime),' ',HOUR(datetime)) as date, count(distinct email) as num from reading where location like \"" + event.getLocation() + "\" and dateTime between \"" + sdf.format(actualStartDate) + "\" and \"" + sdf.format(endDate) + "\" group by location, date");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            while(rs.next()){
                Date date = sdf.parse(rs.getString("date"));
                int num = rs.getInt("num");
                
                tempMap.put(date, num);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        
        ArrayList<String> countList = new ArrayList<>();
        for(String date : dateList){
            if(tempMap.containsKey(sdf.parse(date))){
                countList.add("" + tempMap.get(sdf.parse(date)));
            }else{
                countList.add("0");
            }
        }
        
        
        result.add(dateList);
        result.add(countList);        
        SimpleDateFormat sdf1 = new SimpleDateFormat("dd MMM - ha");
        ArrayList<String> formattedDateList = new ArrayList<>();
        for(String date : result.get(0)){
            date = sdf1.format(sdf.parse(date));
            formattedDateList.add(date);
        }
        ArrayList<ArrayList<String>> formattedResult = new ArrayList<>();
        formattedResult.add(formattedDateList);
        result.remove(0);
        formattedResult.addAll(result);
        System.out.println(formattedResult);
        return formattedResult;
    }
    
    public static Event getEventDetails(String eventName) throws ParseException{
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH");
                
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from schedule where eid in (select eid from event where eventName = \"" + eventName + "\") ");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            while(rs.next()){
                Event event = new Event(eventName, rs.getInt("eid"), rs.getString("location"), sdf.parse(rs.getString("startDateTime")), sdf.parse(rs.getString("endDateTime")));
                return event;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return null;
    }
    
}
