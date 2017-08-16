<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 CalendarViewPanel::displayPrintWeek
*
* Description:
*	 Displays a printable view of a one week calendar.
*
****************************************************************************
--->

<cfparam name="filter" default="">

<!---// Determine the appropriate timezone adjustment. --->
<cfset tz = getProperty("timezoneLibrary") />
<cfset sessionFacade = getProperty("sessionFacade") />
<cfset timezone = iif(sessionFacade.hasUser(), sessionFacade.getUser().getTimezone(), request.timezone) />

<!---// Set the calendar date and validate it is a date. --->
<cfparam name="calendarDate" default="#now()#">
<cfif not isDate(calendarDate)><cfset calendarDate = now()></cfif>

<cfset dayOffset = dayOfWeek(calendarDate)>
<cfset dayStart = dateAdd('d', evaluate(1-dayOffset), calendarDate)>
<cfset dayEnd = dateAdd('d', evaluate(7-dayOffset), calendarDate)>

<!---// Create the date range variables for display purposes. --->
<cfset weekStart = createDateTime(year(dayStart), month(dayStart), day(dayStart), 0, 0, 0)>
<cfset weekEnd = createDateTime(year(dayEnd), month(dayEnd), day(dayEnd), 23, 59, 59)>

<!-- Title bar -->
<table align="center" cellpadding="2" cellspacing="0" class="bc-style" style="width:610;">
	<tr align="center" style="bc-style">
		<th colspan="2" align="center" class="bc-style">
			<cfoutput>
				#lsDateFormat(weekStart,application.resource.bundle.datetime.full_week_title)# &##150; #lsDateFormat(weekEnd,application.resource.bundle.datetime.full_week_title)#
			</cfoutput>
		</th>
	</tr>
	<br>

	<!-- Days -->
	<cfset dayOfMonth = dateAdd('d', -1, weekStart)>
	<cfloop index="ii" from="1" to="7">
		<cfset dayOfMonth = dateAdd('d', 1, dayOfMonth)>
	
		<cfif (dayOfWeek(dayOfMonth) eq 1) or (dayOfWeek(dayOfMonth) eq 7)>
			<cfset bgStyle = "calendarWeekend">
		<cfelse>
			<cfset bgStyle = "calendarWeekday">
		</cfif>
	
		<tr class="<cfoutput>#bgStyle#</cfoutput>" style="bc-style">
			<td width="5%" align="right" valign="top"><cfoutput><div class="bct-time">#lsDateFormat(dayOfMonth,application.resource.bundle.datetime.desc_day)#</div></cfoutput></td>
			<td valign="top">
				<cfoutput query="request.holidays">
					<!---// CODE: Update and uncomment --->
					<!---
					<cfif dateCompare(startDateTime, dayOfMonth, "d") eq 0>
						<div class="bct-printholiday">#title#</div>
					</cfif>
					--->
				</cfoutput>		
				<cfoutput query="request.events">
					<cfset startDT = tz.toLocal(startDateTime,timezone) />
					<cfif dateCompare(startDT, dayOfMonth, "d") eq 0>
						<div class="bct-printevent">#title# <cfif allDay neq true>&##150; #lsTimeFormat(parseDateTime(startDT),application.resource.bundle.datetime.short_hour_minute_marker)# - #lsTimeFormat(dateAdd("s",duration,startDT),application.resource.bundle.datetime.short_hour_minute_marker)#</cfif></div>
					</cfif>				
				</cfoutput><br>
			</td>
		</tr>
	</cfloop>
</table>