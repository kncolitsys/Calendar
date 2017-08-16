<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 CalendarSelectionList::display
*
* Description:
*	 Display a list for selecting a calendar to edit.
*
****************************************************************************
--->

<cfparam name="attributes.selected" default="">

<cfoutput>
<div class="bp-title">#application.resource.bundle.text.calendar_management#</div><br>

<a href="index.cfm?cfevent=administrator.calendar.new">Create New Calendar</a><br><br>
<table width="100%" border="0" cellpadding="4" cellspacing="0" style="font-size:12px;">
	<tr>
		<th width="24" align="center">Edit</th>
		<th width="24" align="center">Delete</th>
		<th align="left">Calendar</th>
	</tr>
	<cfset toggle = true />
	<cfloop query="request.calendars">
		<tr bgcolor="###iif(toggle,de('e9e9e9'),de('f3f3f3'))#">
			<td align="center"><a href="index.cfm?cfevent=administrator.calendar.edit&calendarId=#calendarId#"><img src="images/icon_edit.gif" border="0" alt="Edit" /></a></td>
			<td align="center"><a href="index.cfm?cfevent=administrator.calendar.delete&calendarId=#calendarId#"><img src="images/icon_delete.gif" border="0" alt="Delete" /></a></td>
			<td><a href="index.cfm?cfevent=calendar.view&calendarId=#trim(calendarId)#">#trim(title)#</a></td>
		</tr>
		<cfset toggle = not toggle />
	</cfloop>
</table>
</cfoutput>