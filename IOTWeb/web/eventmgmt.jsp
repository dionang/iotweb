<%-- 
    Document   : eventmgmt.jsp
    Created on : Mar 31, 2019, 1:32:18 PM
    Author     : xuyin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
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
        <title>Event Management Page</title>
    </head>
    <body class="text-center">
        
        <%-- include navbar --%>
        <%@ include file="templates/navbar.html" %>
        <!--============================= start of wrapper =============================-->
        <div id="wrapper">
            <%-- include sidebar --%>
            <%@ include file="templates/sidebar.jsp" %>
            <!--============================= start of events =============================-->
            <section class="main-block light-bg" style="width:100%;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="styled-heading">
                        <h3>Featured Events at Scape</h3>
                    </div>
                </div>
                <div class="row justify-content-center" id="events">
                    
                </div>
            </div>
            </section>
            <!--============================= end of events =============================-->
        </div>
        <!--============================= end of wrapper =============================-->
        <!-- Bootstrap core JavaScript-->
        <script src="vendor/jquery/jquery.min.js" type="text/javascript"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Page level plugin JavaScript-->
        <script src="vendor/chart.js/Chart.min.js"></script>
        <script src="vendor/datatables/jquery.dataTables.js"></script>
        <script src="vendor/datatables/dataTables.bootstrap4.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="js/sb-admin.min.js"></script>

        <!-- Demo scripts for this page-->
        <script src="js/demo/datatables-demo.js"></script>
        <script src="js/demo/chart-area-demo.js"></script>
        <script>
		$(document).ready(function () {
		  getData();
		});
        function getData() {
            $.post('EventMgmtServlet', {
              }, function(response) {
                  
                  var events = JSON.parse(response);
                  console.log(response);
                  var wrapper = document.getElementById("events");
                  var htmlData = '';
                  events.forEach(function(event){
                      console.log(event.startDateTime);
                      var eventStartDateTime = event.startDateTime;
                      var eventEndDateTime = event.endDateTime;
                      var eventName = event.eventName;
                      var eventLocation = event.location;
                      var eventCategory = event.category;
                      var eventImgSrc = "images/event1.jpg"; 
                      if(eventLocation=="labs"){
                          eventImgSrc = "images/event2.jpg";
                      }
                      htmlData += '<div class="col-md-5 featured-responsive" style="max-width:400px;"><div class="featured-place-wrap"><div class="featured-place-wrap">';
                      htmlData += '<a href="#"><img src='+eventImgSrc+' class="img-fluid" alt="#"><div class="featured-title-box">';
                      htmlData += '<h6>'+eventName+'</h6>';
                      htmlData += '<span>• </span><p>'+eventCategory+' </p> ';
                      htmlData += '<ul><li><span class="icon-location-pin"></span><p>Location: '+eventLocation+'</p></li>';
                      htmlData += '<li><span class="icon-screen-smartphone"></span><p>Date:'+eventStartDateTime+'-'+eventEndDateTime+'</p></li></ul>';
                      htmlData += '<div class="bottom-icons"><div class="open-now">OPEN FOR SIGN UP</div><span class="ti-heart"></span>';
                      htmlData += '<span class="ti-bookmark"></span></div>';
                      htmlData += '</div></a></div></div></div>';
                  });
                  wrapper.innerHTML = htmlData;
              })
              
        }
           
        </script>
        
    </body>
</html>
