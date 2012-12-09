package com.zerobyte.lifesync.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.zerobyte.lifesync.dataaccess.UserDao;

public class MergedSchedule {	
	
	private static final int CONST_MAX_TIMESLOTS_PER_SCHEDULE = 48 * 7;
	private TimeSlot finalSchedule[] = new TimeSlot[CONST_MAX_TIMESLOTS_PER_SCHEDULE];
	
	@Autowired
	@Qualifier("userDao")
	UserDao userDao;
	
	public TimeSlot[] mergeSchedule(Map<String,User> owners, List<List<Event>> schedules) throws ParseException
	{
	    initializeTimeSlot();
	    
		for(List<Event> schedule: schedules)
		{
			if(!schedule.isEmpty())
			{
				for(Event event: schedule)
				{
					int startTimeSlot = convertToTimeSlots(event.getStart_time());
					int endTimeSlot = convertToTimeSlots(event.getEnd_time());
															
					for(int i=startTimeSlot;i<endTimeSlot; i++)
					{
						finalSchedule[i].addEvent(event);	 
						finalSchedule[i].addUser(owners.get(event.getSchedule_id()));
					}		
				}
			}
		}

		return finalSchedule;
	}
	
	private void initializeTimeSlot()
	{
		SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm");
		Calendar calendar = Calendar.getInstance();
		calendar.setLenient(false);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		
		String time = ""; 
		for (int i=0;i<finalSchedule.length;i++)
		{
			if(i%48 == 0)
			{
				calendar.set(Calendar.HOUR_OF_DAY, 0);
				calendar.set(Calendar.MINUTE, 0);
			}
			
			finalSchedule[i] = new TimeSlot();
			time = dateFormat.format(calendar.getTime()).toString();
			finalSchedule[i].setTime(time);
			calendar.add(Calendar.MINUTE, 30);
		}
	}
	
	private int convertToTimeSlots(String date) throws ParseException
	{
		int timeslot = 0;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date startTimeDate = format.parse(date);
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(startTimeDate);
		int day = cal.get(Calendar.DAY_OF_WEEK) - 1;
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		int minutes = cal.get(Calendar.MINUTE);
				
		if(minutes >= 0 && minutes < 30 )
			timeslot = (day * 48) + (hour * 2 );
		else if(minutes >= 30 && minutes < 60 )
			timeslot = (day * 48) + (hour * 2 ) + 1;
			
		return timeslot;
	}
	
}
