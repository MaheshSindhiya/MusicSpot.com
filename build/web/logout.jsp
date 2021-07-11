<%@page import="javafx.scene.control.Alert"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<html> 
    <head> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <title>LogOut</title>
    </head> 
    <body>
        <% 
            session.removeAttribute("username"); 
            session.removeAttribute("password"); 
            session.invalidate();             
            response.sendRedirect("signin.jsp");
        %>         
    </body> 
</html>
