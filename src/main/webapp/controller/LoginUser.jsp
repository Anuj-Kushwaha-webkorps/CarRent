<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="com.carmanagement.connection.GetJDBCConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // Get form parameters
    String membershipNumber = request.getParameter("membershipNumber");
    String password = request.getParameter("password");
    String userType = request.getParameter("user");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    boolean loginSuccess = false;

    try {
        // Establish a database connection
        conn = GetJDBCConnection.getConnection();

        // Query based on user type
        String sql = userType.equals("admin") ? "SELECT * FROM admins WHERE admin_id = ? And password = ?" : "SELECT * FROM customers WHERE customer_id = ? And password = ?";
        
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, membershipNumber);
        stmt.setString(2, password);
        
        rs = stmt.executeQuery();

        if (rs.next()) {
            loginSuccess = true;

            // Redirect to respective dashboard
            if (userType.equals("admin")) {
                session.setAttribute("admin_id", membershipNumber);
                // Set cookie (7 days)
                Cookie adminCookie = new Cookie("admin_id", membershipNumber);
                adminCookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
                adminCookie.setPath("/"); // Available for entire application
                response.addCookie(adminCookie);

                response.sendRedirect("/CarManagement/View/adminDashboard.jsp");
            } else {
                session.setAttribute("customer_id", membershipNumber);
                // Set cookie (7 days)
                Cookie adminCookie = new Cookie("customer_id", membershipNumber);
                adminCookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
                adminCookie.setPath("/"); // Available for entire application
                response.addCookie(adminCookie);
                response.sendRedirect("/CarManagement/View/customerDashboard.jsp");
            }
        } else {
            response.sendRedirect("login.jsp?error=Invalid+credentials");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("login.jsp?error=Database+error");
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
