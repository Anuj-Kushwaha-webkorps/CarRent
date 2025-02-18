package com.carmanagement.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GetJDBCConnection{
  public static Connection getConnection() {
	// Database connection details
      String url = "jdbc:mysql://localhost:3306/carrent";
      String user = "root"; 
      String password = "12345"; 
      
      
	  try {
		  Class.forName("com.mysql.cj.jdbc.Driver");
		  Connection connection=DriverManager.getConnection(url, user,password);
		  return connection;
	  }
	  catch(SQLException | ClassNotFoundException  exc) {
		  exc.printStackTrace();
		  return null;
	  }
  }
}
