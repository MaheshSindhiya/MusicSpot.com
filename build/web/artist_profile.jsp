<%@page import="java.sql.ResultSet"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>
<%@page import="UserInfo.user"%>
<% 
    String getusername = "";
    String artist_name = "";
    String print_img = "";
    String Fname = "";
    String lname = "";
    int num_fowl = 0;
    int num_songs = 0;
    artist_name = request.getParameter("artist_name");
    if(session.getAttribute("username") != null){ getusername = session.getAttribute("username").toString();}
    if(session.getAttribute("artistname") != null){ getusername = session.getAttribute("artistname").toString();}
    if(session.getAttribute("username") == null && session.getAttribute("artistname") == null){ response.sendRedirect("signin.jsp"); }
    try{
        JOConnction.rs = JOConnction.st.executeQuery("select * from artists where artistname = '"+artist_name+"'");
        while(JOConnction.rs.next()){
            num_fowl = Integer.parseInt(JOConnction.rs.getString("num_followers"));
            num_songs = Integer.parseInt(JOConnction.rs.getString("num_songs"));
            print_img = JOConnction.rs.getString("img");
            Fname = JOConnction.rs.getString("fname");
            lname = JOConnction.rs.getString("lname");
            
        }
        
    }catch (Exception ex){
        out.print("artist qur error...:" + ex);
    }
%>

<% if(session.getAttribute("artistname") != null){ %> <jsp:include page="main_left.jsp" /> <%}%>
<% if(session.getAttribute("username") != null){ %> <jsp:include page="user_main_left.jsp" /> <%}%>

         <div class="main_right" >
             <div class="breadcrumbs">
                <ul class="collapsed">
                    <li><a href="home.jsp">Home</a></li>
                    <li><%=artist_name%></li>
                  </ul>
            </div>
              <div class="upper_wreper">
                <div class="profile_upper">
                    <img src="<%=print_img%>" alt="">
                    <div class="detail">
                        <h2> <%=Fname%> <%=lname%> </h2>
                        <h4>followers <span> <%=num_fowl %></span></h4>
                        <h4>Songs <span> <%=num_songs%> </span> </h4>
                        <%
                            String artist_names_from_users = "";
                            String artist_names_comm = "";
                            artist_names_comm = ","+artist_name+",";
                            JOConnction.rs = JOConnction.st.executeQuery("select * from users where username = '"+getusername+"' ");
                            while(JOConnction.rs.next()){
                                artist_names_from_users = JOConnction.rs.getString("flw_artist");
                            }
                            if(artist_names_from_users.contains(artist_names_comm)){%>
                                <form action="follow_artist.jsp?artist_name=<%=artist_name%>" method="POST">
                                    <input id="follow" type="submit" name="Unfollow" value="Unfollow" style="background: #FF8A65;">                             
                                </form>
                            <%}
                            else{   %>
                                <form action="follow_artist.jsp?artist_name=<%=artist_name%>" method="POST">
                                    <input id="follow" type="submit" name="follow" value="Follow">                             
                                </form>
                            <%}%>
                    </div>
                    <div class="about">
                        <h4>About...</h4>
                        <p> </p>
                    </div>
                </div>
               
                <div class="profile_bottom">
                <h2> Resent Added </h2> <br>
                <h3 style="margin: 0 0 0 20px;"> Songs </h3> <br>
            <div class="bottum">
                <%
                    JOConnction.rs = JOConnction.st.executeQuery("select * from songs where artistname = '"+artist_name+"' ORDER BY  song_id desc ");
                    
                    while(JOConnction.rs.next()){%>
                        <div class="S_list" style="display: flex; margin-bottom:20px">
                            <img id="simg" src="<%=JOConnction.rs.getString("img")%>" alt="">
                            <div class="detail">
                                <h2> <%=JOConnction.rs.getString("name")%> </h2>
                                <p>@<%=JOConnction.rs.getString("artistname")%></p>
                            </div>
                               
                            <audio src="<%=JOConnction.rs.getString("song_file")%>" controls></audio>
                            <iframe src='like.jsp?song_id=<%=JOConnction.rs.getString("song_id")%>' style='border: 0px;height: 30px;width: 70px;position: relative;top: 25px;' scrolling='no'></iframe> <!--  -->
                            <iframe src='adddToPlist.jsp?song_id=<%=JOConnction.rs.getString("song_id")%>' style='border: 0px;height: 30px;width: 190px;position: relative;top: 25px;' scrolling='no'></iframe> <!--  -->
                            <!--<img id="plist" src="assets/images/plistBTN.png" alt="" onclick="plistbtn()">-->
                        </div>
                    <%}
                %>
            </div>
                         
            </div>
         </div>
    </body>
</html>
