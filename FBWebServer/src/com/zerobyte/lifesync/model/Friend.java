package com.zerobyte.lifesync.model;

public class Friend {
	String user_id = "";
    String f_user_id = "";
    String status = ""; 
    
	public String getUser_id()
	{
		return user_id;
    }

	public String getF_user_id()
	{
        return f_user_id;
	}

	public String getStatus()
	{
		return status;
	}
	
	public void setUser_id(String theUser_id)
	{
		user_id = theUser_id;
    }

	public void setF_user_id(String theF_user_id)
	{
		f_user_id = theF_user_id;
	}

	public void setStatus(String theStatus)
	{
		status = theStatus;
	}
}
