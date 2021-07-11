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

<% if(session.getAttribute("artistname") != null){ %> <jsp:include page="artist_mainHeader.jsp" /> <%}%>
<% if(session.getAttribute("username") != null){ %> <jsp:include page="mainHeader.jsp" /> <%}%>

 <div class="main_part">
    <div class="main_left">
                <div class="user_ing">
                    <img src="<%=print_img%>" alt="User" style="max-height: 150px;">
                    <h3> <b><%=Fname%> <%=lname%> </b> <br> <span>@<%=getusername%></span></h3>
                </div>
                    <% if(session.getAttribute("artistname") != null){ %>
                    <div class="upload_action">
                        <a href="upload_song_form.jsp"> Upload Song  </a>
                    </div>
               <% } %>           
                <div class="playlists">
                    <a href="createPlayList.jsp"> <h4 style=" margin-bottom: 20px;"><img src="assets/images/plus.png" height="20px" > Add playlist </h4> </a>

                    <a href="palylist_page.jsp" ><h4 style=" margin-bottom: 20px;"><img src="assets/images/plistBTN.png" alt="Music albums" style="max-height: 20px;"> Play lists </h4></a>

                    <a href="favorites_page.jsp" ><h4 style=" margin-bottom: 20px;"><img src="assets/images/favorite.png" alt="Favorites" style="max-height: 20px;"> Favorites </h4> </a>
                    
                    <a href="flw_artists_page.jsp" ><h4 style=" margin-bottom: 20px;"><img src="assets/images/Artist 1.png" alt="Artists" style="max-height: 20px;"> Artists you Follow </h4> </a>

                </div>
            </div>