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
    <body>
        <script>
        window.onload = function() {
            getData();
        }
        function getData() {
        }
           
        </script>
        <%-- include navbar --%>
        <%@ include file="../templates/navbar.html" %>
        <!--============================= start of wrapper =============================-->
        <div id="wrapper">
            <%-- include sidebar --%>
            <%@ include file="../templates/sidebar_eventmgmt.html" %>
            <!--============================= start of events =============================-->
            <section class="main-block light-bg" style="width:100%;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-5">
                        <div class="styled-heading">
                            <h3>Featured Events at Scape</h3>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 featured-responsive">
                        <div class="featured-place-wrap">
                            <a href="detail.html">
                                <img src="images/event1.jpg" class="img-fluid" alt="#">
                                
                                <div class="featured-title-box">
                                    <h6>Event at project way</h6>
                                    <p>Media </p> <span>• </span>
                                    <p>Education</p> <span>  </span>
                                    <ul>
                                        <li><span class="icon-location-pin"></span>
                                            <p>Location: project way</p>
                                        </li>
                                        <li><span class="icon-screen-smartphone"></span>
                                            <p>Date: 2019-03-20 12:00:00-2019-03-20 16:00:00</p>
                                        </li>
                                        <li><span class="icon-link"></span>
                                            <p></p>
                                        </li>

                                    </ul>
                                    <div class="bottom-icons">
                                        <div class="open-now">OPEN FOR SIGN UP</div>
                                        <span class="ti-heart"></span>
                                        <span class="ti-bookmark"></span>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-md-6 featured-responsive">
                        <div class="featured-place-wrap">
                            <a href="detail.html">
                                <img src="images/event2.jpg" class="img-fluid" alt="#">
                                
                                <div class="featured-title-box">
                                    <h6>Burger & Lobster</h6>
                                    <p>Music </p> <span>• </span>
                                    <p>Dance</p> <span>  </span>
                                    <ul>
                                        <li><span class="icon-location-pin"></span>
                                            <p>Location: labs</p>
                                        </li>
                                        <li><span class="icon-screen-smartphone"></span>
                                            <p>Date: 2019-03-22 12:00:00-2019-03-22 16:00:00</p>
                                        </li>
                                        <li><span class="icon-link"></span>
                                            <p></p>
                                        </li>

                                    </ul>
                                    <div class="bottom-icons">
                                        <div class="open-now">OPEN FOR SIGN UP</div>
                                        <span class="ti-heart"></span>
                                        <span class="ti-bookmark"></span>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            </section>
            <!--============================= end of events =============================-->
        </div>
        <!--============================= end of wrapper =============================-->
        <!-- Bootstrap core JavaScript-->
        <script src="vendor/jquery/jquery.min.js"></script>
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
        
        
    </body>
</html>
