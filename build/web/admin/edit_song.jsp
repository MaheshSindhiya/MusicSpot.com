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
                        String name = "";
                        String category = "";
                        String language = "";
                        String song = "" ;
                        String artist = "" ;
                        int id = 0;

                        String song_name = request.getParameter("song_name"); 
                        if(request.getParameter("song_name") != null){
//                            session.setAttribute("artistname", artistname);
                            JOConnction.rs = JOConnction.st.executeQuery("select * from songs where name = '"+song_name+"'");
                            while(JOConnction.rs.next()){
                                print_img = JOConnction.rs.getString("img");
                                name = JOConnction.rs.getString("name");
                                category = JOConnction.rs.getString("category");
                                language = JOConnction.rs.getString("language");
                                song = JOConnction.rs.getString("song_file");
                                artist = JOConnction.rs.getString("artistname");
                                id = Integer.parseInt(JOConnction.rs.getString("song_id"));
                            }   
                        }                            
                            
                %>
                            
                            <div class="breadcrumbs">
                                <ul class="collapsed">
                                    <a href="song.jsp"> Go Back </a></li>
                                  </ul>
                            </div>
                            <div class="upload">
                                <div class="form_wreper">

                                    <table border="1px" >
                                        <tr>
                                            <td class="firsr_td1">Change Song Image </td>
                                            <td class="output" style=" "> <img src="../<%=print_img%>" height="200px"> </td>
                                            <td class="submit" style=""> 
                                                <form action="../update_song_img?song_name=<%=song_name%>&id=<%=id%>" method="POST" enctype="multipart/form-data">
                                                    <input type="file" name="simg" accept="image/*" >  
                                                    <input type="submit" name="update_song_btn" class="up_btn" value="Upload"> 
                                                </form>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="firsr_td1">Change Song file </td>
                                            <td class="output" style=" "> <audio src="../<%=song%>" controls></audio> </td>
                                            <td class="submit" style=""> 
                                                <form action="../upload_song_file?song_name=<%=song_name%>&id=<%=id%>" method="POST" enctype="multipart/form-data">
                                                    <input type="file" name="song" accept="audio/*" >
                                                    <input type="submit" name="update_song_btn" class="up_btn" value="Upload"> 
                                                </form>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="firsr_td1">Change Song name </td>
                                            <td class="output"> <%=name%> </td>
                                            <td class="submit"> 
                                                <form action="../FileUploadServlet?admin=<%=artist%>&id=<%=id%>" method="POST" enctype="multipart/form-data">
                                                    <input type="text" name="sname" value="<%=name%>"> 
                                                    
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td class="firsr_td1">Change category </td>
                                            <td class="output"> <%=category%> </td>
                                            <td class="submit"> 
                                                    <select name="scategory" id="" >
                                                        <option value="Classical" <%if(category.equals("Classical")) { out.print("selected"); }%> >Classical</option>
                                                        <option value="Hip-hop" <%if(category.equals("Hip-hop")) { out.print("selected"); }%> >Hip-hop</option>
                                                        <option value="Rap" <%if(category.equals("Rap")) { out.print("selected"); }%> >Rap</option>
                                                        <option value="Pop" <%if(category.equals("Pop")) { out.print("selected"); }%> >Pop</option>
                                                        <option value="Bollywood Music" <%if(category.equals("Bollywood Music")) { out.print("selected"); }%> >Bollywood Music</option>
                                                        <option value="Hollywood Music" <%if(category.equals("Hollywood Music")) { out.print("selected"); }%> >Hollywood Music</option>
                                                    </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="firsr_td1">Change language </td>
                                            <td class="output"> <%=language%> </td>
                                            <td class="submit"> 
                                                    <select name="Language" id="" name="language" >
                                                        <option value="English" <%if(language.equals("English")) { out.print("selected"); }%> >English</option>
                                                        <option value="Hindi" <%if(language.equals("Hindi")) { out.print("selected"); }%> >Hindi</option>
                                                        <option value="Punjabi" <%if(language.equals("Punjabi")) { out.print("selected"); }%> >Punjabi</option>
                                                        <option value="Gujrati" <%if(language.equals("Gujrati")) { out.print("selected"); }%> >Gujrati</option>
                                                    </select>
                                            </td>
                                        </tr>
                                        
                                        <tr style="display: grid; height: 50px;">
                                            <td colspan="3" style="display: grid; place-content: center; width: 439.5%;"> <input type="submit" name="update_song_btn" class="up_btn" value="Upload"> 
                                                </form> </td>
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
