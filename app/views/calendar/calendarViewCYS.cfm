<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 CalendarViewPanel::displayCalendarYear
*
* Description:
*	 Displays a calendar view of a year.
*
****************************************************************************
--->
<cfparam name="calendar" default="">
<cfparam name="filter" default="">
<cfset localDisplayType = "standard">
<cfset localViewType = "year">
<cfset localFormat = "calendar">

<!---// Determine the appropriate timezone adjustment. --->
<cfset tz = getProperty("timezoneLibrary") />
<cfset sessionFacade = getProperty("sessionFacade") />
<cfset timezone = iif(sessionFacade.hasUser(), sessionFacade.getUser().getTimezone(), request.timezone) />

<!---// Set the calendar view date and validate it is a date. --->
<cfparam name="calendarDate" default="#now()#">
<cfif not isDate(calendarDate)><cfset calendarDate = now()></cfif>

<!-- Title bar -->
<cfoutput>
	<table>
		<tr>
			<td><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=#localViewType#&format=#localFormat#&calendarDate=#dateFormat(dateAdd('yyyy', -1, calendarDate),'short')#&filter=#filter#" style="padding:0px 4px 0px 4px;"><img src="images/arrow_l.gif" border="0"></a></td>
			<td width="80" style="text-align:center;"><span class="bp-title" style="white-space:nowrap;padding:0px 4px 0px 4px;">#lsDateFormat(calendarDate,application.resource.bundle.datetime.full_year_title)#</span></td>
			<td><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=#localViewType#&format=#localFormat#&calendarDate=#dateFormat(dateAdd('yyyy', +1, calendarDate),'short')#&filter=#filter#" style="padding:0px 4px 0px 4px;"><img src="images/arrow_r.gif" border="0"></a></td>
		</tr>
	</table>

	<cfinclude template="../shared/calendarViewOptions.cfm" />
	<cfinclude template="../shared/calendarViewMenu.cfm" />
</cfoutput>

<cfset eventDateArray = arrayNew(1) />
<cfset eventDateArray = listToArray(valueList(request.events.startDateTime)) />
<cfset eventDates = structNew() />
<cfloop index="i" from="1" to="#arrayLen(eventDateArray)#">
	<cfset eventDate = tz.toLocal(eventDateArray[i],timezone) />
	<cfif not structKeyExists(eventDates, dateFormat(eventDate,'yyyy/mm/dd'))>
		<cfset structInsert(eventDates,dateFormat(eventDate,'yyyy/mm/dd'),dateFormat(eventDate,'yyyy/mm/dd')) />
	</cfif>
</cfloop>

<table align="center" border="0" cellpadding="10" cellspacing="0" class="bc-style">
	<tr>
		<cfloop index="month" from="1" to="12">
			<td valign="top">
				<cfset monthCalendarDate = createDate(year(calendarDate),month,1) />
				<cfinclude template="../shared/calendarViewSmallCalendarMonth.cfm">
			</td>
			<cfif (month mod 4) eq 0></tr><tr></cfif>
		</cfloop>
	</tr>
</table>
<br>
<cfoutput>#request.calendarCategories#</cfoutput>
<br>
