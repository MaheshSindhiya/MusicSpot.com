<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>
<%@page import="UserInfo.srting_to_array"%>
<% 
    String getusername = "";
    String getPlistname = "";
    String pimg = "";
    String pname = "";
    String user = "";
    String[] song_ary = {};
    String songs = "";
    int i =0;
    
    getPlistname = request.getParameter("getPlistname");
    if(session.getAttribute("username") != null){ getusername = session.getAttribute("username").toString();}
    if(session.getAttribute("artistname") != null) { getusername = session.getAttribute("artistname").toString(); }
    if(session.getAttribute("username") == null && session.getAttribute("artistname") == null){ response.sendRedirect("signin.jsp"); }
    try{
        Statement st = JOConnction.conn.createStatement();
        ResultSet rs = st.executeQuery("select * from Playlists where name = '"+getPlistname+"'");
        session.setAttribute("getPlistname", getPlistname);
        while(rs.next()){
            pimg = rs.getString("img");
            pname = rs.getString("name");
            user = rs.getString("user_name");
            songs = rs.getString("songs");
            song_ary = srting_to_array.convertSTRtoARY(songs);
        }
    }catch (Exception ex){
        out.print("playlist qur error...:" + ex);
    }

%>

<% if(session.getAttribute("artistname") != null){ %> <jsp:include page="main_left.jsp" /> <%}%>
<% if(session.getAttribute("username") != null){ %> <jsp:include page="user_main_left.jsp" /> <%}%>

<style>
    #btn {
        padding: 5px 10px;
        background: #fca311;
        border: none;
        border-radius: 5px;
        color: white;
        cursor: pointer;
    }
    #btn:hover{
        background: #ff253a;
    }

    .btns{
        background: #fca311; border: none; border-radius: 3px; padding: 3px 10px; cursor: pointer; color: white;    position: relative;    top: 35px;
    }
    .btns:hover{
        background: #ff253a;
    }
        
    .rmv_Plist {
        position: relative;
        top: 140px;
        left: 50px;
    }
</style>
    
    <%
        if(request.getParameter("rmv_Plist_btn") != null){
            String getPLname = session.getAttribute("getPlistname").toString();
            String getusernm = session.getAttribute("artistname").toString();
            String art_plists = "";
            String rp_plists = "";
            try{
                JOConnction.rs = JOConnction.st.executeQuery("select * from artists where artistname = '"+getusernm+"' ");
                while(JOConnction.rs.next()){
                    art_plists = JOConnction.rs.getString("plist_name");
                }
                rp_plists = art_plists.replace(getPLname,",");
                JOConnction.st.executeUpdate("delete from Playlists where name = '"+getPLname+"' "); 
                JOConnction.st.executeUpdate("update artists set plist_name = '"+rp_plists+"' where artistname = '"+getusernm+"' "); 
                
                %>
                <script> 
                    alert("palylist removed Sucessfully...");
                    window.location.href = 'http://localhost:8084/MusicSpot/palylist_page.jsp';
                </script>
            <%}catch (Exception ex){
                out.print("rmv Plist : " + ex + "<br>");
            }
        }
    %>

        <div class="main_right" style="color: #FF8A65;">
            <div class="breadcrumbs">
                <ul class="collapsed">
                    <li><% if(session.getAttribute("artistname") != null){ %> <a href="artist_home.jsp">Home</a></li> <%}%>
                        <% if(session.getAttribute("username") != null){ %> <a href="home.jsp">Home</a></li> <%}%>
                    <li><%=pname%></li>
                  </ul>
            </div>
            <div class="upper">
                <img src="<%=pimg%>" alt="">
                <div class="detail">
                    <h2> <%=pname%></h2>
                    <h4>By @<%=user%></h4>
                </div>
                <div class="rmv_Plist"> 
                    <form action="remove_plist.jsp?PList_name=<%=getPlistname%>" method="POST">
                        <input type="submit" name="rmv_Plist_btn" id="btn" value="Remove Playlist" >
                    </form>
                </div>
            </div>
            <div class="bottum">
               <%
                   String song_name = "";
                   try{
                    for(i=0;i<song_ary.length;i++)
                    {
                        song_name = song_ary[i];                    
                        JOConnction.rs = JOConnction.st.executeQuery("select * from songs where name = '"+song_name+"'");

                        while(JOConnction.rs.next()){%>
                            <div class="S_list" style="display: flex; margin-bottom:20px">
                                <img id="simg" src="<%=JOConnction.rs.getString("img")%>" alt="">
                                <div class="detail">
                                    <h2> <%=JOConnction.rs.getString("name")%> </h2>
                                    <p>@<%=getusername%></p>
                                </div>
                                <audio src="<%=JOConnction.rs.getString("song_file")%>" controls></audio>
                                <iframe src='like.jsp?song_id=<%=JOConnction.rs.getString("song_id")%>' style='border: 0px;height: 30px;width: 70px;position: relative;top: 25px;' scrolling='no'></iframe> <!-- -->
                                <form action="RemoveSongFromPlist.jsp?song_name=<%=JOConnction.rs.getString("name")%>"  method="POST" >
                                    <input type="submit" class="btns" name ="remove_song" value = "Remove Song" >
                                </form>
                            </div>
                        <%}
                    }
                }catch (Exception ex){
                    out.print("song print ...:" + ex);
                }
                %>
            </div>
        </div>
    </div>
    