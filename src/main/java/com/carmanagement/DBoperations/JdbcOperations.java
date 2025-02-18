//package com.carmanagement.DBoperations;
//
//import java.sql.Connection;
////import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Statement;
//
//import com.carmanagement.connection.GetJDBCConnection;
//import com.carmanagement.entity.Customer;
//
//
//public class JdbcOperations {
//
//	public boolean addCustomer(Customer c) {
//		
//		 try {
//	            // Establishing connection
//	            Connection conn = GetJDBCConnection.getConnection() ;
//	            Statement stmt = conn.createStatement();
//
//	            String name = c.getName();
//	            String password = c.getPassword();
//	            String email = c.getEmail();
//	          
//	            // SQL query to create a table
//	            String sql = "INSERT INTO customers(name, password, email) values("+name + ","+ password+"," + email+ ")";
//
//	            // Executing the query
//	            stmt.executeUpdate(sql);
//	            
//	            System.out.println("customer created successfully!");
//
//	            // Closing resources
//	            stmt.close();
//	            conn.close();
//	            return true;
//	        } catch (SQLException e) {
//	            e.printStackTrace();
//	            return false;
//	        }
//		
//	}
//}
//

package com.carmanagement.DBoperations;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.*;
import com.carmanagement.connection.GetJDBCConnection;
import com.carmanagement.entity.Admin;
import com.carmanagement.entity.Customer;

public class JdbcOperations {

    public boolean addCustomer(Customer c) {
        String sql = "INSERT INTO customers(name, password, email) VALUES (?, ?, ?)";

        try {
            // Establishing connection
            Connection conn = GetJDBCConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            // Setting parameters
            pstmt.setString(1, c.getName());
            pstmt.setString(2, c.getPassword());
            pstmt.setString(3, c.getEmail());

            // Executing the query
            int rowsInserted = pstmt.executeUpdate();
                        
            // Closing resources
            pstmt.close();
            conn.close();

            if (rowsInserted > 0) {
                System.out.println("Customer created successfully!");
                return true;
            } else {
                System.out.println("Failed to create customer.");
                return false;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

//    public boolean addAdmin(Admin a) {
//        String sql = "INSERT INTO admins(name, password, email, company_name, address) VALUES (?, ?, ?, ?, ?)";
//
//        try {
//            // Establishing connection
//            Connection conn = GetJDBCConnection.getConnection();
//            PreparedStatement pstmt = conn.prepareStatement(sql);
//
//            // Setting parameters
//            pstmt.setString(1, a.getName());
//            pstmt.setString(2, a.getPassword());
//            pstmt.setString(3, a.getEmail());
//            pstmt.setString(4, a.getCompany_name());
//            pstmt.setString(5, a.getAddress());
//
//            // Executing the query
//            int rowsInserted = pstmt.executeUpdate();
//            
//
//            // Closing resources
//            pstmt.close();
//            conn.close();
//
//            if (rowsInserted > 0) {
//                System.out.println("Admin created successfully!");
//                return true;
//            } else {
//                System.out.println("Failed to create Admin.");
//                return false;
//            }
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }

    
//    import java.sql.*;
//    import javax.servlet.http.Cookie;
//    import javax.servlet.http.HttpServletResponse;
//    import javax.servlet.http.HttpSession;

    public int addAdmin(Admin a) {
        String sql = "INSERT INTO admins(name, password, email, company_name, address) VALUES (?, ?, ?, ?, ?)";
        String fetchIdQuery = "SELECT LAST_INSERT_ID()"; // Get last inserted admin_id

        try {
            // Establishing connection
            Connection conn = GetJDBCConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            // Setting parameters
            pstmt.setString(1, a.getName());
            pstmt.setString(2, a.getPassword());
            pstmt.setString(3, a.getEmail());
            pstmt.setString(4, a.getCompany_name());
            pstmt.setString(5, a.getAddress());

            // Executing the query
            int rowsInserted = pstmt.executeUpdate();

            if (rowsInserted > 0) {
                // Retrieve generated admin_id
                ResultSet rs = pstmt.getGeneratedKeys();
                int adminId = -1;
                if (rs.next()) {
                    adminId = rs.getInt(1);
                }

                // Close resources
                rs.close();
                pstmt.close();
                conn.close();

                System.out.println("Admin created successfully! Admin ID: " + adminId);
                return adminId;
            } else {
                System.out.println("Failed to create Admin.");
                return 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }


}

