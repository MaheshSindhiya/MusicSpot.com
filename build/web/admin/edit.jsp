<%@page import="java.sql.ResultSet"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>
<%@page import="UserInfo.user"%>
<% 
    String getusername = "";
    if(session.getAttribute("admin") != null){ getusername = session.getAttribute("admin").toString();}
    else{ response.sendRedirect("login.jsp"); }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%--<jsp:include page="left.jsp" />--%>
 <style>
    .upload {
        display: grid;
        place-content: center;
        height: auto;
        margin-bottom: 100px;
    }

    .form_wreper {
        background: #566573;
        padding: 20px;
        height: 550px;
        width: 800px;
        display: grid;
        line-height: 48px;
        border-radius: 10px;
        place-content: center;
    }

    .form_wreper label, .up_btn {
        margin: 0 20px 0 0;
        background: #fca311;
        border: none;
        border-radius: 3px;
        padding: 3px 10px;
        cursor: pointer;
        color: white;
    }

   .upload .form_wreper img{
        top: 0px;
        left: 0px;
        width: 150px;
        height: 150px;
        object-fit: cover;
        margin-top: 25px;
        border: none;
        border-radius: 50%;
    }

    .upload .form_wreper .firsr_td1{
        width: 30%; padding-left: 10px; 
    }

    .upload .form_wreper .output{
        width: 30%; padding-left: 10px;
    }
    .upload .form_wreper .submit{
        width: 40%; padding-left: 10px;
    }
</style>

        <div class="main_right" style="color: #FF8A65;">
            <div class="wreper">
                <%
                    try{
                        String print_img = "";
                        String Fname = "";
                        String lname = "";
                        String email = "";
                        String dob = "" ;

                        if(request.getParameter("user_name") != null){
                            String username = request.getParameter("user_name"); 
                            session.setAttribute("username", username);
                            JOConnction.rs = JOConnction.st.executeQuery("select * from users where username = '"+username+"'");
                            while(JOConnction.rs.next()){
                                print_img = JOConnction.rs.getString("img");
                                Fname = JOConnction.rs.getString("fname");
                                lname = JOConnction.rs.getString("lname");
                                email = JOConnction.rs.getString("email");
                                dob = JOConnction.rs.getString("dob");
                            }   
                        }    

                        if(request.getParameter("artist_name") != null){
                            String artistname = request.getParameter("artist_name"); 
                            session.setAttribute("artistname", artistname);
                            JOConnction.rs = JOConnction.st.executeQuery("select * from artists where artistname = '"+artistname+"'");
                            while(JOConnction.rs.next()){
                                print_img = JOConnction.rs.getString("img");
                                Fname = JOConnction.rs.getString("fname");
                                lname = JOConnction.rs.getString("lname");
                                email = JOConnction.rs.getString("email");
                                dob = JOConnction.rs.getString("dob");
                            }   
                        }                            
                            
                %>
                            
                            <div class="breadcrumbs">
                                <ul class="collapsed">
                                    <% if(session.getAttribute("artistname") != null){ %> <li> <a href="artist.jsp"> Go Back</a> </li> <% } %>
                                    <% if(session.getAttribute("username") != null){ %> <li> <a href="user.jsp"> Go Back </a></li> <% } %>
                                  </ul>
                            </div>
                            <div class="upload">
                                <div class="form_wreper">

                                    <table border="1px" >
                                        <tr>
                                            <td class="firsr_td1">Change profile Picture </td>
                                            <td class="output" style=" "> <img src="../<%=print_img%>" height="200px"> </td>
                                            <td class="submit" style=""> 
                                                <form action="../update_profile_pic?admin=admin" method="POST" enctype="multipart/form-data">
                                                    <input type="file" name="pro_pic" accept="image/*">
                                                    <input type="submit" name="pro_pic_btn" class="up_btn" value="Upload"> 
                                                </form>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="firsr_td1">Change First name </td>
                                            <td class="output"> <%=Fname%> </td>
                                            <td class="submit"> 
                                                <form action="execude_update.jsp" method="POST"  >
                                                    <input type="text" name="firs_tname" placeholder="First name....">
                                                    <input type="submit" name="fname_btn" class="up_btn" value="Update"> 
                                                </form>                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="firsr_td1">Change Last name </td>
                                            <td class="output"> <%=lname%> </td>
                                            <td class="submit"> 
                                                <form action="execude_update.jsp" method="POST"  >
                                                    <input type="text" name="lname" placeholder="Last name....">
                                                    <input type="submit" name="lname_btn" class="up_btn" value="Update"> 
                                                </form>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="firsr_td1">Change Email </td>
                                            <td class="output"> <%=email%> </td>
                                            <td class="submit"> 
                                                <form action="execude_update.jsp" method="POST"  >
                                                    <input type="email" name="email" placeholder="Email....">
                                                    <input type="submit" name="email_btn" class="up_btn" value="Update"> 
                                                </form>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="firsr_td1">Change Birth Date </td>
                                            <td class="output"> <%=dob%> </td>
                                            <td class="submit"> 
                                                <form action="execude_update.jsp" method="POST"  >
                                                    <input type="date" name="dob" placeholder="Date Of Birth....">
                                                    <input type="submit" name="dob_btn" class="up_btn" value="Update"> 
                                                </form>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="firsr_td1">Change Password </td>
                                            <td class="output" colspan="2"> 
                                                <form action="execude_update.jsp" method="POST"  >
                                                    <input type="password" name="pswd" placeholder="New Password....">
                                                    <input type="password" name="pswd2" placeholder="Conform Password....">
                                                    <input type="submit" name="pswd_btn" class="up_btn" value="Update"> 
                                                </form>
                                            </td>
                                        </tr>

                                    </table>

                                </div>
                            </div>

                            
                        <%
                    }catch (Exception ex){
                        out.print("artist qur error...:" + ex);
                    }
                %>
            </div>
        </div>
    </body>
</html>
