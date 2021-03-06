<%-- 
    Document   : analyticsbylocation.jsp
    Created on : Apr 6, 2019, 11:22:27 PM
    Author     : xuyin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Analytics By Location</title>

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

        <!-- Icon Cards-->
<!--        <div class="row">
          <div class="col-xl-3 col-sm-6 mb-3">
            <div class="card text-white bg-primary o-hidden h-100">
              <div class="card-body">
                <div class="card-body-icon">
                  <i class="fas fa-fw fa-comments"></i>
                </div>
                <div class="mr-5">26 New Messages!</div>
              </div>
              <a class="card-footer text-white clearfix small z-1" href="#">
                <span class="float-left">View Details</span>
                <span class="float-right">
                  <i class="fas fa-angle-right"></i>
                </span>
              </a>
            </div>
          </div>
          <div class="col-xl-3 col-sm-6 mb-3">
            <div class="card text-white bg-warning o-hidden h-100">
              <div class="card-body">
                <div class="card-body-icon">
                  <i class="fas fa-fw fa-list"></i>
                </div>
                <div class="mr-5">11 New Tasks!</div>
              </div>
              <a class="card-footer text-white clearfix small z-1" href="#">
                <span class="float-left">View Details</span>
                <span class="float-right">
                  <i class="fas fa-angle-right"></i>
                </span>
              </a>
            </div>
          </div>
          <div class="col-xl-3 col-sm-6 mb-3">
            <div class="card text-white bg-success o-hidden h-100">
              <div class="card-body">
                <div class="card-body-icon">
                  <i class="fas fa-fw fa-shopping-cart"></i>
                </div>
                <div class="mr-5">123 New Orders!</div>
              </div>
              <a class="card-footer text-white clearfix small z-1" href="#">
                <span class="float-left">View Details</span>
                <span class="float-right">
                  <i class="fas fa-angle-right"></i>
                </span>
              </a>
            </div>
          </div>
          <div class="col-xl-3 col-sm-6 mb-3">
            <div class="card text-white bg-danger o-hidden h-100">
              <div class="card-body">
                <div class="card-body-icon">
                  <i class="fas fa-fw fa-life-ring"></i>
                </div>
                <div class="mr-5">13 New Tickets!</div>
              </div>
              <a class="card-footer text-white clearfix small z-1" href="#">
                <span class="float-left">View Details</span>
                <span class="float-right">
                  <i class="fas fa-angle-right"></i>
                </span>
              </a>
            </div>
          </div>
        </div>-->

        <div class='row'>
            <div class="col-md-5">
                <div class="form-group">
                    <label>Start Date Time:</label>
                    <input type="datetime-local" class="form-control" placeholder="Start Date Time" id="startDateTime" required>
                </div> 
            </div>
            <div class="col-md-5">
                <div class="form-group">
                    <label>End Date Time:</label>
                    <input type="datetime-local" class="form-control" placeholder="End Date Time"   id="endDateTime"   required>
                </div> 
            </div>
            <div class="col-md-2">
                <br/>
                <input type="submit" name="analyticsByTime" onclick="getData()" class="btn" style="border: solid #9F9F9F 1px;" value="Submit">
            </div>               
        </div>

        <!-- Area Chart Example-->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-chart-area"></i>
            User Location & Date Time Analytics Chart at Scape</div>
          <div class="card-body">
            <canvas id="myBarChart" width="100%" height="30"></canvas>
          </div>
          <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
        </div>

<!--         DataTables Example 
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            Data Table Example</div>
          <div class="card-body">
            <div class="table-responsive">
            </div>
          </div>
          <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
        </div>-->

      </div>
      <!-- /.container-fluid -->

      <!-- Sticky Footer -->
      <footer class="sticky-footer">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright © Your Website 2019</span>
          </div>
        </div>
      </footer>

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
        var date   = new Date();
        date       = new Date(date.getTime() - (date.getTimezoneOffset() * 60000));
        
        // auto-populate start and end dates
        document.getElementById('startDateTime').value = date.toISOString().substring(0, 11) + "00:00:00";
        document.getElementById('endDateTime').value   = date.toISOString().substring(0, 19);
        getData();
    }
    
    var myBarChart = null;
    function getData() {
      var startDateTime = document.getElementById('startDateTime').value;
      var endDateTime   = document.getElementById('endDateTime').value;
      
      var startDate = new Date(startDateTime);
      var endDate = new Date(endDateTime);
      if (startDate > endDate) {
        alert("Time period not valid!");
        return;
      }
      
      $.post('AnalyticsByTimeServlet', {
        startDateTime : startDateTime,
        endDateTime   : endDateTime
      }, function(response) {
        var colors = ['#008080', '#007FFF', '#FFBF00', '#8A2BE2', '#964B00', '#50C878', '#B57EDC', '#003153 ', '#C71585', '#C0C0C0']
        var ctx = document.getElementById("myBarChart");
        var datasets = [];
        for (var i = 0; i < response.data.length; i++) {
            var location = response.locationLabels[i];
            var data = response.data[i];
            var dataObj = {
                'label': location,
                'data' : data,
                'backgroundColor' : colors[i]
            };
            
            datasets.push(dataObj);
        }
        
        if (myBarChart !== null) {
            myBarChart.destroy();
        }
        
        myBarChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: response.timeLabels,
                datasets: datasets
            },
            options: {
                scales: {
                    xAxes: [
                        { 
                            stacked: true,
                            scaleLabel: {
                                display: true,
                                labelString: 'Date Time'
                             },
                        }
                    ],
                    yAxes: [
                        { 
                            stacked: true,
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
        myBarChart.update();
      });
    }
  </script>
</body>

</html>
