<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
   
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome To MusicSpot</title>
    <link rel="stylesheet" href="../assets/css/header_style.css">
    <link rel="stylesheet" href="../assets/css/footer_style.css">  
    <link rel="shortcut icon" href="../assets/images/logo.png" type="image/x-icon">
    <link href="../assets/css/signin_style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    
        <header>
            <div class="logo" style="float: left;">
                <img src="../assets/images/logo.png" alt="MusicSpot" width="70px">
            </div>
            <div class="pages">
                <a href="index.jsp">Home</a> |
                <a href="signin.jsp">Sign In</a> |
                <a href="register.jsp">Sign Up</a> |
                <a href="#">About US</a> |
                <a href="#">feedback</a> 
            </div>
        </header>
<body>
    <center>
    <div class="form">
        <h1> Admin Login.... </h1>
        <form action="login.jsp" method="GET">
         
            <label for="username">Username</label><br>
            <input type="text" name="uname" id=""><br>
            <label for="pswd">Password</label> <br>
            <input type="password" name="pswd" id=""><br><br>
            <input type="submit" value="Login" name="login"><br>
            
            <% if(request.getParameter("login") != null)
            {
               String uname = request.getParameter("uname");
               String pswd = request.getParameter("pswd");   
               try
                {
                    JOConnction.JConnect();
                    String qry = "select * from admin where admin_username='"+uname+"' and password='"+pswd+"'";
                    JOConnction.rs = JOConnction.st.executeQuery(qry);
                    if(JOConnction.rs.next()){ 
                        String admin = JOConnction.rs.getString("admin_username");
                        session.setAttribute("admin", admin);

                        response.sendRedirect("admin_home.jsp");
                    }
                    else{ %>
                    <div id ="error">
                        <Br><h4> <% out.print("Username or Password is incorect");%> </h4> 
                    </div>
                    <%}
                }                    
                catch(Exception ex)
                {
                    System.out.println("Error :- " + ex);
                }
               
            }%>
        
        </form>
    </div>
    </center>
            <jsp:include page="../footer.jsp" />
