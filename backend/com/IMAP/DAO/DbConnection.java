package com.IMAP.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {
	private String url = "jdbc:mysql://localhost:3306/digixam";
	private String user = "root";
	private String password = "SQLPassword";

	public Connection getConnection() throws SQLException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection mycon = DriverManager.getConnection(url, user, password);
			if (mycon == null) {
				System.out.println("Not Connected!!!");
				return null;
			} else {
				System.out.println("Connected...");
				return mycon;
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}
}
