
<jsp:include page="header.jsp" />
<center>
    <div class="form">
        <h1> Sign Up here for Artist... </h1><br> <br>
        <form action="artist_register.jsp" method="POST">
            <label for="fname">First Name</label>
            <input type="text" name="fname" class="text" required value="<% if (session.getAttribute("fname") != null ) { out.print(session.getAttribute("fname")); } %>">  <br>

            <label for="lname">Last Name</label>
            <input type="text" name="lname" class="text" required value="<% if (session.getAttribute("lname") != null ) { out.print(session.getAttribute("lname")); } %>"> <br>

            <label for="username">Artist Name</label>
            <input type="text" name="username" class="text" required value="<% if (session.getAttribute("uname") != null ) { out.print(session.getAttribute("uname")); } %>"> <br>

            <label for="psws">Password</label>
            <input type="password" name="pswd" class="text" required value="<% if (session.getAttribute("pswd") != null ) { out.print(session.getAttribute("pswd")); } %>"> <br>

            <label for="email">Email</label>
            <input type="email" name="email" class="text" required value="<% if (session.getAttribute("email") != null ) { out.print(session.getAttribute("email")); } %>"> <br>

            <label for="DOB">Date of Birth</label>
            <input type="date" name="dob" id="dob" required value="<% if (session.getAttribute("dob") != null ) { out.print(session.getAttribute("dob")); } %>"> <br>

            <label for="Gender">Gender</label>        
            <input type="radio" name="gender" value="male" required> Male
            <input type="radio" name="gender" value="female" required> Female <Br>       

            <input type="submit" value="signup" name="signup"><br>
            
            <% if(request.getParameter("signup") != null)
            {%>
                <%@page import="java.util.ArrayList"%>
                <%@page import="java.sql.*" %>
                <%@page import="DBConnect.JOConnction"%>
                
                <%
                    String fname = request.getParameter("fname");
                    session.setAttribute("fname", fname);
                    String lname = request.getParameter("lname");
                    session.setAttribute("lname", lname);
                    String uname = request.getParameter("username");
                    session.setAttribute("uname", uname);
                    String pswd = request.getParameter("pswd");
                    session.setAttribute("pswd", pswd);
                    String email = request.getParameter("email");
                    session.setAttribute("email", email);
                    String dob = request.getParameter("dob");
                    session.setAttribute("dob", dob);
                    String gender = request.getParameter("gender");
//                    String pro_pic = "";
                    ArrayList error_array = new ArrayList();
                    int ans = 0;
                   try
                   {
                        JOConnction.JConnect();
                        JOConnction.rs = JOConnction.st.executeQuery("select * from artists where email='"+email+"'");
                        if (JOConnction.rs.next() ) {%>
                                <Br><h4> <% out.print("Email already exist"); ans = 1; %> </h4> <% 
                        }                
                        JOConnction.rs = JOConnction.st.executeQuery("select * from artists where artistname='"+uname+"'");
                        if (JOConnction.rs.next()) {%>
                                <Br><h4> <% out.print("Artist name already exist"); ans = 1; %> </h4> <% 
                        }
                        if(uname.length() < 4 || uname.length() > 20){%>
                                <Br><h4> <% out.print("User Name Must be between 4 to 20 charectors"); ans = 1; %> </h4> <%                   
                        }                
                        if(fname.length() < 4 || fname.length() > 25){ %>
                           <Br><h4> <% out.print("First Name Must be between 4 to 25 charactors");  ans = 1;  %> </h4> <% 
                        }
                        if(lname.length() < 4 || lname.length() > 25){ %>
                           <Br><h4> <% out.print("Last Name Must be between 4 to 25 charectors");  ans = 1;  %> </h4> <% 
                        }
                        if(pswd.length() < 4 || pswd.length() > 45){%>
                           <Br><h4> <% out.print("Password Must be between 4 to 40 charectors");  ans = 1;  %> </h4> <% 
                        }
                        if(ans == 0){
                            String pro_pic = "";
                            if(gender.equals("male")){                                
                                pro_pic = "assets/images/male.png";                                 
                            }
                            if(gender.equals("female")){
                                pro_pic = "assets/images/female.png";                                
                            }
                            try{
                            JOConnction.st.executeUpdate("insert into artists(artistname, password, Fname, Lname, img, email, dob, gender) values('"+uname+"', '"+pswd+"', '"+fname+"', '"+lname+"', '"+pro_pic+"', '"+email+"', '"+dob+"', '"+gender+"')");
                            out.print("hello Daan");
                            session.setAttribute("artistname", uname);
                            response.sendRedirect("artist_home.jsp");
                            }catch (Exception ex){
                                out.print("error" + ex);
                            }
                        }                        
                   }
                    catch(Exception ex)
                    {
                        System.out.println("Error :- " + ex);
                    }  
             }
                %>
        </form>
    </div>
</center>

<jsp:include page="footer.jsp" />