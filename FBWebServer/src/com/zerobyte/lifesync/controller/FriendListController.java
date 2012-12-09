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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.zerobyte.lifesync.dataaccess.UserDao;
import com.zerobyte.lifesync.model.Event;
import com.zerobyte.lifesync.model.Friend;
import com.zerobyte.lifesync.model.Schedule;
import com.zerobyte.lifesync.model.User;

//Handles all related to Friends for LifeSync Application
@Controller
@RequestMapping(value = { "/friendList" })
public class FriendListController {
 
	@Autowired
	@Qualifier("userDao")
	UserDao userDao;
	
	@RequestMapping(value = { "" })
	public ModelAndView friendsListPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		
		Map<String,String> filter = new HashMap<String,String>();
		filter.put(UserDao.CONST_USER_ID_FIELD, user.getUser_id());
		filter.put(UserDao.CONST_STATUS_FIELD, "'approved'");
		List<Friend> friendApp = userDao.retrieveFriend(filter);
		List<User> friendUserApp = new ArrayList<User>();
		if(friendApp.size() > 0)
		{
			for(int i = 0; i < friendApp.size(); i++)
			{
				filter.clear();
				filter.put(UserDao.CONST_USER_ID_FIELD, friendApp.get(i).getF_user_id());
				friendUserApp.add(userDao.retrieveUser(filter).get(0));
			}
		}
		
		filter.clear();
		filter.put(UserDao.CONST_USER_ID_FIELD, user.getUser_id());
		filter.put(UserDao.CONST_STATUS_FIELD, "'pending'");
		List<Friend> friendPend = userDao.retrieveFriend(filter);
		List<User> friendUserPend = new ArrayList<User>();
		if(friendPend.size() > 0)
		{
			for(int i = 0; i < friendPend.size(); i++)
			{
				filter.clear();
				filter.put(UserDao.CONST_USER_ID_FIELD, friendPend.get(i).getF_user_id());
				friendUserPend.add(userDao.retrieveUser(filter).get(0));
			}
		}
		
		filter.clear();
		filter.put(UserDao.CONST_USER_ID_FIELD, user.getUser_id());
		filter.put(UserDao.CONST_STATUS_FIELD, "'awaiting_response'");
		List<Friend> friendAR = userDao.retrieveFriend(filter);
		List<User> friendUserAR = new ArrayList<User>();
		if(friendAR.size() > 0)
		{
			for(int i = 0; i < friendAR.size(); i++)
			{
				filter.clear();
				filter.put(UserDao.CONST_USER_ID_FIELD, friendAR.get(i).getF_user_id());
				friendUserAR.add(userDao.retrieveUser(filter).get(0));
			}
		}
		
		ModelAndView modelAndView = new ModelAndView("friendList");
		modelAndView.addObject("friendUserApp", friendUserApp);
		modelAndView.addObject("friendApp", friendApp);
		modelAndView.addObject("friendUserPend", friendUserPend);
		modelAndView.addObject("friendPend", friendPend);
		modelAndView.addObject("friendUserAR", friendUserAR);
		modelAndView.addObject("friendAR", friendAR);
		modelAndView.addObject("user", user.getEmail());
		
		return modelAndView;
	}
	
	@RequestMapping(value = { "/facebookFriendList" })
	public ModelAndView FriendListPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		
		ModelAndView modelAndView = new ModelAndView("facebookFriendList");
		modelAndView.addObject("user", user.getEmail());
		
		return modelAndView;	
	}
	
	@RequestMapping(value = { "/facebookFriendList/update_fbid" }, method = RequestMethod.GET)
	public void FriendListUpdateFBID(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		String fb_id = request.getParameter("fb_id");
		
		User user = getUserFromEmail();
		Map<String,String> changes = new HashMap<String,String>();
		changes.put(UserDao.CONST_FBID_FIELD, "'" + fb_id + "'");
		
		Map<String,String> conditions = new HashMap<String,String>();
		conditions.put(UserDao.CONST_USER_ID_FIELD, "'" + user.getUser_id() + "'");
		
		userDao.updateUser(changes, conditions);
	}
	
	@RequestMapping(value = { "/facebookFriendList/friendAdd" }, method = RequestMethod.POST)
	public ModelAndView fbFriendAddPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		String[] fbfriends = request.getParameterValues("friends");
		
		ModelAndView modelAndView = new ModelAndView("facebookFriendAdd");
		
		String message = "";
		
		for(String friend_id: fbfriends) {
			// check for user with associated facebook id
			Map<String,String> conditions = new HashMap<String,String>();
			conditions.put(UserDao.CONST_FBID_FIELD, friend_id);
			List<User> friend = userDao.retrieveUser(conditions);
			
			// if user found, check to see if they are already your friend
			if(!friend.isEmpty()) {
				Map<String,String> friendInfo = new HashMap<String,String>();
				friendInfo.put(UserDao.CONST_F_USER_ID_FIELD, "'" + user.getUser_id() + "'");
				friendInfo.put(UserDao.CONST_USER_ID_FIELD, "'" + friend.get(0).getUser_id() + "'");
				List<Friend> check = userDao.retrieveFriend(friendInfo);
				
				if(check.size() > 0) {
					// already friends, do not add
					//modelAndView.addObject("message", "Already your friend!");
					message += friend.get(0).getFirst_name() + " " + friend.get(0).getLast_name() + " is already your friend!<br/>";
				} else {
					// not friend yet, add to list
					friendInfo.put(UserDao.CONST_STATUS_FIELD, "'pending'");
					
					Map<String,String> awaiting = new HashMap<String,String>();
					awaiting.put(UserDao.CONST_F_USER_ID_FIELD, "'" + friend.get(0).getUser_id() + "'");
					awaiting.put(UserDao.CONST_USER_ID_FIELD, "'" + user.getUser_id() + "'");
					awaiting.put(UserDao.CONST_STATUS_FIELD, "'awaiting_response'");
					
					try {
						int success1 = userDao.createFriend(friendInfo);
						int success2 = userDao.createFriend(awaiting);
						
						if(success1 == 1 && success2 == 1) {
							//modelAndView.addObject("message", "Friend added successfully");
							message += friend.get(0).getFirst_name() + " " + friend.get(0).getLast_name() + " was added successfully.<br/>";
						} else {
							//modelAndView.addObject("error", "Error adding friend");
							message += "There was an error adding " + friend.get(0).getFirst_name() + " " + friend.get(0).getLast_name() + "<br/>";
						}
					} catch(UncategorizedSQLException e) {
						// modelAndView.addObject("error", "SQL Error adding friend");
						message += "A SQL Error occurred<br/>";
					}
				}
			}
		}
		
		modelAndView.addObject("message", message);
		return modelAndView;		
	}
	
	@RequestMapping(value = { "/friendAdd" })
	public ModelAndView friendAddPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		
		ModelAndView modelAndView = new ModelAndView("friendAdd");
		modelAndView.addObject("user", user.getEmail());
		return modelAndView;	
	}
	
	@RequestMapping(value = { "/friendAdd/new" })
	public ModelAndView friendAddNewPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		
		//String email = "'" + request.getParameter("email") + "'";
		String friendEmail = request.getParameter("addFriendEM");
		ModelAndView modelAndView;
		
		Map<String,String> filter = new HashMap<String,String>();
		filter.put(UserDao.CONST_EMAIL_FIELD, "'" + friendEmail + "'");
		List<User> friend = userDao.retrieveUser(filter);
		
		if (friendEmail.equals(user.getEmail())){
			modelAndView = new ModelAndView("genericErrMessage");
			modelAndView.addObject("pageTitle", "FRIEND ADD ERROR.");
			modelAndView.addObject("user", user.getEmail());
			modelAndView.addObject("message", "Cannot add self as friend");
			return modelAndView;
		}
		
		if (friend.size() < 1){
			modelAndView = new ModelAndView("genericErrMessage");
			modelAndView.addObject("pageTitle", "FRIEND ADD ERROR.");
			modelAndView.addObject("user", user.getEmail());
			modelAndView.addObject("message", "This is an invalid email address.");
			return modelAndView;
		}
		
		
		Map<String,String> friendInfo = new HashMap<String,String>();
		friendInfo.put(UserDao.CONST_F_USER_ID_FIELD, "'" + user.getUser_id() + "'");
		friendInfo.put(UserDao.CONST_USER_ID_FIELD, "'" + friend.get(0).getUser_id() + "'");
		List<Friend> check = userDao.retrieveFriend(friendInfo);
		if(check.size() > 0){
			/*modelAndView = new ModelAndView("friendAddFail");
			modelAndView.addObject("user", user.getEmail());*/
			modelAndView = new ModelAndView("genericErrMessage");
			modelAndView.addObject("pageTitle", "FRIEND ADD ERROR.");
			modelAndView.addObject("user", user.getEmail());
			modelAndView.addObject("message", "The email belongs to a user that is either currently your friend, or is pending/awaiting response.");
			return modelAndView;
		}
		friendInfo.put(UserDao.CONST_STATUS_FIELD, "'pending'");
		
		Map<String,String> awaiting = new HashMap<String,String>();
		awaiting.put(UserDao.CONST_F_USER_ID_FIELD, "'" + friend.get(0).getUser_id() + "'");
		awaiting.put(UserDao.CONST_USER_ID_FIELD, "'" + user.getUser_id() + "'");
		awaiting.put(UserDao.CONST_STATUS_FIELD, "'awaiting_response'");
		
		try {
			int success1 = userDao.createFriend(friendInfo);
			int success2 = userDao.createFriend(awaiting);
			
			if(success1 == 1 && success2 == 1){
				//modelAndView = new ModelAndView("friendAddSuccess");
				modelAndView = new ModelAndView("genericMessage");
				modelAndView.addObject("pageTitle", "FRIEND ADD SUCCESS");
				//modelAndView.addObject("user", user.getEmail());
				modelAndView.addObject("newLink", "/FBWebServer/friendList");
				modelAndView.addObject("message", "Congratulations! Friend add was successful");
			}
			else{
				modelAndView = new ModelAndView("genericErrMessage");
				modelAndView.addObject("pageTitle", "FRIEND ADD ERROR.");
				//modelAndView.addObject("user", user.getEmail());
				modelAndView.addObject("message", "Friend add was not successful");
			}
			
		} catch(UncategorizedSQLException e) {
			modelAndView = new ModelAndView("genericErrMessage");
			modelAndView.addObject("pageTitle", "FRIEND ADD ERROR.");
			//modelAndView.addObject("user", user.getEmail());
			modelAndView.addObject("message", "Friend add was not successful");
		}
		
		modelAndView.addObject("user", user.getEmail());
		return modelAndView;
	}
	

	@RequestMapping(value = { "/friendApprove" }) //finish this part soon
	public ModelAndView FriendApprovePage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		
		String friendID = request.getParameter("friendID");
		Map<String,String> filter1 = new HashMap<String,String>();
		filter1.put(UserDao.CONST_F_USER_ID_FIELD, "'" + friendID + "'");
		filter1.put(UserDao.CONST_USER_ID_FIELD, "'" + user.getUser_id() + "'");
		Map<String,String> change1 = new HashMap<String,String>();
		change1.put(UserDao.CONST_STATUS_FIELD, "'approved'");
		//userDao.updateFriend(change, filter);//check if must perform security check
		
		Map<String,String> filter2 = new HashMap<String,String>();
		filter2.put(UserDao.CONST_F_USER_ID_FIELD, "'" + user.getUser_id() + "'");
		filter2.put(UserDao.CONST_USER_ID_FIELD, "'" + friendID + "'");
		Map<String,String> change2 = new HashMap<String,String>();
		change2.put(UserDao.CONST_STATUS_FIELD, "'approved'");
		
		ModelAndView modelAndView;
		try {
			int successUpdate = userDao.updateFriend(change1, filter1);
			int successNew = userDao.updateFriend(change2, filter2);
			
			if(successUpdate == 1 && successNew == 1){
				//modelAndView = new ModelAndView("friendAppSuccess");
				modelAndView = new ModelAndView("genericMessage");
				modelAndView.addObject("pageTitle", "FRIEND APPROVE SUCCESS");
				//modelAndView.addObject("user", user.getEmail());
				modelAndView.addObject("newLink", "/FBWebServer/friendList");
				modelAndView.addObject("message", "Congratulations! Approving friend was successful");
			}
			else {
				//modelAndView = new ModelAndView("friendAppFail");
				modelAndView = new ModelAndView("genericErrMessage");
				modelAndView.addObject("pageTitle", "FRIEND APPROVE ERROR");
				//modelAndView.addObject("user", user.getEmail());
				modelAndView.addObject("message", "Sorry! Approving friend was not successful");
			}
			
		} catch(UncategorizedSQLException e) {
			//modelAndView = new ModelAndView("friendAAppFail");
			modelAndView = new ModelAndView("genericErrMessage");
			modelAndView.addObject("pageTitle", "FRIEND APPROVE ERROR");
			//modelAndView.addObject("user", user.getEmail());
			modelAndView.addObject("message", "Sorry! Approving friend was not successful");
		}
		
		modelAndView.addObject("user", user.getEmail());
		return modelAndView;	
	}
	
	@RequestMapping(value = { "/friendDelete" })
	public ModelAndView FriendDeletePage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		
		String friendId = request.getParameter("friendID");
		Map<String,String> friendDelete1 = new HashMap<String,String>();
		friendDelete1.put(UserDao.CONST_F_USER_ID_FIELD, "'" + friendId + "'");
		friendDelete1.put(UserDao.CONST_USER_ID_FIELD, "'" + user.getUser_id() + "'");
		
		Map<String,String> friendDelete2 = new HashMap<String,String>();
		friendDelete2.put(UserDao.CONST_F_USER_ID_FIELD, "'" + user.getUser_id() + "'");
		friendDelete2.put(UserDao.CONST_USER_ID_FIELD, "'" + friendId + "'");
		
		ModelAndView modelAndView;
		try {
			int successDelete1 = userDao.deleteFriend(friendDelete1);
			int successDelete2 = userDao.deleteFriend(friendDelete2);
			
			if(successDelete1 == 1 && successDelete2 == 1){
				//modelAndView = new ModelAndView("friendDeleteSuccess");
				modelAndView = new ModelAndView("genericMessage");
				modelAndView.addObject("pageTitle", "FRIEND DELETE SUCCESS");
				//modelAndView.addObject("user", user.getEmail());
				modelAndView.addObject("newLink", "/FBWebServer/friendList");
				modelAndView.addObject("message", "Congratulations! Deleting friend was successful");
			}
			else{
				//modelAndView = new ModelAndView("friendDeleteFail");
				modelAndView = new ModelAndView("genericErrMessage");
				modelAndView.addObject("pageTitle", "FRIEND DELETE ERROR");
				//modelAndView.addObject("user", user.getEmail());
				modelAndView.addObject("message", "Sorry! Deleting friend was not successful");
			}
			
		} catch(UncategorizedSQLException e) {
			//modelAndView = new ModelAndView("friendDeleteFail");
			modelAndView = new ModelAndView("genericErrMessage");
			modelAndView.addObject("pageTitle", "FRIEND DELETE ERROR");
			//modelAndView.addObject("user", user.getEmail());
			modelAndView.addObject("message", "Sorry! Deleting friend was not successful");
		}
		
		modelAndView.addObject("user", user.getEmail());
		return modelAndView;
	}
	
	@RequestMapping(value = { "/friendView" })
	public ModelAndView friendAccPage(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
			
			User user = getUserFromEmail();
			
			String friendId = request.getParameter("friendID");
			Map<String,String> filter = new HashMap<String,String>();
			filter.put(UserDao.CONST_USER_ID_FIELD, friendId);
			
			List<User> friend = userDao.retrieveUser(filter);

			ModelAndView modelAndView = new ModelAndView("userAcc");
			modelAndView.addObject("appUserFN", friend.get(0).getFirst_name());
			modelAndView.addObject("appUserLN", friend.get(0).getLast_name());
			modelAndView.addObject("appUserEmail", friend.get(0).getEmail());
			modelAndView.addObject("user", user.getEmail());
			//modelAndView.addObject("appUserPW", user.getPassword());
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
