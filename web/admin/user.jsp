<%@page import="java.sql.ResultSet"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>
<%@page import="UserInfo.user"%>
<% 
    String getusername = "";
    if(session.getAttribute("admin") != null){ getusername = session.getAttribute("admin").toString();}
    else{ response.sendRedirect("login.jsp"); }
%>

<jsp:include page="left.jsp" />

<style>
    input[type="submit"] {
        background: tomato;
        margin: 25px 10px;
        padding: 3px 10px;
        border: none;
        color: white;
        border-radius: 3px;
    }
    
    .search_user {
        height: 80px;
        width: 100%;
        
    }
    
    .form1 {
        height: 100%;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    input[type="search"] {
        height: 35px;
        width: 60%;
        padding: 5px;
        border: none;
        border-radius: 5px;
    }
    
    .bottum .S_list {
        display: flex;
        width: 100%;
        position: relative;
        align-content: center;
        margin: 0 0 20px 0;
        justify-content: center;
    }
</style>
        
        <div class="main_right">
            <div class="werper">
                
                <div class="search_user">
                    <form action="search_results.jsp" class="form1" method="POST">
                        <input type="search" name="search_user" placeholder="Search User...">
                        <input type="submit" name="search_btn_user" value="Search" style="background: blueviolet; height: 35px;">
                    </form>
                </div>
                
                <div class="bottum">
                <%
                    JOConnction.rs = JOConnction.st.executeQuery("select * from users ORDER BY user_id desc ");
                    
                    while(JOConnction.rs.next()){%>
                        <div class="S_list" style="display: flex; margin-bottom:20px">
                            <img id="simg" src="../<%=JOConnction.rs.getString("img")%>" alt="">
                            <div class="detail">
                                <h2> <%=JOConnction.rs.getString("fname")%> <%=JOConnction.rs.getString("lname")%> </h2>
                                <h5> @<%=JOConnction.rs.getString("username")%> </h5>
                            </div>
                            <form action="delete.jsp?user_name=<%=JOConnction.rs.getString("username")%>" method="POST">
                                <input type="submit" name="delete_btn" value="Delete User" >
                            </form>
                            <form action="edit.jsp?user_name=<%=JOConnction.rs.getString("username")%>" method="POST">
                                <input type="submit" name="edit_btn" value="Edit User" style="background: blueviolet;">
                            </form>
<!--                            <iframe src='delete.jsp?user_name=<%=JOConnction.rs.getString("username")%>' ></iframe> style='border: 0px;height: 30px;width: 70px;position: relative;top: 25px;' scrolling='no'  
                            <iframe src='edit.jsp?user_name=<%=JOConnction.rs.getString("username")%>' ></iframe>  style='border: 0px;height: 30px;width: 190px;position: relative;top: 25px;' scrolling='no' -->
                        </div>
                    <%}
                %>
            </div>
            </div>
        </div>  

    </body>
</html>
