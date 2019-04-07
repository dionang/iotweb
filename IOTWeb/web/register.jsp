<%-- 
    Document   : register.jsp
    Created on : Apr 6, 2019, 11:04:44 PM
    Author     : xuyin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Custom fonts for this template-->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

        <!-- Custom styles for this template-->
        <link href="css/sb-admin.css" rel="stylesheet">
    </head>
    <body class="bg-dark">
        <div class="container">
            <div class="card card-register mx-auto mt-5">
              <div class="card-header">Register an Admin Account</div>
              <div class="card-body">
                <form action="AdminRegisterController">
                  <div class="form-group">
                    <div class="form-label-group">
                      <input type="text" id="inputEmail" name="email" class="form-control" placeholder="Email address" required="required">
                      <label for="inputEmail">Username</label>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="form-row">
                      <div class="col-md-6">
                        <div class="form-label-group">
                          <input type="password" id="inputPassword" name="password" class="form-control" placeholder="Password" required="required">
                          <label for="inputPassword">Password</label>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-label-group">
                          <input type="password" id="confirmPassword" name="password" class="form-control" placeholder="Confirm password" required="required">
                          <label for="confirmPassword">Confirm password</label>
                        </div>
                      </div>
                    </div>
                  </div>
                  <button class="btn btn-primary btn-block" type="submit">Register</button>
                </form>
                <div class="text-center">
                  <a class="d-block small mt-3" href="login.jsp">Login Page</a>
                </div>
              </div>
            </div>
          </div>

          <!-- Bootstrap core JavaScript-->
          <script src="vendor/jquery/jquery.min.js"></script>
          <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

          <!-- Core plugin JavaScript-->
          <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    </body>
</html>
