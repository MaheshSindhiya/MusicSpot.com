<%@page import="java.sql.ResultSet"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>
<%@page import="UserInfo.user"%>
<% 
    String getusername = "";
    if(session.getAttribute("username") != null){ getusername = session.getAttribute("username").toString();}
    if(session.getAttribute("artistname") != null){ getusername = session.getAttribute("artistname").toString();}
        if(session.getAttribute("username") == null && session.getAttribute("artistname") == null){ response.sendRedirect("signin.jsp"); }
%>


<jsp:include page="user_main_left.jsp" />

        <div class="main_right" >
            <h3 style="font-size: 32px; color: #fd9a00; margin: 15px 0 0 25px;">Artists you may Like</h3>
            <div class="line-3">
                <%
                    JOConnction.rs = JOConnction.st.executeQuery("select TOP(6) * from artists ORDER BY  num_songs desc ");
                    while(JOConnction.rs.next()){%>
                        <div class="conteiner-3">
                            <div class="werper">
                                <a href="artist_profile.jsp?artist_name=<%=JOConnction.rs.getString("artistname")%>"><img src="<%=JOConnction.rs.getString("img")%>" alt=""></a>
                                    <h4><%=JOConnction.rs.getString("fname")%> <%=JOConnction.rs.getString("lname")%></h4>
                            </div>
                        </div>
                    <%}%>
            </div>
            <div class="bottum">
                <%
                    JOConnction.rs = JOConnction.st.executeQuery("select * from songs ORDER BY  song_id desc ");
                    
                    while(JOConnction.rs.next()){%>
                        <div class="S_list" style="display: flex; margin-bottom:20px">
                            <img id="simg" src="<%=JOConnction.rs.getString("img")%>" alt="">
                            <div class="detail">
                                <h2> <%=JOConnction.rs.getString("name")%> </h2>
                                <p>@<%=JOConnction.rs.getString("artistname")%></p>
                            </div>
                               
                            <audio src="<%=JOConnction.rs.getString("song_file")%>" controls></audio>
                            <iframe src='like.jsp?song_id=<%=JOConnction.rs.getString("song_id")%>' style='border: 0px;height: 30px;width: 70px;position: relative;top: 25px;' scrolling='no'></iframe> <!--  -->
                            <iframe src='adddToPlist.jsp?song_id=<%=JOConnction.rs.getString("song_id")%>' style='border: 0px;height: 30px;width: 195px;position: relative;top: 25px;' scrolling='no'></iframe> <!--  -->
                            <!--<img id="plist" src="assets/images/plistBTN.png" alt="" onclick="plistbtn()">-->
                        </div>
                    <%}
                %>
            </div>
        </div>
    </div>    
<jsp:include page="footer.jsp" />