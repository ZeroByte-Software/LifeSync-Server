package com.zerobyte.lifesync.model;

import java.util.ArrayList;
import java.util.List;

public class TimeSlot {
	
	List<Event> events = new ArrayList<Event>();
	List<User> users = new ArrayList<User>();
    String schedule_id = "";
    String time;
    
	public List<Event> getEvents()
	{
		return events;
    }
	
	public List<User> getUsers()
	{
		return users;
    }

	public String getSchedule_id()
	{
		return schedule_id;
	}
	
	public String getTime()
	{
		return time;
	}
	
	public void setEvent(List<Event> theEvents)
	{
		events = theEvents;
    }
	
	public void addEvent(Event theEvent)
	{
		events.add(theEvent);
    }
	
	public void addUser(User theUser)
	{
		users.add(theUser);
    }
	
	public void removeEvent(Event theEvent)
	{
		for(int i=0; i< events.size(); i++)
		{
			if(events.get(i).getEvent_id().equals(theEvent.event_id))
				events.remove(i);
		}
	}
	
	public void removeUser(User user)
	{
		for(int i=0; i< users.size(); i++)
		{
			if(users.get(i).getUser_id().equals(user.getUser_id()))
				users.remove(i);
		}
	}

	public void setSchedule_id(String theSchedule_id)
	{
		schedule_id = theSchedule_id;
	}
	
	public void setTime(String theTime)
	{
		time = theTime;
	}
}
