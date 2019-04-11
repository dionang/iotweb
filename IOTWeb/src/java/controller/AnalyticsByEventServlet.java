/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import dao.AnalyticsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author moses
 */
public class AnalyticsByEventServlet extends HttpServlet {

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
        response.setContentType("text/json;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String eventName = request.getParameter("eventName");
            try {
                ArrayList<ArrayList<String>> analyticsByEvent = AnalyticsDAO.analyticsByEvent(eventName);
                JsonObject result = new JsonObject();
                
                JsonArray data = new JsonArray();
                for (int i = 0; i < analyticsByEvent.size(); i++) {
                    JsonArray dataArr = new JsonArray();
                    for (String s : analyticsByEvent.get(i)) {
                        dataArr.add(s);
                    }
                    
                    switch (i) {
                        case 0:
                            result.add("timeLabels", dataArr);
                            break;
                        case 1:
                            result.add("counts", dataArr);
                            break;
                        case 2:
                            result.add("preferences", dataArr);
                            break;
                        case 3:
                            result.add("preferenceCounts", dataArr);
                            break;
                        case 4:
                            result.add("genders", dataArr);
                            break;
                        case 5:
                            result.add("genderCounts", dataArr);
                            break;
                        case 6:
                            result.add("ageBands", dataArr);
                            break;
                        case 7:
                            result.add("ageCounts", dataArr);
                            break;
                        default:
                            break;
                    }
                }
                
                // add elements to json object
//                result.add("data", data);
                out.println(result.toString());
            } catch (ParseException ex) {
                ex.printStackTrace();
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
