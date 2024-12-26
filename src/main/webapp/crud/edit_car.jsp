<%@ include file="../db.jsp" %>
<%
    String id = request.getParameter("id");
    String brand = "";
    String model = "";
    int year = 0;
    double price = 0.0;

    if (id != null) {
        try {
            // Query untuk mendapatkan data mobil berdasarkan ID
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Cars WHERE car_id = ?");
            ps.setInt(1, Integer.parseInt(id));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                brand = rs.getString("brand");
                model = rs.getString("model");
                year = rs.getInt("year");
                price = rs.getDouble("price");
            } else {
                out.println("<p>Car not found for ID: " + id + "</p>");
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
%>

<div class="h-screen flex items-center">
    <div class="container mx-auto p-8 bg-gray-50 rounded-lg shadow-lg max-w-md">
        <h1 class="text-2xl font-bold text-gray-800 mb-6">Edit Car Details</h1>
        <form method="post" class="space-y-4">
            <div>
                <label for="brand" class="block text-sm font-medium text-gray-700 mb-2">Brand:</label>
                <input type="text" name="brand" id="brand" value="<%= brand %>" required
                    class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
                <label for="model" class="block text-sm font-medium text-gray-700 mb-2">Model:</label>
                <input type="text" name="model" id="model" value="<%= model %>" required
                    class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
                <label for="year" class="block text-sm font-medium text-gray-700 mb-2">Year:</label>
                <input type="number" name="year" id="year" value="<%= year %>" required
                    class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
                <label for="price" class="block text-sm font-medium text-gray-700 mb-2">Price:</label>
                <input type="number" step="0.01" name="price" id="price" value="<%= price %>" required
                    class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <input type="hidden" name="id" value="<%= id %>" />
            <button type="submit"
                class="w-full bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 focus:ring-2 focus:ring-blue-500">
                Save Changes
            </button>
        </form>
    </div>
</div>

<%
    // Menangani pembaruan data
    String newBrand = request.getParameter("brand");
    String newModel = request.getParameter("model");
    String newYear = request.getParameter("year");
    String newPrice = request.getParameter("price");

    if (newBrand != null && newModel != null && newYear != null && newPrice != null) {
        try {
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE Cars SET brand = ?, model = ?, year = ?, price = ? WHERE car_id = ?"
            );
            ps.setString(1, newBrand);
            ps.setString(2, newModel);
            ps.setInt(3, Integer.parseInt(newYear));
            ps.setDouble(4, Double.parseDouble(newPrice));
            ps.setInt(5, Integer.parseInt(id));
            ps.executeUpdate();

            out.println("<p>Car updated successfully!</p>");
            response.sendRedirect("../pages/dashboard.jsp");
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
%>
