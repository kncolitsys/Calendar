<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 CalendarViewPanel::displayListYear
*
* Description:
*	 Displays a list view of a one year calendar.
*
****************************************************************************
--->

<cfparam name="filter" default="">
<cfparam name="attributes.calendar">
<cfset localDisplayType = "standard">
<cfset localFormat = "list">
<cfset localViewType = "year">

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
			<td><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=#localViewType#&format=#localFormat#&calendarDate=#dateFormat(dateAdd('yyyy', -1, calendarDate),'short')#&filter=#filter#"><img src="images/arrow_l.gif" border="0"></a></td>
			<td width="80" style="text-align:center;"><span class="bp-title" style="white-space:nowrap;padding:0px 4px 0px 4px;"><span class="bp-title">#lsDateFormat(calendarDate,application.resource.bundle.datetime.full_year_title)#</span></td>
			<td><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=#localViewType#&format=#localFormat#&calendarDate=#dateFormat(dateAdd('yyyy', +1, calendarDate),'short')#&filter=#filter#"><img src="images/arrow_r.gif" border="0"></a></td>
		</tr>
	</table>

	<cfinclude template="../shared/calendarViewOptions.cfm" />
	<cfinclude template="../shared/calendarViewMenu.cfm" />
</cfoutput>

<table width="100%" align="center" cellpadding="10" cellspacing="0" class="bc-style">
	<cfloop index="month" from="1" to="12">
		<tr>
			<td valign="top">
				<cfset monthCalendarDate = createDate(year(calendarDate), month, 1) />
				<cfinclude template="../shared/calendarViewSmallListMonth.cfm">
			</td>
		</tr>
	</cfloop>
</table>
<br>