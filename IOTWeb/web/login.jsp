<%-- 
    Document   : index
    Created on : 25 Feb, 2019, 6:29:11 PM
    Author     : Dion
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <form action="VisitorLoginController">
            <div class="container">
                <label for="email"><b>Username</b></label>
                <input type="text" placeholder="Enter Email" name="email" required>
                <br>
                
                <label for="password"><b>Password</b></label>
                <input type="password" placeholder="Enter Password" name="password" required>
                <br>
                
                <button type="submit">Login</button>
                <label>
                    <input type="checkbox" checked="checked" name="remember"> Remember me
                </label>
            </div>
        </form>
    </body>
</html>

