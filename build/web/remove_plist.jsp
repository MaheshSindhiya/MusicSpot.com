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
    if(session.getAttribute("artistname") != null)
    { 
        getusername = session.getAttribute("artistname").toString(); 
    }
    if(session.getAttribute("username") == null && session.getAttribute("artistname") == null){ response.sendRedirect("signin.jsp"); }
    try{
        Statement st = JOConnction.conn.createStatement();
        ResultSet rs = st.executeQuery("select * from Playlists where name = '"+getPlistname+"'");
        
    }catch (Exception ex){
        out.print("playlist qur error...:" + ex);
    }

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    
    <%
        if(request.getParameter("rmv_Plist_btn") != null){
            String getPLname = request.getParameter("PList_name");
            String getusernm = "";
            String art_plists = "";
            String rp_plists = "";
            if(session.getAttribute("username") != null){ getusernm = session.getAttribute("username").toString();}
            if(session.getAttribute("artistname") != null) { getusernm = session.getAttribute("artistname").toString(); }
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