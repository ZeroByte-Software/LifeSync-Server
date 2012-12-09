package com.zerobyte.lifesync.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.zerobyte.lifesync.dataaccess.UserDao;
import com.zerobyte.lifesync.model.Event;
import com.zerobyte.lifesync.model.Schedule;
import com.zerobyte.lifesync.model.User;
import java.util.ArrayList;
import com.zerobyte.lifesync.model.Friend;
import com.zerobyte.lifesync.model.MergedSchedule;
import com.zerobyte.lifesync.model.NewEventForm;
 
//Handles all supported URI's related to schedules for the Facebook application
@Controller
@RequestMapping(value = { "/schedules" })
public class ScheduleController {
 
	@Autowired
	@Qualifier("userDao")
	UserDao userDao;
	
	private static final String CONST_UNIVERSAL_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
	
	//Handles the request for a view of a list of schedules belonging to the logged in user 
	@RequestMapping(value = { "" })
	public ModelAndView schedListPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		
		ModelAndView modelAndView = new ModelAndView("scheduleList");
		modelAndView.addObject("schedules", retrieveScheduleForUser(user.getUser_id()));
		modelAndView.addObject("user", user.getEmail());
		
		return modelAndView;	
	}
	
	//Handles the schedule viewing functionality by returning a table representation of a schedule 
	@RequestMapping(value = { "/schedule/view" })
	public ModelAndView schedViewPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		
		String scheduleID = request.getParameter("scheduleID");
		if(scheduleID == null || scheduleID.isEmpty())
			return createMessageModelAndView("Error","No schedule id was provided in the parameters.",user.getEmail());
		if(checkScheduleViewRights(user.getEmail(),scheduleID) == false)
			return createMessageModelAndView("Error","You do not have the right to view the schedule.",user.getEmail());

		ModelAndView modelAndView = new ModelAndView("eventList");
		modelAndView.addObject("user", user.getEmail());
		modelAndView.addObject("scheduleID", scheduleID);
		
		List<Event> events = retrieveEventsForSchedule(scheduleID);
		
		try {
			events = convertToTimeSlots(events);
			
			for (int i=0;i<events.size();i++){
				//Check against every time slot(48*7=336)
				for(int j=0;j<337;j++){
					int day=j/48+1;
	
				//Assume the start and end time in Event is in the form "integer". 
				//"1" stands for 0:00 Monday, "2" stands for 0:30 Monday, 
				//"48" stands for 0:00 Tuesday, "96"stands for 0:00 Wednesday as son on...
	
					String day2="";
					switch(day){
					case 1:
						day2="Sunday";
						break;
					case 2: 
						day2="Monday";
						break;
					case 3:
						day2="Tuesday";
						break;
					case 4:
						day2="Wednesday";
						break;
					case 5:
						day2="Thursday";
						break;
					case 6:
						day2="Friday";
						break;
					case 7:
						day2="Saturday";
						break;
					}
					
					int start_t=Integer.valueOf(events.get(i).getStart_time()).intValue();
					int end_t=Integer.valueOf(events.get(i).getEnd_time()).intValue();
					
					if(start_t<=j &&j< end_t) {
						modelAndView.addObject(day2+Integer.toString(j%48+1), events.get(i));
						modelAndView.addObject(day2+Integer.toString(j%48+1)+"c", "red");
					}
				}
			}			
	        //Retrieve list of Friends to select to merge
			modelAndView.addObject("friends", retrieveFriendsToMergeForUser(user.getUser_id()));
			
		} catch (ParseException e) {
			return createMessageModelAndView("Error","Unable to parse date provided by database.",user.getEmail());
		}
		
		return modelAndView;	
	}
	
	//Converts date field in event object to reference a time slot in the table
	private List<Event> convertToTimeSlots(List<Event> events) throws ParseException
	{
		List<Event> timeslots = events;
		for(Event event: timeslots)
		{
			String startTime = event.getStart_time();
			String endTime = event.getEnd_time();
			
			//'2012-10-24 21:00:00'
			SimpleDateFormat format = new SimpleDateFormat(CONST_UNIVERSAL_DATE_FORMAT);
			
			Date startTimeDate = format.parse(startTime);
			Date endTimeDate = format.parse(endTime);
			
			event.setStart_time(Integer.toString(dateToTimeSlot(startTimeDate)));
			event.setEnd_time(Integer.toString(dateToTimeSlot(endTimeDate)));

		}
		
		return timeslots;
	}
	
	//Converts date to relevent periodic time slot in the schedule table
	private int dateToTimeSlot(Date date)
	{
		Calendar cal = Calendar.getInstance();
		cal.setTime(date); 
		int day = cal.get(Calendar.DAY_OF_WEEK)-1;
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		int minutes = cal.get(Calendar.MINUTE);
		int timeslot = 0;
		
		if(minutes >= 0 && minutes < 30 )
			timeslot = (day * 48) + (hour * 2 ) + 1 - 1;
		else if(minutes >= 30 && minutes < 60 )
			timeslot = (day * 48) + (hour * 2 ) + 2 - 1;
		
		return timeslot;
	}
	
	//Converts date field to reference a time slot in the table in order to use table representation
	@RequestMapping(value = { "/schedule/create" }, method = RequestMethod.GET)
	public ModelAndView schedCreatePage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		
		ModelAndView modelAndView = new ModelAndView("createSchedule");
		modelAndView.addObject("user", user.getEmail());
		return modelAndView;	
	}
	
	//Handles merging functionality of schedules by returning a representation of more than one schedule
	@RequestMapping(value = { "/schedule/merge" }, method = RequestMethod.GET)
	public ModelAndView schedMergePage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		
		String scheduleID = request.getParameter("scheduleID");
		String[] userToMerge = request.getParameterValues("friendToMerge");
		if(scheduleID == null || scheduleID.isEmpty())
			return createMessageModelAndView("Error","No schedule id was provided in the parameters.",user.getEmail());
		if(checkScheduleViewRights(user.getEmail(),scheduleID) == false)
			return createMessageModelAndView("Error","You do not have rights to view the schedule.",user.getEmail());
		if(userToMerge == null || userToMerge.length == 0)
			return createMessageModelAndView("Error","No users requested for merging was provided in the parameters.",user.getEmail());
		
		ModelAndView modelAndView = new ModelAndView("mergedSchedView");
		modelAndView.addObject("scheduleID", scheduleID);
		modelAndView.addObject("user", user.getEmail());
		
		//Retrieve list of Friends with schedules available for users to merge with
		modelAndView.addObject("friends", retrieveFriendsToMergeForUser(user.getUser_id()));
		
		//Retrieve data necessary to merge schedules
		List<List<Event>> friendSchedules = new ArrayList<List<Event>>();
		Map<String, User> owners = new HashMap<String,User>();
		owners.put(scheduleID, retrieveUserOfSchedule(scheduleID));
		
		if(userToMerge != null && userToMerge.length > 0)
		{
			for(int i = 0; i < userToMerge.length; i++)
			{
				List<Event> activeSched = retrieveActiveScheduleEventsForUser(userToMerge[i]);
				if (activeSched != null && !activeSched.isEmpty())
				{
					friendSchedules.add(activeSched);
					
					String theScheduleID = activeSched.get(0).getSchedule_id(); 
					if(checkScheduleViewRights(user.getEmail(),theScheduleID) == false)
						return createMessageModelAndView("Error","You do not have rights to view the schedule.",user.getEmail());

					owners.put(theScheduleID, retrieveUserOfSchedule(theScheduleID));
				}
				else 
				{
					return createMessageModelAndView("Error","One or more users does not have an active schedule.",user.getEmail());
				}
			}
		}

		friendSchedules.add(retrieveEventsForSchedule(scheduleID));
		
		try{
			
			MergedSchedule mergedSched = new MergedSchedule();
			modelAndView.addObject("mergedSchedule", mergedSched.mergeSchedule(owners,friendSchedules));
			
		} catch (ParseException e) {
			return createMessageModelAndView("Error","Unable to merge schedule due to a date format error.",user.getEmail());
		}
		return modelAndView;	
	}
	
	//Handles event viewing for events within a merged schedule
	@RequestMapping(value = { "/schedule/merge/event/view" }, method = RequestMethod.GET)
	public ModelAndView eventViewPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException,ParseException {
		
		User user = getUserFromEmail();
		
		String eventID = request.getParameter("eventID");
		if(eventID == null || eventID.isEmpty())
			return createMessageModelAndView("Error","No event id was provided in the parameters.",user.getEmail());
		
		Event event = retrieveEventWithEventId(eventID);
		if(event == null)
			return createMessageModelAndView("Error","No such event exists with specified ID",user.getEmail());
		if(checkScheduleViewRights(user.getEmail(),event.getSchedule_id()) == false)
			return createMessageModelAndView("Error","You do not have the right to view the schedule.",user.getEmail());
		
		NewEventForm eventForm = convertEventToNewEventForm(event);
		
		ModelAndView modelAndView = new ModelAndView("eventViewMerge");
		modelAndView.addObject("origEvent", eventForm);
		modelAndView.addObject("user", user.getEmail());
		return modelAndView;
	}
	
	//Handles event creation functionality by returning a form for event data
	@RequestMapping(value = { "/schedule/events/event/create" }, method = RequestMethod.GET)
	public ModelAndView eventCreatePage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		
		String schedID = request.getParameter("scheduleID");
		if(schedID == null || schedID.isEmpty())
			return createMessageModelAndView("Error","No schedule id was provided in the parameters.",user.getEmail());
		if(checkScheduleEditRights(user.getEmail(), schedID) == false)
			return createMessageModelAndView("Error","You do not have the right to edit the schedule.",user.getEmail());
		
		ModelAndView modelAndView = new ModelAndView("createEvent");
		modelAndView.addObject("newEvent", new NewEventForm());
		modelAndView.addObject("user", user.getEmail());
		modelAndView.addObject("scheduleID", schedID);
		return modelAndView;	
	}
	
	//Handles event removal functionality
	@RequestMapping(value = { "/schedule/events/event/delete" }, method = RequestMethod.GET)
	public ModelAndView eventDeletePage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		
		String eventID = request.getParameter("eventID");
		if(eventID == null || eventID.isEmpty())
			return createMessageModelAndView("Error","No event id was provided in the parameters.",user.getEmail());
		String schedID = retrieveEventWithEventId(eventID).getSchedule_id();
		if(checkScheduleEditRights(user.getEmail(), schedID) == false)
			return createMessageModelAndView("Error","You do not have the right to edit the schedule.",user.getEmail());
		
		Map<String,String> conditions = new HashMap<String,String>();
		conditions.put(UserDao.CONST_EVENTID_FIELD, "'" + eventID + "'");
		
		if(userDao.deleteEvent(conditions) != 1)
			return createMessageModelAndView("Error","Event removal was unsuccessful.",user.getEmail());
		
		String redirectUrl = "/schedules/schedule/view?scheduleID=" + schedID;
		return new ModelAndView("redirect:" + redirectUrl);
	}
	
	//Handles event creation functionality utilizing form data to create an event
	@RequestMapping(value = { "/schedule/events/event/create" }, method = RequestMethod.POST)
	public ModelAndView eventCreatePage2(HttpServletRequest request,
		HttpServletResponse response, @ModelAttribute("newEvent") NewEventForm newEvent) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		
		if(newEvent.getName().isEmpty() || newEvent.getStart_day().isEmpty() || newEvent.getStart_hour().isEmpty() || newEvent.getStart_minute().isEmpty() || newEvent.getEnd_day().isEmpty() || newEvent.getEnd_hour().isEmpty() || newEvent.getEnd_minute().isEmpty() || newEvent.getSchedule_id().isEmpty())
			return createMessageModelAndView("Error","One or more mandatory fields were left empty.",user.getEmail());
		else if (!StringUtils.isAlphanumericSpace(newEvent.getName()) || !StringUtils.isAlphanumericSpace(newEvent.getLocation()) || !StringUtils.isAlphanumericSpace(newEvent.getDescription()) )
			return createMessageModelAndView("Error","Only alphanumeric and space characters are allowed as string inputs.",user.getEmail());
		else if(!StringUtils.isNumeric(newEvent.getStart_day()) || !StringUtils.isNumeric(newEvent.getStart_hour()) || !StringUtils.isNumeric(newEvent.getStart_minute()) || !StringUtils.isNumeric(newEvent.getEnd_day()) || !StringUtils.isNumeric(newEvent.getEnd_hour()) || !StringUtils.isNumeric(newEvent.getEnd_minute()))
			return createMessageModelAndView("Error","Only numeric characters are allowed as time inputs.",user.getEmail());
		if(checkScheduleEditRights(user.getEmail(), newEvent.getSchedule_id()) == false)
			return createMessageModelAndView("Error","You do not have the right to edit the schedule.",user.getEmail());
		
		if(Integer.parseInt(newEvent.getEnd_day()) == Integer.parseInt(newEvent.getStart_day()) && Integer.parseInt(newEvent.getEnd_hour()) == Integer.parseInt(newEvent.getStart_hour()) && Integer.parseInt(newEvent.getEnd_minute()) == Integer.parseInt(newEvent.getStart_minute()))		
			return createMessageModelAndView("Error","The start date is the same as the end date.",user.getEmail());
		if(Integer.parseInt(newEvent.getEnd_day()) == Integer.parseInt(newEvent.getStart_day()) && Integer.parseInt(newEvent.getEnd_hour()) < Integer.parseInt(newEvent.getStart_hour()))		
			return createMessageModelAndView("Error","The start hour should not be after the end hour.",user.getEmail());
		
		
		if(Integer.parseInt(newEvent.getEnd_day()) < Integer.parseInt(newEvent.getStart_day()))		
			return createMessageModelAndView("Error","The start day should not be after the end day.",user.getEmail());
		
	
		if(Integer.parseInt(newEvent.getEnd_day()) == Integer.parseInt(newEvent.getStart_day()) && (Integer.parseInt(newEvent.getEnd_hour()) == Integer.parseInt(newEvent.getStart_hour())) && (Integer.parseInt(newEvent.getEnd_minute()) < Integer.parseInt(newEvent.getStart_minute())) )		
			return createMessageModelAndView("Error","The start minute should not be after the end minute.",user.getEmail());
		
		String startTime;
		String endTime;
		
		try {
			
			startTime = convertToDateFormat(newEvent.getStart_day(), newEvent.getStart_hour(), newEvent.getStart_minute());
			endTime = convertToDateFormat(newEvent.getEnd_day(), newEvent.getEnd_hour(), newEvent.getEnd_minute());
			
			if(isOverlapping(startTime,endTime,newEvent.getSchedule_id(),null))
				return createMessageModelAndView("Error","Event specified overlaps with an existing event in the schedule.",user.getEmail());
		
		} catch (ArrayIndexOutOfBoundsException e) {
			return createMessageModelAndView("Error","Supplied date does not exist.",user.getEmail());	
		} catch (ParseException e) {
			return createMessageModelAndView("Error","Unable to parse dates of events.",user.getEmail());
		}
		
		Map<String,String> attributes = new HashMap<String,String>();
		attributes.put(UserDao.CONST_NAME_FIELD, "'" + newEvent.getName() + "'");
		attributes.put(UserDao.CONST_STARTTIME_FIELD, "'"+ startTime+ "'");
		attributes.put(UserDao.CONST_ENDTIME_FIELD, "'" + endTime + "'");
		attributes.put(UserDao.CONST_LOCATION_FIELD, "'" + newEvent.getLocation() + "'");
		attributes.put(UserDao.CONST_DESCRIPTION_FIELD, "'" + newEvent.getDescription() + "'");
		attributes.put(UserDao.CONST_SCHEDULEID_FIELD, newEvent.getSchedule_id());
		
		if(userDao.createEvent(attributes) != 1)
			return createMessageModelAndView("Error","Event creation was unsuccessful.",user.getEmail());

		
		String redirectUrl = "/schedules/schedule/view?scheduleID=" + newEvent.getSchedule_id();
		return new ModelAndView("redirect:" + redirectUrl);
	}
	
	//Check if event time overlaps with an existing event in database
	private boolean isOverlapping(String startDate, String endDate, String schedule_id, String event_id) throws ParseException
	{
		SimpleDateFormat dateFormat = new SimpleDateFormat(CONST_UNIVERSAL_DATE_FORMAT); 
		
		Calendar startCal = Calendar.getInstance();
		startCal.setLenient(false);
		startCal.setTime(dateFormat.parse(startDate));
		
		Calendar endCal = Calendar.getInstance();
		endCal.setLenient(false);
		endCal.setTime(dateFormat.parse(endDate));
		
		Calendar startCalDB = Calendar.getInstance();
		startCalDB.setLenient(false);
		Calendar endCalDB = Calendar.getInstance();
		endCalDB.setLenient(false);
		
		List<Event> events = retrieveEventsForSchedule(schedule_id);
		
		for (Event event: events)
		{
			if(event_id == null || !event_id.equals(event.getEvent_id()))
			{
				startCalDB.setTime(dateFormat.parse(event.getStart_time()));
				endCalDB.setTime(dateFormat.parse(event.getEnd_time()));
				
				if(startCalDB.compareTo(endCal) <= 0 && endCalDB.compareTo(startCal) >= 0)
					return true;
				
				startCalDB.clear();
				endCalDB.clear();
			}
		}
		
		return false;
	}
	
	//Handles event editing functionality by returning a form to retrieve changes to an event
	@RequestMapping(value = { "/schedule/events/event/edit" }, method = RequestMethod.GET)
	public ModelAndView eventEditPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		
		String eventID = request.getParameter("eventID");
		if(eventID == null || eventID.isEmpty())
			return createMessageModelAndView("Error","No event id was provided in the parameters.",user.getEmail());
		
		Event event = retrieveEventWithEventId(eventID);
		if(event == null)
			return createMessageModelAndView("Error","Unable to find event with specified event ID",user.getEmail());
		if(checkScheduleEditRights(user.getEmail(), event.getSchedule_id()) == false)
			return createMessageModelAndView("Error","You do not have the right to edit the schedule.",user.getEmail());
		
		try{
			NewEventForm eventForm = convertEventToNewEventForm(event);
			
			ModelAndView modelAndView = new ModelAndView("eventView");
			modelAndView.addObject("origEvent", eventForm);
			modelAndView.addObject("editEvent", new NewEventForm());
			modelAndView.addObject("scheduleID", event.getSchedule_id());
			modelAndView.addObject("user", user.getEmail());
			return modelAndView;
			
		} catch (ParseException e) {
			return createMessageModelAndView("Error","Unable to parse date from database.",user.getEmail());
		}
	}
	
	private NewEventForm convertEventToNewEventForm(Event event) throws ParseException
	{
		NewEventForm eventForm = new NewEventForm();		
		SimpleDateFormat dateFormat = new SimpleDateFormat(CONST_UNIVERSAL_DATE_FORMAT); 
		
		Calendar cal = Calendar.getInstance();
		cal.setLenient(false);
		
		cal.setTime(dateFormat.parse(event.getStart_time()));
		eventForm.setStart_day(String.valueOf(cal.get(Calendar.DAY_OF_WEEK)));
		eventForm.setStart_hour(String.valueOf(cal.get(Calendar.HOUR_OF_DAY)));
		eventForm.setStart_minute(String.valueOf(cal.get(Calendar.MINUTE)));
		
		cal.clear();
		cal.setTime(dateFormat.parse(event.getEnd_time()));
		eventForm.setEnd_day(String.valueOf(cal.get(Calendar.DAY_OF_WEEK)));
		eventForm.setEnd_hour(String.valueOf(cal.get(Calendar.HOUR_OF_DAY)));
		eventForm.setEnd_minute(String.valueOf(cal.get(Calendar.MINUTE)));

		eventForm.setName(event.getName());
		eventForm.setSchedule_id(event.getSchedule_id());
		eventForm.setLocation(event.getLocation());
		eventForm.setDescription(event.getDescription());
		eventForm.setEvent_id(event.getEvent_id());

		return eventForm;
	}
	
	//Handles event editing functionality by returning a form to retrieve changes to an event
	@RequestMapping(value = { "/schedule/events/event/edit" }, method = RequestMethod.POST)
	public ModelAndView eventEditPage2(HttpServletRequest request,
		HttpServletResponse response, @ModelAttribute("editEvent") NewEventForm editEvent) throws ServletException, IOException {
				
		User user = getUserFromEmail();
		
		if(editEvent.getName().isEmpty() || editEvent.getStart_day().isEmpty() || editEvent.getStart_hour().isEmpty() || editEvent.getStart_minute().isEmpty() || editEvent.getEnd_day().isEmpty() || editEvent.getEnd_hour().isEmpty() || editEvent.getEnd_minute().isEmpty() || editEvent.getSchedule_id().isEmpty())
			return createMessageModelAndView("Error","One or more mandatory fields were left empty.",user.getEmail());
		else if (!StringUtils.isAlphanumericSpace(editEvent.getName()) || !StringUtils.isAlphanumericSpace(editEvent.getLocation()) || !StringUtils.isAlphanumericSpace(editEvent.getDescription()) )
			return createMessageModelAndView("Error","Only alphanumeric and space characters are allowed as string inputs.",user.getEmail());
		else if(!StringUtils.isNumeric(editEvent.getStart_day()) || !StringUtils.isNumeric(editEvent.getStart_hour()) || !StringUtils.isNumeric(editEvent.getStart_minute()) || !StringUtils.isNumeric(editEvent.getEnd_day()) || !StringUtils.isNumeric(editEvent.getEnd_hour()) || !StringUtils.isNumeric(editEvent.getEnd_minute()))
			return createMessageModelAndView("Error","Only numeric characters are allowed as time inputs.",user.getEmail());
		if(checkScheduleEditRights(user.getEmail(), editEvent.getSchedule_id()) == false)
			return createMessageModelAndView("Error","You do not have the right to edit the schedule.",user.getEmail());
		
		if(Integer.parseInt(editEvent.getEnd_day()) == Integer.parseInt(editEvent.getStart_day()) && Integer.parseInt(editEvent.getEnd_hour()) == Integer.parseInt(editEvent.getStart_hour()) && Integer.parseInt(editEvent.getEnd_minute()) == Integer.parseInt(editEvent.getStart_minute()))		
			return createMessageModelAndView("Error","The start date is the same as the end date.",user.getEmail());
		if(Integer.parseInt(editEvent.getEnd_day()) == Integer.parseInt(editEvent.getStart_day()) && Integer.parseInt(editEvent.getEnd_hour()) < Integer.parseInt(editEvent.getStart_hour()))		
			return createMessageModelAndView("Error","The start hour should not be after the end hour.",user.getEmail());
		
		
		if(Integer.parseInt(editEvent.getEnd_day()) < Integer.parseInt(editEvent.getStart_day()))		
			return createMessageModelAndView("Error","The start day should not be after the end day.",user.getEmail());
		
	
		if(Integer.parseInt(editEvent.getEnd_day()) == Integer.parseInt(editEvent.getStart_day()) && (Integer.parseInt(editEvent.getEnd_hour()) == Integer.parseInt(editEvent.getStart_hour())) && (Integer.parseInt(editEvent.getEnd_minute()) < Integer.parseInt(editEvent.getStart_minute())) )		
			return createMessageModelAndView("Error","The start minute should not be after the end minute.",user.getEmail());
		
		
		String startTime;
		String endTime;
		
		try {
			
			startTime = convertToDateFormat(editEvent.getStart_day(), editEvent.getStart_hour(), editEvent.getStart_minute());
			endTime = convertToDateFormat(editEvent.getEnd_day(), editEvent.getEnd_hour(), editEvent.getEnd_minute());
			
			if(isOverlapping(startTime,endTime,editEvent.getSchedule_id(),editEvent.getEvent_id()))
				return createMessageModelAndView("Error","Event specified overlaps with an existing event in the schedule.",user.getEmail());
		
		} catch (ArrayIndexOutOfBoundsException e) {
			return createMessageModelAndView("Error","Supplied date does not exist.",user.getEmail());
		} catch (ParseException e) {
			return createMessageModelAndView("Error","Unable to parse dates of events.",user.getEmail());
		}
		
		Map<String,String> changes = new HashMap<String,String>();
		changes.put(UserDao.CONST_NAME_FIELD, "'" + editEvent.getName() + "'");
		changes.put(UserDao.CONST_STARTTIME_FIELD, "'"+ startTime+ "'");
		changes.put(UserDao.CONST_ENDTIME_FIELD, "'" + endTime + "'");
		changes.put(UserDao.CONST_LOCATION_FIELD, "'" + editEvent.getLocation() + "'");
		changes.put(UserDao.CONST_DESCRIPTION_FIELD, "'" + editEvent.getDescription() + "'");
		changes.put(UserDao.CONST_SCHEDULEID_FIELD, editEvent.getSchedule_id());
		
		Map<String,String> conditions = new HashMap<String,String>();
		conditions.put(UserDao.CONST_EVENTID_FIELD, "'" + editEvent.getEvent_id() + "'");
		
		if(userDao.updateEvent(changes, conditions) != 1)
			return createMessageModelAndView("Error","Event update was unsuccessful.",user.getEmail());

		
		String redirectUrl = "/schedules/schedule/view?scheduleID=" + editEvent.getSchedule_id();
		return new ModelAndView("redirect:" + redirectUrl);
	}
	
	//Handles schedule creation functionality by creating a schedule on the database
	@RequestMapping(value = { "/schedule/create" }, method = RequestMethod.POST)
	public ModelAndView schedCreatePage2(HttpServletRequest request,
		HttpServletResponse response, @ModelAttribute("newSchedule") Schedule schedule) throws ServletException, IOException {
		
		User user = getUserFromEmail();
	    
		Map<String,String> attributes = new HashMap<String,String>();
		attributes.put(UserDao.CONST_USER_ID_FIELD, user.getUser_id());
		
		if(userDao.createSchedule(attributes) == 1)
			return createMessageModelAndView("Success","Successfully created a new schedule! You can view your schedule <a href=\"/FBWebServer/schedules\">here</a>.",user.getEmail());
		else
			return createMessageModelAndView("Error","Schedule creation was unsuccessful.",user.getEmail());
			
	}
	
	//TODO:SET ACTIVE
	//Handles schedule creation functionality by creating a schedule on the database

	@RequestMapping(value = { "/schedule/setActive" })
	public ModelAndView schedEditPage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();
		
		String scheduleId = request.getParameter("scheduleID");
		if(scheduleId == null || scheduleId.isEmpty())
			return createMessageModelAndView("Error","No schedule id was provided in the parameters.",user.getEmail());
		
		List<Schedule> schedules = retrieveScheduleForUser(user.getUser_id());
		
		for(Schedule schedule: schedules)
		{
			if(scheduleId.equals(schedule.getSchedule_id()))
			{
				if(setActiveOnSchedule(schedule.getSchedule_id(),true) == false)
					return createMessageModelAndView("Error","Unable to update schedule to being active.",user.getEmail());
			}
			else
			{
				if(setActiveOnSchedule(schedule.getSchedule_id(),false) == false)
					return createMessageModelAndView("Error","Unable to update schedule to being inactive.",user.getEmail());
			}
		}
		
		return new ModelAndView("redirect:/schedules");	
	}
	
	//Handles schedule deletion functionality by deleting a schedule on the database
	@RequestMapping(value = { "/schedule/delete" })
	public ModelAndView schedDeletePage(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {
		
		User user = getUserFromEmail();

		String scheduleId = request.getParameter("scheduleID");
		if(scheduleId == null || scheduleId.isEmpty())
			return createMessageModelAndView("Error","No schedule id was provided in the parameters.",user.getEmail());
		if(checkScheduleEditRights(user.getEmail(),scheduleId) == false)
			return createMessageModelAndView("Error","No schedule id was provided in the parameters.",user.getEmail());
		
		Map<String,String> attributes = new HashMap<String,String>();
		attributes.put(UserDao.CONST_SCHEDID_FIELD, "'" + scheduleId + "'");
		
		if(userDao.deleteSchedule(attributes) == 1)
			return createMessageModelAndView("Success","Successfully deleted the schedule! You can view your other schedules <a href=\"/FBWebServer/schedules\">here</a>.",user.getEmail());
		else
			return createMessageModelAndView("Error","Schedule deletion was unsuccessful.",user.getEmail());	
	}
	
	//Sets specified schedule to active or inactive 
	private boolean setActiveOnSchedule(String schedule_id, boolean isActive)
	{
		Map<String,String> conditions = new HashMap<String,String>();
		conditions.put(UserDao.CONST_SCHEDID_FIELD, schedule_id);
		
		Map<String,String> changes = new HashMap<String,String>();
		
		if(isActive) 
		{
			changes.put(UserDao.CONST_ACTIVE_FIELD, "1");
		}
		else
			changes.put(UserDao.CONST_ACTIVE_FIELD, "0");
		
		if(userDao.updateSchedule(changes, conditions) == 1)
			return true;
		else
			return false;
	}
	
	//Converts inputs into a string date with a specific format
	private String convertToDateFormat(String day, String hour, String minute) throws ArrayIndexOutOfBoundsException
	{
		SimpleDateFormat dateFormat = new SimpleDateFormat(CONST_UNIVERSAL_DATE_FORMAT); 
		int baseYear = 2012;
		int baseMonth = 11;
		int baseDay = 17;
		Calendar cal = Calendar.getInstance();
		cal.setLenient(false);
		cal.set(baseYear, baseMonth-1, baseDay + Integer.parseInt(day), Integer.parseInt(hour), Integer.parseInt(minute),0);
		
		String date = dateFormat.format(cal.getTime()).toString();
		return date;
	}
	
	//Retrieves user object representing the user with the email associated with the logged-in user
	private User getUserFromEmail()
	{
		Map<String,String> filter = new HashMap<String,String>();
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String userEmail = auth.getName(); //get logged in username
	      
		filter.put(UserDao.CONST_EMAIL_FIELD, "'" + userEmail + "'");
		List<User> users = userDao.retrieveUser(filter);
		
		return users.get(0);
	}
	
	//Returns a generic ModelAndView object for error messages 
	private ModelAndView createMessageModelAndView(String pageTitle, String message, String userEmail)
	{
		ModelAndView modelAndView = new ModelAndView("genericMessage");
		modelAndView.addObject("pageTitle", pageTitle);
		modelAndView.addObject("message", message);
		modelAndView.addObject("user", userEmail);
		return modelAndView;
	}
	
	//Retrieves list of schedule objects representing the schedules belonging to the user with the specified user id
	private List<Schedule> retrieveScheduleForUser(String user_id)
	{
		Map<String,String> filter = new HashMap<String,String>();
		filter.put(UserDao.CONST_USER_ID_FIELD, user_id);	
		return userDao.retrieveSchedule(filter);
	}
	
	//Retrieves list of event objects representing the events of the active schedule belonging to the user with the specified user id
	private List<Event> retrieveActiveScheduleEventsForUser(String user_id)
	{
		List<Schedule> schedule = retrieveActiveScheduleForUser(user_id);
		if(schedule.size() == 0)
			return null;
		Map<String,String> filter = new HashMap<String,String>();
		filter.put(UserDao.CONST_SCHEDID_FIELD, schedule.get(0).getSchedule_id());
		return userDao.retrieveEvent(filter);
	}
	
	//Retrieves user object representing the owner of the schedule with the specified id
	private User retrieveUserOfSchedule(String scheduleID)
	{
		Map<String,String> conditions = new HashMap<String,String>();
		conditions.put(UserDao.CONST_SCHEDULEID_FIELD, scheduleID);
		List<Schedule> schedule = userDao.retrieveSchedule(conditions);
		
		conditions.clear();
		conditions.put(UserDao.CONST_USER_ID_FIELD, schedule.get(0).getUser_id());
		List<User> user = userDao.retrieveUser(conditions);
		
		return user.get(0);
	}
	
	//Retrieves schedule object representing the active schedule of the user with the specified id
	private List<Schedule> retrieveActiveScheduleForUser(String user_id)
	{
		Map<String,String> filter = new HashMap<String,String>();
		filter.put(UserDao.CONST_USER_ID_FIELD, user_id);	
		filter.put(UserDao.CONST_ACTIVE_FIELD, "1");
		return userDao.retrieveSchedule(filter);
	}
	
	//Retrieves list of event objects representing the events belonging to a schedule with the specified schedule id
	private List<Event> retrieveEventsForSchedule(String schedule_id)
	{
		Map<String,String> conditions = new HashMap<String,String>();
		conditions.put(UserDao.CONST_SCHEDID_FIELD,schedule_id);
		return userDao.retrieveEvent(conditions);
	}
	
	//Retrieves list of friend objects representing the approved friends of the user with specified user id
	private List<Friend> retrieveFriendsForUser(String user_id)
	{
		Map<String,String> conditions = new HashMap<String,String>();
		conditions.put(UserDao.CONST_USER_ID_FIELD, user_id);
		conditions.put(UserDao.CONST_STATUS_FIELD, "'approved'");
		
		return userDao.retrieveFriend(conditions);
	}
	
	//Retrieves list of user objects representing the approved friends of the user with the specified user id
	private List<User> retrieveFriendsToMergeForUser(String user_id)
	{
		List<Friend> friends = retrieveFriendsForUser(user_id);
		List<User> friendUsers = new ArrayList<User>();
		Map<String,String> conditions = new HashMap<String,String>();
		
		for(Friend friend: friends)
		{
			if(retrieveActiveScheduleForUser(friend.getF_user_id()).size() != 0)
			{
				conditions.put(UserDao.CONST_USER_ID_FIELD, friend.getF_user_id());
				friendUsers.add(userDao.retrieveUser(conditions).get(0));
			}
		}
		
		return friendUsers;
	}
	
	//Retrieves event object with the specified event id
	private Event retrieveEventWithEventId(String event_id)
	{
		Map<String,String> conditions = new HashMap<String,String>();
		conditions.put(UserDao.CONST_EVENTID_FIELD, "'" + event_id + "'");
		return userDao.retrieveEvent(conditions).get(0);
	}
	
	//Checks if user is allowed to view
	public boolean checkScheduleViewRights(String email, String scheduleID)
	{
		User user = getUserFromEmail();
		String targetUser = user.getUser_id();
		
		Map<String,String> conditions = new HashMap<String,String>();		
		conditions.put(UserDao.CONST_SCHEDID_FIELD, "'" + scheduleID + "'");
		Schedule schedule = userDao.retrieveSchedule(conditions).get(0);

		//Check if you are the owner if the schedule
		if(targetUser.equals(schedule.getUser_id()))
			return true;
    
		//Check if you are a friend of the schedule's owner
		conditions.clear();
		conditions.put(UserDao.CONST_USER_ID_FIELD, "'" + schedule.getUser_id() + "'");
		List<Friend> friends = userDao.retrieveFriend(conditions);
		
		  for(Friend friend: friends)
		  {
		    	if(targetUser.equals(friend.getF_user_id()))
		    		return true;
		  }
		
		return false;
	}
	
	//Checks if user is allowed to edit
	public boolean checkScheduleEditRights(String email, String scheduleID)
	{
		Map<String,String> conditions = new HashMap<String,String>();
		conditions.put(UserDao.CONST_EMAIL_FIELD, "'" + email + "'");
		User user = userDao.retrieveUser(conditions).get(0);
		String targetUserID = user.getUser_id();
		
		conditions.clear();
		conditions.put(UserDao.CONST_SCHEDID_FIELD, "'" + scheduleID + "'");
		Schedule schedule = userDao.retrieveSchedule(conditions).get(0);

		if(targetUserID.equals(schedule.getUser_id()))
			return true;
		
		return false;
	}
}
