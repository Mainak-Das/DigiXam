package com.IMAP.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.IMAP.DAO.DatabaseDAO;
import com.IMAP.model.User;
import com.IMAP.required.RandomUsername;
import com.IMAP.required.SendMail;

public class RegistrationController extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
    public RegistrationController() {
        super();
        
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String role =request.getParameter("role");
		String name =request.getParameter("name");
		String email =request.getParameter("email");
		String password =request.getParameter("password");
		if(password == null)
		{
			password = new RandomUsername().generateUsername(6);
		}
		String username = name.split(" ", 2)[0].toLowerCase()+new RandomUsername().generateUsername(3);
		User u= new User();
		u.setRole(role);
		u.setName(name);
		u.setUsername(username);
		u.setEmail(email);
		u.setPassword(password);
		//out.println(u.getUsername());
		DatabaseDAO dao;
		try {
			dao = new DatabaseDAO();
			dao.registration(u);
			new SendMail().registrationMail(u);
			HttpSession session= request.getSession();
			session.setAttribute("username", u.getUsername());
			session.setAttribute("email", u.getEmail());
			response.sendRedirect("home");
		} catch (SQLException e) {
			e.printStackTrace();		
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}	
	}
}

