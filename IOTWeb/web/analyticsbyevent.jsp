<%-- 
    Document   : analyticsbyevent.jsp
    Created on : Apr 6, 2019, 11:22:52 PM
    Author     : xuyin
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="dao.AnalyticsDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<String> allEvents = AnalyticsDAO.getAllEvents();
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>SB Admin - Dashboard</title>

  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

  <!-- Page level plugin CSS-->
  <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">
</head>

<body id="page-top">
  <%-- include navbar --%>
  <%@ include file="templates/navbar.html" %>

  <div id="wrapper">

    <%-- include sidebar --%>
    <%@ include file="templates/sidebar.jsp" %>

    <div id="content-wrapper">
      <div class="container-fluid">
        <div class='row'>
            <div class="col-md-5">
                <div class="form-group">
                    <label>Event Name:</label>
                    <select class="form-control" id="eventName">
                        <%
                            for (String event : allEvents) {
                                out.println("<option>" + event + "</option>");
                            }
                        %>
                    </select>
                </div> 
            </div>
            <div class="col-md-2">
                <br/>
                <input type="submit" name="analyticsByEvent" onclick="getData()" class="btn" style="border: solid #9F9F9F 1px;" value="Submit">
            </div>               
        </div>
        <div>
            Total number of participants: <span id="totalParticipants"></span>
        </div>
                    
        <!-- Area Chart Example-->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-chart-area"></i>
            Number of Visitors During Event</div>
          <div class="card-body">
            <canvas id="myLineChart" style="width:100%; height:30"></canvas>
          </div>
        </div>
        <div class="card mb-3" style="width:49%; margin:1; float:right">
          <div class="card-header">
            <i class="fas fa-chart-area"></i>
            Breakdown of Visitors Gender </div>
          <div class="card-body">
            <canvas id="genderPieChart" style="width:100%; height:30"></canvas>
          </div>
        </div>
        <div class="card mb-3" style="width:49%; margin:1">
          <div class="card-header">
            <i class="fas fa-chart-area"></i>
            Breakdown of Visitors Preferences </div>
          <div class="card-body">
            <canvas id="preferencesPieChart" style="width:100%; height:30"></canvas>
          </div>
        </div>
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-chart-area"></i>
            Breakdown of Visitors Age Groups </div>
          <div class="card-body">
            <canvas id="ageBarChart" style="width:100%; height:30"></canvas>
          </div>
        </div>
      </div>
      <!-- /.container-fluid -->
    </div>
    <!-- /.content-wrapper -->

  </div>
  <!-- /#wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="login.html">Logout</a>
        </div>
      </div>
    </div>
  </div>

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
  
  <script>
    window.onload = function() {
        getData();
    }
    var myLineChart = null;
    var myPieChart = null;
    var genderPieChart = null;
    var ageBarChart = null;
    
    function getData() {
      var eventName = document.getElementById('eventName').value;
      $.post('AnalyticsByEventServlet', {
        eventName : eventName,
      }, function(response) {
        document.getElementById('totalParticipants').innerHTML = response.totalParticipants;
        var colors = ['#008080', '#007FFF', '#FFBF00', '#8A2BE2', '#964B00', '#50C878', '#B57EDC', '#003153 ', '#C71585', '#C0C0C0']
        plotLineChart(response);
        plotPreferencePieChart(response, colors);
        plotGenderPieChart(response);
        plotAgeBarChart(response, colors);
      });
    }
    
    function plotLineChart(response) {
        var ctx = document.getElementById("myLineChart");
        var datasets = [{
            label: '# of visitors',
            data : response.counts,
            borderColor: "#3e95cd",
            fill: false
        }];
        
        if (myLineChart !== null) {
            myLineChart.destroy();
        }
        
        myLineChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: response.timeLabels,
                datasets: datasets
            },
            options: {
                elements: {
                    line: {
                        tension: 0
                    }
                },
                scales: {
                    xAxes: [
                        { 
                            scaleLabel: {
                                display: true,
                                labelString: 'Date Time'
                             },
                        }
                    ],
                    yAxes: [
                        { 
                            scaleLabel: {
                                display: true,
                                labelString: 'No. of Users'
                             },
                            ticks: {
                                callback: function(value) {
                                    if (value % 1 === 0) {
                                        return value;
                                    }
                                }
                            }
                        }
                    ]
                }
            }
        });
        myLineChart.update();
    }
    
    function plotPreferencePieChart(response, colors) {
        var ctx = document.getElementById("preferencesPieChart");
        var datasets = [{
            label: '# of visitors',
            data : response.preferenceCounts,
            backgroundColor: colors
        }];
        
        if (myPieChart !== null) {
            myPieChart.destroy();
        }
        
        myPieChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: response.preferences,
                datasets: datasets
            },
            options: {
            }
        });
        myPieChart.update();
    }
    
    function plotGenderPieChart(response) {
        var ctx = document.getElementById("genderPieChart");
        var datasets = [{
            label: '# of visitors',
            data : response.genderCounts,
            backgroundColor: ['blue', 'red']
//            borderColor: "#3e95cd",
//            fill: false
        }];
        
        console.log(datasets);
        if (genderPieChart !== null) {
            genderPieChart.destroy();
        }
        
        genderPieChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Male', 'Female'],
                datasets: datasets
            },
            options: {
            }
        });
        genderPieChart.update();
    }
    
    function plotAgeBarChart(response, colors) {
        var ctx = document.getElementById("ageBarChart");
        var datasets = [{
            label: '# of visitors',
            data : response.ageCounts,
            backgroundColor: colors
        }];
        
        if (ageBarChart !== null) {
            ageBarChart.destroy();
        }
        
        ageBarChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: response.ageBands,
                datasets: datasets
            },
            options: {
                elements: {
                    line: {
                        tension: 0
                    }
                },
                scales: {
                    xAxes: [
                        { 
                            scaleLabel: {
                                display: true,
                                labelString: 'Age Groups'
                             },
                        }
                    ],
                    yAxes: [
                        { 
                            scaleLabel: {
                                display: true,
                                labelString: 'No. of Users'
                             },
                            ticks: {
                                callback: function(value) {
                                    if (value % 1 === 0) {
                                        return value;
                                    }
                                }
                            }
                        }
                    ]
                }
            }
        });
        ageBarChart.update();
    }
  </script>
</body>

</html>
