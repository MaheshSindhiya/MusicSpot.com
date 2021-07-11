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
    if(session.getAttribute("admin") != null){ getusername = session.getAttribute("admin").toString();}
    else{ response.sendRedirect("login.jsp"); }
    try{
        JOConnction.rs = JOConnction.st.executeQuery("select * from admin where admin_username = '"+getusername+"'");
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
    <link rel="stylesheet" href="../assets/fontawesome-free-5.15.1-web/css/all.css" type="text/css"/>
    <link rel="stylesheet" href="../assets/css/footer_style.css"> 
    <link rel="stylesheet" href="../assets/css/style.css" type="text/css"/>
    <link rel="shortcut icon" href="../assets/images/logo.png" type="image/x-icon">
    <title>MusicSpot</title>
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
            <a href="../mainheader.html"><img src="../assets/images/logo.png" alt="MusicSpot" height="40px" style="background-color: white;"></a>
        </div>

         <div class="right_portion" style="width: 70%; color: white;">
             <span style="float: right;margin: 5px 0;background: tomato;padding: 5px 10px;border: none;border-radius: 3px;"> <a href="../logout.jsp"> Logout </a> </span>
        </div>
    </div>
    