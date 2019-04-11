<%-- 
    Document   : addevent
    Created on : 11 Apr, 2019, 2:17:36 PM
    Author     : Dion
--%>

<%@page import="dao.AnalyticsDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<% 
    ArrayList<String> allLocations = AnalyticsDAO.getAllLocations();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="EventCreationServlet" onsubmit="return validateForm()">
            Event Name: <input name="eventName"/><br/>
            Location: 
            <select name="location">
            <%
                for (String location : allLocations) {
                    out.println("<option>" + location + "</option>");
                }
            %>    
            </select><br/>
            Start Time: <input type="datetime-local" name="startDateTime" value="2019-03-18T08:00" required /><br/>
            End Time:   <input type="datetime-local" name="endDateTime"   value="2019-03-18T18:00" required /><br/>
            Categories: <br/>
            <input type="checkbox" name="category" value="food"> Food<br/>
            <input type="checkbox" name="category" value="technology"> Technology<br/>
            <input type="checkbox" name="category" value="gaming"> Gaming <br/>
            <input type="checkbox" name="category" value="dance"> Dance <br/>
            <input type="checkbox" name="category" value="music"> Music <br/>
            <input type="submit"/>
        </form>
    </body>
    
    <script>
        function validateForm() {
            var startDateTime = document.forms[0].startDateTime.value;
            var endDateTime   = document.forms[0].endDateTime.value;
            var startDate = new Date(startDateTime);
            var endDate = new Date(endDateTime);
            if (startDate > endDate) {
              alert("Time period not valid!");
              return false;
            }
            return true;
        }
    </script>
</html>
