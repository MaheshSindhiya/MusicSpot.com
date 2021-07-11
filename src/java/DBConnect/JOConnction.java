package DBConnect;

import java.sql.*;

public class JOConnction {
    public static Connection conn;
    public static Statement st;
    public static ResultSet rs;
    
    public static void JConnect() throws ClassNotFoundException, SQLException
    {    
        String userid = "root";
        String password = "root";
        
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");  
        conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=music",userid, password); 
        st=conn.createStatement();             
    }
}
