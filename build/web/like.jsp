<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>
<% 
    String getusername = "";
    String plist_name = "";
    String userid = "";
    int song_id = 0;
    String songName = "";
    String getSongName = "";
    int num_song_like = 0;
    Statement stArtist_id = JOConnction.conn.createStatement();
    Statement stSongName = JOConnction.conn.createStatement();
    Statement stSongAction = JOConnction.conn.createStatement();
    Statement likeUpdate = JOConnction.conn.createStatement();
//    int song_id = 0;
     try{        
        if(session.getAttribute("artistname") != null){ 
            getusername = session.getAttribute("artistname").toString();
            ResultSet rs = stArtist_id.executeQuery("select * from artists where artistname = '"+getusername+"'");
            while (rs.next()){
                userid = rs.getString("artist_id");
            }
        }
        if(session.getAttribute("username") != null){ 
           getusername = session.getAttribute("username").toString();
           ResultSet rs = stArtist_id.executeQuery("select * from users where username = '"+getusername+"'");
           while (rs.next()){
               userid = rs.getString("user_id");
           }
        }
        if(session.getAttribute("username") == null && session.getAttribute("artistname") == null){ response.sendRedirect("signin.jsp"); }
        
    }catch(Exception ex){
        out.print("Uppler 1111111 half..:    \n"+ ex);
    }
    try{        
        if(request.getParameter("song_id") != null){ 

            song_id = Integer.parseInt(request.getParameter("song_id")); 
            ResultSet rs2 = stSongName.executeQuery("select * from songs where song_id = '"+song_id+"'");
            while (rs2.next()){
                getSongName = rs2.getString("name");
                songName = ","+getSongName+",";
                num_song_like = Integer.parseInt(rs2.getString("num_likes"));
            }
        }
    }catch(Exception ex){
        out.print("Uppler 22222222 half..:    \n"+ ex);
    }
    
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <link rel="stylesheet" type="text/css" href="assets/style.css">
        <style type="text/css">
            .S_list #like, #plist {
                cursor: pointer;
                height: 20px;
                width: 20px;
                margin: 0 10px;
                position: relative;
                top: 35px;
                filter: invert(100%) sepia(94%) saturate(929%) hue-rotate(183deg) brightness(121%) contrast(101%);
            }

            .forms{
                display: flex;
                justify-content: space-between;
            }
            
            .btns{
                background: #fca311; border: none; border-radius: 3px; padding: 3px 10px; cursor: pointer; color: white;
            }

        </style>
    </head>
    <body>
        <div class="forms">
            <%
                try{                    
                    if(request.getParameter("like_song") != null){
                        int song_id2 = Integer.parseInt(request.getParameter("song_id"));
                        JOConnction.rs = JOConnction.st.executeQuery("select * from favorites where user_name = '"+getusername+"'");
                        if(JOConnction.rs.next()){
                            JOConnction.st.executeUpdate("update favorites set song_name = CONCAT(song_name,'"+getSongName+",') where user_name = '"+getusername+"'");
                        }
                        else{
                         String qur = "insert into favorites(user_name, song_name) values('"+getusername+"','"+songName+"')";
                         JOConnction.st.executeUpdate(qur);
                        }
                         num_song_like++;
                         likeUpdate.executeUpdate("update songs set num_likes = '"+num_song_like+"' where name = '"+getSongName+"'");
                          %>
                   <script> alert("Song Added to favorite succesfully  :)"); </script>
                <%
                    }
                } catch(Exception ex){
                    out.print("Like Button...: " + ex);
                }
            %>
            
            <%
                try{
                 String rpsong = "";
                 String rp_song = "";
                 if(request.getParameter("unlike_song") != null)
                 {
                    int song_id2 = Integer.parseInt(request.getParameter("song_id"));
                    JOConnction.rs = JOConnction.st.executeQuery("select * from favorites where user_name = '"+getusername+"' ");
                    while(JOConnction.rs.next()){
                        rpsong = JOConnction.rs.getString("song_name");  
                    }
                   rp_song = rpsong.replace(songName, ",");                   
                   String qur = "update favorites set song_name = '"+rp_song+"' where user_name = '"+getusername+"' ";
                   JOConnction.st.executeUpdate(qur);
                   num_song_like--;                                
                   likeUpdate.executeUpdate("update songs set num_likes = '"+num_song_like+"' where name = '"+getSongName+"'");
                   %>
                   <script> 
                       alert("Song removed from favorite succesfully  :)");                        
                   </script>
                <%}
                }catch(Exception ex){
                    out.print("Unlike   :" + ex);
                }
            %>
            
             
            
        <%
            try{
                String checkSong = "";
                ResultSet rsSongAction = stSongAction.executeQuery("select song_name from favorites where user_name = '"+getusername+"' ");
                while(rsSongAction.next()){
                   checkSong = rsSongAction.getString("song_name");
//                   out.print(checkSong);
                }
                if(checkSong.contains(songName)){ //remove song from liked songs%>

                    <form name="lick" action="like.jsp?song_id=<%=song_id%>"  method="POST" >
                        <input type="submit" class="btns" name ="unlike_song" value = "Unlike" >
                        
                    </form>
                <% }
                else{ //like Song%>
                    <form name="lick" action="like.jsp?song_id=<%=song_id%>" method="POST" style="display: grid">
                        <input type="submit" class="btns" name ="like_song" value = "Like"  style="background: #3875C5;">
                        
                    </form>
                <%}
            }catch(Exception ex){
                 out.print("\n hello...:    \n" + ex);
            }            
        %>
        
        <!--Add to play List Part-->

        </div>  
        
    </body>
</html>
