<%@page import="java.sql.ResultSet"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>
<%@page import="UserInfo.user"%>
<%@page import="UserInfo.srting_to_array"%>
<% 
    String getusername = "";
    String artist_name = "";
    String print_img = "";
    String Fname = "";
    String lname = "";
    int num_fowl = 0;
    int num_songs = 0;
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

<% if(session.getAttribute("artistname") != null){ %> <jsp:include page="main_left.jsp" /> <%}%>
<% if(session.getAttribute("username") != null){ %> <jsp:include page="user_main_left.jsp" /> <%}%>

        <div class="main_right" style="color: #FF8A65;">
            <div class="breadcrumbs">
                <ul class="collapsed">
                    <li><% if(session.getAttribute("artistname") != null){ %> <a href="artist_home.jsp">Home</a></li> <%}%>
                        <% if(session.getAttribute("username") != null){ %> <a href="home.jsp">Home</a></li> <%}%>
                    <li> Artists you Follow </li>
                  </ul>
            </div>
            <div class="line-3">
            <%
                try{
                    String[] artist_ary = {};
                    int i = 0;
                    String artists = "";
                    String one_artist = "";
                    JOConnction.rs = JOConnction.st.executeQuery("select * from users where username = '"+getusername+"' ");
                    while(JOConnction.rs.next()){
                        artists = JOConnction.rs.getString("flw_artist");
                    }
                    artist_ary = srting_to_array.convertSTRtoARY(artists); 
                    for(i=0;i<artist_ary.length;i++)
                    {
                        one_artist = artist_ary[i];                    
                        JOConnction.rs = JOConnction.st.executeQuery("select * from artists where artistname = '"+one_artist+"'");
                        while(JOConnction.rs.next()){ %>   
                                <div class="conteiner-3">
                                    <div class="werper">
                                        <a href="artist_profile.jsp?artist_name=<%=JOConnction.rs.getString("artistname")%>"><img src="<%=JOConnction.rs.getString("img")%>" alt=""></a>
                                            <h4><%=JOConnction.rs.getString("fname")%> <%=JOConnction.rs.getString("lname")%></h4>
                                    </div>
                                </div>
                      <%}%>

                <%  }                
                }catch (Exception ex){
                    out.print("artist qur error...:" + ex);
                }%>
            </div>
        </div>
        
    </body>
</html>
