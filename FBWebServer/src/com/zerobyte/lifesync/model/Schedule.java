package com.zerobyte.lifesync.model;

public class Schedule {
	 String schedule_id = "";
	 String user_id = "";
	 String active = "";
	    
	public String getUser_id()
	{
		return user_id;
    }

	public String getSchedule_id()
	{
        return schedule_id;
	}
	
	public String getActive()
	{
        return active;
	}
	
	public void setUser_id(String theUser_id)
	{
		user_id = theUser_id;
    }

	public void setSchedule_id(String theSchedule_id)
	{
		schedule_id = theSchedule_id;
	}
	
	public void setActive(String theActive)
	{
		active = theActive;
	}
}
