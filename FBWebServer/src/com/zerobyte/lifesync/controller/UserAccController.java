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
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.zerobyte.lifesync.dataaccess.UserDao;
import com.zerobyte.lifesync.model.Event;
import com.zerobyte.lifesync.model.Friend;
import com.zerobyte.lifesync.model.Schedule;
import com.zerobyte.lifesync.model.User;

@Controller
@RequestMapping(value = { "/userAcc" })
public class UserAccController {
 
	@Autowired
	@Qualifier("userDao")
	UserDao userDao;
	
	@RequestMapping(value = { "" })
	public ModelAndView userAccPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		
		//Map<String,String> filter = new HashMap<String,String>();
		//filter.put(UserDao.CONST_USER_ID_FIELD, user.getUser_id());
		
		//List<User> curUser = userDao.retrieveUser(filter);
		ModelAndView modelAndView = new ModelAndView("userAcc");
		modelAndView.addObject("appUserFN", user.getFirst_name());
		modelAndView.addObject("appUserLN", user.getLast_name());
		modelAndView.addObject("appUserEmail", user.getEmail());
		modelAndView.addObject("user", user.getEmail());
		//modelAndView.addObject("appUserPW", user.getPassword());
		return modelAndView;	
	}
	
	@RequestMapping(value = { "/accChange" })
	public ModelAndView accountPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		ModelAndView modelAndView = new ModelAndView("accChange");
		modelAndView.addObject("user", user.getEmail());
		
		return modelAndView;	
	}
	
	@RequestMapping(value = { "/accChange/new" })
	public ModelAndView accountNewPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		
		//String email = "'" + request.getParameter("email") + "'";
		String password = request.getParameter("password");
		String changeFN = request.getParameter("changeFN");
		String changeLN = request.getParameter("changeLN");
		String changeEM = request.getParameter("changeEM");
		String changePW = request.getParameter("changePW");
	
		Map<String,String> userInfo = new HashMap<String,String>();
		
		ModelAndView modelAndView;
		//if(user.getPassword() == password);
		if(user.getPassword().equals(password) )
		/*String email = "'" + request.getParameter("email") + "'";
		String password = "'" + request.getParameter("password") + "'";
		String changeFN = request.getParameter("changeFN");
		String changeLN = request.getParameter("changeLN");
		String changeEM = request.getParameter("changeEM");
		String changePW = request.getParameter("changePW");
		
		Map<String,String> credentials = new HashMap<String,String>();
		credentials.put(UserDao.CONST_EMAIL_FIELD, email);
		credentials.put(UserDao.CONST_PASSWORD_FIELD, password);
		List<User> users = userDao.retrieveUser(credentials);
		
		Map<String,String> userInfo = new HashMap<String,String>();
		
		ModelAndView modelAndView;
		if(users.size() == 1)*/
		{	
			if(!changeFN.isEmpty())
			{
			userInfo.put(UserDao.CONST_FIRSTNAME_FIELD, "'" + changeFN + "'");
			}
			if(!changeLN.isEmpty())
			{
			userInfo.put(UserDao.CONST_LASTNAME_FIELD, "'" + changeLN + "'");
			}
			if(!changeEM.isEmpty())
			{
			userInfo.put(UserDao.CONST_EMAIL_FIELD, "'" + changeEM + "'");
			}
			if(!changePW.isEmpty())
			{
			userInfo.put(UserDao.CONST_PASSWORD_FIELD, "'" + changePW + "'");
			}
			
			Map<String,String> credentials = new HashMap<String,String>();
			credentials.put(UserDao.CONST_EMAIL_FIELD, "'" + user.getEmail() + "'");
			credentials.put(UserDao.CONST_PASSWORD_FIELD, "'" + user.getPassword() + "'");
			userDao.updateUser(userInfo, credentials);
			
			//users = userDao.retrieveUser(attributes);
			
			/*String appUserFN = user.getFirst_name();
			String appUserLN = user.getLast_name();
			String appUserEmail = user.getEmail();
			String appUserPW = user.getPassword();*/
			
			//modelAndView = new ModelAndView("accChangeSuccess");
			modelAndView = new ModelAndView("genericMessage");
			modelAndView.addObject("pageTitle", "ACCOUNT CHANGE SUCCESS");
			//modelAndView.addObject("user", user.getEmail());
			modelAndView.addObject("newLink", "/FBWebServer/userAcc");
			modelAndView.addObject("message", "Congratulations! Changing account was successful");
			/*modelAndView.addObject("appUserFN", user.getFirst_name());
			modelAndView.addObject("appUserLN", user.getLast_name());
			modelAndView.addObject("appUserEmail", user.getEmail());*/
			//modelAndView.addObject("appUserPW", appUserPW);
		}
		else
		{
			//modelAndView = new ModelAndView("accChangeFail");
			modelAndView = new ModelAndView("genericErrMessage");
			modelAndView.addObject("pageTitle", "ACCOUNT CHANGE ERROR.");
			//modelAndView.addObject("user", user.getEmail());
			modelAndView.addObject("message", "Changing account was not successful");
		}
		
		modelAndView.addObject("user", user.getEmail());
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
