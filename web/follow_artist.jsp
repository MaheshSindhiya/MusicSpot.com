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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <%
            try{
                if(request.getParameter("follow") != null){
                   String get_artist_name = request.getParameter("artist_name"); 
                   num_fowl++;
                   JOConnction.st.executeUpdate("update artists set followers = CONCAT(followers, '"+getusername+",'), num_followers = '"+num_fowl+"' where artistname = '"+artist_name+"' ");
                   JOConnction.st.executeUpdate("update users set flw_artist = CONCAT(flw_artist, '"+artist_name+",') where username = '"+getusername+"' "); %>
                   <script>
                       alert("You Started Following '<%=Fname%> <%=lname%>'...");
                        window.location.href = 'http://localhost:8084/MusicSpot/artist_profile.jsp?artist_name=<%=artist_name%>';                       
                   </script>
                <%}
            }catch (Exception ex){
                out.print("artist follw error...:" + ex);
            }
        %>
        
        <%
            try{
                String get_flws_name_from_artistT = "";
                String get_artist_name_from_userT = "";
                String remove_flw_name_from_artist = "";
                String remove_artist_name_from_user = "";
                String username_comm = "";
                String artistName_comm = "";
                if(request.getParameter("Unfollow") != null){
                   String get_artist_name = request.getParameter("artist_name"); 
                   num_fowl--;
                   JOConnction.rs = JOConnction.st.executeQuery("select * from artists where artistname = '"+artist_name+"' ");
                   while(JOConnction.rs.next()){
                       get_flws_name_from_artistT = JOConnction.rs.getString("followers");
                   }
                   username_comm = ","+getusername+",";
                   remove_flw_name_from_artist = get_flws_name_from_artistT.replace(username_comm, ",");
                   JOConnction.st.executeUpdate("update artists set followers = '"+remove_flw_name_from_artist+"', num_followers = '"+num_fowl+"' where artistname = '"+artist_name+"' ");
                   
                   JOConnction.rs = JOConnction.st.executeQuery("select * from users where username = '"+getusername+"' ");
                   while(JOConnction.rs.next()){
                       get_artist_name_from_userT = JOConnction.rs.getString("flw_artist");
                   }
                   artistName_comm = ","+artist_name+",";
                   remove_artist_name_from_user = get_artist_name_from_userT.replace(artistName_comm, ",");
                   JOConnction.st.executeUpdate("update users set flw_artist = '"+remove_artist_name_from_user+"' where username = '"+getusername+"' "); %>
                   <script>
                       alert("You just Unfollowed '<%=Fname%> <%=lname%>'...");
                        window.location.href = 'http://localhost:8084/MusicSpot/artist_profile.jsp?artist_name=<%=artist_name%>';                       
                   </script>
               <% }
            }catch (Exception ex){
                out.print("artist Unfollow error...:" + ex);
            }
        %>
        
        
    </body>
</html>
