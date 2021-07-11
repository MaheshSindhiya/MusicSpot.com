<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>
<%@page import="UserInfo.srting_to_array"%>
<% 
    String getusername = "";
    String getPlistname = "";
    String getsongNM = "";
    
    
    getPlistname = request.getParameter("getPlistname");
    if(session.getAttribute("username") != null){ getusername = session.getAttribute("username").toString();}
    if(session.getAttribute("artistname") != null)
    { 
        getusername = session.getAttribute("artistname").toString(); 
    }
    if(session.getAttribute("username") == null && session.getAttribute("artistname") == null){ response.sendRedirect("signin.jsp"); }
    try{
        getsongNM = request.getParameter("song_name");
        Statement st = JOConnction.conn.createStatement();
        ResultSet rs = st.executeQuery("select * from Playlists where name = '"+getPlistname+"'");
        out.print("songname top: " + getsongNM + "<br>");
        
    }catch (Exception ex){
        out.print("playlist qur error...:" + ex);
    }

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    
    <%
        try{
        if(request.getParameter("remove_song") != null){
            String get_PlistnamesFromSongsTable = "";
            String Plistname_comm = "";
            String remove_PlistNameFromSongsTable = "";
            String PlistTable_songs = "";
            String rp_songsFromPlistTable = "";
            
            
            String get_songName = request.getParameter("song_name");
            String songNameComm = "," + get_songName + ",";
//            String getusernm = session.getAttribute("artistname").toString();
            String getPLname = session.getAttribute("getPlistname").toString();
            Plistname_comm = "," + getPLname + ",";
            
                JOConnction.rs = JOConnction.st.executeQuery("select * from Playlists where name = '"+getPLname+"' ");
                while(JOConnction.rs.next()){
                    PlistTable_songs = JOConnction.rs.getString("songs"); // Getting Songs from Playlist Table
                }
                rp_songsFromPlistTable = PlistTable_songs.replace(songNameComm,","); // removeing song name from Playlist 
                JOConnction.st.executeUpdate("update Playlists set songs = '"+rp_songsFromPlistTable+"' where name = '"+getPLname+"' "); //updating playlist Table
                
                JOConnction.rs = JOConnction.st.executeQuery("select * from songs where name = '"+get_songName+"'");
                while(JOConnction.rs.next()){
                    get_PlistnamesFromSongsTable = JOConnction.rs.getString("plist_name"); // Getting Playlist names for song
                }
                remove_PlistNameFromSongsTable = get_PlistnamesFromSongsTable.replace(Plistname_comm,","); //Removing Playlistname from Song
                JOConnction.st.executeUpdate("update songs set plist_name = '"+remove_PlistNameFromSongsTable+"' where name = '"+get_songName+"' ");  //updating Songs Table

                %>
                <script> 
                    alert("Song removed Sucessfully...");
                    
                    window.location.href = 'http://localhost:8084/MusicSpot/playlist.jsp?getPlistname=<%=getPLname%>';
                </script>
        <%}   
        }catch (Exception ex){
                out.print("rmv Plist : " + ex + "<br>");
            }
    %>
   
    
    
    