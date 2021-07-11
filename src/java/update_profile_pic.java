
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

@WebServlet("/update_profile_pic")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 200, // 2MB
        maxFileSize = 1024 * 1024 * 1000, // 10MB
        maxRequestSize = 1024 * 1024 * 5000)

public class update_profile_pic extends HttpServlet {

    
    public static final String imgUPLOAD_DIR = "files/profile_pics/";
   
    public String imgDBFileName = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session=request.getSession();
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();        
        String getartistname = "";
        
        String admin = request.getParameter("admin");
        Part part = request.getPart("pro_pic");//        
        
        String fileName = System.currentTimeMillis() + "_" + extractFileName(part);//file name
        
        String savePath = "F:\\setup\\all\\project\\MusicSpot\\web\\files\\profile_pics\\" + File.separator + fileName; //img file
        
        File fileSaveDir = new File(savePath);//img file
        
        part.write(savePath + File.separator); //img file
        
        imgDBFileName = imgUPLOAD_DIR + File.separator + fileName; //Song file

        try {
            if(session.getAttribute("artistname") != null ){
                getartistname=(String)session.getAttribute("artistname");
                JOConnction.JConnect();
                PreparedStatement addSongToArtistAccount = JOConnction.conn.prepareStatement("update artists SET img = '"+imgDBFileName+"' where artistname = '"+getartistname+"' ");
                addSongToArtistAccount.executeUpdate();
                if(admin != null ){
                    out.println("<script> alert('Profile Pic Updated Succesfully'); "
                              + "window.location.href = 'http://localhost:8084/MusicSpot/admin/edit.jsp?artist_name=" + getartistname +"'; </script>");
                }
                out.println("<script> alert('Profile Pic Updated Succesfully'); "
                            + "window.location.href = 'http://localhost:8084/MusicSpot/update_profile.jsp'; </script>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            out.println(e);
        }
        try {
            if(session.getAttribute("username") != null ){
                getartistname=(String)session.getAttribute("username");
                JOConnction.JConnect();
                PreparedStatement addSongToArtistAccount = JOConnction.conn.prepareStatement("update users SET img = '"+imgDBFileName+"' where username = '"+getartistname+"' ");
                addSongToArtistAccount.executeUpdate();
                if(admin != null ){
                    out.println("<script> alert('Profile Pic Updated Succesfully'); "
                              + "window.location.href = 'http://localhost:8084/MusicSpot/admin/edit.jsp?user_name=" + getartistname +"'; </script>");
                }
                out.println("<script> alert('Profile Pic Updated Succesfully'); "
                            + "window.location.href = 'http://localhost:8084/MusicSpot/update_profile.jsp'; </script>");
            }
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
