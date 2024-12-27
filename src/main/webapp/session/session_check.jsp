<% 
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("../pages/login.jsp?error=login_required");
        return;
    }
%>
