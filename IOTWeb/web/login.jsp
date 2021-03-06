<%-- 
    Document   : index
    Created on : 25 Feb, 2019, 6:29:11 PM
    Author     : Dion
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Custom fonts for this template-->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

        <!-- Custom styles for this template-->
        <link href="css/sb-admin.css" rel="stylesheet">
    </head>
    <body class="text-center" style="background-color: #FD8D00;">
        <div class="container">
            <div class="row mt-5">
                <div class="col">
                    <img class="mb-4" src='images/scape_white.png' alt="#" width="200" height="100">
                    <img class="mb-4" src='images/logo.png' alt="#" width="200" height="50">
                </div>
            </div>
            
            <div class="card card-login mx-auto mt-5" style="margin-top: 0px !important;">
              <div class="card-header">Login</div>
              <div class="card-body">
                <form action="AdminLoginController">
                    <div class="form-group">
                      <div class="form-label-group">
                        
                        <input type="text" placeholder="Enter Email" name="email" id="inputEmail" class="form-control" required="required" autofocus="autofocus">
                        <label for="inputEmail">Username</label>
                        
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="form-label-group">
                          
                        <input type="password" placeholder="Enter Password" name="password" id="inputPassword" class="form-control" required="required" autofocus="autofocus">
                        <label for="inputPassword">Password</label>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="checkbox">
                        <label>
                            <input type="checkbox" checked="checked" name="remember"> Remember me
                        </label>
                      </div>
                    <div class="form-group">
                    <button class="btn btn-primary btn-block" type="submit">Login</button>
                </form>
                <div class="text-center">
                    <a class="d-block small mt-3" href="register.jsp">Register an Account</a>
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

