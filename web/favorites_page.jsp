<%@page import="java.sql.ResultSet"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>
<%@page import="UserInfo.user"%>
<%@page import="UserInfo.srting_to_array"%>
<% 
    String getusername = "";
    String songs = "";
    String[] song_ary = {};
    
    if(session.getAttribute("username") != null){ getusername = session.getAttribute("username").toString();}
    if(session.getAttribute("artistname") != null){ getusername = session.getAttribute("artistname").toString();}
        if(session.getAttribute("username") == null && session.getAttribute("artistname") == null){ response.sendRedirect("signin.jsp"); }
    try{
        Statement st = JOConnction.conn.createStatement();
        ResultSet rs = st.executeQuery("select * from favorites where user_name = '"+getusername+"'");
        while(rs.next()){
            songs = rs.getString("song_name");
            song_ary = srting_to_array.convertSTRtoARY(songs);
        }
    }catch (Exception ex){
        out.print("playlist qur error...:" + ex);
    }
%>

<% if(session.getAttribute("artistname") != null){ %> <jsp:include page="main_left.jsp" /> <%}%>
<% if(session.getAttribute("username") != null){ %> <jsp:include page="user_main_left.jsp" /> <%}%>


        <div class="main_right" style="color: #FF8A65;">
            <div class="breadcrumbs">
                <ul class="collapsed">
                    <li><% if(session.getAttribute("artistname") != null){ %> <a href="artist_home.jsp">Home</a></li> <%}%>
                        <% if(session.getAttribute("username") != null){ %> <a href="home.jsp">Home</a></li> <%}%>
                    <li> Favorite Songs</li>
                  </ul>
            </div>
            <div class="bottum">
                <%
                    int i = 0;
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
                                <iframe src='adddToPlist.jsp?song_id=<%=JOConnction.rs.getString("song_id")%>' style='border: 0px;height: 30px;width: 190px;position: relative;top: 25px;' scrolling='no'></iframe> <!--  -->
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