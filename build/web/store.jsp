<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>
<%@page import="UserInfo.srting_to_array"%>
<% 
    String getusername = "";
   
//    if(session.getAttribute("username") != null){ getusername = session.getAttribute("username").toString();}
   
    if(session.getAttribute("artistname") != null)
    { 
        getusername = session.getAttribute("artistname").toString(); 
    }
    else{ response.sendRedirect("signin.jsp"); }
%>


