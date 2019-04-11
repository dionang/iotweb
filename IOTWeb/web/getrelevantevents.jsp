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

        <!-- Breadcrumbs-->
        <ol class="breadcrumb">
          <li class="breadcrumb-item">
            <a href="#">Dashboard</a>
          </li>
          <li class="breadcrumb-item active">Overview</li>
        </ol>

        <div class='row'>
            <div class="col-md-3">
                <div class="form-group">
                    <label>Event Categories:</label><br/>
                    <input type="checkbox" id="food" value="food"> Food<br/>
                    <input type="checkbox" id="technology" value="technology"> Technology<br/>
                    <input type="checkbox" id="gaming" value="gaming"> Gaming <br/>
                    <input type="checkbox" id="dance" value="dance"> Dance <br/>
                    <input type="checkbox" id="music" value="music"> Music <br/>
                </div> 
            </div>
            <div class="col-md-2">
                <div class="form-group">
                    <label>Min Age:</label>
                    <input type="number" class="form-control" id="minAge" min="0" max="100" required>
                </div> 
            </div>
            <div class="col-md-2">
                <div class="form-group">
                    <label>Max Age:</label>
                    <input type="number" class="form-control" id="maxAge" min="0" max="100" required>
                </div> 
            </div>
            <div class="col-md-2">
                <div class="form-group">
                    <label>Gender:</label>
                    <select class="form-control" id="gender">
                        <option></option>
                        <option value='M'>Male</option>
                        <option value='F'>Female</option>
                    </select>
                </div> 
            </div>
            <div class="col-md-1"></div>
            <div class="col-md-2">
                <br/>
                <input type="submit" name="getRelevantEvents" onclick="getData()" class="btn" style="border: solid #9F9F9F 1px;" value="Submit">
            </div>               
        </div>
        <table class="table table-striped">
            <thead>
                <tr><th>Event</th><th>Specific Count</th><th>Actual Count</th><th>Percentage</th></tr>
            </thead>
            <tbody id="eventData">
                
            </tbody>
        
        </table>

<!--        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-chart-area"></i>
            Number of Visitors During Event</div>
          <div class="card-body">
            <canvas id="myLineChart" style="width:100%; height:30"></canvas>
          </div>
        </div>-->
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
    
    function getData() {
//      var categories = document.getElementById('eventName').value;
      var categories = [];
      if (document.getElementById('food').checked) categories.push("food");
      if (document.getElementById('technology').checked) categories.push("technology");
      if (document.getElementById('gaming').checked) categories.push("gaming");
      if (document.getElementById('dance').checked) categories.push("dance");
      if (document.getElementById('music').checked) categories.push("music");
      var minAge = document.getElementById('minAge').value;
      var maxAge = document.getElementById('maxAge').value;
      var gender = document.getElementById('gender').value;
      $.post('AnalyticsByVisitorServlet', {
        categories: categories.join(),
        minAge : minAge,
        maxAge : maxAge,
        gender : gender
      }, function(response) {
        var colors = ['#008080', '#007FFF', '#FFBF00', '#8A2BE2', '#964B00', '#50C878', '#B57EDC', '#003153 ', '#C71585', '#C0C0C0'];
        var tbody = document.getElementById('eventData');
        tbody.innerHTML = "";
        for (var event of response.data) {
            var tr = document.createElement('tr');
            tr.innerHTML = '<td>' + event.eventName + '</td>' +
                '<td>' + event.specific + '</td>' +
                '<td>' + event.total + '</td>' +
                '<td>' + event.percentage + '</td>';
            tbody.appendChild(tr);
        }
//        plotPieChart(response);
      });
    }
    
    function plotPieChart(response) {
        var genderPieChart = null;
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
    
  </script>
</body>

</html>