<%@page import="java.sql.ResultSet"%>
<%@page import="DBConnect.JOConnction"%>
<%@page import="java.sql.*"%>
<%@page import="UserInfo.user"%>
<% 
    String getusername = "";
    String print_img = "";
    String Fname = "";
    String lname = "";
    int num_fowl = 0;
    int num_songs = 0;
    if(session.getAttribute("username") != null ){
        getusername = session.getAttribute("username").toString();
    }
    if(session.getAttribute("artistname") != null){ 
        getusername = session.getAttribute("artistname").toString();
    }
    if(session.getAttribute("username") == null && session.getAttribute("artistname") == null){ response.sendRedirect("signin.jsp"); }
    try{
        JOConnction.rs = JOConnction.st.executeQuery("select * from artists where artistname = '"+getusername+"'");
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

<style>
    
    .plist_form {
        height: 200px;
        width: 400px;
        background: bisque;
        padding: 20px;
        border-radius: 10px;
        display: grid;
        margin: 100px 0 0 0;
        place-content: center;
        line-height: 30px;
    }
    
    .cover {
        height: 400px;
        width: 800px;
        display: grid;
        place-content: center;
        position: relative;
        top: -100px;
    }
</style>

<div class="main_right" >
    
    <div class="cover">
        <div class="plist_form">
            <form action="creatPlist" method="POST" enctype="multipart/form-data">
                <label for="plistName">PlayList Name :</label>
                <input type="text" name="plName" class="text" required >  <br>
                <label for="plImg">select Image : </label>
                <input type="file" name="plist_img"><br>
                <input type="submit" name="createPL" value="Create">
            </form>        
        </div>    
    </div>
</div>