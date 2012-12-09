package com.zerobyte.lifesync.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.zerobyte.lifesync.dataaccess.UserDao;
import com.zerobyte.lifesync.model.User;
 
//Handles core supported URI's for Facebook application
@Controller
@RequestMapping(value = { "/" })
public class DefaultController {
 
	@Autowired
	@Qualifier("userDao")
	UserDao userDao;
	
	//Handles login functionality and returns login page
	@RequestMapping(value = { "/login" })
	public ModelAndView loginPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		ModelAndView modelAndView = new ModelAndView("login");			
		return modelAndView;	
	}
	
	//Handles the redirection of a user with ROLE_USER to schedules page
	// Sends admin (ROLE_ADMIN) to admin page
	@RequestMapping(value = { "/main" })
	public ModelAndView mainPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
			
		User user = getUserFromEmail();
			
		if(user.getAuthority().equals("ROLE_USER"))
			return new ModelAndView("redirect:/schedules");
		else if(user.getAuthority().equals("ROLE_ADMIN"))
			return new ModelAndView("redirect:/adminPage");
			
		return new ModelAndView("login");
	}
	//Handles register functionality and returns register page
	@RequestMapping(value = { "/register" })
	public ModelAndView registerPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		ModelAndView modelAndView = new ModelAndView("register");
		
		return modelAndView;	
	}
	
	//Handles new user creation functionality and returns page with form for user data
	@RequestMapping(value = { "/register/new" })
	public ModelAndView registerNewPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		ModelAndView modelAndView = new ModelAndView();
		
		String password = request.getParameter("password");
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String email = request.getParameter("email");
		
		Map<String,String> userInfo = new HashMap<String,String>();
		userInfo.put(UserDao.CONST_PASSWORD_FIELD, "'" + password + "'");
		userInfo.put(UserDao.CONST_FIRSTNAME_FIELD, "'" + firstname + "'");
		userInfo.put(UserDao.CONST_LASTNAME_FIELD, "'" + lastname + "'");
		userInfo.put(UserDao.CONST_EMAIL_FIELD, "'" + email + "'");
		userInfo.put(UserDao.CONST_AUTHORITY_FIELD, "'ROLE_USER'");
		userInfo.put(UserDao.CONST_ENABLED_FIELD, "1");
		
		if(password.isEmpty() || firstname.isEmpty() || lastname.isEmpty() || email.isEmpty())
			return new ModelAndView("regerror");
		
		//Check if user exists already
		Map<String,String> credentials = new HashMap<String,String>();
		credentials.put(UserDao.CONST_EMAIL_FIELD, "'" + email + "'");
		List<User> users = userDao.retrieveUser(credentials);

		if(users.isEmpty()) {
			try {
				int success = userDao.createUser(userInfo);
				
				if(success == 1)
					modelAndView = new ModelAndView("registerComplete");
				else
					modelAndView = new ModelAndView("regerror");
				
			} catch(Exception e) {
				modelAndView = new ModelAndView("regerror");
			}
		} else {
			modelAndView = new ModelAndView("regerror");
		}
			
		return modelAndView;	
	}
	
	//Handles instance where logging in has failed by returning an error page
	@RequestMapping(value = { "/loginfailed"})
	public ModelAndView loginErrorPage (HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		ModelAndView modelAndView = new ModelAndView("genericMessage");
		modelAndView.addObject("pageTitle", "Error");
		modelAndView.addObject("message", "Your login credentials were not correct. Please try again.");
		return modelAndView;		
		
	}
	
	//Handles logout functionality by directing users back to login page
	@RequestMapping(value = { "/logout"})
	public ModelAndView logoutPage (HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		ModelAndView modelAndView = new ModelAndView("login");
		return modelAndView;		
		
	}
	
	private User getUserFromEmail()
	{
		Map<String,String> filter = new HashMap<String,String>();
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String userEmail = auth.getName(); //get logged in username
	      
		filter.put(UserDao.CONST_EMAIL_FIELD, "'" + userEmail + "'");
		List<User> users = userDao.retrieveUser(filter);
		
		return users.get(0);
	}
}
