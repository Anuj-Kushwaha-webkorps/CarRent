<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="com.carmanagement.connection.GetJDBCConnection" %>
<%@ page contentType="application/json; charset=UTF-8" %>

<%
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    String vehicleId = request.getParameter("vehicle_id");
    JSONArray bookedDates = new JSONArray();

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        conn = GetJDBCConnection.getConnection();

        String sql = "SELECT start_date, end_date FROM bookings WHERE vehicle_id=?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, Integer.parseInt(vehicleId));
        rs = stmt.executeQuery();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        while (rs.next()) {
            java.sql.Date startDate = rs.getDate("start_date");
            java.sql.Date endDate = rs.getDate("end_date");

            if (startDate != null && endDate != null) {
                Calendar cal = Calendar.getInstance();
                cal.setTime(startDate);

                while (!cal.getTime().after(endDate)) {
                    @SuppressWarnings("unchecked")
                    boolean added = bookedDates.add(sdf.format(cal.getTime())); // Suppress warning
                    cal.add(Calendar.DATE, 1);
                }
            }
        }

        // Debugging: Print JSON output to server logs before sending it
        System.out.println("JSON Response: " + bookedDates.toJSONString());

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }

    // Ensure proper JSON formatting in output
    out.print(bookedDates.toJSONString());
    out.flush();  // Ensure no extra whitespace is added
%>
