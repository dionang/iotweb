<%-- 
    Document   : protect
    Created on : 25 Feb 2019, 6:36:25 PM
    Author     : moses
--%>

<%

    Object o = session.getAttribute("email");
    if(o == null){
        response.sendRedirect("login.jsp");
        return;
    }
%> 