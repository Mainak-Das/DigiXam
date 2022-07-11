package com.IMAP.required;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.IMAP.DAO.DbConnection;

public class UserRole {
	private String role;
	private String sql;
	private String user;

	public String[] getRole(String email, String username) {
		String sql2 = "SELECT role, name FROM users where email = ? OR username = ?";
		try {
			DbConnection dbcon2 = new DbConnection();
			Connection con2 = dbcon2.getConnection();
			PreparedStatement st2 = con2.prepareStatement(sql2);
			st2.setString(1, email);
			st2.setString(2, username);
			ResultSet rs2 = st2.executeQuery();
			if (rs2.next()) {
				role = rs2.getString("role");
				user = rs2.getString("name");
			}
			rs2.close();
			st2.close();
			con2.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new String[] { role, user };
	}
}
