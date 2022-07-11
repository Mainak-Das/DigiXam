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
import com.IMAP.model.NewPasswordModel;
import com.IMAP.required.SendMail;

public class NewPasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public NewPasswordController() {
        super();
        
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String password= request.getParameter("password");
		NewPasswordModel npm= new NewPasswordModel();
		npm.setPassword(password);
		HttpSession session = request.getSession();
		npm.setEmail((String)session.getAttribute("email"));
		DatabaseDAO dao;
		try {
			dao = new DatabaseDAO();
			if(dao.isExistPassword(npm))
			{
				session.setAttribute("err", "Please enter another password!");
				response.sendRedirect("newpassword");
			}
			else {
				int i= dao.updatePassword(npm);
				if(i>0)
				{
					new SendMail().passwordChangedMail(npm);
					session.invalidate();
					response.sendRedirect("login");
				}
				else
				{
					response.sendRedirect("newpassword");
				}
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	

}
