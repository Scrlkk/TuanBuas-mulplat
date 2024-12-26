<%@ page import="java.sql.*" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/db_mulplat";
    String dbUser = "root";
    String dbPass = "";
    Connection conn = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
        session.setAttribute("conn", conn);
    } catch (Exception e) {
        out.println("Database Connection Error: " + e.getMessage());
    }
%>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
