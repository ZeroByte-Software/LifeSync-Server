package com.zerobyte.lifesync.model;

public class NewEventForm {
	
    String name = "";
    String start_day = ""; 
    String start_hour = ""; 
    String start_minute = ""; 
    String end_day = ""; 
    String end_hour = ""; 
    String end_minute = ""; 
    String location = "";
    String description = ""; 
    String schedule_id = "";
    String event_id = "";

	public String getName()
	{
        return name;
	}
	
	public String getStart_day()
	{
		return start_day;
	}
	
	public String getStart_hour()
	{
		return start_hour;
	}
	
	public String getStart_minute()
	{
		return start_minute;
	}
	
	public String getEnd_day()
	{
		return end_day;
    }
	
	public String getEnd_hour()
	{
		return end_hour;
    }
	
	public String getEnd_minute()
	{
		return end_minute;
    }

	public String getLocation()
	{
		return location;
	}

	public String getDescription()
	{
		return description;
	}

	public String getSchedule_id()
	{
		return schedule_id;
	}
	
	public String getEvent_id()
	{
		return event_id;
	}

	public void setName(String theName)
	{
        name = theName;
	}
	
	public void setStart_day(String theStart_day)
	{
		start_day = theStart_day;
	}
	
	public void setStart_hour(String theStart_hour)
	{
		start_hour = theStart_hour;
	}
	
	public void setStart_minute(String theStart_minute)
	{
		start_minute = theStart_minute;
	}
	
	public void setEnd_day(String theEnd_day)
	{
		end_day = theEnd_day;
    }
	
	public void setEnd_hour(String theEnd_hour)
	{
		end_hour = theEnd_hour;
    }
	
	public void setEnd_minute(String theEnd_minute)
	{
		end_minute = theEnd_minute;
    }

	public void setLocation(String theLocation)
	{
		location = theLocation;
	}

	public void setDescription(String theDescription)
	{
		description = theDescription;
	}

	public void setSchedule_id(String theSchedule_id)
	{
		schedule_id = theSchedule_id;
	}
	
	public void setEvent_id(String theEvent_id)
	{
		event_id = theEvent_id;
	}
}
