<%@ page import="java.sql.*" %>
<%@ include file="../db.jsp" %>
<%
    String transactionId = request.getParameter("id");
    String message = "";

    try {
        PreparedStatement ps = conn.prepareStatement("DELETE FROM Transactions WHERE transactions_id = ?");
        ps.setInt(1, Integer.parseInt(transactionId));
        int rowsDeleted = ps.executeUpdate();

        if (rowsDeleted > 0) {
            message = "Transaction deleted successfully!";
        } else {
            message = "Transaction not found!";
        }
    } catch (Exception e) {
        message = "Error: " + e.getMessage();
    }
%>
<script>
    alert("<%= message %>");
    window.location.href = "../pages/dashboard.jsp"; // Redirect back to dashboard
</script>
