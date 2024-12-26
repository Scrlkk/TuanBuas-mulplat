<%@ page import="java.sql.*" %>
<%@ include file="../db.jsp" %>
<div class="container mx-auto p-8 bg-gray-50 rounded-lg shadow-lg">
    <h1 class="text-3xl font-bold mb-6 text-gray-800">Welcome, <%= session.getAttribute("user") %></h1>
    <div class="flex justify-between mb-8">
        <a href="../crud/add_car.jsp" class="bg-blue-600 text-white px-6 py-3 rounded hover:bg-blue-700">Add New Car</a>
        <a href="logout.jsp" class="bg-red-600 text-white px-6 py-3 rounded hover:bg-red-700">Logout</a>
    </div>

    <!-- Transaction History Section -->
    <h2 class="text-2xl font-semibold mb-4 text-gray-700">Transaction History</h2>
    <div class="overflow-x-auto">
        <table class="table-auto w-full border-collapse border border-gray-300 bg-white rounded-lg text-left">
            <thead>
                <tr class="bg-gray-200">
                    <th class="border border-gray-300 px-6 py-4 text-gray-700">Transaction ID</th>
                    <th class="border border-gray-300 px-6 py-4 text-gray-700">Car Brand</th>
                    <th class="border border-gray-300 px-6 py-4 text-gray-700">User Name</th>
                    <th class="border border-gray-300 px-6 py-4 text-gray-700">Transaction Date</th>
                    <th class="border border-gray-300 px-6 py-4 text-gray-700">Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        PreparedStatement ps = conn.prepareStatement(
                            "SELECT t.transactions_id, c.brand, u.name, t.transaction_date " +
                            "FROM Transactions t " +
                            "JOIN Cars c ON t.car_id = c.car_id " +
                            "JOIN Users u ON t.user_id = u.user_id"
                        );
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                %>
                <tr>
                    <td class="border border-gray-300 px-6 py-4"><%= rs.getInt("transactions_id") %></td>
                    <td class="border border-gray-300 px-6 py-4"><%= rs.getString("brand") %></td>
                    <td class="border border-gray-300 px-6 py-4"><%= rs.getString("name") %></td>
                    <td class="border border-gray-300 px-6 py-4"><%= rs.getDate("transaction_date") %></td>
                    <td class="border border-gray-300 px-6 py-4">
                        <a href="../crud/delete_transaction.jsp?id=<%= rs.getInt("transactions_id") %>" 
                           class="text-red-500 underline hover:text-red-700"
                           onclick="return confirm('Are you sure you want to delete this transaction?')">
                            Delete
                        </a>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='5' class='border border-gray-300 px-6 py-4 text-red-500'>Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>

    <h3 class="text-lg font-semibold mt-8 mb-4 text-gray-700">Add New Transaction</h3>
    <form action="../crud/add_transaction.jsp" method="POST" class="space-y-6 bg-white p-6 rounded-lg shadow-md">
        <div>
            <label for="car_id" class="block font-medium text-gray-700 mb-2">Car:</label>
            <select name="car_id" id="car_id" class="w-full border border-gray-300 rounded px-3 py-2">
                <%
                    try {
                        PreparedStatement ps = conn.prepareStatement("SELECT car_id, brand, model FROM Cars");
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                %>
                <option value="<%= rs.getInt("car_id") %>">
                    <%= rs.getString("brand") %> <%= rs.getString("model") %>
                </option>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<option>Error: " + e.getMessage() + "</option>");
                    }
                %>
            </select>
        </div>

        <div>
            <label for="user_id" class="block font-medium text-gray-700 mb-2">User:</label>
            <select name="user_id" id="user_id" class="w-full border border-gray-300 rounded px-3 py-2">
                <%
                    try {
                        PreparedStatement ps = conn.prepareStatement("SELECT user_id, name FROM Users");
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                %>
                <option value="<%= rs.getInt("user_id") %>">
                    <%= rs.getString("name") %>
                </option>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<option>Error: " + e.getMessage() + "</option>");
                    }
                %>
            </select>
        </div>

        <div>
            <label for="transaction_date" class="block font-medium text-gray-700 mb-2">Transaction Date:</label>
            <input type="date" id="transaction_date" name="transaction_date" required class="w-full border border-gray-300 rounded px-3 py-2">
        </div>

        <button type="submit" class="bg-green-600 text-white px-6 py-3 rounded hover:bg-green-700">Add Transaction</button>
    </form>

    <!-- Car List Section -->
    <h2 class="text-2xl font-semibold mt-8 mb-4 text-gray-700">Car List</h2>
    <div class="overflow-x-auto">
        <table class="table-auto w-full border-collapse border border-gray-300 bg-white rounded-lg text-left">
            <thead>
                <tr class="bg-gray-200">
                    <th class="border border-gray-300 px-6 py-4 text-gray-700">Brand</th>
                    <th class="border border-gray-300 px-6 py-4 text-gray-700">Model</th>
                    <th class="border border-gray-300 px-6 py-4 text-gray-700">Year</th>
                    <th class="border border-gray-300 px-6 py-4 text-gray-700">Price</th>
                    <th class="border border-gray-300 px-6 py-4 text-gray-700">Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        PreparedStatement ps = conn.prepareStatement("SELECT * FROM Cars");
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                %>
                <tr>
                    <td class="border border-gray-300 px-6 py-4"><%= rs.getString("brand") %></td>
                    <td class="border border-gray-300 px-6 py-4"><%= rs.getString("model") %></td>
                    <td class="border border-gray-300 px-6 py-4"><%= rs.getInt("year") %></td>
                    <td class="border border-gray-300 px-6 py-4">$<%= rs.getDouble("price") %></td>
                    <td class="border border-gray-300 px-6 py-4">
                        <a href="../crud/edit_car.jsp?id=<%= rs.getInt("car_id") %>" class="text-blue-500 underline hover:text-blue-700">Edit</a> | 
                        <a href="../crud/delete_car.jsp?id=<%= rs.getInt("car_id") %>" class="text-red-500 underline hover:text-red-700" onclick="return confirm('Are you sure you want to delete this car?')">Delete</a>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='5' class='border border-gray-300 px-6 py-4 text-red-500'>Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>
</div>
