<%@page import="java.sql.ResultSet"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>
<%@page import="UserInfo.user"%>
<% 
    String getusername = "";
    String print_img = "";
    String Fname = "";
    String lname = "";
    int num_fowl = 0;
    int num_songs = 0;
    if(session.getAttribute("username") != null){ getusername = session.getAttribute("username").toString();}
    else{ response.sendRedirect("signin.jsp"); }
    try{
        JOConnction.rs = JOConnction.st.executeQuery("select * from users where username = '"+getusername+"'");
        while(JOConnction.rs.next()){
            print_img = JOConnction.rs.getString("img");
            Fname = JOConnction.rs.getString("fname");
            lname = JOConnction.rs.getString("lname");
            
        }
        
    }catch (Exception ex){
        out.print("artist qur error...:" + ex);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="assets/fontawesome-free-5.15.1-web/css/all.css" type="text/css"/>
    <link rel="stylesheet" href="assets/css/footer_style.css"> 
    <link rel="stylesheet" href="assets/css/style.css" type="text/css"/>
    <link rel="shortcut icon" href="assets/images/logo.png" type="image/x-icon">
    <title>MusicSpot</title>
    <script>
        function menuToggle(){
            const toggleMenu = document.querySelector('.menu');
            toggleMenu.classList.toggle('active')
        }
    </script>
     <style>
        .breadcrumbs {
            font-family: Helvetica, Arial, sans-serif;
            margin: 0;
            padding: 1em;
            background-color: rgba(227, 227, 227, 0);
            }


            /* Regular breadcrumbs */

            .breadcrumbs ul {
            list-style-type: none;
            margin: 0;
            padding: 2em;
            color: #333;
            }

            .breadcrumbs li {
            display: inline-block;
            position: relative;
            padding-right: 2em;
            margin: 0;
            }
            .breadcrumbs li:after {
                content: '>';
                position: absolute;
                display: inline-block;
                right: 0;
                width: 2em;
                text-align: center;
            }
            .breadcrumbs li:last-child {
            font-weight: bold;
            }
            .breadcrumbs li:last-child:after {
                content: '';
            }

            .breadcrumbs a {
            text-decoration: none;
            display: inline-block;
            color: #333;
            white-space: nowrap;
            }
            .breadcrumbs a:hover {
                text-decoration: underline;
            }


            /* Collapsed breadcrumbs */

            .breadcrumbs .collapsed li {
            overflow: hidden;
            }
            .breadcrumbs .collapsed li:after {
                background: rgb(227,227,227);
                background: linear-gradient(90deg, rgb(227 227 227 / 0%) 0%, rgb(86 86 86) 35%);
                padding-left: 1em;
            }

            .breadcrumbs .collapsed a {
            max-width: 2em;
            transition: max-width 300ms ease-in-out;
            }
            .breadcrumbs .collapsed a:hover,
            .breadcrumbs .collapsed a:focus,
            .breadcrumbs .collapsed li:hover a {
                max-width: 1000px;
            }
            .breadcrumbs .collapsed li:hover:after {
                padding-left: 0em;
                background: transparent;
            }
    </style>
    
</head>
<body>
     <div class="header">
        <div class="header_left">
            <a href="mainheader.html"><img src="assets/images/logo.png" alt="MusicSpot" height="40px" style="background-color: white;"></a>
        </div>
        <div class="search">
            <form action="searchResults.jsp">
                <input type="search" name="search_btn" placeholder="Search song...">
                <i class="fa fa-search"></i>
              </form>
        </div>
        <div class="header_right">
            <div class="inner"style="display: flex;">
                <div class="action">
                    <div class="profile" onclick="menuToggle();">
                        <img src="<%=print_img%>" alt="HEllo">
                    </div>
                    <div class="menu">
                        <h3> <b><%=Fname%> <%=lname%> </b> <br> <span> <%=getusername %> </span></h3>
                        <ul>
                            <li><a href="#"> <img src="assets/images/user.png" alt=""> My profile</a></li>
                            <li><a href="update_profile.jsp"> <img src="assets/images/edit.png" alt=""> Edit Profile</a></li>
                            <li><a href="artist_register.jsp"> <img src="assets/images/microphone.png" alt=""> Became artist</a></li>
                            <li><a href="logout.jsp"> <img src="assets/images/log-out.png" alt=""> LogOut</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    