package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.ArrayList;
import java.sql.*;

public final class register_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "header.jsp", out, false);
      out.write("\n");
      out.write("<center>\n");
      out.write("    <div class=\"form\">\n");
      out.write("        <form action=\"register.jsp\" method=\"POST\">\n");
      out.write("            <label for=\"fname\">First Name</label>\n");
      out.write("            <input type=\"text\" name=\"fname\" class=\"text\" required> <br>\n");
      out.write("\n");
      out.write("            <label for=\"lname\">Last Name</label>\n");
      out.write("            <input type=\"text\" name=\"lname\" class=\"text\" required> <br>\n");
      out.write("\n");
      out.write("            <label for=\"username\">User Name</label>\n");
      out.write("            <input type=\"text\" name=\"username\" class=\"text\" required> <br>\n");
      out.write("\n");
      out.write("            <label for=\"psws\">Password</label>\n");
      out.write("            <input type=\"password\" name=\"pswd\" class=\"text\" required> <br>\n");
      out.write("\n");
      out.write("            <label for=\"email\">Email</label>\n");
      out.write("            <input type=\"email\" name=\"email\" class=\"text\" required> <br>\n");
      out.write("\n");
      out.write("            <label for=\"DOB\">Date of Birth</label>\n");
      out.write("            <input type=\"date\" name=\"dob\" id=\"dob\" required> <br>\n");
      out.write("\n");
      out.write("            <label for=\"Gender\">Gender</label>        \n");
      out.write("            <input type=\"radio\" name=\"gender\" value=\"Male\"  checked required> Male\n");
      out.write("            <input type=\"radio\" name=\"gender\" value=\"Female\" required> Female <Br>       \n");
      out.write("\n");
      out.write("            <input type=\"submit\" value=\"signup\" name=\"signup\">\n");
      out.write("        </form>\n");
      out.write("    </div>\n");
      out.write("</center>\n");
      out.write("\n");
      out.write("    ");
 if(request.getParameter("signup") != null)
    {
      out.write("\n");
      out.write("        \n");
      out.write("        \n");
      out.write("        ");

            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String uname = request.getParameter("username");
            String pswd = request.getParameter("pswd");
            String email = request.getParameter("email");            
            String dob = request.getParameter("dob");
            String gender = request.getParameter("gender");
            ArrayList error_array = new ArrayList();
           try
           {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=musicspot","root","root");
                Statement st = conn.createStatement();
                
                
//                    st.executeUpdate("inseret into login values('"+uname+"', '"+pswd+"', 'user')");
                    st.executeUpdate("insert into users(user_name, Fname, Lname, email, DOB) values('',"+uname+"', '"+fname+"', '"+lname+"', '"+email+"', '"+dob+"')");
                    
                    session.setAttribute("username", uname);
                    response.sendRedirect("home.jsp");
                
               
      out.write("\n");
      out.write("                <div id =\"error\">\n");
      out.write("                    <Br><br><h4> ");
 
                        
                        if(error_array.contains("Email already exist"))
                            out.print("Email already exist..");
                        if(error_array.contains("User name already exist"))
                            out.print("User name already exist..");
                        if(error_array.contains("User Name Must be between 4 to 20 charectors"))
                            out.print("User Name Must be between 4 to 20 charectors");
                        if(error_array.contains("First Name Must be between 4 to 25 charactors"))
                            out.print("First Name Must be between 4 to 25 charactors");
                        if(error_array.contains("Last Name Must be between 4 to 25 charectors"))
                            out.print("Last Name Must be between 4 to 25 charectors");
                        if(error_array.contains("Password Must be between 4 to 40 charectors"))
                            out.print("Password Must be between 4 to 40 charectors");                        
                        
                        
      out.write(" </h4> \n");
      out.write("                </div>\n");
      out.write("                ");

           }
            catch(Exception ex)
            {
                System.out.println("Error :- " + ex);
            }  
     }
        
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "footer.jsp", out, false);
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
