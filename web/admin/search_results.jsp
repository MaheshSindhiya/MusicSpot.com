<%@page import="java.sql.ResultSet"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>
<%@page import="UserInfo.user"%>
<% 
    String getusername = "";
    if(session.getAttribute("admin") != null){ getusername = session.getAttribute("admin").toString();}
    else{ response.sendRedirect("login.jsp"); }
%>

<jsp:include page="left.jsp" />
<style>
    input[type="submit"] {
        background: tomato;
        margin: 25px 10px;
        padding: 3px 10px;
        border: none;
        color: white;
        border-radius: 3px;
    }
    
    .search_user {
        height: 80px;
        width: 100%;
        
    }
    
    .form1 {
        height: 100%;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    input[type="search"] {
        height: 35px;
        width: 60%;
        padding: 5px;
        border: none;
        border-radius: 5px;
    }
    
    .bottum .S_list {
        display: flex;
        width: 100%;
        position: relative;
        align-content: center;
        margin: 0 0 20px 0;
        justify-content: center;
    }
</style>

        <div class="main_right" >
            <div class="bottum">
                <%
                    if(request.getParameter("search_btn_user") != null){ %>
                        <div class="breadcrumbs">
                            <ul class="collapsed">
                               <li> <a href="user.jsp"> Go Back </a></li> 
                              </ul>
                        </div>
                      <%  String get_search = request.getParameter("search_user");
                        JOConnction.rs = JOConnction.st.executeQuery("select * from users where username like '%"+get_search+"%' ORDER BY  user_id desc ");

                        while(JOConnction.rs.next()){%>
                        <div class="S_list" style="display: flex; margin-bottom:20px">
                            <img id="simg" src="../<%=JOConnction.rs.getString("img")%>" alt="">
                            <div class="detail">
                                <h2> <%=JOConnction.rs.getString("fname")%> <%=JOConnction.rs.getString("lname")%> </h2>
                                <h5> @<%=JOConnction.rs.getString("username")%> </h5>
                            </div>
                            <form action="delete.jsp?user_name=<%=JOConnction.rs.getString("username")%>" method="POST">
                                <input type="submit" name="delete_btn" value="Delete User" >
                            </form>
                            <form action="edit.jsp?user_name=<%=JOConnction.rs.getString("username")%>" method="POST">
                                <input type="submit" name="edit_btn" value="Edit User" style="background: blueviolet;">
                            </form>
                        </div>
                    <%}
                    
                    }
                %>
                
                <%
                    if(request.getParameter("search_song_btn") != null){ %>
                    
                        <div class="breadcrumbs">
                            <ul class="collapsed">
                               <li> <a href="song.jsp"> Go Back </a></li> 
                              </ul>
                        </div>
                    
                         <%String get_search = request.getParameter("search_song");
                        JOConnction.rs = JOConnction.st.executeQuery("select * from songs where name like '%"+get_search+"%' ORDER BY  song_id desc ");

                        while(JOConnction.rs.next()){%>
                        <div class="S_list" style="display: flex; margin-bottom:20px">
                            <img id="simg" src="../<%=JOConnction.rs.getString("img")%>" alt="">
                            <div class="detail">
                                <h2> <%=JOConnction.rs.getString("name")%> </h2>
                                <p>@<%=getusername%></p>
                            </div>
                               
                            <audio src="../<%=JOConnction.rs.getString("song_file")%>" controls></audio>   
                            
                            <form action="delete.jsp?song_name=<%=JOConnction.rs.getString("name")%>" method="POST">
                                <input type="submit" name="delete_btn_song" value="Delete Song" >
                            </form>
                            <form action="edit_song.jsp?song_name=<%=JOConnction.rs.getString("name")%>" method="POST">
                                <input type="submit" name="edit_btn_song" value="Edit Song" style="background: blueviolet;">
                            </form>
                            
                        </div>
                    <%}
                    
                    }
                %>
                
                <%
                    if(request.getParameter("search_artist_btn") != null){ %>
                    
                        <div class="breadcrumbs">
                                <ul class="collapsed">
                                   <li> <a href="artist.jsp"> Go Back </a></li> 
                                  </ul>
                            </div>
                    
                        <% String get_search = request.getParameter("search_artist");
                        JOConnction.rs = JOConnction.st.executeQuery("select * from artists where artistname like '%"+get_search+"%' ORDER BY  artist_id desc ");

                        while(JOConnction.rs.next()){%>
                        <div class="S_list" style="display: flex; margin-bottom:20px">
                            <img id="simg" src="../<%=JOConnction.rs.getString("img")%>" alt="">
                            <div class="detail">
                                <h2> <%=JOConnction.rs.getString("fname")%> <%=JOConnction.rs.getString("lname")%> </h2>
                                <h5> @<%=JOConnction.rs.getString("artistname")%> </h5>
                            </div>
                            <form action="delete.jsp?artist_name=<%=JOConnction.rs.getString("artistname")%>" method="POST">
                                <input type="submit" name="delete_btn" value="Delete Artist" >
                            </form>
                            <form action="edit.jsp?artist_name=<%=JOConnction.rs.getString("artistname")%>" method="POST">
                                <input type="submit" name="edit_btn" value="Edit Artist" style="background: blueviolet;">
                            </form>
                        </div>
                    <%}
                    
                    }
                %>
                
            </div>
        </div>