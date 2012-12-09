package com.zerobyte.lifesync.controller;

import java.io.IOException;
import java.util.ArrayList;
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

//Handles all related to the administration page for LifeSync Facebook app
@Controller
@RequestMapping(value = { "/adminPage" })
public class AdminController {
 
	@Autowired
	@Qualifier("userDao")
	UserDao userDao;
	
	//Handles the main page for admin and returns a list of all users of LifeSync
	@RequestMapping(value = { "" })
	public ModelAndView usersListPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User admin = getUserFromEmail();
		
		//retrieves all users in the our database
		List<User> users = userDao.retrieveAllUsers();
		//List<User> friendUserApp = new ArrayList<User>();
		
		ModelAndView modelAndView = new ModelAndView("adminPage");
		modelAndView.addObject("allUsers", users);
		modelAndView.addObject("user", admin.getEmail());
		return modelAndView;	
	}
	
	//Handles the page that displays a user of LifeSync's info
	@RequestMapping(value = { "/userInfo" })
	public ModelAndView userInfoPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User admin = getUserFromEmail();
		
		String userID = request.getParameter("userID");
		Map<String,String> filter1 = new HashMap<String,String>();
		filter1.put(UserDao.CONST_USER_ID_FIELD, "'" + userID + "'");
		
		//retrieves the user chosen to be viewed
		List<User> user = userDao.retrieveUser(filter1);
		//List<User> friendUserApp = new ArrayList<User>();
		
		ModelAndView modelAndView = new ModelAndView("adminPageUserInfo");
		modelAndView.addObject("appUserID", user.get(0).getUser_id());
		modelAndView.addObject("appUserFN", user.get(0).getFirst_name());
		modelAndView.addObject("appUserLN", user.get(0).getLast_name());
		modelAndView.addObject("appUserEmail", user.get(0).getEmail());
		modelAndView.addObject("appUserRole", user.get(0).getAuthority());
		modelAndView.addObject("user", admin.getEmail());
		return modelAndView;	
	}
	
	//Handles the page that contains a form for editing a user
	@RequestMapping(value = { "/adminEdit" })
	public ModelAndView userInfoEditPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User admin = getUserFromEmail();
		
		String userID = request.getParameter("userID");
		Map<String,String> filter1 = new HashMap<String,String>();
		filter1.put(UserDao.CONST_USER_ID_FIELD, "'" + userID + "'");
		
		//retrieves the user that is to be edited
		List<User> user = userDao.retrieveUser(filter1);
		//List<User> friendUserApp = new ArrayList<User>();
		
		ModelAndView modelAndView = new ModelAndView("adminEdit");
		modelAndView.addObject("appUserID", user.get(0).getUser_id());
		modelAndView.addObject("appUserFN", user.get(0).getFirst_name());
		modelAndView.addObject("appUserLN", user.get(0).getLast_name());
		modelAndView.addObject("appUserPW", user.get(0).getPassword());
		modelAndView.addObject("appUserEmail", user.get(0).getEmail());
		modelAndView.addObject("appUserRole", user.get(0).getAuthority());
		modelAndView.addObject("user", admin.getEmail());
		return modelAndView;	
	}
	
	//Handles the updates for the changes made by admin for the user
	@RequestMapping(value = { "/adminEdit/new" })
	public ModelAndView userInfoEditNewPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User admin = getUserFromEmail();
		
		//String email = "'" + request.getParameter("email") + "'";
		//Retrieves all the changes made from the jsp page
		String userID = request.getParameter("changeID");
		String changeFN = request.getParameter("changeFN");
		String changeLN = request.getParameter("changeLN");
		String changeEM = request.getParameter("changeEM");
		String changePW = request.getParameter("changePW");
		String changeRole = request.getParameter("changeRole");
		
		/*System.out.println(userID);
		System.out.println(changeFN);
		System.out.println(changeLN);
		System.out.println(changeEM);
		System.out.println(changePW);
		System.out.println(changeRole);*/
		
		Map<String,String> userInfo = new HashMap<String,String>();
				
		ModelAndView modelAndView;
		
		if(!changeFN.isEmpty())
		{
			userInfo.put(UserDao.CONST_FIRSTNAME_FIELD, "'" + changeFN + "'");
			//System.out.println("passed1");
		}
		if(!changeLN.isEmpty())
		{
			userInfo.put(UserDao.CONST_LASTNAME_FIELD, "'" + changeLN + "'");
			//System.out.println("passed2");
		}
		if(!changeEM.isEmpty())
		{
			userInfo.put(UserDao.CONST_EMAIL_FIELD, "'" + changeEM + "'");
			//System.out.println("passed3");
		}
		if(!changePW.isEmpty())
		{
			userInfo.put(UserDao.CONST_PASSWORD_FIELD, "'" + changePW + "'");
			//System.out.println("passed4");
		}
		if(!changeRole.isEmpty() || !(changeRole == null))
		{
			userInfo.put(UserDao.CONST_AUTHORITY_FIELD, "'" + changeRole + "'");
			//System.out.println("passed5");
		}
		
		//System.out.println("Going to get credentials");
		
		Map<String,String> credentials = new HashMap<String,String>();
		credentials.put(UserDao.CONST_USER_ID_FIELD, "'" + userID + "'");
		//userDao.updateUser(userInfo, credentials);
		//System.out.println("Going to try");
		try {
			//updates the database with changes
			int success1 = userDao.updateUser(userInfo, credentials);
			
			if(success1 == 1){
				//modelAndView = new ModelAndView("adminEditSuccess");
				modelAndView = new ModelAndView("genericMessage");
				modelAndView.addObject("pageTitle", "Administration");
				//modelAndView.addObject("user", user.getEmail());
				modelAndView.addObject("newLink", "/FBWebServer/adminPage");
				modelAndView.addObject("message", "Congratulations! Editing user was successful");
			}
			else {
				//modelAndView = new ModelAndView("adminEditFail");
				modelAndView = new ModelAndView("genericErrMessage");
				modelAndView.addObject("pageTitle", "Administration");
				//modelAndView.addObject("user", user.getEmail());
				modelAndView.addObject("message", "Editing user was not successful");
			}
			
		} catch(UncategorizedSQLException e) {
			//modelAndView = new ModelAndView("adminEditFail");
			modelAndView = new ModelAndView("genericErrMessage");
			modelAndView.addObject("pageTitle", "Administration");
			//modelAndView.addObject("user", user.getEmail());
			modelAndView.addObject("message", "Editing user was not successful");
		}
					
		modelAndView.addObject("user", admin.getEmail());
		modelAndView.addObject("userRole", admin.getAuthority());
		return modelAndView;	
	}
	
	//Handles the deletion of a user made by admin
	@RequestMapping(value = { "/userDelete" })
	public ModelAndView userDeletePage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User admin = getUserFromEmail();
		
		String userId = request.getParameter("userID");
		Map<String,String> userDelete = new HashMap<String,String>();
		userDelete.put(UserDao.CONST_USER_ID_FIELD, "'" + userId + "'");
		
		ModelAndView modelAndView;
		try {
			//deletes the user for the database
			int successDelete = userDao.deleteUser(userDelete);
			
			if(successDelete == 1){
				//modelAndView = new ModelAndView("adminDeleteSuccess");
				modelAndView = new ModelAndView("genericMessage");
				modelAndView.addObject("pageTitle", "Administration");
				//modelAndView.addObject("user", user.getEmail());
				modelAndView.addObject("newLink", "/FBWebServer/adminPage");
				modelAndView.addObject("message", "Congratulations! Deleting user was successful");
			}
			else {
				//modelAndView = new ModelAndView("adminDeleteFail");
				modelAndView = new ModelAndView("genericErrMessage");
				modelAndView.addObject("pageTitle", "Administration");
				//modelAndView.addObject("user", user.getEmail());
				modelAndView.addObject("message", "Deleting user was not successful");
			}
			
		} catch(UncategorizedSQLException e) {
			//modelAndView = new ModelAndView("adminDeleteFail");
			modelAndView = new ModelAndView("genericErrMessage");
			modelAndView.addObject("pageTitle", "Admnistration");
			//modelAndView.addObject("user", user.getEmail());
			modelAndView.addObject("message", "Deleting user was not successful");
		}
		
		modelAndView.addObject("user", admin.getEmail());
		return modelAndView;
	}
	
	//returns a user based on authetication or the session user
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
