<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.carmanagement.connection.GetJDBCConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin List</title>
    <link rel="stylesheet" href="styles.css"> <!-- Link to external CSS file -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(230deg, rgba(11, 141, 234, 0.469), rgba(227, 19, 126, 0.403));
            margin: 0;
            padding: 0;
        }
        h2 {
            text-align: center;
            margin-top: 20px;
        }
        .admin-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            padding: 20px;
        }
        .admin-card {
            width: 320px;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }
        .admin-card h3 {
            margin: 10px 0;
            color: #333;
        }
        .admin-card p {
            margin: 5px 0;
            color: #555;
        }
        .hidden {
            display: none;
        }
        .view-btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            margin-top: 10px;
        }
        .view-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<h2>Admin List</h2>

<div class="admin-container">
<%

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
       
        conn = GetJDBCConnection.getConnection();

        // Fetch all admins from the database
        String sql = "SELECT admin_id, name, email, company_name, address FROM admins";
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();

        while (rs.next()) {
            int adminId = rs.getInt("admin_id");
            String name = rs.getString("name");
            String email = rs.getString("email");
            String companyName = rs.getString("company_name");
            String address = rs.getString("address");
%>
            <div class="admin-card">
                <input type="hidden" class="hidden" value="<%= adminId %>" /> <!-- Hidden Admin ID -->
                <h3><%= name %></h3>
                <p><strong>Email:</strong> <%= email %></p>
                <p><strong>Company:</strong> <%= companyName %></p>
                <p><strong>Address:</strong> <%= address %></p>
                <a href="/CarManagement/controller/ViewAdminVehicleForBooking.jsp?admin_id=<%= adminId %>" class="view-btn">View Vehicles</a>
            </div>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</div>

</body>
</html>
