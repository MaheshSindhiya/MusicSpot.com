<%@page import="java.sql.ResultSet"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>
<%@page import="UserInfo.user"%>
<% 
    String getartistname = "";
    if(session.getAttribute("artistname") != null){ getartistname = session.getAttribute("artistname").toString();}
//    if(session.getAttribute("artistname") != null){ getartistname = session.getAttribute("artistname").toString();}
%>

<% if(session.getAttribute("artistname") != null){ %> <jsp:include page="main_left.jsp" /> <%}%>
<% if(session.getAttribute("username") != null){ %> <jsp:include page="user_main_left.jsp" /> <%}%>
<style>
        .upload {
            display: grid;
            place-content: center;
        }

        .form_wreper {
            background: bisque;
            padding: 20px;
            height: 450px;
            width: 500px;
            display: grid;
            line-height: 48px;
            border-radius: 10px;
            place-content: center;
        }

        .form_wreper label, input[type="submit"] {
            margin: 0 20px 0 0;
        }
    </style>

        <div class="main_right">
            
            <div class="breadcrumbs">
                <ul class="collapsed">
                    <li><a href="artist_home.jsp">Home</a></li>
<!--                    <li><a href="#">First link</a></li>
                    <li><a href="#">Second link</a></li>
                    <li><a href="#">Another lengthier link</a></li>
                    <li><a href="#">Final link in the hierarchy</a></li>-->
                    <li>Upload Song</li>
                  </ul>
            </div>
            
            <div class="upload">
                <div class="form_wreper">
                    <center> <u> <h1> Upload Song </h1> </u> </center> <br>
                    <form action="FileUploadServlet" method="POST" enctype="multipart/form-data">
                       1 <label for="Simg">Song Image</label>
                       <input type="file" name="simg" id="" accept="image/*" required> <br>
                       2 <label for="sname">Song Name</label>
                        <input type="text" name="sname" id="" value="<% if (session.getAttribute("songName") != null ) { out.print(session.getAttribute("songName")); } %>" required> <br>
                       3 <label for="category" name="Cetegory" required> Category </label>
                        <select name="scategory" id="" value="<% if (session.getAttribute("category") != null ) { out.print(session.getAttribute("category")); } %>" required>
                            <option value="Classical">Classical</option>
                            <option value="Hip-hop">Hip-hop</option>
                            <option value="Rap">Rap</option>
                            <option value="Pop">Pop</option>
                            <option value="Bollywood Music">Bollywood Music</option>
                            <option value="Hollywood Music">Hollywood Music</option>
                        </select> <br>
                       4 <label for="Language">Language</label>
                        <select name="Language" id="" name="language" value="<% if (session.getAttribute("language") != null ) { out.print(session.getAttribute("language")); } %>" required>
                            <option value="English">English</option>
                            <option value="Hindi">Hindi</option>
                            <option value="Punjabi">Punjabi</option>
                            <option value="Gujrati">Gujrati</option>
                        </select> <br>
                       5 <label for="Writen_By">write By/Lyrics by</label>
                        <input type="text" name="writen_by" id="" value="<% if (session.getAttribute("lyrics") != null ) { out.print(session.getAttribute("lyrics")); } %>" required> <br>
                       6 <label for="Upload Song">Upload Song</label>
                       <input type="file" name="song" id="song" accept="audio/*" required> <br>

                        <input type="submit" value="Upload" name="UploadSong">
                        <input type="reset" value="Cancle" name="Cancle">
                        
                    </form>
                    <%
                        if(request.getParameter("Cancle") != null){
                            response.sendRedirect("artist_home.jsp");
                        }
                    %>
                </div>
            </div>
        </div>
    </div>