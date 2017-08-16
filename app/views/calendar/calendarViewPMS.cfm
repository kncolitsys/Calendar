<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 CalendarViewPanel::displayPrintMonth
*
* Description:
*	 Displays a printable view of a one month calendar.
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

<!---// Create the date range variables for display purposes. --->
<cfset monthStart = createDateTime(year(calendarDate), month(calendarDate), 1, 0, 0, 0)>
<cfset monthEnd = createDateTime(year(calendarDate), month(calendarDate), daysInMonth(monthStart), 23, 59, 59)>

<cfset colOffset = dayOfWeek(monthStart)>
<cfset colLast = colOffset + daysInMonth(monthStart) - 1>
<cfset rows = daysInMonth(monthStart)>
<cfset day = 1>

<br>
<table cellpadding="2" cellspacing="0" align="center" class="bc-style" style="width:610;">
	<tr>
		<th colspan="2" class="bc-style"><cfoutput>#lsDateFormat(calendarDate,application.resource.bundle.datetime.full_month_title)#</cfoutput></th>
	</tr>

	<!-- Days -->
	<cfset dayOfMonth = dateAdd('d', -1, monthStart)>
	<cfloop index="ii" from="1" to="#rows#">
		<cfset dayOfMonth = dateAdd('d', 1, dayOfMonth)>

		<cfif (dayOfWeek(dayOfMonth) eq 1) or (dayOfWeek(dayOfMonth) eq 7)>
			<cfset bgStyle="calendarWeekend">
		<cfelse>
			<cfset bgStyle="calendarWeekday">
		</cfif>
	
		<tr class="<cfoutput>#bgStyle#</cfoutput>">
			<td width="5%" align="right" valign="top">
				<cfoutput><div class="bct-printtime" style="white-space:nowrap;">#lsDateFormat(dayOfMonth,application.resource.bundle.datetime.desc_day)#</div></cfoutput>
			</td>

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
						<div class="bct-printevent">#title# <cfif allDay neq true>- #lsTimeFormat(parseDateTime(startDT),application.resource.bundle.datetime.short_hour_minute_marker)# - #lsTimeFormat(dateAdd("s",duration,startDT),application.resource.bundle.datetime.short_hour_minute_marker)#</cfif></div>
					</cfif>
				</cfoutput><br>
			</td>
		</tr>
	</cfloop>		
</table>

