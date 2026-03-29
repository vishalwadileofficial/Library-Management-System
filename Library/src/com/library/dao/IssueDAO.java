package com.library.dao;

import com.library.model.IssueRecord;
import com.library.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class IssueDAO {

  public boolean issueBook(IssueRecord record) {
    Connection conn = null;
    PreparedStatement psResolve = null;
    PreparedStatement psInsert = null;
    PreparedStatement psUpdateBook = null;

    try {
      conn = DBConnection.getConnection();
      conn.setAutoCommit(false); // Start Transaction

      // 1. Check if book is available
      psResolve = conn.prepareStatement("SELECT available FROM books WHERE id = ?");
      psResolve.setInt(1, record.getBookId());
      ResultSet rs = psResolve.executeQuery();
      if (rs.next()) {
        int available = rs.getInt("available");
        if (available <= 0) {
          return false; // Book not available
        }
      } else {
        return false; // Book not found
      }

      // 2. Insert Issue Record
      String insertSql = "INSERT INTO issue_records (book_id, student_id, issue_date, return_date, status) VALUES (?, ?, ?, ?, 'ISSUED')";
      psInsert = conn.prepareStatement(insertSql);
      psInsert.setInt(1, record.getBookId());
      psInsert.setInt(2, record.getStudentId());
      psInsert.setDate(3, record.getIssueDate());
      psInsert.setDate(4, record.getReturnDate());
      psInsert.executeUpdate();

      // 3. Decrement Book Availability
      String updateSql = "UPDATE books SET available = available - 1 WHERE id = ?";
      psUpdateBook = conn.prepareStatement(updateSql);
      psUpdateBook.setInt(1, record.getBookId());
      psUpdateBook.executeUpdate();

      conn.commit(); // Commit Transaction
      return true;
    } catch (SQLException e) {
      e.printStackTrace();
      if (conn != null) {
        try {
          conn.rollback();
        } catch (SQLException ex) {
          ex.printStackTrace();
        }
      }
      return false;
    } finally {
      try {
        if (psResolve != null)
          psResolve.close();
      } catch (SQLException e) {
      }
      try {
        if (psInsert != null)
          psInsert.close();
      } catch (SQLException e) {
      }
      try {
        if (psUpdateBook != null)
          psUpdateBook.close();
      } catch (SQLException e) {
      }
      try {
        if (conn != null)
          conn.close();
      } catch (SQLException e) {
      }
    }
  }

  public boolean returnBook(int issueId, Date actualReturnDate, double fine) {
    Connection conn = null;
    PreparedStatement psGetBook = null;
    PreparedStatement psUpdateIssue = null;
    PreparedStatement psUpdateBook = null;

    try {
      conn = DBConnection.getConnection();
      conn.setAutoCommit(false); // Start Transaction

      // 1. Get Book ID from Issue Record
      int bookId = -1;
      psGetBook = conn.prepareStatement("SELECT book_id FROM issue_records WHERE id = ?");
      psGetBook.setInt(1, issueId);
      ResultSet rs = psGetBook.executeQuery();
      if (rs.next()) {
        bookId = rs.getInt("book_id");
      } else {
        return false; // Issue record not found
      }

      // 2. Update Issue Record
      String updateIssueSql = "UPDATE issue_records SET actual_return_date = ?, status = 'RETURNED', fine = ? WHERE id = ?";
      psUpdateIssue = conn.prepareStatement(updateIssueSql);
      psUpdateIssue.setDate(1, actualReturnDate);
      psUpdateIssue.setDouble(2, fine);
      psUpdateIssue.setInt(3, issueId);
      psUpdateIssue.executeUpdate();

      // 3. Increment Book Availability
      String updateBookSql = "UPDATE books SET available = available + 1 WHERE id = ?";
      psUpdateBook = conn.prepareStatement(updateBookSql);
      psUpdateBook.setInt(1, bookId);
      psUpdateBook.executeUpdate();

      conn.commit();
      return true;
    } catch (SQLException e) {
      e.printStackTrace();
      if (conn != null) {
        try {
          conn.rollback();
        } catch (SQLException ex) {
          ex.printStackTrace();
        }
      }
      return false;
    } finally {
      try {
        if (psGetBook != null)
          psGetBook.close();
      } catch (SQLException e) {
      }
      try {
        if (psUpdateIssue != null)
          psUpdateIssue.close();
      } catch (SQLException e) {
      }
      try {
        if (psUpdateBook != null)
          psUpdateBook.close();
      } catch (SQLException e) {
      }
      try {
        if (conn != null)
          conn.close();
      } catch (SQLException e) {
      }
    }
  }

  public List<IssueRecord> getAllIssueRecords() {
    List<IssueRecord> records = new ArrayList<>();
    String sql = "SELECT i.*, b.title, s.name FROM issue_records i " +
        "JOIN books b ON i.book_id = b.id " +
        "JOIN students s ON i.student_id = s.id " +
        "ORDER BY i.issue_date DESC";

    try (Connection conn = DBConnection.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql)) {

      while (rs.next()) {
        IssueRecord rec = new IssueRecord();
        rec.setId(rs.getInt("id"));
        rec.setBookId(rs.getInt("book_id"));
        rec.setStudentId(rs.getInt("student_id"));
        rec.setIssueDate(rs.getDate("issue_date"));
        rec.setReturnDate(rs.getDate("return_date"));
        rec.setActualReturnDate(rs.getDate("actual_return_date"));
        rec.setStatus(rs.getString("status"));
        rec.setFine(rs.getDouble("fine"));

        rec.setBookTitle(rs.getString("title"));
        rec.setStudentName(rs.getString("name"));

        records.add(rec);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return records;
  }
}
