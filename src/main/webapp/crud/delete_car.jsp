<%@ page import="java.sql.*" %>
<%@ include file="../db.jsp" %>
<%
    String id = request.getParameter("id");

    if (id != null) {
        try {
            // Validasi input untuk menghindari SQL injection
            int carId = Integer.parseInt(id);

            // Periksa apakah ada data terkait di tabel `transactions`
            PreparedStatement psCheck = conn.prepareStatement("SELECT COUNT(*) FROM transactions WHERE car_id = ?");
            psCheck.setInt(1, carId);
            ResultSet rs = psCheck.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                // Jika ada data terkait, hapus terlebih dahulu dari tabel `transactions`
                PreparedStatement psDeleteTransactions = conn.prepareStatement("DELETE FROM transactions WHERE car_id = ?");
                psDeleteTransactions.setInt(1, carId);
                psDeleteTransactions.executeUpdate();
            }

            // Setelah data terkait dihapus, hapus data di tabel `cars`
            PreparedStatement psDeleteCars = conn.prepareStatement("DELETE FROM cars WHERE car_id = ?");
            psDeleteCars.setInt(1, carId);
            int rowsAffected = psDeleteCars.executeUpdate();

            if (rowsAffected > 0) {
                out.println("<p>Car deleted successfully!</p>");
            } else {
                out.println("<p>Error: No car found with ID " + carId + "</p>");
            }

            // Redirect kembali ke halaman dashboard setelah penghapusan
            response.sendRedirect("../pages/dashboard.jsp");

        } catch (NumberFormatException e) {
            out.println("<p>Error: Invalid car ID format. Please provide a valid numeric ID.</p>");
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>Error: Missing 'id' parameter in the URL.</p>");
    }
%>
