<%@page import="java.sql.ResultSet"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>
<%@page import="UserInfo.user"%>


<% if(session.getAttribute("artistname") != null){ %> <jsp:include page="main_left.jsp" /> <%}%>
<% if(session.getAttribute("username") != null){ %> <jsp:include page="user_main_left.jsp" /> <%}%>




        <div class="main_right" >
            <div class="bottum">
                <%
                    String get_search = request.getParameter("search_btn");
                    JOConnction.rs = JOConnction.st.executeQuery("select * from songs where name like '%"+get_search+"%' ORDER BY  song_id desc ");
                    
                    while(JOConnction.rs.next()){%>
                        <div class="S_list" style="display: flex; margin-bottom:20px">
                            <img id="simg" src="<%=JOConnction.rs.getString("img")%>" alt="">
                            <div class="detail">
                                <h2> <%=JOConnction.rs.getString("name")%> </h2>
                                <p>@<%=JOConnction.rs.getString("artistname")%></p>
                            </div>
                               
                            <audio src="<%=JOConnction.rs.getString("song_file")%>" controls></audio>
                            <iframe src='like.jsp?song_id=<%=JOConnction.rs.getString("song_id")%>' style='border: 0px;height: 30px;width: 70px;position: relative;top: 25px;' scrolling='no'></iframe> <!--  -->
                            <iframe src='adddToPlist.jsp?song_id=<%=JOConnction.rs.getString("song_id")%>' style='border: 0px;height: 30px;width: 190px;position: relative;top: 25px;' scrolling='no'></iframe> <!--  -->
                            <!--<img id="plist" src="assets/images/plistBTN.png" alt="" onclick="plistbtn()">-->
                        </div>
                    <%}
                %>
            </div>
        </div>