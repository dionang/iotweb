/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author moses
 */
public class Event {
    private String eventName;
    private int eventId;
    private String location;
    private ArrayList<String> eventCategories;
    private Date startDate;
    private Date endDate;

    public Event(String eventName, int eventId, String location, ArrayList<String> eventCategories, Date startDate, Date endDate) {
        this.eventName = eventName;
        this.eventId = eventId;
        this.location = location;
        this.eventCategories = eventCategories;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public Event(String eventName, int eventId, String location, Date startDate, Date endDate) {
        this.eventName = eventName;
        this.eventId = eventId;
        this.location = location;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public String getEventName() {
        return eventName;
    }

    public int getEventId() {
        return eventId;
    }

    public String getLocation() {
        return location;
    }
    
    public void addCategory(String category){
        eventCategories.add(category);
    }
    
    public ArrayList<String> getEventCategories() {
        return eventCategories;
    }

    public Date getStartDate() {
        return startDate;
    }

    public Date getEndDate() {
        return endDate;
    }
    
}
