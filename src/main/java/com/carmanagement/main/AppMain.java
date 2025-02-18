package com.carmanagement.main;

import com.carmanagement.connection.GetJDBCConnection;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
//import java.sql.PreparedStatement;


public class AppMain {
	
	    public static void main(String[] args) {
	        

	        try {
	            // Establishing connection
	            Connection conn = GetJDBCConnection.getConnection() ;
	            Statement stmt = conn.createStatement();

	            // SQL query to create a table
	            String sql = "select * from customers";

	            // Executing the query
	            ResultSet rs = stmt.executeQuery(sql);
	            
	            while(rs.next()) {
	        		System.out.println(rs.getInt("customer_id"));
	        	}
	            System.out.println("Table 'Employees' created successfully!");

	            // Closing resources
	            stmt.close();
	            conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

}
