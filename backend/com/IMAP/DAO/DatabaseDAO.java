package com.IMAP.DAO;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import com.IMAP.model.Answer;
import com.IMAP.model.AssignedUserDepartmentSubject;
import com.IMAP.model.Department;
import com.IMAP.model.Examination;
import com.IMAP.model.ForgotPasswordModel;
import com.IMAP.model.Marks;
import com.IMAP.model.NewPasswordModel;
import com.IMAP.model.Subject;
import com.IMAP.model.User;
import com.IMAP.model.UserDepartmentSubject;
import com.google.gson.Gson;

public class DatabaseDAO {
	DbConnection dbcon;
	Connection con;

	public DatabaseDAO() throws SQLException {
		super();
		dbcon = new DbConnection();
		con = dbcon.getConnection();
	}

	public void registration(User u) throws SQLException {
		String sql = "INSERT INTO users (role,name,email,username,password,dept_id,class) VALUES (?,?,?,?,md5(?),?,?)";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, u.getRole());
		st.setString(2, u.getName());
		st.setString(3, u.getEmail());
		st.setString(4, u.getUsername());
		st.setString(5, u.getPassword());
		st.setInt(6, u.getDept());
		st.setString(7, u.getYear());
		int i = st.executeUpdate();
		System.out.println(i + " row inserted succesfully.");

	}

	public boolean login(User u) throws SQLException {
		String sql = "SELECT * FROM users WHERE (email=? OR username=?) AND password=md5(?)";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, u.getEmail());
		st.setString(2, u.getUsername());
		st.setString(3, u.getPassword());
		ResultSet rs = st.executeQuery();
		if (rs.next())
			return true;
		else
			return false;
	}

	public boolean isExistEmail(ForgotPasswordModel fpm) throws SQLException {
		String sql = "SELECT * FROM users WHERE email=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, fpm.getEmail());
		ResultSet rs = st.executeQuery();
		if (rs.next())
			return true;
		else
			return false;
	}

	public int updatePassword(NewPasswordModel npm) throws SQLException {
		String sql = "UPDATE users set password=md5(?) where email=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, npm.getPassword());
		st.setString(2, npm.getEmail());
		int i = st.executeUpdate();
		System.out.println(i + " row updated succesfully.");
		return i;
	}

	public boolean isExistPassword(NewPasswordModel npm) throws SQLException {
		String sql = "SELECT * FROM users WHERE email=? and password=md5(?)";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, npm.getEmail());
		st.setString(2, npm.getPassword());
		ResultSet rs = st.executeQuery();
		if (rs.next())
			return true;
		else
			return false;
	}

	public int deleteUser(int id) throws SQLException {
		String sql = "DELETE from users where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public int editUser(User u, InputStream is) throws SQLException {
		String sql = "UPDATE users set name = ?, email = ?,profile_img=?, profile_path=?, dept_id=?, class=? where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, u.getName());
		st.setString(2, u.getEmail());
		st.setString(3, u.getProfile_name());
		st.setString(4, u.getProfile_path());
		st.setInt(5, u.getDept());
		st.setString(6, u.getYear());
		st.setInt(7, u.getId());
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public void insertDepartment(Department d) throws SQLException {
		String sql = "INSERT INTO Department (name) VALUES (?)";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, d.getName());
		int i = st.executeUpdate();
		System.out.println(i + " row inserted succesfully.");

	}

	public int deleteDepartment(int id) throws SQLException {
		String sql = "DELETE from department where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public int editDepartment(Department d) throws SQLException {
		String sql = "UPDATE department set name = ? where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, d.getName());
		st.setInt(2, d.getId());
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public void insertSubject(Subject d) throws SQLException {
		String sql = "INSERT INTO subjects (name,year,sem,dept_id) VALUES (?,?,?,?)";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, d.getName());
		st.setString(2, d.getYear());
		st.setString(3, d.getSem());
		st.setInt(4, d.getDept());
		int i = st.executeUpdate();
		System.out.println(i + " row inserted succesfully.");

	}

	public int deleteSubject(int id) throws SQLException {
		String sql = "DELETE from subjects where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public int editSubject(Subject d) throws SQLException {
		String sql = "UPDATE subjects set name = ?,year= ?,sem= ?, dept_id=? where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, d.getName());
		st.setString(2, d.getYear());
		st.setString(3, d.getSem());
		st.setInt(4, d.getDept());
		st.setInt(5, d.getId());
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public void assigned(UserDepartmentSubject uds) throws SQLException {
		String sql = "INSERT INTO user_department_subject (user_id,dept_id,sub_id,year) VALUES (?,?,?,?)";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, uds.getUser_id());
		st.setInt(2, uds.getDept_id());
		st.setInt(3, uds.getSub_id());
		st.setString(4, uds.getYear());
		int i = st.executeUpdate();
		System.out.println(i + " row inserted succesfully.");
	}

	public int deleteAssigned(int id) throws SQLException {
		String sql = "DELETE from user_department_subject where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public int editAssigned(AssignedUserDepartmentSubject uds) throws SQLException {
		String sql = "UPDATE user_department_subject set user_id = ?,dept_id=?,sub_id=?,class=? where id=?";
		PreparedStatement st = con.prepareStatement(sql);

		st.setInt(1, uds.getUser_id());
		st.setInt(2, uds.getDept_id());
		st.setInt(3, uds.getSub_id());
		st.setString(4, uds.getYear());
		st.setInt(5, uds.getId());
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public void insertExam(Examination e, InputStream is) {
		String sql = "INSERT INTO examination (user_id,dept_id,sub_id,qsn_name,question,year,duration,date,time) VALUES (?,?,?,?,?,?,?,?,?)";
		try {

			java.util.Date utilDate = new java.util.Date();
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			java.sql.Time sqlTime = new java.sql.Time(utilDate.getTime());
			PreparedStatement st = con.prepareStatement(sql);
			st.setInt(1, e.getUser_id());
			st.setInt(2, e.getDept_id());
			st.setInt(3, e.getSub_id());

			if (is != null) {
				String j = new Gson().toJson(e.getQsn_name());
				System.out.println(j);
				// Array anArray = con.createArrayOf("VARCHAR", e.getQsn_name());
				st.setString(4, j);
				st.setBinaryStream(5, is, (int) e.getQsn().getSize());

			}
			st.setString(6, e.getYear());
			st.setInt(7, e.getDuration());
			st.setDate(8, sqlDate);
			st.setTime(9, sqlTime);

			int i = st.executeUpdate();
			System.out.println(i + "row inserted for upload table");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public int deleteExamination(int id) throws SQLException {
		String sql = "DELETE from examination where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public int editExamination(Examination e, InputStream is) throws SQLException {
		String sql = "UPDATE examination set user_id = ?,dept_id=?,sub_id=?,qsn_name=?,question=?,year=?,duration=?,date=?,time=? where id=?";
		PreparedStatement st = con.prepareStatement(sql);

		java.util.Date utilDate = new java.util.Date();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
		java.sql.Time sqlTime = new java.sql.Time(utilDate.getTime());

		st.setInt(1, e.getUser_id());
		st.setInt(2, e.getDept_id());
		st.setInt(3, e.getSub_id());
		if (is != null) {
			String j = new Gson().toJson(e.getQsn_name());
			System.out.println(j);
			// Array anArray = con.createArrayOf("VARCHAR", e.getQsn_name());
			st.setString(4, j);
			st.setBinaryStream(5, is, (int) e.getQsn().getSize());

		}
		st.setString(6, e.getYear());
		st.setInt(7, e.getDuration());
		st.setDate(8, sqlDate);
		st.setTime(9, sqlTime);
		st.setInt(10, e.getId());
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return s;
	}

	public String[] getFileName(int id) throws SQLException {
		String sql = "SELECT * FROM examination WHERE id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		ResultSet rs = st.executeQuery();
		if (rs.next()) {
			return new String[] { "true", rs.getString("qsn_name") };
		} else
			return new String[] { "false", null };

	}

	public String[] getAnswer(int id) throws SQLException {
		String sql = "SELECT * FROM answer WHERE id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		ResultSet rs = st.executeQuery();
		if (rs.next()) {
			return new String[] { "true", rs.getString("ans_name") };
		} else
			return new String[] { "false", null };

	}

	public String getSubjectName(int id) throws SQLException {
		String sql = "SELECT * FROM examination as e inner join subjects as s on e.sub_id=s.id WHERE e.id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		ResultSet rs = st.executeQuery();
		if (rs.next()) {
			return rs.getString("s.name");
		} else
			return null;

	}

	public String getAnswerName(int id) throws SQLException {
		String sql = "select* from subjects where id=(SELECT sub_id as sid FROM answer as a inner join examination as e on a.qsn_id=e.id WHERE a.id=?)";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		ResultSet rs = st.executeQuery();
		if (rs.next()) {
			return rs.getString("name");
		} else
			return null;

	}

	public int removeProfile(int id) throws SQLException {
		String sql = "DELETE profile_img,profile_path from users where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public void insertAnswer(Answer e, InputStream is) {
		String sql = "INSERT INTO answer (ans_name,ans,qsn_id,date,time,user_id) VALUES (?,?,?,?,?,?)";
		try {

			java.util.Date utilDate = new java.util.Date();
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			java.sql.Time sqlTime = new java.sql.Time(utilDate.getTime());
			PreparedStatement st = con.prepareStatement(sql);

			if (is != null) {
				String j = new Gson().toJson(e.getAns_name());
				System.out.println(j);
				// Array anArray = con.createArrayOf("VARCHAR", e.getQsn_name());
				st.setString(1, j);
				st.setBinaryStream(2, is, (int) e.getAns().getSize());

			}
			st.setInt(3, e.getFile_id());
			st.setDate(4, sqlDate);
			st.setTime(5, sqlTime);
			st.setInt(6, e.getUser_id());

			int i = st.executeUpdate();
			System.out.println(i + "row inserted for upload table");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public void addMarks(Marks u) throws SQLException {
		String sql = "INSERT INTO marks (ans_id,qsn_id,marks) VALUES (?,?,?)";
		PreparedStatement st = con.prepareStatement(sql);

		st.setInt(1, u.getAid());
		st.setInt(2, u.getEid());
		st.setInt(3, u.getMarks());
		int i = st.executeUpdate();
		System.out.println(i + " row inserted succesfully.");

	}

	public int deleteMarks(int id) throws SQLException {
		String sql = "DELETE from marks where qsn_id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public int editMarks(Marks u) throws SQLException {
		String sql = "UPDATE marks set marks=? where ans_id=? and qsn_id=?,";
		PreparedStatement st = con.prepareStatement(sql);

		st.setInt(1, u.getMarks());
		st.setInt(2, u.getAid());
		st.setInt(3, u.getEid());
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public HashMap<String, ArrayList<String>> getEmails(User u) throws SQLException {
		String sql = "SELECT * FROM users WHERE dept_id=? and class=?";
		PreparedStatement st = con.prepareStatement(sql);
		System.out.println(u.getDept() + u.getYear());
		st.setInt(1, u.getDept());
		st.setString(2, u.getYear());
		ResultSet rs = st.executeQuery();
		// List<String> email = new ArrayList<String>();
		// List<HashMap<String, String>> us = new ArrayList<HashMap<String, String>>();
		// HashMap<String, String> user = new HashMap<String, String>();
		ArrayList<String> em = new ArrayList<String>();
		ArrayList<String> un = new ArrayList<String>();
		ArrayList<String> n = new ArrayList<String>();
		ArrayList<String> p = new ArrayList<String>();
		HashMap<String, ArrayList<String>> user = new HashMap<String, ArrayList<String>>();
		while (rs.next()) {

			System.out.println("email:" + rs.getString("email"));
			// email.add(rs.getString("email"));
			em.add(rs.getString("email"));
			un.add(rs.getString("username"));
			n.add(rs.getString("name"));
			p.add(rs.getString("password"));

		}

		user.put("emails", em);
		user.put("uname", un);
		user.put("name", n);
		user.put("pass", p);
		// System.out.println(email.toString());
		System.out.println(user.toString());
		// return email;
		return user;
	}
}
