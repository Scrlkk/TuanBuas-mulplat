<%@ include file="../db.jsp" %>
<% 
    String error = request.getParameter("error");
    if ("login_required".equals(error)) {
%>
    <script>
        alert("Please log in to access this page.");
    </script>
<% 
    }
%>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (email != null && password != null) {
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Users WHERE email=? AND password=?");
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                session.setAttribute("user", rs.getString("name"));
                response.sendRedirect("dashboard.jsp");
            } else {
                // Tampilkan alert jika email atau password salah
%>
                <script>
                    alert("Invalid email or password!");
                    window.location.href = "login.jsp"; // Redirect ke halaman login
                </script>
<%
            }
        } catch (Exception e) {
            // Tampilkan alert jika terjadi error pada server
%>
            <script>
                alert("Error: <%= e.getMessage() %>");
                window.location.href = "login.jsp"; // Redirect ke halaman login
            </script>
<%
        }
    }
%>


<div class="flex items-center justify-center min-h-screen bg-gray-100">
    <div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4 w-1/4">
        <h2 class="text-2xl font-bold mb-4 text-center">Login</h2>
        <form method="post" class="space-y-4">
            <div>
                <label for="email" class="block text-gray-700 font-bold mb-2">Email:</label>
                <input
                    type="email"
                    id="email"
                    name="email"
                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                    required
                />
            </div>
            <div>
                <label for="password" class="block text-gray-700 font-bold mb-2">Password:</label>
                <input
                    type="password"
                    id="password"
                    name="password"
                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                    required
                />
            </div>
            <div class="flex items-center justify-between">
                <button
                    type="submit"
                    class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
                >
                    Login
                </button>
            </div>
        </form>
    </div>
</div>
