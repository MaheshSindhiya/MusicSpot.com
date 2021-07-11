
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import DBConnect.JOConnction;
import javax.servlet.http.HttpSession;

@WebServlet("/creatPlist")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 200, // 2MB
        maxFileSize = 1024 * 1024 * 1000, // 10MB
        maxRequestSize = 1024 * 1024 * 5000)

public class creatPlist extends HttpServlet {

    
    public static final String imgUPLOAD_DIR = "files/plist_img/";
   
    public String imgDBFileName = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session=request.getSession();
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String plName = request.getParameter("plName");        
         String getartistname = "";
        
        if(session.getAttribute("artistname") != null ){
            getartistname=(String)session.getAttribute("artistname");      
        }
        if(session.getAttribute("username") != null ){
            getartistname=(String)session.getAttribute("username");      
        }
        try{
            JOConnction.JConnect();
            PreparedStatement SongNameCheck = JOConnction.conn.prepareStatement("select * from Playlists where name ='"+plName+"'");
            SongNameCheck.executeQuery();
            if (SongNameCheck.getResultSet().next()){
                
                out.println("<script> alert('Play list name already exist'); "
                        + "window.location.href = 'http://localhost:8084/MusicSpot/createPlayList.jsp'; </script>");
                return;
            }
        }catch(ClassNotFoundException | SQLException ex){
            out.println("Error...:"+ ex);
        }
        
        
        Part part = request.getPart("plist_img");//
        
        
        String fileName = System.currentTimeMillis() + "_" + extractFileName(part);//file name
        
        String savePath = "F:\\setup\\all\\project\\MusicSpot\\web\\files\\plist_img\\" + File.separator + fileName; //img file
        
        File fileSaveDir = new File(savePath);//img file
        
        part.write(savePath + File.separator); //img file
        
        imgDBFileName = imgUPLOAD_DIR + File.separator + fileName; //Song file

        try {
            JOConnction.JConnect();
            PreparedStatement addSongToArtistAccount = JOConnction.conn.prepareStatement("update artists SET plist_name = CONCAT(plist_name,'"+plName+",') where artistname = '"+getartistname+"' ");
            addSongToArtistAccount.executeUpdate();
//            Class.forName("com.mysql.jdbc.Driver");
//            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fileupload", "root", "");
            PreparedStatement pst = JOConnction.conn.prepareStatement("insert into Playlists(name, songs, img, user_name) values(?,?,?,?)");
            pst.setString(1, plName);
            pst.setString(2, ",");
            pst.setString(3, imgDBFileName);
            pst.setString(4, getartistname);
            pst.executeUpdate();
            
            out.println("<script> alert('Playlist Created Succesfully'); "
                        + "window.location.href = 'http://localhost:8084/MusicSpot/createPlayList.jsp'; </script>");
        } catch (ClassNotFoundException | SQLException e) {
            out.println(e);
        }

    }
//    // file name of the upload file is included in content-disposition header like this:
//    //form-data; name="dataFile"; filename="PHOTO.JPG"
//
    private String extractFileName(Part part) {//This method will print the file name.
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}
