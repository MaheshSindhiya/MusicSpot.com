<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>

 <%
    String getusername = "";
    String getsong_name_rs = "";
    int song_id = 0;

    if(session.getAttribute("artistname") != null)
    { 
        getusername = session.getAttribute("artistname").toString(); 
    }
    if(session.getAttribute("username") != null)
    { 
        getusername = session.getAttribute("username").toString(); 
    }
    if(session.getAttribute("username") == null && session.getAttribute("artistname") == null){ response.sendRedirect("signin.jsp"); }
    try{        
        if(request.getParameter("song_id") != null){ 
            song_id = Integer.parseInt(request.getParameter("song_id"));
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
        <title> </title>
    </head>
    <body>
        
        <% 
           try{
                if(request.getParameter("Add") != null){
                    String Pname_add = "";
                    String songName_comm_add = "";
                    String songName_plist_add = "";
                    String songname_add = "";
                    
                    int song_id4 = Integer.parseInt(request.getParameter("song_id"));
                    JOConnction.rs = JOConnction.st.executeQuery("select * from songs where song_id = '"+song_id4+"'");
                    while(JOConnction.rs.next()){
                        songname_add = JOConnction.rs.getString("name");
                    }
                    
                    Pname_add = request.getParameter("plists");
                    songName_comm_add = ","+songname_add+",";
                    try{
                        JOConnction.rs = JOConnction.st.executeQuery("select * from Playlists where name = '"+Pname_add+"'");
                        while(JOConnction.rs.next()){
                            songName_plist_add = JOConnction.rs.getString("songs");
                        }
                        if(songName_plist_add.contains(songName_comm_add)){  %>
                            <script> alert("Song allredy present.... "); </script>
                       <% }
                        else{
                            JOConnction.st.executeUpdate("update Playlists set songs = CONCAT(songs,'"+songname_add+",') where name = '"+Pname_add+"' ");
                            JOConnction.st.executeUpdate("update songs set plist_name = CONCAT(plist_name,'"+Pname_add+",') where name = '"+songname_add+"' "); 
                       %>
                            <script> alert("Song Added sucessfully.... "); </script>
                       <% } 
                    } catch (Exception ex){
                        out.print("add btn form   :" + ex + "<br>");
                    }
                }            
           }catch(Exception ex){
               out.print("error : " + ex + "<br>");
           }
       %>
       
       <% 
           try{
               if(request.getParameter("addPlistBtn") != null){
                    int song_id3 = Integer.parseInt(request.getParameter("song_id"));
                    try{
                        JOConnction.rs = JOConnction.st.executeQuery("select * from Playlists where user_name = '"+getusername+"' ");
                        if(JOConnction.rs != null){ %>
                            <form name="plist_frm" action="adddToPlist.jsp?song_id=<%=song_id3%>" method="POST" >
                                <select name="plists" id=""  required> <!--  -->
                                    <%while(JOConnction.rs.next()){ %>
                                        <option value="<%=JOConnction.rs.getString("name")%>"> <%=JOConnction.rs.getString("name")%> </option>
                                    <% } %>
                                </select> 
                                <input type="submit" name="Add" name="addPlistBtn" value="Done" >
                            </form>

                        <%}
                        else{ %>
                            <script> alert("No play list found, Please Create playlist. "); </script>
                        <%}

                    }catch (Exception ex){
                        out.print("add_to_plist  :" + ex);
                    }
                }
           }catch(Exception ex){
               out.print("error : " + ex + "<br>");
           }
       %>
       <form name="plist_frm" action="adddToPlist.jsp?song_id=<%=song_id%>" method="POST"  >
            <input type="submit" name ="addPlistBtn" value = "Add to Playlist" style="background: #fca311; border: none; border-radius: 3px; padding: 3px 10px; cursor: pointer; color: white;" >        
        </form>    
           
    </body>
</html







