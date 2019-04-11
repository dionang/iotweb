/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.EventDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Dion
 */
@WebServlet(name = "EventCreationServlet", urlPatterns = {"/EventCreationServlet"})
public class EventCreationServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        String eventName = request.getParameter("eventName");
        String location = request.getParameter("location");
        String startDateTime = request.getParameter("startDateTime");
        String endDateTime = request.getParameter("endDateTime");
        String[] eventCategories = request.getParameterValues("category");
        
        // parse the date input into Timestamp object
        Date startDate = new Date();
        Date endDate = new Date();
        try {
            startDate = sdf.parse(startDateTime);
            endDate = sdf.parse(endDateTime);
        } catch (ParseException ex) {
            ex.printStackTrace();
        }
        Timestamp startTime = new Timestamp(startDate.getTime());
        Timestamp endTime = new Timestamp(endDate.getTime());
        
        try {
            EventDAO.createEvent(eventName, location, startTime, endTime, eventCategories);
            out.println("Created event successfully!");
        } catch (IllegalArgumentException e) {
            // overlapping schedule
            System.out.println(e.getMessage());
            out.println(e.getMessage());
        }
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
