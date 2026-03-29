<%@ page import="com.library.util.DBConnection" %>
  <%@ page import="java.sql.*" %>
    <%@ include file="includes/header.jsp" %>
      <%@ include file="includes/sidebar.jsp" %>

        <% if (session.getAttribute("admin")==null) { response.sendRedirect("login.jsp"); return; } %>

          <div class="main-content">
            <div class="header">
              <h1>Dashboard</h1>
              <span>Welcome, <%= ((com.library.model.Admin)session.getAttribute("admin")).getName() %></span>
            </div>

            <% int totalBooks=0; int totalStudents=0; int issuedBooks=0; double totalFines=0.0; try (Connection
              conn=DBConnection.getConnection()) { Statement stmt=conn.createStatement(); ResultSet
              rs1=stmt.executeQuery("SELECT COUNT(*) FROM books"); if (rs1.next()) totalBooks=rs1.getInt(1); ResultSet
              rs2=stmt.executeQuery("SELECT COUNT(*) FROM students"); if (rs2.next()) totalStudents=rs2.getInt(1);
              ResultSet rs3=stmt.executeQuery("SELECT COUNT(*) FROM issue_records WHERE status='ISSUED'");
            if (rs3.next()) issuedBooks = rs3.getInt(1);
            
            ResultSet rs4 = stmt.executeQuery(" SELECT SUM(fine) FROM issue_records"); if (rs4.next())
              totalFines=rs4.getDouble(1); } catch (Exception e) { e.printStackTrace(); } %>

              <div class="cards-container">
                <div class="card">
                  <h3>Total Books</h3>
                  <p>
                    <%= totalBooks %>
                  </p>
                </div>
                <div class="card">
                  <h3>Registered Students</h3>
                  <p>
                    <%= totalStudents %>
                  </p>
                </div>
                <div class="card">
                  <h3>Currently Issued</h3>
                  <p>
                    <%= issuedBooks %>
                  </p>
                </div>
                <div class="card">
                  <h3>Fines Collected</h3>
                  <p>$<%= totalFines %>
                  </p>
                </div>
              </div>

          </div>

          <%@ include file="includes/footer.jsp" %>