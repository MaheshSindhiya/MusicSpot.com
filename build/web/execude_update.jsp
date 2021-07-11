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
    String email = "";
    String dob = "" ;
    int num_fowl = 0;
    int num_songs = 0;
    if(session.getAttribute("username") != null){ getusername = session.getAttribute("username").toString();}
    if(session.getAttribute("artistname") != null){ getusername = session.getAttribute("artistname").toString();}
    if(session.getAttribute("username") == null && session.getAttribute("artistname") == null){ response.sendRedirect("signin.jsp"); }
    
 %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update User details </title>
        <style>
            .block {
                height: 90vh;
                width: 97%;
                /* background: aqua; */
                padding: 20px;
                display: grid;
                color: white;
                place-content: center;
            }
            
            .block_wr {
                background: #673ab7;
                height: 200px;
                width: 400px;
                display: grid;
                place-content: center;
                line-height: 40px;
                border: none;
                box-shadow: 10px 20px 30px #311b92;
                border-radius: 20px;
            }
            
            input[type="password"] {
                height: 25px;
                padding: 5px;
                border: none;
                border-radius: 5px;
            }
            
            input.btns {
                height: 35px;
                border: none;
                border-radius: 5px;
                background: cornflowerblue;
                color: white;
            }
            
            input.btns:hover {
                background: #2b73f3;
            }
        </style>
    </head>
    <body>
        <%
            try{
                String get_fname = "";
                String getUserName = "";
                get_fname = request.getParameter("firs_tname");
                if(request.getParameter("fname_btn") != null){
                    if(session.getAttribute("artistname") != null){ 
                        getUserName = session.getAttribute("artistname").toString();
                        JOConnction.st.executeLargeUpdate("update artists set fname= '"+get_fname+"' where artistname = '"+getUserName+"' "); %>
                        <script>
                            alert("First name is updated to <%=get_fname%>");
                            window.location.href = 'http://localhost:8084/MusicSpot/update_profile.jsp';
                        </script>
                    <%}
                    if(session.getAttribute("username") != null){ 
                        getUserName = session.getAttribute("username").toString();
                        JOConnction.st.executeLargeUpdate("update users set fname= '"+get_fname+"' where username = '"+getUserName+"' "); %>
                        <script>
                            alert("First name is updated to <%=get_fname%>");
                            window.location.href = 'http://localhost:8084/MusicSpot/update_profile.jsp';
                        </script>
                    <%}
                }    

            }catch (Exception ex){
                out.print("artist qur error...:" + ex);
            }                                                   
        %>
        
        <%
            try{
                String get_lname = "";
                String getUserName = "";
                get_lname = request.getParameter("lname");
                if(request.getParameter("lname_btn") != null){
                    if(session.getAttribute("artistname") != null){ 
                        getUserName = session.getAttribute("artistname").toString();
                        JOConnction.st.executeLargeUpdate("update artists set lname= '"+get_lname+"' where artistname = '"+getUserName+"' "); %>
                        <script>
                            alert("Last name is updated to <%=get_lname%>");
                            window.location.href = 'http://localhost:8084/MusicSpot/update_profile.jsp';
                        </script>
                    <%}
                    if(session.getAttribute("username") != null){ 
                        getUserName = session.getAttribute("username").toString();
                        JOConnction.st.executeLargeUpdate("update users set lname= '"+get_lname+"' where username = '"+getUserName+"' "); %>
                        <script>
                            alert("Last name is updated to <%=get_lname%>");
                            window.location.href = 'http://localhost:8084/MusicSpot/update_profile.jsp';
                        </script>
                    <%}
                }    

            }catch (Exception ex){
                out.print("artist qur error...:" + ex);
            }                                                   
        %>
        
        <%
            try{
                String get_email = "";
                String getUserName = "";
                get_email = request.getParameter("email");
                if(request.getParameter("email_btn") != null){
                    if(session.getAttribute("artistname") != null){ 
                        getUserName = session.getAttribute("artistname").toString();
                        JOConnction.st.executeLargeUpdate("update artists set email= '"+get_email+"' where artistname = '"+getUserName+"' "); %>
                        <script>
                            alert("Email address is updated to <%=get_email%>");
                            window.location.href = 'http://localhost:8084/MusicSpot/update_profile.jsp';
                        </script>
                    <%}
                    if(session.getAttribute("username") != null){ 
                        getUserName = session.getAttribute("username").toString();
                        JOConnction.st.executeLargeUpdate("update users set email= '"+get_email+"' where username = '"+getUserName+"' "); %>
                        <script>
                            alert("Email address is updated to <%=get_email%>");
                            window.location.href = 'http://localhost:8084/MusicSpot/update_profile.jsp';
                        </script>
                    <%}
                }    

            }catch (Exception ex){
                out.print("artist qur error...:" + ex);
            }                                                   
        %>
        
        <%
            try{
                String get_dob = "";
                String getUserName = "";
                get_dob = request.getParameter("dob");
                if(request.getParameter("dob_btn") != null){
                    if(session.getAttribute("artistname") != null){ 
                        getUserName = session.getAttribute("artistname").toString();
                        JOConnction.st.executeLargeUpdate("update artists set dob= '"+get_dob+"' where artistname = '"+getUserName+"' "); %>
                        <script>
                            alert("Date of Birth is updated to <%=get_dob%>");
                            window.location.href = 'http://localhost:8084/MusicSpot/update_profile.jsp';
                        </script>
                    <%}
                    if(session.getAttribute("username") != null){ 
                        getUserName = session.getAttribute("username").toString();
                        JOConnction.st.executeLargeUpdate("update users set dob= '"+get_dob+"' where username = '"+getUserName+"' "); %>
                        <script>
                            alert("Date of Birth is updated to <%=get_dob%>");
                            window.location.href = 'http://localhost:8084/MusicSpot/update_profile.jsp';
                        </script>
                    <%}
                }    

            }catch (Exception ex){
                out.print("artist qur error...:" + ex);
            }                                                   
        %>
        
        <%
            try{
                if(request.getParameter("oldpswd_btn") != null){
                    String getUserName = "";
                    String getOldPswd = "";
                    String setPSWD = "";
                    String getPSWD = request.getParameter("oldpswd");
                    out.print(getPSWD);
                    setPSWD = request.getParameter("set_pswd");
                    if(session.getAttribute("artistname") != null){ 
                        getUserName = session.getAttribute("artistname").toString();
                        JOConnction.rs = JOConnction.st.executeQuery("select * from artists where artistname = '"+getUserName+"' ");
                        while(JOConnction.rs.next()){
                            getOldPswd = JOConnction.rs.getString("password");
                        }
                        if(getPSWD.equals(getOldPswd)){
                            JOConnction.st.executeLargeUpdate("update artists set password= '"+setPSWD+"' where artistname = '"+getUserName+"' "); %>
                           <script>
                               alert("Password has changed to <%=setPSWD%>");
                               window.location.href = 'http://localhost:8084/MusicSpot/update_profile.jsp';
                           </script>
                       <%}
                       else{ %>
                       <script>
                           alter("Password Does not Metch...");
                           window.location.href = 'http://localhost:8084/MusicSpot/execude_update.jsp';
                       </script>
                       <%}
                    }
                    
                    if(session.getAttribute("username") != null){ 
                        getUserName = session.getAttribute("username").toString();
                        JOConnction.rs = JOConnction.st.executeQuery("select * from users where username = '"+getUserName+"' ");
                        while(JOConnction.rs.next()){
                            getOldPswd = JOConnction.rs.getString("password");
                        }
                        if(getPSWD.equals(getOldPswd)){
                            JOConnction.st.executeLargeUpdate("update users set password= '"+setPSWD+"' where username = '"+getUserName+"' "); %>
                           <script>
                               alert("Password has Changed to <%=setPSWD%>");
                               window.location.href = 'http://localhost:8084/MusicSpot/update_profile.jsp';
                           </script>
                       <%}
                       else{ %>
                       <script>
                           alter("Password Does not Metch...");
                           window.location.href = 'http://localhost:8084/MusicSpot/execude_update.jsp';
                       </script>
                       <%}
                    }
                }
            }catch (Exception ex){
                out.print("artist qur error...:" + ex);
            }                                                   
        %>
        
        <%
            try{
                String getUserName = "";
                String getPSWD1 = "";
                String getPSWD2 = "";
                if(request.getParameter("pswd_btn") != null){
                    getPSWD1 = request.getParameter("pswd");
                    getPSWD2 = request.getParameter("pswd2");
            if(getPSWD1.equals(getPSWD2)){ %>
            <div class="block">
                <div class="block_wr">
                    <form action="execude_update.jsp?set_pswd=<%=getPSWD1%>" method="POST">
                        <label for="oldpswd"> Enter Your old Password to set new password </label> <br>
                        <input type="password" name="oldpswd" placeholder="Enter Old Password....">
                        <input type="submit" name="oldpswd_btn" class="btns" value="Change Password">
                    </form>
                </div>
            </div>
                        
                    <%}
                    else{ %>
                    <script>
                        alert("Password Does not Metch...");
                        window.location.href = 'http://localhost:8084/MusicSpot/update_profile.jsp';
                    </script>
                    <%}
                }
            }catch (Exception ex){
                out.print("artist qur error...:" + ex);
            }                                                   
        %>
    </body>
</html>
