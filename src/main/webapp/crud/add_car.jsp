<%@ include file="../session/session_check.jsp" %>
<%@ include file="../db.jsp" %>
<%
    String brand = request.getParameter("brand");
    String model = request.getParameter("model");
    String year = request.getParameter("year");
    String price = request.getParameter("price");
    String jumlah = request.getParameter("jumlah");

    if (brand != null) {
        try {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO Cars (brand, model, year, price, jumlah) VALUES (?, ?, ?, ?, ?)");
            ps.setString(1, brand);
            ps.setString(2, model);
            ps.setInt(3, Integer.parseInt(year));
            ps.setDouble(4, Double.parseDouble(price));
            ps.setInt(5,Integer.parseInt(jumlah));
            ps.executeUpdate();
            response.sendRedirect("../pages/dashboard.jsp");
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>
<div class="h-screen flex items-center">
<div class="container mx-auto p-8 bg-gray-50 rounded-lg shadow-lg max-w-md">
    <h1 class="text-2xl font-bold text-gray-800 mb-6">Add New Car</h1>
    <form method="post" class="space-y-4">
        <div>
            <label for="brand" class="block text-sm font-medium text-gray-700 mb-2">Brand:</label>
            <input type="text" name="brand" id="brand" required 
                class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>
        <div>
            <label for="model" class="block text-sm font-medium text-gray-700 mb-2">Model:</label>
            <input type="text" name="model" id="model" required 
                class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>
        <div>
            <label for="year" class="block text-sm font-medium text-gray-700 mb-2">Year:</label>
            <input type="number" name="year" id="year" required 
                class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>
        <div>
            <label for="price" class="block text-sm font-medium text-gray-700 mb-2">Price:</label>
            <input type="number" step="0.01" name="price" id="price" required 
                class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>
        <div>
            <label for="jumlah" class="block text-sm font-medium text-gray-700 mb-2">Jumlah:</label>
            <input type="number" step="0.01" name="jumlah" id="jumlah" required 
                class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>
        <button type="submit" 
            class="w-full bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 focus:ring-2 focus:ring-blue-500">
            Add Car
        </button>
    </form>
</div>
</div>
