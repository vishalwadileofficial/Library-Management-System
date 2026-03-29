<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <nav class="sidebar">
    <div class="sidebar-header">
      <h3>LMS Admin</h3>
    </div>
    <ul class="sidebar-menu">
      <li><a href="${pageContext.request.contextPath}/dashboard.jsp"><span>Dashboard</span></a></li>
      <li><a href="${pageContext.request.contextPath}/BookServlet"><span>Books</span></a></li>
      <li><a href="${pageContext.request.contextPath}/StudentServlet"><span>Students</span></a></li>
      <li><a href="${pageContext.request.contextPath}/IssueServlet"><span>Issued Books</span></a></li>
      <li><a href="${pageContext.request.contextPath}/LoginServlet?action=logout"><span>Logout</span></a></li>
    </ul>
  </nav>