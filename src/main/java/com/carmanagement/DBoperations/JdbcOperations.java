
package com.carmanagement.DBoperations;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import com.carmanagement.connection.GetJDBCConnection;
import com.carmanagement.entity.Admin;
import com.carmanagement.entity.Customer;
import com.carmanagement.entity.Vehicle;

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

    public boolean addVehicle(Vehicle v) {
        String sql = "INSERT INTO vehicles (Vehicle_name, Brand, Model, Rental_price_per_hr, Availability, Fuel_type, Admin_id) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            // Establishing connection
            Connection conn = GetJDBCConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            // Setting parameters
            pstmt.setString(1, v.getName());
            pstmt.setString(2, v.getBrand());
            pstmt.setString(3, v.getModel());
            pstmt.setInt(4, v.getRental_price_per_hr());  // Using BigDecimal for precision
            pstmt.setString(5, v.getAvailability());
            pstmt.setString(6, v.getFuel_type());
            pstmt.setInt(7, v.getAdmin_id());

            // Executing the query
            int rowsInserted = pstmt.executeUpdate();

            // Closing resources
            pstmt.close();
            conn.close();

            if (rowsInserted > 0) {
                System.out.println("Vehicle added successfully!");
                return true;
            } else {
                System.out.println("Failed to add vehicle.");
                return false;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Vehicle> getAllVehicles(int adminId) {
        List<Vehicle> vehicleList = new ArrayList<>();

        
        if (adminId != -1) {
            // Fetch vehicles based on admin_id from the database
            try (Connection connection = GetJDBCConnection.getConnection()) {
                String query = "SELECT * FROM vehicles WHERE admin_id = ?";
                try (PreparedStatement ps = connection.prepareStatement(query)) {
                    ps.setInt(1, adminId);
                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            Vehicle vehicle = new Vehicle();
                            vehicle.setName(rs.getString("Vehicle_name"));
                            vehicle.setBrand(rs.getString("Brand"));
                            vehicle.setModel(rs.getString("Model"));
                            vehicle.setRental_price_per_hr(rs.getInt("Rental_price_per_hr"));
                            vehicle.setFuel_type(rs.getString("Fuel_type"));
                            vehicle.setAvailability(rs.getString("Availability"));
                            vehicle.setVehicle_id(rs.getInt("Vehicle_id"));
                            vehicleList.add(vehicle);
                        }
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return vehicleList;
    }

    public boolean editVehicle(Vehicle v) {
    	String sql = "UPDATE vehicles SET Vehicle_name = ?, Brand = ?, Model = ?, Rental_price_per_hr = ?, Availability = ?, Fuel_type = ?, Admin_id = ? WHERE Vehicle_id = ?";

         try {
             // Establishing connection
             Connection conn = GetJDBCConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);

             // Setting parameters
             pstmt.setString(1, v.getName());
             pstmt.setString(2, v.getBrand());
             pstmt.setString(3, v.getModel());
             pstmt.setInt(4, v.getRental_price_per_hr());  // Using BigDecimal for precision
             pstmt.setString(5, v.getAvailability());
             pstmt.setString(6, v.getFuel_type());
             pstmt.setInt(7, v.getAdmin_id());
             pstmt.setInt(8, v.getVehicle_id()); // This is the 8th parameter for WHERE condition


             // Executing the query
             int rowsInserted = pstmt.executeUpdate();

             // Closing resources
             pstmt.close();
             conn.close();

             if (rowsInserted > 0) {
                 System.out.println("Vehicle updated successfully!");
                 return true;
             } else {
                 System.out.println("Failed to update vehicle.");
                 return false;
             }

         } catch (SQLException e) {
             e.printStackTrace();
             return false;
         }
    }

    public  void sendEmail(  String to, String subject, String msg) {
		// TODO Auto-generated method stub
		//variable for gmail host
		String host = "smtp.gmail.com";
		String from="anuj.k@webkorps.com";
		//get the system properties
		Properties properties = System.getProperties();
		System.out.println("Properties:" + properties);
		
		//set host
		properties.put("mail.smtp.host", host);
		properties.put("mail.smtp.port", "587");
		properties.put("mail.smtp.starttls.enable","true");
		properties.put("mail.smtp.auth", "true");
		properties.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
		
		//step1 : to get session object
		Session session = Session.getInstance(properties, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				// TODO Auto-generated method stub
				return new PasswordAuthentication(from, "alupwdjlusmalfqy");
			}
			
			
		} );
		
		session.setDebug(true);
		MimeMessage m = new MimeMessage(session);
		try {
		//from email
	
		m.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
		m.setFrom(new InternetAddress(from));
			
		
		m.setSubject(subject);
		
//		String msg = "This is Confirnation message for you \n you are successfully registered to our Library Application your id is "+id+"and password is "+password;
		
		m.setText(msg);
		
		Transport.send(m);
	
		System.out.println("sent...");
		
		
		
		
		}catch(Exception e) {
			e.printStackTrace();
		}
		
    }	
	

//    public void sendEmail(String to, String subject, String messageText) {
//        // Sender's email credentials
//        final String from = "anuj.k@webkorps.com";  // Update sender email
//        final String password = "ndxqebxabkxjoogv"; // Use App Password if using Gmail/Outlook
//
//        // SMTP server details
//        String host = "smtp.gmail.com";  // Change if using a different mail server (e.g., Outlook, Zoho)
//        
//        // Setup mail server properties
//        Properties properties = new Properties();
//        properties.put("mail.smtp.auth", "true");
//        properties.put("mail.smtp.starttls.enable", "true");
//        properties.put("mail.smtp.host", host);
//        properties.put("mail.smtp.port", "587");
//        properties.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
//
//        // Get the session object
//        Session session = Session.getInstance(properties, new Authenticator() {
//            protected PasswordAuthentication getPasswordAuthentication() {
//                return new PasswordAuthentication(from, password);
//            }
//        });
//
//        try {
//            // Create message
//            Message message = new MimeMessage(session);
//            message.setFrom(new InternetAddress(from));
//            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
//            message.setSubject(subject);
//            message.setText(messageText);
//
//            // Send message
//            Transport.send(message);
//            System.out.println("Email sent successfully!");
//        } catch (MessagingException e) {
//            e.printStackTrace();
//        }
//    }


}

