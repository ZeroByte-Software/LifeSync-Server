/* AndroidController.java
 * 
 * Controller to handle all interactions with the Android app.
 * 
 */

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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.zerobyte.lifesync.dataaccess.UserDao;
import com.zerobyte.lifesync.model.Event;
import com.zerobyte.lifesync.model.Friend;
import com.zerobyte.lifesync.model.Schedule;
import com.zerobyte.lifesync.model.User;
 
@Controller
@RequestMapping(value = { "/android" })
public class AndroidController {
 
	@Autowired
	@Qualifier("userDao")
	UserDao userDao;
	
	/*
	 * Handles user login
	 */
	@RequestMapping(value = { "/login" }, method = RequestMethod.GET)
	public ModelAndView loginPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		ModelAndView modelAndView = new ModelAndView("androidLogin");
		
		// Get info from HTTP request from Android app and put into hash map
		String email = request.getParameter( "email" );
		String password = request.getParameter( "password" );
		Map<String, String> mapCredentials = new HashMap<String, String>();
		
		mapCredentials.put( "email", "'" + email + "'");
		mapCredentials.put( "password", "'" + password + "'");
		
		List<User> users = userDao.retrieveUser( mapCredentials );
		
		if( !users.isEmpty() )
		{
			User userAcct = users.get(0);
			Gson userJson = new Gson();
			
			modelAndView.addObject( "userJson", userJson.toJson(userAcct) );
			response.setStatus( HttpServletResponse.SC_OK );
		}
		else
			response.setStatus( HttpServletResponse.SC_UNAUTHORIZED );
		
		return modelAndView;	
	}
	
	/*
	 * Handles user registration
	 */
	@RequestMapping(value = { "/register" }, method = RequestMethod.POST)
	public ModelAndView registerPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		ModelAndView modelAndView = new ModelAndView("androidRegister");
		
		// Get info from HTTP request from Android app and put into hash map
		String email = request.getParameter( "email" );
		String password = request.getParameter( "password" );
		String fName = request.getParameter( "fName" );
		String lName = request.getParameter( "lName" );
		Map<String, String> mapEmail = new HashMap<String, String>();	// Used to check if email already exists
		Map<String, String> mapRegInfo = new HashMap<String, String>();
		
		mapEmail.put( "email", "'" + email + "'" );
		
		mapRegInfo.put( "email", "'" + email + "'");
		mapRegInfo.put( "password", "'" + password + "'");
		mapRegInfo.put( "first_name", "'" + fName + "'" );
		mapRegInfo.put( "last_name", "'" + lName + "'" );
		
		// Check if email already exists
		List<User> users = userDao.retrieveUser( mapEmail );
		
		if( users.isEmpty() )
		{
			int result = userDao.createUser( mapRegInfo );
			
			if( result == 1 )
				response.setStatus( HttpServletResponse.SC_CREATED );
			else
				response.setStatus( HttpServletResponse.SC_BAD_REQUEST );
		}
		else
			response.setStatus( HttpServletResponse.SC_CONFLICT );
		
		return modelAndView;
	}
	
	@RequestMapping(value = { "/friendlist" }, method = RequestMethod.GET)
	public ModelAndView friendListPage(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
			ModelAndView modelAndView = new ModelAndView("androidFriendList");
			//User user = getUserFromEmail();
			// Get info from HTTP request from Android app and put into hash map
			String email = request.getParameter( "email" );

			//Map<String, String> mapEmail = new HashMap<String, String>();	// Used to check if email already exists
			
			//mapEmail.put( "email", "'" + email + "'" );

			Map<String,String> filter = new HashMap<String,String>();
			filter.put(UserDao.CONST_EMAIL_FIELD, "'" + email + "'");
			//filter.put(UserDao.CONST_STATUS_FIELD, "'approved'");
			List<User> myUserInfo = userDao.retrieveUser(filter);
			
			filter.clear();
			filter.put(UserDao.CONST_STATUS_FIELD, "'approved'");
			filter.put(UserDao.CONST_USER_ID_FIELD, myUserInfo.get(0).getUser_id());	
			List<Friend> friendApp = userDao.retrieveFriend(filter);
			
			//List<String> friendNames = new ArrayList<String>();
			List<User> friendUserApp = new ArrayList<User>();
			//List<User> myFriendList = new ArrayList<User>();
			ArrayList<List<User>> androidFriendList = new ArrayList<List<User>>();
			
			Gson friends = new Gson();
			for(Friend friend: friendApp)
			{
				filter.clear();
				filter.put(UserDao.CONST_USER_ID_FIELD, friend.getF_user_id());
				friendUserApp.add(userDao.retrieveUser(filter).get(0));
				
				//friendNames.add(myFriendUser.get(0).getFirst_name() + " " + myFriendUser.get(0).getLast_name());
				//myFriendList.add(myFriendUser.get(0));
				//myFriendUser.get(0).getFirst_name();
				//myFriendUser.get(0).getLast_name();
			}
			androidFriendList.add(friendUserApp);
			filter.clear();
			filter.put(UserDao.CONST_USER_ID_FIELD, myUserInfo.get(0).getUser_id());
			filter.put(UserDao.CONST_STATUS_FIELD, "'awaiting_response'");
			List<Friend> friendAR = userDao.retrieveFriend(filter);
			List<User> friendUserAR = new ArrayList<User>();
			//Gson ARfriends = new Gson();
			if(friendAR.size() > 0)
			{
				for(int i = 0; i < friendAR.size(); i++)
				{
					filter.clear();
					filter.put(UserDao.CONST_USER_ID_FIELD, friendAR.get(i).getF_user_id());
					friendUserAR.add(userDao.retrieveUser(filter).get(0));
					
				}
			}

			androidFriendList.add(friendUserAR);
			
			filter.clear();
			filter.put(UserDao.CONST_USER_ID_FIELD, myUserInfo.get(0).getUser_id());
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
			androidFriendList.add(friendUserPend);
			//modelAndView.addObject("myFriendNames", friends.toJson(friendNames));
			modelAndView.addObject("myFriendList", friends.toJson(androidFriendList));
			//modelAndView.addObject("myFriendListAR", ARfriends.toJson(friendUserAR));
			return modelAndView;
		}
	@RequestMapping(value = { "/friendAdd" })
	public ModelAndView friendBumpPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
			String email = request.getParameter( "email" );
			String friendemail = request.getParameter("friendemail");
			Map<String,String> filter = new HashMap<String,String>();
			filter.put(UserDao.CONST_EMAIL_FIELD, "'" + email + "'");
			//filter.put(UserDao.CONST_STATUS_FIELD, "'approved'");
			List<User> myUserInfo = userDao.retrieveUser(filter);
			//User user = getUserFromEmail();
			// Get info from HTTP request from Android app and put into hash map
			

			filter.clear();
			filter.put(UserDao.CONST_EMAIL_FIELD, "'" + friendemail + "'");
			List<User> friend = userDao.retrieveUser(filter);
		
			//String friendEmail = request.getParameter("addFriendEM");
			ModelAndView modelAndView;
			
		
			
			if (friend.size() < 1){
				modelAndView = new ModelAndView("androidFriendAddFail");
				return modelAndView;
			}
			
			Map<String,String> friendInfo = new HashMap<String,String>();
			friendInfo.put(UserDao.CONST_F_USER_ID_FIELD, "'" + myUserInfo.get(0).getUser_id() + "'");
			friendInfo.put(UserDao.CONST_USER_ID_FIELD, "'" + friend.get(0).getUser_id() + "'");
			List<Friend> check = userDao.retrieveFriend(friendInfo);
			if(check.size() > 0){
				modelAndView = new ModelAndView("androidFriendAddFail");
				//modelAndView.addObject("user", myUserInfo.get(0).getEmail());
				//modelAndView.addObject("message", "The email belongs to a user that is either currently your friend, or is pending/awaiting response.");
				return modelAndView;
			}
			friendInfo.put(UserDao.CONST_STATUS_FIELD, "'approved'");
			
			Map<String,String> awaiting = new HashMap<String,String>();
			awaiting.put(UserDao.CONST_F_USER_ID_FIELD, "'" + friend.get(0).getUser_id() + "'");
			awaiting.put(UserDao.CONST_USER_ID_FIELD, "'" + myUserInfo.get(0).getUser_id() + "'");
			awaiting.put(UserDao.CONST_STATUS_FIELD, "'approved'");
			
			try {
				int success1 = userDao.createFriend(friendInfo);
				int success2 = userDao.createFriend(awaiting);
				
				if(success1 == 1 && success2 == 1)
					modelAndView = new ModelAndView("androidFriendAddSuccess");
				else
					modelAndView = new ModelAndView("androidFriendAddFail");
				
			} catch(UncategorizedSQLException e) {
				modelAndView = new ModelAndView("androidFriendAddFail");
			}
			Gson newfriend = new Gson();
			modelAndView.addObject("friendUser", newfriend.toJson(friendInfo.get(0)));
			return modelAndView;
	}
	
	@RequestMapping(value = { "/friendAdd/new" })
	public ModelAndView friendAddNewPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter( "email" );
		String friendemail = request.getParameter("friendemail");
		Map<String,String> filter = new HashMap<String,String>();
		filter.put(UserDao.CONST_EMAIL_FIELD, "'" + email + "'");
		//filter.put(UserDao.CONST_STATUS_FIELD, "'approved'");
		List<User> myUserInfo = userDao.retrieveUser(filter);
		//User user = getUserFromEmail();
		// Get info from HTTP request from Android app and put into hash map
		

		filter.clear();
		filter.put(UserDao.CONST_EMAIL_FIELD, "'" + friendemail + "'");
		List<User> friend = userDao.retrieveUser(filter);
	
		//String friendEmail = request.getParameter("addFriendEM");
		ModelAndView modelAndView;
		
	
		
		if (friend.size() < 1){
			modelAndView = new ModelAndView("androidFriendAddFail");
			return modelAndView;
		}
		
		Map<String,String> friendInfo = new HashMap<String,String>();
		friendInfo.put(UserDao.CONST_F_USER_ID_FIELD, "'" + myUserInfo.get(0).getUser_id() + "'");
		friendInfo.put(UserDao.CONST_USER_ID_FIELD, "'" + friend.get(0).getUser_id() + "'");
		List<Friend> check = userDao.retrieveFriend(friendInfo);
		if(check.size() > 0){
			modelAndView = new ModelAndView("androidFriendAddFail");
			//modelAndView.addObject("user", myUserInfo.get(0).getEmail());
			//modelAndView.addObject("message", "The email belongs to a user that is either currently your friend, or is pending/awaiting response.");
			return modelAndView;
		}
		friendInfo.put(UserDao.CONST_STATUS_FIELD, "'pending'");
		
		Map<String,String> awaiting = new HashMap<String,String>();
		awaiting.put(UserDao.CONST_F_USER_ID_FIELD, "'" + friend.get(0).getUser_id() + "'");
		awaiting.put(UserDao.CONST_USER_ID_FIELD, "'" + myUserInfo.get(0).getUser_id() + "'");
		awaiting.put(UserDao.CONST_STATUS_FIELD, "'awaiting_response'");
		
		try {
			int success1 = userDao.createFriend(friendInfo);
			int success2 = userDao.createFriend(awaiting);
			
			if(success1 == 1 && success2 == 1)
				modelAndView = new ModelAndView("androidFriendAddSuccess");
			else
				modelAndView = new ModelAndView("androidFriendAddFail");
			
		} catch(UncategorizedSQLException e) {
			modelAndView = new ModelAndView("androidFriendAddFail");
		}
		Gson newfriend = new Gson();
		modelAndView.addObject("friendUser", newfriend.toJson(friendInfo.get(0)));
		return modelAndView;
	}
	@RequestMapping(value = { "/friendApprove" }) //finish this part soon
	public ModelAndView androidFriendApprovePage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		String email = request.getParameter( "email" );
		String friendemail = request.getParameter("friendemail");
		Map<String,String> filter = new HashMap<String,String>();

		
		filter.put(UserDao.CONST_EMAIL_FIELD, "'" + friendemail + "'");
		List<User> friend = userDao.retrieveUser(filter);
		//String friendID = request.getParameter("friendID");
		Map<String,String> filter1 = new HashMap<String,String>();
		filter1.put(UserDao.CONST_F_USER_ID_FIELD, "'" + friend.get(0).getUser_id() + "'");
		filter.clear();
		filter.put(UserDao.CONST_EMAIL_FIELD, "'" + email + "'");
		List<User> myUserInfo = userDao.retrieveUser(filter);
		filter1.put(UserDao.CONST_USER_ID_FIELD, "'" + myUserInfo.get(0).getUser_id() + "'");
		Map<String,String> change1 = new HashMap<String,String>();
		change1.put(UserDao.CONST_STATUS_FIELD, "'approved'");
		//userDao.updateFriend(change, filter);//check if must perform security check
		
		Map<String,String> filter2 = new HashMap<String,String>();
		filter2.put(UserDao.CONST_F_USER_ID_FIELD, "'" + myUserInfo.get(0).getUser_id() + "'");
		filter2.put(UserDao.CONST_USER_ID_FIELD, "'" + friend.get(0).getUser_id() + "'");
		Map<String,String> change2 = new HashMap<String,String>();
		change2.put(UserDao.CONST_STATUS_FIELD, "'approved'");
		
		ModelAndView modelAndView;
		try {
			int successUpdate = userDao.updateFriend(change1, filter1);
			int successNew = userDao.updateFriend(change2, filter2);
			
			if(successUpdate == 1 && successNew == 1){
				modelAndView = new ModelAndView("androidFriendAppSuccess");
				//modelAndView = new ModelAndView("genericMessage");
				//modelAndView.addObject("pageTitle", "FRIEND APPROVE SUCCESS");
				//modelAndView.addObject("user", user.getEmail());
				//modelAndView.addObject("newLink", "/FBWebServer/friendList");
				//modelAndView.addObject("message", "Congratulations! Approving friend was successful");
			}
			else {
				modelAndView = new ModelAndView("androidFriendAppFail");
				//modelAndView = new ModelAndView("genericErrMessage");
				//modelAndView.addObject("pageTitle", "FRIEND APPROVE ERROR");
				//modelAndView.addObject("user", user.getEmail());
				//modelAndView.addObject("message", "Sorry! Approving friend was not successful");
			}
			
		} catch(UncategorizedSQLException e) {
			//modelAndView = new ModelAndView("friendAAppFail");
			modelAndView = new ModelAndView("androidGenericErrorMessage");
			//modelAndView.addObject("pageTitle", "FRIEND APPROVE ERROR");
			//modelAndView.addObject("user", user.getEmail());
			//modelAndView.addObject("message", "Sorry! Approving friend was not successful");
		}
		
		Gson newfriend = new Gson();;
		modelAndView.addObject("friendUserApp", newfriend.toJson(friend.get(0)));
		return modelAndView;	
	}
	@RequestMapping(value = { "/friendDelete" })
	public ModelAndView FriendDeletePage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		String email = request.getParameter( "email" );
		String friendemail = request.getParameter("friendemail");
		Map<String,String> filter = new HashMap<String,String>();

		filter.put(UserDao.CONST_EMAIL_FIELD, "'" + friendemail + "'");
		List<User> friend = userDao.retrieveUser(filter);
		filter.clear();
		filter.put(UserDao.CONST_EMAIL_FIELD, "'" + email + "'");
		List<User> myUserInfo = userDao.retrieveUser(filter);
	
		
		Map<String,String> friendDelete1 = new HashMap<String,String>();
		friendDelete1.put(UserDao.CONST_F_USER_ID_FIELD, "'" + friend.get(0).getUser_id() + "'");
		friendDelete1.put(UserDao.CONST_USER_ID_FIELD, "'" + myUserInfo.get(0).getUser_id() + "'");
		
		Map<String,String> friendDelete2 = new HashMap<String,String>();
		friendDelete2.put(UserDao.CONST_F_USER_ID_FIELD, "'" + myUserInfo.get(0).getUser_id() + "'");
		friendDelete2.put(UserDao.CONST_USER_ID_FIELD, "'" + friend.get(0).getUser_id() + "'");
		
		ModelAndView modelAndView;
		try {
			int successDelete1 = userDao.deleteFriend(friendDelete1);
			int successDelete2 = userDao.deleteFriend(friendDelete2);
			
			if(successDelete1 == 1 && successDelete2 == 1){
				modelAndView = new ModelAndView("androidFriendDeleteSuccess");
				//modelAndView = new ModelAndView("genericMessage");
				//modelAndView.addObject("pageTitle", "FRIEND DELETE SUCCESS");
				//modelAndView.addObject("user", user.getEmail());
				//modelAndView.addObject("newLink", "/FBWebServer/friendList");
				//modelAndView.addObject("message", "Congratulations! Deleting friend was successful");
			}
			else{
				modelAndView = new ModelAndView("androidFriendDeleteFail");
				//modelAndView = new ModelAndView("genericErrMessage");
				//modelAndView.addObject("pageTitle", "FRIEND DELETE ERROR");
				//modelAndView.addObject("user", user.getEmail());
				//modelAndView.addObject("message", "Sorry! Deleting friend was not successful");
			}
			
		} catch(UncategorizedSQLException e) {
			//modelAndView = new ModelAndView("friendDeleteFail");
			modelAndView = new ModelAndView("androidGenericErrorMessage");
			//modelAndView.addObject("pageTitle", "FRIEND DELETE ERROR");
			//modelAndView.addObject("user", user.getEmail());
			//modelAndView.addObject("message", "Sorry! Deleting friend was not successful");
		}
		Gson nofriend = new Gson();;
		modelAndView.addObject("friendUserDel", nofriend.toJson(friend.get(0)));
		return modelAndView;
	}
	@RequestMapping(value = { "/schedule" }, method = RequestMethod.GET)
	public ModelAndView scheduleListPage(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
			ModelAndView modelAndView = new ModelAndView("androidSchedule");
			//User user = getUserFromEmail();
			// Get info from HTTP request from Android app and put into hash map
			String email = request.getParameter( "email" );

			//Map<String, String> mapEmail = new HashMap<String, String>();	// Used to check if email already exists
			
			//mapEmail.put( "email", "'" + email + "'" );

			Map<String,String> filter = new HashMap<String,String>();
			filter.put(UserDao.CONST_EMAIL_FIELD, "'" + email + "'");
			//filter.put(UserDao.CONST_STATUS_FIELD, "'approved'");
			List<User> myUserInfo = userDao.retrieveUser(filter);
			
			filter.clear();
			//filter.put(UserDao.CONST_STATUS_FIELD, "'approved'");
			filter.put(UserDao.CONST_USER_ID_FIELD, myUserInfo.get(0).getUser_id());
			filter.put(UserDao.CONST_ACTIVE_FIELD, "'1'");
			List<Schedule> schedules = userDao.retrieveSchedule(filter);
			//List<Friend> friendApp = userDao.retrieveFriend(filter);
			Schedule firstSched = new Schedule();
			if (schedules.size() > 0)
				firstSched = schedules.get(0);
			else if (userDao.createSchedule(filter)>0)
				firstSched = schedules.get(0);
				
			List<Event> scheduleEvents = new ArrayList<Event>();
			
			Gson schedulesJson = new Gson();
			//for(Event event: mScheduleEvents)
			//{
				filter.clear();
				
				filter.put(UserDao.CONST_SCHEDID_FIELD, firstSched.getSchedule_id());
				scheduleEvents = userDao.retrieveEvent(filter);
			//List<String> eventNames = new ArrayList<String>
				//friendNames.add(myFriendUser.get(0).getFirst_name() + " " + myFriendUser.get(0).getLast_name());
				//myFriendUser.get(0).getFirst_name();
				//myFriendUser.get(0).getLast_name();
			//}
			
			modelAndView.addObject("myScheduleEvents", schedulesJson.toJson(scheduleEvents));
			
			return modelAndView;
		}
	
	/*
	 * Handles addition of events into a schedule.
	 */
	@RequestMapping(value = { "/inputEvent" }, method = RequestMethod.GET)
	public ModelAndView inputEventPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		ModelAndView modelAndView = new ModelAndView("androidInputEvent");
		
		// Get info from HTTP request from Android app
		String userID = request.getParameter( "user_id" );
		String name = request.getParameter( "event_name" );
		String startTime = request.getParameter( "event_start_time" );
		String endTime = request.getParameter( "event_end_time" );
		String location = request.getParameter( "event_location" );
		String description = request.getParameter( "event_description" );
		
		// Get current user's first schedule
		Map<String, String> mapUser = new HashMap<String, String>();
		mapUser.put( UserDao.CONST_USER_ID_FIELD, userID );
		mapUser.put( UserDao.CONST_ACTIVE_FIELD, "'1'");
		List<Schedule> schedules = userDao.retrieveSchedule(mapUser);
		Schedule firstSchedule = schedules.get(0);
		
		// Create event in database
		Map<String, String> mapEvent = new HashMap<String, String>();
		
		
		mapEvent.put(UserDao.CONST_NAME_FIELD, "'" + name + "'");
		mapEvent.put(UserDao.CONST_STARTTIME_FIELD, "'" + startTime + "'");
		mapEvent.put(UserDao.CONST_ENDTIME_FIELD, "'" + endTime + "'");
		mapEvent.put(UserDao.CONST_LOCATION_FIELD, "'" + location + "'");
		mapEvent.put(UserDao.CONST_DESCRIPTION_FIELD, "'" + description + "'");
		mapEvent.put(UserDao.CONST_SCHEDULEID_FIELD, "'" + firstSchedule.getSchedule_id() + "'");
		
		int result = userDao.createEvent( mapEvent );
		
		if( result == 1)
		{
			List<Event> event = userDao.retrieveEvent( mapEvent );
			Gson eventJson = new Gson();
			
			modelAndView.addObject( "event", eventJson.toJson(event) );
			response.setStatus( HttpServletResponse.SC_CREATED );
		}
		else
			response.setStatus( HttpServletResponse.SC_BAD_REQUEST );
		
		return modelAndView;
	}
	
	/*
	 * Handles editing of events in a schedule.
	 */
	@RequestMapping(value = { "/editEvent" }, method = RequestMethod.POST)
	public void editEventPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		// Get info from HTTP request from Android app
		String eventID = request.getParameter( "event_id" );
		String name = request.getParameter( "event_name" );
		String startTime = request.getParameter( "event_start_time" );
		String endTime = request.getParameter( "event_end_time" );
		String location = request.getParameter( "event_location" );
		String description = request.getParameter( "event_description" );
		
		// Edit event in database
		Map<String, String> newInfoMap = new HashMap<String, String>();
		newInfoMap.put(UserDao.CONST_NAME_FIELD, "'" + name + "'");
		newInfoMap.put(UserDao.CONST_STARTTIME_FIELD, "'" + startTime + "'");
		newInfoMap.put(UserDao.CONST_ENDTIME_FIELD, "'" + endTime + "'");
		newInfoMap.put(UserDao.CONST_LOCATION_FIELD, "'" + location + "'");
		newInfoMap.put(UserDao.CONST_DESCRIPTION_FIELD, "'" + description + "'");
		
		Map<String, String> conditions = new HashMap<String, String>();
		conditions.put( UserDao.CONST_EVENTID_FIELD, eventID );
		
		int result = userDao.updateEvent( newInfoMap, conditions );
		
		if( result == 1)
			response.setStatus( HttpServletResponse.SC_OK );
		else
			response.setStatus( HttpServletResponse.SC_BAD_REQUEST );
	}
	
	/*
	 * Handles removal of events from the user's active schedule.
	 */
	@RequestMapping(value = { "/removeEvent" }, method = RequestMethod.POST)
	public void removeEventPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		// Get info from HTTP request from Android app
		String eventID = request.getParameter( "event_id" );
		
		// Create event in database
		Map<String, String> mapEvent = new HashMap<String, String>();
		mapEvent.put(UserDao.CONST_EVENTID_FIELD, "'" + eventID + "'");
		
		int result = userDao.deleteEvent(mapEvent);
		
		if( result == 1)
			response.setStatus( HttpServletResponse.SC_OK );
		else
			response.setStatus( HttpServletResponse.SC_BAD_REQUEST );
	}
}
