<%-- 
    Document   : msin
    Created on : 25 Feb, 2019, 5:40:37 PM
    Author     : Dion
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Main page</title>
    </head>
    <body>
        <h1>Welcome to the main page</h1>
        <form action="LogoutController" method="get">
            <input type="submit" value="logout" 
                 name="Submit" id="logout" />
        </form>
    </body>
</html>
