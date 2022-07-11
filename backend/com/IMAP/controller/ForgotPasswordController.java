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
import com.IMAP.model.ForgotPasswordModel;
import com.IMAP.required.RandomUsername;
import com.IMAP.required.SendMail;

public class ForgotPasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public ForgotPasswordController() {
        super();
        
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email= request.getParameter("email");
		ForgotPasswordModel fpm= new ForgotPasswordModel();
		fpm.setEmail(email);
		DatabaseDAO dao;
		try {
			HttpSession session= request.getSession();
			dao = new DatabaseDAO();
			if(dao.isExistEmail(fpm)) {
				try {
						String otp= new RandomUsername().getRandomOTP();
						fpm.setOtp(otp);
						session.setAttribute("email", fpm.getEmail());
						session.setAttribute("otp", fpm.getOtp());
						SendMail sm = new SendMail();
						if(sm.otpMail(fpm))
						{
							response.sendRedirect("otp");
						}
					}
				catch (AddressException e) {
					
					e.printStackTrace();
				} catch (MessagingException e) {
					
					e.printStackTrace();
				}
			}
			else
			{
				session.setAttribute("msg", "Mail ID does not exist!");
				response.sendRedirect("forgotpassword");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	
	}
}
