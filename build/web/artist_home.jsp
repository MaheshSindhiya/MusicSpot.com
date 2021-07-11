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
//    if(session.getAttribute("username") != null){ getusername = session.getAttribute("username").toString();}
    if(session.getAttribute("artistname") != null){ getusername = session.getAttribute("artistname").toString();}
    else{ response.sendRedirect("signin.jsp"); }
    try{
        JOConnction.rs = JOConnction.st.executeQuery("select * from artists where artistname = '"+getusername+"'");
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

<jsp:include page="main_left.jsp" />

        <div class="main_right" >
            <div class="upper_wreper">
                <div class="profile_upper">
                    <img src="<%=print_img%>" alt="">
                    <div class="detail">
                        <h2> <%=Fname%> <%=lname%> </h2>
                        <h4>followers <span> <%=num_fowl %></span></h4>
                        <h4>Songs <span> <%=num_songs%> </span> </h4> 
                        <!-- <input type="submit" name="follow" value="Follow"> -->
                        
                    </div>
                    <div class="about">
                        <h4>About...</h4>
                        <p> </p>
                    </div>
                </div>
            </div>
            <div class="profile_bottom">
                <h2> Resent Added </h2> <br>
                <div class="wreper">
                    <div class="line-2">
                    <h3> Playlists </h3>
                        <%
                            try{
                                JOConnction.rs = JOConnction.st.executeQuery("select TOP(5) * from Playlists where user_name = '"+getusername+"' ORDER BY  plist_id desc ");
                                while(JOConnction.rs.next()){ %>                                
                                    <div class="conteiner-2">
                                        <div class="werper">
                                            <a href="playlist.jsp?getPlistname=<%=JOConnction.rs.getString("name")%>"><img src="<%=JOConnction.rs.getString("img")%>" alt="">
                                                <h4> <%=JOConnction.rs.getString("name")%> </h4></a>
                                        </div>
                                    </div>                                    
                                <%}
                            }catch (Exception ex){
                                out.print("play list...:" + ex);
                            }
                        %>
                    </div>
                </div>
            </div>
                    <h3 style="margin: 0 0 0 20px;"> Songs </h3> <br>
            <div class="bottum">
                <%
                    JOConnction.rs = JOConnction.st.executeQuery("select * from songs where artistname = '"+getusername+"' ORDER BY  song_id desc ");
                    
                    while(JOConnction.rs.next()){%>
                        <div class="S_list" style="display: flex; margin-bottom:20px">
                            <img id="simg" src="<%=JOConnction.rs.getString("img")%>" alt="">
                            <div class="detail">
                                <h2> <%=JOConnction.rs.getString("name")%> </h2>
                                <p>@<%=getusername%></p>
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
<jsp:include page="footer.jsp" />