package com.zerobyte.lifesync.dataaccess;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.core.RowMapper;

import com.zerobyte.lifesync.model.Event;
import com.zerobyte.lifesync.model.Friend;
import com.zerobyte.lifesync.model.Schedule;
import com.zerobyte.lifesync.model.User;

import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

//TODO: Add error handling to failed SQL statements!
public class UserDao extends JdbcDaoSupport {
	
	// Database table name
	private static final String CONST_APPUSER_NAME = "AppUser";
	private static final String CONST_SCHEDULE_NAME = "Schedule";
	private static final String CONST_FRIEND_NAME = "Friend";
	private static final String CONST_EVENT_NAME = "Event";
	
    public static final String CONST_USER_ID_FIELD = "user_id";
    public static final String CONST_PASSWORD_FIELD = "password";
    public static final String CONST_FIRSTNAME_FIELD = "first_name"; 
    public static final String CONST_LASTNAME_FIELD = "last_name";
    public static final String CONST_AUTHORITY_FIELD = "authority";
    public static final String CONST_EMAIL_FIELD = "email"; 
    public static final String CONST_FBID_FIELD = "fb_id";
    public static final String CONST_ENABLED_FIELD = "enabled";
    
    public static final String CONST_SCHEDID_FIELD = "schedule_id";
    public static final String CONST_ACTIVE_FIELD = "active";
    
    public static final String CONST_F_USER_ID_FIELD = "f_user_id";
    public static final String CONST_FEMAIL_FIELD = "f_email";
    public static final String CONST_STATUS_FIELD = "status";
    
    public static final String CONST_EVENTID_FIELD = "event_id";
    public static final String CONST_NAME_FIELD = "name";
    public static final String CONST_STARTTIME_FIELD = "start_time"; 
    public static final String CONST_ENDTIME_FIELD = "end_time";
	public static final String CONST_LOCATION_FIELD = "location";
	public static final String CONST_DESCRIPTION_FIELD = "description"; 
	public static final String CONST_SCHEDULEID_FIELD = "schedule_id";

	//Methods for creating records in tables.
	public int createUser(Map<String,String> attributes) {
		
		List<String> fields = new ArrayList<String>();
		List<String> values = new ArrayList<String>();
		for (String key: attributes.keySet())
		{
			fields.add(key);
			values.add(attributes.get(key));  
		}
		String query = "INSERT INTO " + CONST_APPUSER_NAME + " (" + StringUtils.join(fields, ",") + ")\n";		
		query = query + "VALUES (" + StringUtils.join(values, ",") + ")\n";
		return getJdbcTemplate().update(query);
	}
	
	public int createSchedule(Map<String,String> attributes) {
		
		List<String> fields = new ArrayList<String>();
		List<String> values = new ArrayList<String>();
		for (String key: attributes.keySet())
		{
			fields.add(key);
			values.add(attributes.get(key));  
		}
		String query = "INSERT INTO " + CONST_SCHEDULE_NAME + " (" + StringUtils.join(fields, ",") + ")\n";		
		query = query + "VALUES (" + StringUtils.join(values, ",") + ")\n";
		return getJdbcTemplate().update(query);
	}
	
	public int createEvent(Map<String,String> attributes) {
		
		List<String> fields = new ArrayList<String>();
		List<String> values = new ArrayList<String>();
		for (String key: attributes.keySet())
		{
			fields.add(key);
			values.add(attributes.get(key));  
		}
		String query = "INSERT INTO " + CONST_EVENT_NAME + " (" + StringUtils.join(fields, ",") + ")\n";		
		query = query + "VALUES (" + StringUtils.join(values, ",") + ")\n";
		return getJdbcTemplate().update(query);
	}
	
	public int createFriend(Map<String,String> attributes) {
		
		List<String> fields = new ArrayList<String>();
		List<String> values = new ArrayList<String>();
		for (String key: attributes.keySet())
		{
			fields.add(key);
			values.add(attributes.get(key));  
		}
		String query = "INSERT INTO " + CONST_FRIEND_NAME + " (" + StringUtils.join(fields, ",") + ")\n";		
		query = query + "VALUES (" + StringUtils.join(values, ",") + ")\n";
		return getJdbcTemplate().update(query);
	}
	
	//Methods for retrieving records in tables.
	public List<User> retrieveUser(Map<String,String> conditions ) {

		String query = "SELECT *\nFROM " + CONST_APPUSER_NAME + "\n";
		List<String> whereConditions = new ArrayList<String>(); 
		for (String key: conditions.keySet())
		{
			whereConditions.add(key + " = " + conditions.get(key) + "");
		}
		query = query + "WHERE " + StringUtils.join(whereConditions, " AND ") + "\n";
		return getJdbcTemplate().query(query, new UserMapper());
	}
	
	public List<User> retrieveAllUsers( ) {

		String query = "SELECT *\nFROM " + CONST_APPUSER_NAME + "\n";
		return getJdbcTemplate().query(query, new UserMapper());
	}
	
	public List<Schedule> retrieveSchedule(Map<String,String> conditions ) {

		String query = "SELECT *\nFROM " + CONST_SCHEDULE_NAME + "\n";
		List<String> whereConditions = new ArrayList<String>(); 
		for (String key: conditions.keySet())
		{
			whereConditions.add(key + "=" + conditions.get(key));
		}
		query = query + "WHERE " + StringUtils.join(whereConditions, " AND ") + "\n";
		return getJdbcTemplate().query(query, new ScheduleMapper());
	}
	
	public List<Event> retrieveEvent(Map<String,String> conditions ) {

		String query = "SELECT *\nFROM " + CONST_EVENT_NAME + "\n";
		List<String> whereConditions = new ArrayList<String>(); 
		for (String key: conditions.keySet())
		{
			whereConditions.add(key + "=" + conditions.get(key));
		}
		query = query + "WHERE " + StringUtils.join(whereConditions, " AND ") + "\n";
		return getJdbcTemplate().query(query, new EventMapper());
	}
	
	public List<Friend> retrieveFriend(Map<String,String> conditions ) {

		String query = "SELECT *\nFROM " + CONST_FRIEND_NAME + "\n";
		List<String> whereConditions = new ArrayList<String>(); 
		for (String key: conditions.keySet())
		{
			whereConditions.add(key + "=" + conditions.get(key));
		}
		query = query + "WHERE " + StringUtils.join(whereConditions, " AND ") + "\n";
		return getJdbcTemplate().query(query, new FriendMapper());
	}
	
	//Methods for updating records in tables.
	public int updateUser(Map<String,String> changes, Map<String,String> conditions ) {

		String query = "UPDATE " + CONST_APPUSER_NAME + "\n";
		
		List<String> setChanges = new ArrayList<String>(); 
		for (String key: changes.keySet())
		{
			setChanges.add(key + "=" + changes.get(key));
		}
		query = query + "SET " + StringUtils.join(setChanges, ",") + "\n";
		
		List<String> whereConditions = new ArrayList<String>(); 
		for (String key: conditions.keySet())
		{
			whereConditions.add(key + "=" + conditions.get(key));
		}
		query = query + "WHERE " + StringUtils.join(whereConditions, " AND ") + "\n";
		return getJdbcTemplate().update(query);
	}
	
	public int updateSchedule(Map<String,String> changes, Map<String,String> conditions ) {

		String query = "UPDATE " + CONST_SCHEDULE_NAME + "\n";
		
		List<String> setChanges = new ArrayList<String>(); 
		for (String key: changes.keySet())
		{
			setChanges.add(key + "=" + changes.get(key));
		}
		query = query + "SET " + StringUtils.join(setChanges, ",") + "\n";
		
		List<String> whereConditions = new ArrayList<String>(); 
		for (String key: conditions.keySet())
		{
			whereConditions.add(key + "=" + conditions.get(key));
		}
		query = query + "WHERE " + StringUtils.join(whereConditions, " AND ") + "\n";
		return getJdbcTemplate().update(query);
	}
	
	public int updateEvent(Map<String,String> changes, Map<String,String> conditions ) {

		String query = "UPDATE " + CONST_EVENT_NAME + "\n";
		
		List<String> setChanges = new ArrayList<String>(); 
		for (String key: changes.keySet())
		{
			setChanges.add(key + "=" + changes.get(key));
		}
		query = query + "SET " + StringUtils.join(setChanges, ",") + "\n";
		
		List<String> whereConditions = new ArrayList<String>(); 
		for (String key: conditions.keySet())
		{
			whereConditions.add(key + "=" + conditions.get(key));
		}
		query = query + "WHERE " + StringUtils.join(whereConditions, " AND ") + "\n";
		return getJdbcTemplate().update(query);
	}
	
	public int updateFriend(Map<String,String> changes, Map<String,String> conditions ) {

		String query = "UPDATE " + CONST_FRIEND_NAME + "\n";
		
		List<String> setChanges = new ArrayList<String>(); 
		for (String key: changes.keySet())
		{
			setChanges.add(key + "=" + changes.get(key));
		}
		query = query + "SET " + StringUtils.join(setChanges, ",") + "\n";
		
		List<String> whereConditions = new ArrayList<String>(); 
		for (String key: conditions.keySet())
		{
			whereConditions.add(key + "=" + conditions.get(key));
		}
		query = query + "WHERE " + StringUtils.join(whereConditions, " AND ") + "\n";
		return getJdbcTemplate().update(query);
	}
	
	//Methods for deleting records in tables.
	public int deleteUser(Map<String,String> conditions ) {

		String query = "DELETE FROM " + CONST_APPUSER_NAME + "\n";
		List<String> whereConditions = new ArrayList<String>(); 
		for (String key: conditions.keySet())
		{
			whereConditions.add(key + "=" + conditions.get(key));
		}
		query = query + "WHERE " + StringUtils.join(whereConditions, " AND ") + "\n";
		return getJdbcTemplate().update(query);
	}
	
	public int deleteSchedule(Map<String,String> conditions ) {

		String query =  "DELETE FROM " + CONST_SCHEDULE_NAME + "\n";
		List<String> whereConditions = new ArrayList<String>(); 
		for (String key: conditions.keySet())
		{
			whereConditions.add(key + "=" + conditions.get(key));
		}
		query = query + "WHERE " + StringUtils.join(whereConditions, " AND ") + "\n";
		return getJdbcTemplate().update(query);
	}
	
	public int deleteEvent(Map<String,String> conditions ) {

		String query = "DELETE FROM " + CONST_EVENT_NAME + "\n";
		List<String> whereConditions = new ArrayList<String>(); 
		for (String key: conditions.keySet())
		{
			whereConditions.add(key + "=" + conditions.get(key));
		}
		query = query + "WHERE " + StringUtils.join(whereConditions, " AND ") + "\n";
		return getJdbcTemplate().update(query);
	}
	
	public int deleteFriend(Map<String,String> conditions ) {

		String query = "DELETE FROM " + CONST_FRIEND_NAME + "\n";
		List<String> whereConditions = new ArrayList<String>(); 
		for (String key: conditions.keySet())
		{
			whereConditions.add(key + "=" + conditions.get(key));
		}
		query = query + "WHERE " + StringUtils.join(whereConditions, " AND ") + "\n";
		return getJdbcTemplate().update(query);
	}

	private static final class UserMapper implements RowMapper<User> {
		public User mapRow(ResultSet rs, int rowNum) throws SQLException {
			User targetUser = new User();
			targetUser.setUser_id(rs.getString(CONST_USER_ID_FIELD));
			targetUser.setPassword(rs.getString(CONST_PASSWORD_FIELD));
			targetUser.setFirst_name(rs.getString(CONST_FIRSTNAME_FIELD));
			targetUser.setLast_name(rs.getString(CONST_LASTNAME_FIELD));
			targetUser.setAuthority(rs.getString(CONST_AUTHORITY_FIELD));
			targetUser.setEmail(rs.getString(CONST_EMAIL_FIELD));
			targetUser.setFb_id(rs.getString(CONST_FBID_FIELD));
			targetUser.setEnabled(rs.getString(CONST_ENABLED_FIELD));
			return targetUser;
		}
	}
	
	private static final class ScheduleMapper implements RowMapper<Schedule> {
		public Schedule mapRow(ResultSet rs, int rowNum) throws SQLException {
			Schedule targetSched = new Schedule();
			targetSched.setUser_id(rs.getString(CONST_USER_ID_FIELD));
			targetSched.setSchedule_id(rs.getString(CONST_SCHEDID_FIELD));
			targetSched.setActive(rs.getString(CONST_ACTIVE_FIELD));
			return targetSched;
		}
	}
	
	private static final class FriendMapper implements RowMapper<Friend> {
		public Friend mapRow(ResultSet rs, int rowNum) throws SQLException {
			Friend targetFriend = new Friend();
			targetFriend.setUser_id(rs.getString(CONST_USER_ID_FIELD));
			targetFriend.setF_user_id(rs.getString(CONST_F_USER_ID_FIELD));
			targetFriend.setStatus(rs.getString(CONST_STATUS_FIELD));
			return targetFriend;
		}
	}
	
	private static final class EventMapper implements RowMapper<Event> {
		public Event mapRow(ResultSet rs, int rowNum) throws SQLException {
			Event targetEvent = new Event();
			targetEvent.setEvent_id(rs.getString(CONST_EVENTID_FIELD));
			targetEvent.setSchedule_id(rs.getString(CONST_SCHEDULEID_FIELD));
			targetEvent.setName(rs.getString(CONST_NAME_FIELD));
			targetEvent.setStart_time(rs.getString(CONST_STARTTIME_FIELD));
			targetEvent.setEnd_time(rs.getString(CONST_ENDTIME_FIELD));
			targetEvent.setLocation(rs.getString(CONST_LOCATION_FIELD));
			targetEvent.setDescription(rs.getString(CONST_DESCRIPTION_FIELD));
			return targetEvent;
		}
	}
	
	
};
