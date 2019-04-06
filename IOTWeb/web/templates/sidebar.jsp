<!-- Sidebar -->
<ul class="sidebar navbar-nav" style="background-color:#464557">
  <li class="nav-item">
    <a class="nav-link" href="eventmgmt.jsp">
      <i class="fas fa-fw fa-calendar-check"></i>
      <span>Event Management</span>
    </a>
  </li>
  <li class="nav-item dropdown show">
    <a class="nav-link dropdown-toggle" href="analyticsbytime.jsp" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
      <i class="fas fa-fw fa-chart-area"></i>
      <span>Analytics</span>
    </a>
    <div class="dropdown-menu show" aria-labelledby="pagesDropdown">
      <a class="dropdown-item" href="analyticsbytime.jsp">Analytics by time</a>
      <a class="dropdown-item" href="analyticsbylocation.jsp">Analytics by location</a>
      <a class="dropdown-item" href="analyticsbyevent.jsp">Analytics by event</a>
    </div>
  </li>
</ul>
<script>
    $(function(){
        $('.sidebar a').filter(function(){return this.href==location.href}).parent().addClass('active').siblings().removeClass('active')
        $('.sidebar a').click(function(){
            $(this).parent().addClass('active').siblings().removeClass('active')	
        })
    })
</script>