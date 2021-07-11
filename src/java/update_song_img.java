
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

@WebServlet("/update_song_img")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 200, // 2MB
        maxFileSize = 1024 * 1024 * 1000, // 10MB
        maxRequestSize = 1024 * 1024 * 5000)

public class update_song_img extends HttpServlet {

    
    public static final String imgUPLOAD_DIR = "files/songs/song_img/";
   
    public String imgDBFileName = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session=request.getSession();
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();        
        String getartistname = "";
        
        String song_name = request.getParameter("song_name");
        String id = request.getParameter("id");
        Part part = request.getPart("simg");//        
        
        String fileName = System.currentTimeMillis() + "_" + extractFileName(part);//file name
        
        String savePath = "F:\\setup\\all\\project\\MusicSpot\\web\\files\\songs\\song_img\\" + File.separator + fileName; //img file
        
        File fileSaveDir = new File(savePath);//img file
        
        part.write(savePath + File.separator); //img file
        
        imgDBFileName = imgUPLOAD_DIR + File.separator + fileName; //Song file

        try {
            
            JOConnction.JConnect();
            PreparedStatement addSongToArtistAccount = JOConnction.conn.prepareStatement("update songs SET img = '"+imgDBFileName+"' where song_id = '"+id+"' ");
            addSongToArtistAccount.executeUpdate();            
            out.println("<script> alert('Song Image Updated Succesfully'); "
                        + "window.location.href = 'http://localhost:8084/MusicSpot/admin/edit_song.jsp?song_name="+ song_name +"'; </script>");
            
        } catch (ClassNotFoundException | SQLException e) {
            out.println(e);
        }
    }
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
