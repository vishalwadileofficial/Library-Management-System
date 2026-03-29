package com.library.dao;

import com.library.model.Student;
import com.library.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

  public List<Student> getAllStudents() {
    List<Student> students = new ArrayList<>();
    try (Connection conn = DBConnection.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM students ORDER BY id DESC")) {

      while (rs.next()) {
        students.add(mapResultSetToStudent(rs));
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return students;
  }

  public boolean addStudent(Student student) {
    String sql = "INSERT INTO students (name, email, branch, year) VALUES (?, ?, ?, ?)";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql)) {

      ps.setString(1, student.getName());
      ps.setString(2, student.getEmail());
      ps.setString(3, student.getBranch());
      ps.setInt(4, student.getYear());

      return ps.executeUpdate() > 0;
    } catch (SQLException e) {
      e.printStackTrace();
      return false;
    }
  }

  public boolean deleteStudent(int id) {
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement("DELETE FROM students WHERE id=?")) {
      ps.setInt(1, id);
      return ps.executeUpdate() > 0;
    } catch (SQLException e) {
      e.printStackTrace();
      return false;
    }
  }

  private Student mapResultSetToStudent(ResultSet rs) throws SQLException {
    Student student = new Student();
    student.setId(rs.getInt("id"));
    student.setName(rs.getString("name"));
    student.setEmail(rs.getString("email"));
    student.setBranch(rs.getString("branch"));
    student.setYear(rs.getInt("year"));
    return student;
  }
}
