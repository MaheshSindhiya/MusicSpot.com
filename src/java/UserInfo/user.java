        
package UserInfo;

import DBConnect.JOConnction;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class user {
    private Connection conn;
    private ResultSet P_user;
    
    public user(Connection conn, String user){
        try {
            this.conn = JOConnction.conn;
            String qur = "select * from users where username = '"+user+"'";
            this.P_user = JOConnction.st.executeQuery(qur);
        } catch (SQLException ex) {
            Logger.getLogger(user.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public String getusername(){
        String username = null;
        try {
            username = this.P_user.getString("username");
        } catch (SQLException ex) {
            Logger.getLogger(user.class.getName()).log(Level.SEVERE, null, ex);
        }
        return username;        
    }
    
    public String getFnameAndLname(){
        ResultSet Fname = null;
        String name = null;
        try {
            String username = this.P_user.getString("username");
            String qur1 = "select fname, lname from users where username = '"+username+"'";
            Fname = JOConnction.st.executeQuery(qur1);
            name = ""+Fname.getString("fname")+" "+Fname.getString("lname")+"" ;
        } catch (SQLException ex) {
            Logger.getLogger(user.class.getName()).log(Level.SEVERE, null, ex);
        }
        return name;        
    }
   
}
