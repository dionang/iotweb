<%-- 
    Document   : msin
    Created on : 25 Feb, 2019, 5:40:37 PM
    Author     : Dion
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dao.AnalyticsDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="protect.jsp"%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Main page</title>
    </head>
    <body>
        <h1>Welcome to the main page</h1>
        <%=AnalyticsDAO.getAllEvents()%>
        <%=AnalyticsDAO.getAllLocations()%>
        <%
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        %>
            <%=AnalyticsDAO.analyticsByTime(sdf.parse("2019-03-18 11:00:00"), sdf.parse("2019-03-18 19:00:00"))%>
        <form action="LogoutController" method="get">
            <input type="submit" value="logout" 
                 name="Submit" id="logout" />
        </form>
    </body>
</html>
