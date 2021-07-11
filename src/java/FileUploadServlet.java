
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

@WebServlet("/FileUploadServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 200, // 2MB
        maxFileSize = 1024 * 1024 * 1000, // 10MB
        maxRequestSize = 1024 * 1024 * 5000)

public class FileUploadServlet extends HttpServlet {

    public static final String UPLOAD_DIR = "files/songs/song_img/";
    public static final String SongUPLOAD_DIR = "files/songs/";
    public String dbFileName = "";
    public String SongdbFileName = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session=request.getSession();
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String admin = request.getParameter("admin");
        String id = request.getParameter("id");
        
        String category = request.getParameter("scategory");
        session.setAttribute("category", category);
        
        String language = request.getParameter("Language");
        session.setAttribute("language", language);
        
        String songName = request.getParameter("sname");
        session.setAttribute("songName", songName);
        
        String lyrics = request.getParameter("writen_by");
        session.setAttribute("lyrics", lyrics);
        
        String getartistname=(String)session.getAttribute("artistname");
        int total_Songs = 0;
        try{
            JOConnction.JConnect();
            PreparedStatement getNumOfSongs = JOConnction.conn.prepareStatement("select * from artists where artistname ='"+getartistname+"'");
            getNumOfSongs.executeQuery();
            while(getNumOfSongs.getResultSet().next()){
                total_Songs = Integer.parseInt(getNumOfSongs.getResultSet().getString("num_songs"));
                total_Songs++;                
            }
        }catch(ClassNotFoundException | NumberFormatException | SQLException ex){
             out.println("Error...:"+ ex);
        }
        
        try {
            JOConnction.JConnect();
            if(admin != null){
                
                PreparedStatement pst = JOConnction.conn.prepareStatement("update songs set name = '"+songName+"', artistname = '"+ admin +"', language = '"+ language +"', category = '"+ category +"' where song_id = '"+id+"'");
                pst.executeUpdate();

                out.println("<script> alert('Song Uploaded Succesfully'); "
                            + "window.location.href = 'http://localhost:8084/MusicSpot/admin/edit_song.jsp'; </script>");
            }
            try{
                JOConnction.JConnect();
                PreparedStatement SongNameCheck = JOConnction.conn.prepareStatement("select * from songs where name ='"+songName+"'");
                SongNameCheck.executeQuery();
                if (SongNameCheck.getResultSet().next()){
                    out.println("<script> alert('Song name already exist'); "
                            + "window.location.href = 'http://localhost:8084/MusicSpot/upload_song_form.jsp'; </script>");
                    out.println("<center><h1>Song name already exist</h1> ");
                    out.println("<a href = 'upload_song_form.jsp'> Go back </a> </center>");                
                    return;
                }
            }catch(ClassNotFoundException | SQLException ex){
                out.println("Error... song name :"+ ex);
            }
            if(admin == null){
                PreparedStatement addSongToArtistAccount = JOConnction.conn.prepareStatement("update artists SET songs_name = CONCAT(songs_name,'"+songName+",'), num_songs = '"+total_Songs+"'  where artistname = '"+getartistname+"' ");
                addSongToArtistAccount.executeUpdate();
                PreparedStatement pst = JOConnction.conn.prepareStatement("insert into songs(name, song_file, artistname, language, img, category) values(?,?,?,?,?,?)");
                pst.setString(1, songName);
                pst.setString(2, SongdbFileName);
                pst.setString(3, getartistname);
                pst.setString(4, language);
                pst.setString(5, dbFileName);
                pst.setString(6, category);
                pst.executeUpdate();

                out.println("<script> alert('Song Uploaded Succesfully'); "
                            + "window.location.href = 'http://localhost:8084/MusicSpot/upload_song_form.jsp'; </script>");
            }
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
