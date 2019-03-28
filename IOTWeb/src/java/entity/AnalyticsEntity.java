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
public class AnalyticsEntity {
    
    public Date date;
    public String location;
    public ArrayList<Visitor> visitorList;

    public AnalyticsEntity(Date date, String location) {
        this.date = date;
        this.location = location;
        this.visitorList = new ArrayList<>();
    }
    
    public void addVisitor(Visitor v){
        visitorList.add(v);
    }
    
    public void addVisitors(ArrayList<Visitor> visitorList){
        visitorList.addAll(visitorList);
    }
    
    public String toString(){
        return "Date: " + date + "\nLocation: " + location + "\n" + visitorList; 
    }
}
