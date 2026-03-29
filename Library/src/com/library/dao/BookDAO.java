package com.library.dao;

import com.library.model.Book;
import com.library.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

  public List<Book> getAllBooks() {
    List<Book> books = new ArrayList<>();
    try (Connection conn = DBConnection.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM books ORDER BY id DESC")) {

      while (rs.next()) {
        books.add(mapResultSetToBook(rs));
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return books;
  }

  public boolean addBook(Book book) {
    String sql = "INSERT INTO books (title, author, category, quantity, available) VALUES (?, ?, ?, ?, ?)";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql)) {

      ps.setString(1, book.getTitle());
      ps.setString(2, book.getAuthor());
      ps.setString(3, book.getCategory());
      ps.setInt(4, book.getQuantity());
      ps.setInt(5, book.getQuantity()); // Initially available = quantity

      return ps.executeUpdate() > 0;
    } catch (SQLException e) {
      e.printStackTrace();
      return false;
    }
  }

  public boolean deleteBook(int id) {
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement("DELETE FROM books WHERE id=?")) {
      ps.setInt(1, id);
      return ps.executeUpdate() > 0;
    } catch (SQLException e) {
      e.printStackTrace();
      return false;
    }
  }

  public Book getBookById(int id) {
    Book book = null;
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM books WHERE id=?")) {
      ps.setInt(1, id);
      ResultSet rs = ps.executeQuery();
      if (rs.next()) {
        book = mapResultSetToBook(rs);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return book;
  }

  public boolean updateBook(Book book) {
    // Note: Logic to update available copies if quantity changes requires more
    // care.
    // For simplicity, we assume generic updates here.
    String sql = "UPDATE books SET title=?, author=?, category=?, quantity=? WHERE id=?";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql)) {

      ps.setString(1, book.getTitle());
      ps.setString(2, book.getAuthor());
      ps.setString(3, book.getCategory());
      ps.setInt(4, book.getQuantity());
      ps.setInt(5, book.getId());

      return ps.executeUpdate() > 0;
    } catch (SQLException e) {
      e.printStackTrace();
      return false;
    }
  }

  private Book mapResultSetToBook(ResultSet rs) throws SQLException {
    Book book = new Book();
    book.setId(rs.getInt("id"));
    book.setTitle(rs.getString("title"));
    book.setAuthor(rs.getString("author"));
    book.setCategory(rs.getString("category"));
    book.setQuantity(rs.getInt("quantity"));
    book.setAvailable(rs.getInt("available"));
    return book;
  }
}
