<%-- 
    Document   : addevent
    Created on : 11 Apr, 2019, 2:17:36 PM
    Author     : Dion
--%>

<%@page import="dao.AnalyticsDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<% 
    ArrayList<String> allLocations = AnalyticsDAO.getAllCurrentLocations();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Event</title>
        <!-- Custom fonts for this template-->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <!-- Page level plugin CSS-->
        <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
        <!-- Custom styles for this template-->
        <link href="css/sb-admin.css" rel="stylesheet">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,400i,500,700,900" rel="stylesheet">
        <!-- Hover Effects -->
        <link rel="stylesheet" href="css/set1.css">
        <!-- Main CSS -->
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <%-- include navbar --%>
        <%@ include file="templates/navbar.html" %>
        <!--============================= start of wrapper =============================-->
        <div id="wrapper">
            <%-- include sidebar --%>
            <%@ include file="templates/sidebar.jsp" %>
             <section class="main-block light-bg" style="width:100%;">
             <div class="container">
                <div class="row justify-content-center">
                    <div class="styled-heading">
                        <h3>Create new events:</h3>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <form action="EventCreationServlet" onsubmit="return validateForm()" style="width:80%;">
                        <div class="form-group row">
                            <label for="exampleFormControlInput1" class="col-sm-2">Event Name:</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="eventName">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="exampleFormControlInput1" class="col-sm-2">Location:</label>
                            <div class="col-sm-10">
                                <select class="form-control" name="location">
                            <%
                                for (String location : allLocations) {
                                    out.println("<option>" + location + "</option>");
                                }
                            %>    
                            </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="exampleFormControlInput1" class="col-sm-2">Start Time:</label>
                            <div class="col-sm-10">
                                <input type="datetime-local" class="form-control" name="startDateTime" id="startDateTime" required />
                            </div>
                        </div>  
                        <div class="form-group row">
                            <label class="col-sm-2">End Time:</label>
                            <div class="col-sm-10">
                                <input type="datetime-local" class="form-control" name="endDateTime"   id="endDateTime" required />
                            </div>
                        </div> 
                        <div class="form-group row">
                            <label for="exampleFormControlInput1" class="col-sm-2">Event Capacity:</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="capacity">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2">Choose Venue Image:</label>
                            <div class="input-group col-sm-10">
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input">
                                    <label class="custom-file-label">Choose file</label>
                                </div>
                            </div>
                        </div> 
                        <div class="form-group row">
                            <label for="exampleFormControlInput1" class="col-sm-2">Categories:</label>
                            
                            <div class="col-md-2 text-center">
                            <label class="image-checkbox">
                                <img src="images/food_cat.jpg" height="80" width="100"/>
                                <input type="checkbox" name="category" value="food"> 
                                <h6>Food</h6>
                            </label>
                            </div>
                            <div class="col-md-2 text-center">
                            <label class="image-checkbox">
                                <img src="images/tech_cat.jpg" height="80" width="100"/>
                                <input type="checkbox" name="category" value="technology"> 
                                <h6>Technology</h6>
                            </label>
                            </div>
                            <div class="col-md-2 text-center">
                            <label class="image-checkbox">
                                <img src="images/gaming_cat.jpg" height="80" width="100"/>
                                <input type="checkbox" name="category" value="gaming"> 
                                <h6>Gaming</h6>
                            </label>
                            </div>
                            <div class="col-md-2 text-center">
                            <label class="image-checkbox">
                                <img src="images/dance_cat.jpg" height="80" width="100"/>
                                <input type="checkbox" name="category" value="dance"> 
                                <h6>Dance</h6>
                            </label>
                            </div>
                            <div class="col-md-2 text-center">
                            <label class="image-checkbox">
                                <img src="images/music_cat.jpg" height="80" width="100"/>
                                <input type="checkbox" name="category" value="music"> 
                                <h6>Music</h6>
                            </label>
                            </div>
                        </div>
                        <div class="text-center">   
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </div>
                </div>
                    </form>  
                </div>
            </div>
            </section>
        </div>
    <script>
        window.onload = function() {
            var date   = new Date();
            date       = new Date(date.getTime() - (date.getTimezoneOffset() * 60000));

            // auto-populate start and end dates
            document.getElementById('startDateTime').value = date.toISOString().substring(0, 11) + "00:00";
            document.getElementById('endDateTime').value   = date.toISOString().substring(0, 16);
        }
        
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
    <script type="text/javascript">
    jQuery(function ($) {
        // init the state from the input
        $(".image-checkbox").each(function () {
            if ($(this).find('input[type="checkbox"]').first().attr("checked")) {
                $(this).addClass('image-checkbox-checked');
            }
            else {
                $(this).removeClass('image-checkbox-checked');
            }
        });

        // sync the state to the input
        $(".image-checkbox").on("click", function (e) {
            if ($(this).hasClass('image-checkbox-checked')) {
                $(this).removeClass('image-checkbox-checked');
                $(this).find('input[type="checkbox"]').first().removeAttr("checked");
            }
            else {
                $(this).addClass('image-checkbox-checked');
                $(this).find('input[type="checkbox"]').first().attr("checked", "checked");
            }

            e.preventDefault();
        });
    });
  </script>
  <style>
    .image-checkbox
    {
        cursor: pointer;
        box-sizing: border-box;
        -moz-box-sizing: border-box;
        -webkit-box-sizing: border-box;
        border: 4px solid transparent;
        outline: 0;
    }

        .image-checkbox input[type="checkbox"]
        {
            display: none;
        }

    .image-checkbox-checked
    {
        border-color: #f58723;
    }
</style>
    </body>
    
    
</html>
