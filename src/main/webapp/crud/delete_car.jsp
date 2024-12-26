<%@ include file="../db.jsp" %>
<%
    String id = request.getParameter("id");

    if (id != null) {
        try {
            // Query untuk menghapus mobil berdasarkan ID
            PreparedStatement ps = conn.prepareStatement("DELETE FROM Cars WHERE car_id = ?");
            ps.setInt(1, Integer.parseInt(id));
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                out.println("<p>Car deleted successfully!</p>");
            } else {
                out.println("<p>Error: No car found with ID " + id + "</p>");
            }

            // Redirect kembali ke dashboard setelah penghapusan
            response.sendRedirect("../pages/dashboard.jsp");
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>Error: Missing 'id' parameter in the URL.</p>");
    }
%>