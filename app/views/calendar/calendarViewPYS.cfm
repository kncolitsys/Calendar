<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 CalendarViewPanel::displayPrintYear
*
* Description:
*	 Displays a printable view of a one year calendar.
*
****************************************************************************
--->
<cfparam name="calendar">
<cfparam name="filter" default="">

<!---// Determine the appropriate timezone adjustment. --->
<cfset tz = getProperty("timezoneLibrary") />
<cfset sessionFacade = getProperty("sessionFacade") />
<cfset timezone = iif(sessionFacade.hasUser(), sessionFacade.getUser().getTimezone(), request.timezone) />

<!---// Set the calendar date and validate it is a date. --->
<cfparam name="calendarDate" default="#now()#">
<cfif not isDate(calendarDate)><cfset calendarDate = now()></cfif>

<table border="0" cellpadding="0" cellspacing="0" align="center" style="width:610;">
	<tr>
		<td>
			<cfloop index="month" from="1" to="12">
				<view:calendarViewStandardPrintMonth contextId="#contextId#" calendar="#calendar#" calendarDate="#createDate(year(calendarDate), month, 1)#" filter="#filter#">
			</cfloop>
		</td>
	</tr>
</table>