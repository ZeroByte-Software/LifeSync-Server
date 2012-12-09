package com.zerobyte.lifesync.model;

//Bean class used to hold data about a single restriction. 
public class User
{
	String user_id = "";
    String password = "";
    String first_name = ""; 
    String last_name = "";
    String authority = "";
    String enabled = "";
    String email = ""; 
    String fb_id = "";

    public String getUser_id()
	{
        return user_id;
	}
    
	public String getPassword()
	{
        return password;
	}

	public String getFirst_name()
	{
		return first_name;
	}

	public String getLast_name()
	{
		return last_name;
    }

	public String getEnabled()
	{
		return enabled;
	}
	
	public String getAuthority()
	{
		return authority;
	}

	public String getEmail()
	{
		return email;
	}

	public String getFb_id()
	{
		return fb_id;
	}
	
	public void setUser_id(String theUser_id)
	{
		user_id = theUser_id;
	}
	
	public void setPassword(String thePassword)
	{
        password = thePassword;
	}

	public void setFirst_name(String theFirstName)
	{
		first_name = theFirstName;
	}

	public void setLast_name(String theLastName)
	{
		last_name = theLastName;
    }

	public void setAuthority(String theAuthority)
	{
		authority = theAuthority;
	}
	
	public void setEnabled(String theEnabled)
	{
		enabled = theEnabled;
	}

	public void setEmail(String theEmail)
	{
		email = theEmail;
	}

	public void setFb_id(String theFBID)
	{
		fb_id = theFBID;
	}
};
