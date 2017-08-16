<!---
****************************************************************************
* Method:			
*	 MainApplicationPanel::displayCalendars
*
* Description:
*	 Displays a list of all the available calendars.
*
****************************************************************************
--->

<cfoutput>
<br>
<cfif isQuery(request.calendars)>
<cfloop query="request.calendars">
	<div style="clear:left;border-left:3px solid ##333366;border-top:1px solid ##333366;padding-left:4px;font-size:14px;">
		<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#" style="font-weight:bold;font-size:16px;">#title#</a><br>#description#<br>
	</div>
	<br>
</cfloop>
</cfif>
<br>
</cfoutput>
