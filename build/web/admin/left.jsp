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

<jsp:include page="header.jsp" />

        <div class="main_part">
           <div class="main_left">
               <div class="user_ing">
                   <img src="../<%=print_img%>" alt="User" style="max-height: 150px;">
                   <h3> <b><%=Fname%> <%=lname%> </b> <br> <span>@<%=getusername%></span></h3>
               </div>

               <div class="playlists" style="margin: 50px">
                   <a href="admin_home.jsp"> <h4 style=" margin-bottom: 20px;"><img src="../assets/images/dashboard.png" style="height: 20px;"> Dashboard </h4> </a>
                   
                   <a href="user.jsp"> <h4 style=" margin-bottom: 20px;"><img src="../assets/images/user.png" style="height: 25px;"> User </h4> </a>
                   
                   <a href="artist.jsp" ><h4 style=" margin-bottom: 20px;"><img src="../assets/images/Artist 1.png" style="max-height: 20px;"> Artists </h4> </a>
                   
                   <a href="song.jsp" ><h4 style=" margin-bottom: 20px;"><img src="../assets/images/music-track.png" style="max-height: 20px;"> Songs </h4> </a>

               </div>
           </div>
