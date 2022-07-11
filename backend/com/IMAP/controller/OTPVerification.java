package com.IMAP.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class OTPVerification extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public OTPVerification() {
        super();
        
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().println("Verified!");
		String txt1= request.getParameter("txt1");
		String txt2= request.getParameter("txt2");
		String txt3= request.getParameter("txt3");
		String txt4= request.getParameter("txt4");
		String otp= txt1+txt2+txt3+txt4;
		HttpSession session = request.getSession();
		if(session.getAttribute("otp").equals(otp))
		{
			response.sendRedirect("newpassword");
		}
		else
		{
			response.sendRedirect("forgotpassword");
		}
	}

}
