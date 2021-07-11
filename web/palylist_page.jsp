<%@page import="java.sql.ResultSet"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>
<%@page import="UserInfo.user"%>
<% 
    String getusername = "";
    int num_fowl = 0;
    int num_songs = 0;
    if(session.getAttribute("username") != null){ getusername = session.getAttribute("username").toString();}
    if(session.getAttribute("artistname") != null){ getusername = session.getAttribute("artistname").toString();}
    if(session.getAttribute("username") == null && session.getAttribute("artistname") == null){ response.sendRedirect("signin.jsp"); }
    try{
        JOConnction.rs = JOConnction.st.executeQuery("select * from artists where artistname = '"+getusername+"'");
        while(JOConnction.rs.next()){
            num_fowl = Integer.parseInt(JOConnction.rs.getString("num_followers"));
            num_songs = Integer.parseInt(JOConnction.rs.getString("num_songs"));
        }
        
    }catch (Exception ex){
        out.print("artist qur error...:" + ex);
    }
%>

<% if(session.getAttribute("artistname") != null){ %> <jsp:include page="main_left.jsp" /> <%}%>
<% if(session.getAttribute("username") != null){ %> <jsp:include page="user_main_left.jsp" /> <%}%>

        <div class="main_right" style="color: #FF8A65;">
            <div class="breadcrumbs">
                <ul class="collapsed">
                    <li><% if(session.getAttribute("artistname") != null){ %> <a href="artist_home.jsp">Home</a></li> <%}%>
                        <% if(session.getAttribute("username") != null){ %> <a href="home.jsp">Home</a></li> <%}%>
                    <li> play lists </li>
                  </ul>
            </div>
            <div class="page_main" style="height: 100vh">
                <div class="wreper">
                    <div class="items" style="display: flex; flex-wrap: wrap; justify-content: flex-start; margin: 0 0 0 20px">
                        <%
                            try{
                                JOConnction.rs = JOConnction.st.executeQuery("select * from Playlists where user_name = '"+getusername+"'");
                                while(JOConnction.rs.next()){ %>                                
                                <div class="conteiner-2" style="width: 180px; height: 205px;">
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