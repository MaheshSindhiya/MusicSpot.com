<%@page import="java.sql.ResultSet"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>
<%@page import="UserInfo.user"%>
<% 
    String getusername = "";
    String print_img = "";
    String Fname = "";
    String lname = "";
    String num_artist = "";
    String num_songs = "";
    String num_user = "";
    String num_plist = "";
    if(session.getAttribute("admin") != null){ getusername = session.getAttribute("admin").toString();}
    else{ response.sendRedirect("login.jsp"); }
    try{
        JOConnction.rs = JOConnction.st.executeQuery("select * from admin where admin_username = '"+getusername+"'");
        while(JOConnction.rs.next()){
            print_img = JOConnction.rs.getString("img");
            Fname = JOConnction.rs.getString("fname");
            lname = JOConnction.rs.getString("lname");            
        }
        JOConnction.rs = JOConnction.st.executeQuery("select COUNT(*) from artists");
        while(JOConnction.rs.next()){
            num_artist = JOConnction.rs.getString(1);
        }
        JOConnction.rs = JOConnction.st.executeQuery("select COUNT(*) from songs");
        while(JOConnction.rs.next()){
            num_songs = JOConnction.rs.getString(1);
        }
        JOConnction.rs = JOConnction.st.executeQuery("select COUNT(*) from users");
        while(JOConnction.rs.next()){
            num_user = JOConnction.rs.getString(1);
        }
        JOConnction.rs = JOConnction.st.executeQuery("select COUNT(*) from playlists");
        while(JOConnction.rs.next()){
            num_plist = JOConnction.rs.getString(1);
        }
    }catch (Exception ex){
        out.print("artist qur error...:" + ex);
    }
%>

<jsp:include page="left.jsp" />
<style>
    .artist {
        background: #d5d5d5;
        height: 200px;
        padding: 20px;
        box-sizing: border-box;
        display: flex;
        width: 240px;
        border: none;
        border-radius: 5px;
        margin: 10px 0;
        
    }
    
    .l {
        height: 100%;
        width: 65%;
        line-height: 90px;
    }
    
    .r {
        height: 100%;
        width: 5%;
        display: grid;
        place-content: center;
        opacity: 0.1;
    }
    
    .wreper{
        padding: 20px;
        display: flex;
        flex-wrap: wrap;
        justify-content: space-evenly;
    }
    
    .span{
        font-size: 22px; opacity: 0.5;
        
    }
</style>

        <div class="main_right">
            <div class="wreper">
                <div class="artist">
                    <div class="l">
                        <h1 style="font-size: 100px;"> <%=num_artist%> </h1>
                        <span class="span"> Artist </span> </div>
                        <div class="r"> <img src="../assets/images/Artist 1.png" height="140px" alt=""/> </div>                    
                </div>
                        
                <div class="artist">
                    <div class="l">
                        <h1 style="font-size: 100px;"> <%=num_user%> </h1>
                        <span class="span"> Users </span> </div>
                        <div class="r"> <img src="../assets/images/group.png" height="140px" alt=""/> </div>                    
                </div>
                
                <div class="artist">
                    <div class="l">
                        <h1 style="font-size: 100px;"> <%=num_songs%> </h1>
                        <span class="span"> Songs </span> </div>
                        <div class="r"> <img src="../assets/images/plistBTN.png" height="140px" alt=""/> </div>                    
                </div>
                        
                <div class="artist">
                    <div class="l">
                        <h1 style="font-size: 100px;"> <%=num_plist%> </h1>
                        <span class="span"> Playlists </span> </div>
                        <div class="r"> <img src="../assets/images/music-album (3).png" height="140px" alt=""/> </div>                    
                </div>                        
            </div>
            
            <span style="margin: 0 25px"> Popular Songs </span>
            <div class="bottum">
                <%
                    JOConnction.rs = JOConnction.st.executeQuery("select TOP(5)* from songs ORDER BY num_likes desc ");
                    
                    while(JOConnction.rs.next()){%>
                        <div class="S_list" style="display: flex; margin-bottom:20px">
                            <img id="simg" src="../<%=JOConnction.rs.getString("img")%>" alt="">
                            <div class="detail">
                                <h2> <%=JOConnction.rs.getString("name")%> </h2>
                                <p>@<%=getusername%></p>
                            </div>
                               
                            <audio src="../<%=JOConnction.rs.getString("song_file")%>" controls></audio>                            
                        </div>
                    <%}
                %>
            </div>
            
            <span style="margin: 0 25px"> Popular Artists </span>
            <div class="line-3">
                <%
                    JOConnction.rs = JOConnction.st.executeQuery("select TOP(6) * from artists ORDER BY  num_songs desc ");
                    while(JOConnction.rs.next()){%>
                        <div class="conteiner-3">
                            <div class="werper">
                                <a href="../artist_profile.jsp?artist_name=<%=JOConnction.rs.getString("artistname")%>"><img src="../<%=JOConnction.rs.getString("img")%>" alt=""></a>
                                    <h4><%=JOConnction.rs.getString("fname")%> <%=JOConnction.rs.getString("lname")%></h4>
                            </div>
                        </div>
                    <%}%>
            </div>
        </div>       

    </body>
</html>
