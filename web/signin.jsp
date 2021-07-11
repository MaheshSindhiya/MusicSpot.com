<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<jsp:include page="header.jsp" />
    <center>
    <div class="form">
        <div class="left_form">
<!--            <img src="assets/images/logo.jpg" alt=""/>-->
        </div>
        <div class="right_form">
            <form action="signin.jsp" method="GET">
                <label for="role"> Are you a</label>        
                <U><input type="radio" name="role" value="user" required> User</u> or
                <u><input type="radio" name="role" value="artist" required> Artist</u> ?<br><Br>
                <label for="username">Username</label><br>
                <input type="text" name="uname" id=""><br>
                <label for="pswd">Password</label> <br>
                <input type="password" name="pswd" id=""><br><br>
                <input type="submit" value="Login" name="login"><br>

                <% if(request.getParameter("login") != null)
                {
                   String uname = request.getParameter("uname");
                   String pswd = request.getParameter("pswd");
                   String role = request.getParameter("role");    

                   if(role.equals("user")){
                        try
                        {
                             JOConnction.JConnect();
                             String qry = "select * from users where username='"+uname+"' and password='"+pswd+"'";
                             JOConnction.rs = JOConnction.st.executeQuery(qry);
                             if(JOConnction.rs.next()){ 
                                 String username = JOConnction.rs.getString("username");
                                 session.setAttribute("username", username);

                                 response.sendRedirect("home.jsp");
                             }
                            else{ %>
                            <div id ="error">
                                <Br><h4> <% out.print("user name or Password is incorect");%> </h4> 
                            </div>
                            <%}
                        }                    
                        catch(Exception ex)
                        {
                            System.out.println("Error :- " + ex);
                        }
                   }
                  else{
                        try{
                            String qry2 = "select * from artists where artistname='"+uname+"' and password='"+pswd+"'";
                            JOConnction.rs = JOConnction.st.executeQuery(qry2);
                            if(JOConnction.rs.next()){
                                String artistname = JOConnction.rs.getString("artistname");
                                session.setAttribute("artistname", artistname);

                                response.sendRedirect("artist_home.jsp");
                            }
                            else{ %>
                            <div id ="error">
                                <Br><h4> <% out.print("user name or Password is incorect");%> </h4> 
                            </div>
                            <%}
                        }
                       catch(Exception ex)
                       {
                           System.out.println("Error :- " + ex);
                       }  
                    }
                }   %>
            </form>
        </div>
    </div>
    </center>
<jsp:include page="footer.jsp" />
