<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>
<%@page import="UserInfo.user"%>
<%@page import="UserInfo.srting_to_array"%>
<% 
    String getusername = "";
    
    if(session.getAttribute("admin") != null){ getusername = session.getAttribute("admin").toString();}
    else{ response.sendRedirect("login.jsp"); }
    
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%--<jsp:include page="left.jsp" />--%>
         <div class="main_right">
            <div class="wreper">
                <%
                    try{
                        if(request.getParameter("delete_btn") != null){
                            String username = request.getParameter("user_name");
                            JOConnction.st.executeUpdate("delete from users where username = '"+username+"' ");
                            JOConnction.st.executeUpdate("delete from playlist where user_name = '"+username+"' ");
                            %>
                           
                            <script> 
                                alert("User removed Sucessfully...");
                                window.location.href = 'http://localhost:8084/MusicSpot/admin/user.jsp';
                            </script>
                        <%}
                        
                    }catch (Exception ex){
                        out.print("artist qur error...:" + ex);
                    }
                %>
                
                <%
                    try{
                        if(request.getParameter("delete_btn") != null){
                            String username = request.getParameter("artist_name");
                            JOConnction.st.executeUpdate("delete from artists where artistname = '"+username+"' ");
                            JOConnction.st.executeUpdate("delete from playlists where user_name = '"+username+"' ");
                            %>
                           
                            <script> 
                                alert("Artist removed Sucessfully...");
                                window.location.href = 'http://localhost:8084/MusicSpot/admin/artist.jsp';
                            </script>
                        <%}
                        
                    }catch (Exception ex){
                        out.print("artist qur error...:" + ex);
                    }
                %>
                
                <%
                    try{
                        String plist = "";
                        String[] plist_ary = {};
                        String PlistTable_songs = "";
                        String rp_songsFromPlistTable = "";
                        int i = 0;                    
                        String getPlistS = ",";
                        if(request.getParameter("delete_btn_song") != null){
                            String songname = request.getParameter("song_name");
                            String songNameComm = "," + songname + ",";
                            JOConnction.rs = JOConnction.st.executeQuery("select * from Playlists where songs like '%"+ songname +"%'");
                            while(JOConnction.rs.next()){
                                plist = JOConnction.rs.getString("name");
                                getPlistS = getPlistS + plist + ",";
                            }
                            plist_ary = srting_to_array.convertSTRtoARY(getPlistS);
                            String plist_name = "";
                            for(i=0;i<plist_ary.length;i++)
                             {
                                plist_name = plist_ary[i]; 
                                JOConnction.rs = JOConnction.st.executeQuery("select * from Playlists where name = '"+plist_name+"' ");
                                while(JOConnction.rs.next()){
                                    PlistTable_songs = JOConnction.rs.getString("songs"); // Getting Songs from Playlist Table
                                }
                                rp_songsFromPlistTable = PlistTable_songs.replace(songNameComm,","); // removeing song name from Playlist 
                                JOConnction.st.executeUpdate("update Playlists set songs = '"+rp_songsFromPlistTable+"' where name = '"+plist_name+"' "); //updating playlist Table
                                
                            } 
                            JOConnction.st.executeUpdate("delete from songs where name = '"+songname+"' ");
                            %>
                            <script> 
                                alert("Song removed Sucessfully...");

                                window.location.href = 'http://localhost:8084/MusicSpot/admin/song.jsp';
                            </script>
                        <%}
                    }catch (Exception ex){
                            out.print("rmv Plist : " + ex + "<br>");
                    }
                %>
            </div>
         </div>
    </body>
</html>
