<%@ include file="../session/session_check.jsp" %>
<%@ page import="java.sql.*" %>
<%@ include file="../db.jsp" %>
<%
    String carId = request.getParameter("car_id");
    String userId = request.getParameter("user_id");
    String transactionDate = request.getParameter("transaction_date");

    String message = "";
    try {
        PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO Transactions (car_id, user_id, transaction_date) VALUES (?, ?, ?)"
        );
        ps.setInt(1, Integer.parseInt(carId));
        ps.setInt(2, Integer.parseInt(userId));
        ps.setDate(3, Date.valueOf(transactionDate));
        ps.executeUpdate();

        message = "Transaction added successfully!";
    } catch (Exception e) {
        message = "Error: " + e.getMessage();
    }
%>
<script>
    alert("<%= message %>");
    window.location.href = "../pages/dashboard.jsp";
</script>
