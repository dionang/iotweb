/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.util.ArrayList;

/**
 *
 * @author moses
 */
public class Visitor {
    
    public String name;
    public int age;
    public String email;
    public char gender;
    public ArrayList<String> preferenceList; //to be implemented
    
    public Visitor(String name, int age, String email, char gender) {
        this.name = name;
        this.age = age;
        this.email = email;
        this.gender = gender;
    }
    
    public Visitor(String email){
        this.email = email;
    }
    
    public String toString(){
        return "Email: " + email;
    }
}
