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
import java.util.ArrayList;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author moses
 */
public class AnalyticsByVisitorServlet extends HttpServlet {

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
            String gender = request.getParameter("gender");
            if(gender.isEmpty()){
                gender = "%";
            }
            
            String minAge = request.getParameter("minAge");
            if(minAge.isEmpty()){
                minAge = "0";
            }
            
            String maxAge = request.getParameter("maxAge");
            if(maxAge.isEmpty()){
                maxAge = "100";
            }
            
            String[] categoriesArr = request.getParameter("categories").split(",");
            
            
            ArrayList<String> categories = new ArrayList<>();
            if(categoriesArr != null){
                categories = new ArrayList<>(Arrays.asList(categoriesArr));
            }
            
            ArrayList<ArrayList<String>> resultList = AnalyticsDAO.analyticsByVisitorCharacteristics(gender, minAge, maxAge, categories);
            JsonObject result = new JsonObject();
            String[] properties = new String[] { "eventName", "specific", "percentage", "total" };
            
            JsonArray dataArr = new JsonArray();
            for (int i = 0; i < resultList.get(0).size(); i++) {
                JsonObject eventObj = new JsonObject();
                for (int j = 0; j < resultList.size(); j++) {
                    eventObj.addProperty(properties[j], resultList.get(j).get(i));
                }
                dataArr.add(eventObj);
            }
            
            result.add("data", dataArr);
            out.println(result.toString());
        }catch (Exception e){
            e.printStackTrace();
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
