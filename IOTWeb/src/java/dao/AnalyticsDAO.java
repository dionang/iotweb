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
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

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
    
    public static ArrayList<String> getAllEventCategories(){
        ArrayList<String> result = new ArrayList<>();
        result.add("food");
        result.add("technology");
        result.add("music");
        result.add("dance");
        result.add("gaming");
        
        return result;
    }
    
    public static ArrayList<String> getAllUserPreferences(){
        ArrayList<String> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select distinct category from preferences order by category asc;");
            rs = stmt.executeQuery();
            while(rs.next()){
                String category = rs.getString("category");
                result.add(category);
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
//                    System.out.println("added " + tempResult.get(sdf.parse(dateString)).get(locationName));
                }else{
                    dataList.get(locationList.indexOf(locationName)).add(("0"));
//                    System.out.println("added 0");
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
    
    
    public static ArrayList<ArrayList<String>> analyticsByEvent(String eventName) throws ParseException{ // [[labels (time)], [count at event by time], [preferences], [count of each preference], [genders], [count of each gender]]
        // 0 - list of timestamps
        // 1 - list of # people at the respective time at the event
        // 2 - list of preferences
        // 3 - list of # people with respective preferences at the event
        // 4 - list of genders (M, F)
        // 5 - list of # people with respective genders at the event
        // 6 - list of age bands (<12, 12-14, ..)
        // 7 - list of # people with respective age bands at the event
        ArrayList<ArrayList<String>> result = new ArrayList<>();
        Event event = getEventDetails(eventName);
        
        result.addAll(timeAnalyticsByEvent(event));
        result.addAll(preferenceAnalyticsByEvent(event));
        result.addAll(genderAnalyticsByEvent(event));
        result.addAll(ageAnalyticsByEvent(event));
        
        System.out.println(result);
        return result;
    }
    
    public static ArrayList<ArrayList<String>> timeAnalyticsByEvent(Event event) throws ParseException{ // [[labels (time)], [count at event by time]]
        ArrayList<ArrayList<String>> result = new ArrayList<>();
        
        String eventName = event.getEventName();
        
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
    
    public static ArrayList<ArrayList<String>> preferenceAnalyticsByEvent(Event event){ // [[preferences], [count of each preference]]
        ArrayList<ArrayList<String>> result = new ArrayList<>();
        ArrayList<String> categoryList = getAllUserPreferences();
        ArrayList<String> countList = new ArrayList<>();
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH"); //2019-03-18 12:00:16
        Date startDate = event.getStartDate();
        Date endDate = event.getEndDate();
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        HashMap<String, Integer> tempMap = new HashMap<>();
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select category, COUNT(category) as count from preferences where email in (Select distinct email from reading where location like \"" + event.getLocation() + "\" and dateTime between \"" + sdf.format(startDate) + "\" and \"" + sdf.format(endDate) + "\") group by category");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            while(rs.next()){
                String categoryName = rs.getString("category");
                int count = rs.getInt("count");
                
                tempMap.put(categoryName, count);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        
        for(String category : categoryList){
            if(tempMap.containsKey(category)){
                countList.add("" + tempMap.get(category));
            }else{
                countList.add("0");
            }
        }
        result.add(categoryList);
        result.add(countList);
        return result;
    }
    
    public static ArrayList<ArrayList<String>> ageAnalyticsByEvent(Event event){ // [[ages], [count of each age]]
        ArrayList<ArrayList<String>> result = new ArrayList<>();
        
        // create two arrays, one for labels, one for counts
        String[] ageBands = new String[] {"<12", "12-14", "15-16", "17-20", "21-24", "25-30", ">30"};
        int[] counts = new int[7];

        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH"); //2019-03-18 12:00:16
        Date startDate = event.getStartDate();
        Date endDate = event.getEndDate();
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        HashMap<String, Integer> tempMap = new HashMap<>();
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select age from visitor where email in (Select distinct email from reading where location like \"" + event.getLocation() + "\" and dateTime between \"" + sdf.format(startDate) + "\" and \"" + sdf.format(endDate) + "\")");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            while(rs.next()){
                int age = rs.getInt("age");
                if (age < 12) {
                    counts[0]++;
                } else if (age < 15) {
                    counts[1]++;
                } else if (age < 17) {
                    counts[2]++;
                } else if (age < 21) {
                    counts[3]++;
                } else if (age < 25) {
                    counts[4]++;
                } else if (age < 30) {
                    counts[5]++;
                } else {
                    counts[6]++;
                }
            }
            
            ArrayList<String> countList = (ArrayList<String>) Arrays.stream(counts)
                                                            .mapToObj(String::valueOf)
                                                            .collect(Collectors.toList());
            result.add(new ArrayList<>(Arrays.asList(ageBands)));
            result.add(countList);
        } catch (SQLException e) {
            e.printStackTrace();
            
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        
        return result;
    }
    
    public static ArrayList<ArrayList<String>> genderAnalyticsByEvent(Event event){ // [[genders], [count of each gender]]
        ArrayList<ArrayList<String>> result = new ArrayList<>();
        ArrayList<String> genderList = new ArrayList<>();
        genderList.add("M");
        genderList.add("F");
        ArrayList<String> countList = new ArrayList<>();
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH"); //2019-03-18 12:00:16
        Date startDate = event.getStartDate();
        Date endDate = event.getEndDate();
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        HashMap<String, Integer> tempMap = new HashMap<>();
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select gender, COUNT(gender) as count from visitor where email in (Select distinct email from reading where location like \"" + event.getLocation() + "\" and dateTime between \"" + sdf.format(startDate) + "\" and \"" + sdf.format(endDate) + "\") group by gender");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            while(rs.next()){
                String genderName = rs.getString("gender");
                int count = rs.getInt("count");
                
                tempMap.put(genderName, count);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        
        for(String gender : genderList){
            if(tempMap.containsKey(gender)){
                countList.add("" + tempMap.get(gender));
            }else{
                countList.add("0");
            }
        }
        result.add(genderList);
        result.add(countList);
        return result;
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
    
    public static Event updateEventCategories(Event event){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
                
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select category from eventCategory where eid = ?");
            stmt.setInt(1, event.getEventId());
            rs = stmt.executeQuery();
            while(rs.next()){
                event.addCategory(rs.getString("category"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        
        return event;
    }
    
    public static String getWisdom(String eventName) throws ParseException{
        Event event = getEventDetails(eventName);
        event = updateEventCategories(event);
        ArrayList<String> eventCategories = event.getEventCategories();
        
        ArrayList<ArrayList<String>> visitorPreferences = preferenceAnalyticsByEvent(event);
        ArrayList<String> preferenceList = visitorPreferences.get(0);
        ArrayList<String> visitorPreferenceData = visitorPreferences.get(1);
        
        HashMap<String, Integer> visitorPreferenceMap = new HashMap<>();
        
        
        for(int i = 0; i < preferenceList.size(); i++){
            visitorPreferenceMap.put(preferenceList.get(i), Integer.parseInt(visitorPreferenceData.get(i)));
        }
        
        String bestPerformingPreference = "";
        int bestPerformingNumber = 0;
        
        String worstPerformingPreference = "";
        int worstPerformingNumber = Integer.MAX_VALUE;
        
        for(String visitorPreference : preferenceList){
            if(eventCategories.contains(visitorPreference)){ //Checks for preferences that did not meet expectations
                int count = visitorPreferenceMap.get(visitorPreference);
                if(count < worstPerformingNumber){
                    worstPerformingPreference = visitorPreference;
                    worstPerformingNumber = count;
                }
            }else{ //Checks for preferences that werent accounted for
                int count = visitorPreferenceMap.get(visitorPreference);
                if(count > bestPerformingNumber){
                    bestPerformingPreference = visitorPreference;
                    bestPerformingNumber = count;
                }
            }
        }
        
        String bestPerforming = "One unexpected preference of the visitors who participated in the event was: " + bestPerformingPreference + ", with " + bestPerformingNumber + " visitors. This event did not expect to attract so many visitors who were interested in this category.";
        String worstPerforming = "Another unexpected preference of the visitors who participated in the event was: " + worstPerformingPreference + ", with " + worstPerformingNumber + " visitors. This event did not attract a significant number of visitors who were interested in this category";
        
        System.out.println(bestPerforming);
        System.out.println(worstPerforming);
        
        return "";
    }
    
    public static ArrayList<ArrayList<String>> analyticsByVisitorCharacteristics(String gender, String minAge, String maxAge, ArrayList<String> categories) throws ParseException{
        ArrayList<ArrayList<String>> result = new ArrayList<>();
        ArrayList<String> eventNameList = new ArrayList<>();
        ArrayList<String> specificVisitorsList = new ArrayList<>();
        ArrayList<String> totalVisitorsList = new ArrayList<>();
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
                
        try {
            conn = ConnectionManager.getConnection();
            String statement = "select *, count(distinct email) as count from (select r.location, r.email, s.eid from reading r right outer join schedule s on r.location = s.location and r.datetime between s.startDateTime and s.endDateTime group by r.email, eid having r.email in (select email from visitor ";
            boolean first = true;
            
            if(categories.size() > 0){
                first = false;
                statement += "where email in (select email from preferences where category = \"" + categories.get(0) + "\")";
                for(int i = 1; i < categories.size(); i++){
                    statement += "and email in (select email from preferences where category = \"" + categories.get(i) + "\")";
                }
            }
            
            if(first){
                first = false;
                statement += "where ";
            }else{
                statement += "and ";
            }
            statement += "age between " + minAge + " and " + maxAge + " and gender like \"" + gender + "\")) as temp2 join event e on e.eid = temp2.eid group by e.eid order by count desc"; 
            
            
            stmt = conn.prepareStatement(statement);
            System.out.println(stmt);
            rs = stmt.executeQuery();
            while(rs.next()){
                String eventName = rs.getString("eventName");
                eventNameList.add(eventName);
                specificVisitorsList.add("" +rs.getInt("count"));
                totalVisitorsList.add("" + getNumberOfVisitors(eventName));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        
        result.add(eventNameList);
        result.add(specificVisitorsList);
        
        ArrayList<String> percentageUsersList = new ArrayList<>();
        for(int i = 0; i < specificVisitorsList.size(); i++){
            int specificCount = Integer.parseInt(specificVisitorsList.get(i));
            int totalCount = Integer.parseInt(totalVisitorsList.get(i));
            percentageUsersList.add("" + (100.0 * specificCount / totalCount) + "%");
        }
        result.add(percentageUsersList);
        result.add(totalVisitorsList);
        return result;
    }
    
    public static int getNumberOfVisitors(String eventName) throws ParseException{
        Event event = getEventDetails(eventName);
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH"); //2019-03-18 12:00:16
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
                
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select count(distinct email) as count from reading where location like \"" + event.getLocation() + "\" and dateTime between \"" + new java.sql.Timestamp(event.getStartDate().getTime()) + "\" and \"" + new java.sql.Timestamp(event.getEndDate().getTime()) + "\" group by location");
            System.out.println(stmt);
            rs = stmt.executeQuery();
            while(rs.next()){
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        
        return 0;
    }
    
    
}
