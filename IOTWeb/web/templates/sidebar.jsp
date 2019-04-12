<!-- Sidebar -->
<%@include file="protect.jsp"%>
<ul class="sidebar navbar-nav" style="background-color:#464557">
  <li class="nav-item">
    <a class="nav-link" href="addevent.jsp">
      <i class="fas fa-plus"></i>
      <span>Create Events</span>
    </a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="getrelevantevents.jsp">
      <i class="fas fa-calendar-alt"></i>
      <span>View Events</span>
    </a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="eventmgmt.jsp">
      <i class="fas fa-fw fa-star"></i>
      <span>Featured Events</span>
    </a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="analyticsbytime.jsp">
      <i class="fas fa-fw fa-chart-bar"></i>
      <span>Analytics by time</span>
    </a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="analyticsbyevent.jsp">
      <i class="fas fa-chart-line"></i>
      <span>Analytics by event</span>
    </a>
  </li>
  
</ul>
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
    $(function(){
        $('.sidebar a').filter(function(){return this.href==location.href}).parent().addClass('active').siblings().removeClass('active')
        $('.sidebar a').click(function(){
            $(this).parent().addClass('active').siblings().removeClass('active')	
        })
    })
</script>