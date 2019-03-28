/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.google.gson.JsonObject;
import dao.AnalyticsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.TreeMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author moses
 */
public class AnalyticsByTimeServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String startDateTimeStr = request.getParameter("startDateTime");
            String endDateTimeStr = request.getParameter("endDateTime");
            
            Date startDateTime = null;
            Date endDateTime = null;
            
            String pattern = "yyyy-MM-dd'T'HH:mm";
            SimpleDateFormat sdf = new SimpleDateFormat(pattern);
            
            try {
                startDateTime = sdf.parse(startDateTimeStr);
                endDateTime = sdf.parse(endDateTimeStr);
                TreeMap<Date, HashMap<String, Integer>> resultMap = AnalyticsDAO.analyticsByTime(startDateTime, endDateTime);
                JsonObject result = new JsonObject();
                for (Date date : resultMap.keySet()) {
                    JsonObject locationCountObj = new JsonObject();
                    HashMap<String, Integer> locationCount = resultMap.get(date);
                    
                    for (String location : locationCount.keySet()) {
                        locationCountObj.addProperty(location, locationCount.get(location));
                    }
                    
                    result.add(date.toString(), locationCountObj);
                }
                
                out.println(result.toString());
            } catch (ParseException ex) {
                
            }
            
            
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
