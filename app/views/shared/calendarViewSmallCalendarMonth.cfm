<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 CalendarViewPanel::displaySmallMonth
*
* Description:
*	 Displays a "small" version of a calendar view of an entire month.	This
*	 is for inclusion with such views as the calendar year view.
*
****************************************************************************
--->
<cfparam name="monthCalendarDate" default="#now()#">
<cfparam name="filter" default="">
<cfparam name="weekStart" default="1">
<cfset localViewType = "small">
<cfset localFormat = "month">

<!---// Set the calendar view date and validate it is a date. --->
<cfif not isDate(monthCalendarDate)><cfset monthCalendarDate = now()></cfif>

<!---// Create date variables to search database. --->
<cfset monthStart = createDateTime(year(monthCalendarDate), month(monthCalendarDate), 1, 0, 0, 0)>
<cfset monthEnd = createDateTime(year(monthCalendarDate), month(monthCalendarDate), daysInMonth(monthCalendarDate), 23, 59, 59)>

<cfset offSet = dayOfWeek(monthStart) mod 7 - 1>
<cfset days = daysInMonth(monthCalendarDate)>
<cfset day = createDate(year(monthCalendarDate), month(monthCalendarDate), 1)>

<table border="0" cellpadding="0" cellspacing="0" class="bc-style">		
	<!-- Title bar -->
	<tr align="center" bgcolor="#c0c0c0">
		<cfoutput>
			<th colspan="7" align="center" class="bc-style">
				<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&ViewType=Month&calendarDate=#dateFormat(monthCalendarDate,'short')#&filter=#filter#">#lsDateFormat(monthCalendarDate,application.resource.bundle.datetime.short_month_year)#</a>
			</th>
		</cfoutput>
	</tr>
	<!-- Days of Month -->
	<tr class="bc-style">
		<cfoutput>
			<cfset headerStart = weekStart>
			<cfset headerDays = 7>
			<cfset headerWidth = Int(100 / 7)>
			<cfloop index="i" from="#headerStart#" to="#evaluate(headerStart + headerDays - 1)#">
				<cfset headerDay = i mod headerDays>
				<cfif headerDay eq 0><cfset headerDay = 7></cfif>
				<th width="#headerWidth#%" class="bc-style">#left(dayOfWeekAsString(headerDay),1)#</th>
			</cfloop>
		</cfoutput>
	</tr>
	
	<!-- Days -->
	<tr class="bcl-layout">
		<cfset colOffset = (dayOfWeek(monthStart) + (7 - weekStart)) mod 7 + 1>
		<cfset colLast = colOffset + daysInMonth(monthStart) - 1>
		<cfset cells = (ceiling(colLast/7)) * 7>
		<cfset dayOfMonth = createDateTime(year(monthCalendarDate), month(monthCalendarDate), 1, 0, 0, 0)>
		
		<cfloop index="cell" from="1" to="#cells#">
			<cfif cell gte colOffset and cell lte colLast>
				<td align="center" valign="top" style="border:1px solid #d0d0d0;">
					<cfif structKeyExists(eventDates, dateFormat(dayOfMonth,"yyyy/mm/dd")) eq true>
						<cfoutput><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&viewType=day&calendarDate=#dateFormat(dayOfMonth,'short')#&filter=#filter#" class="bcd-active">#day(dayOfMonth)#</a><br></cfoutput>
					<cfelse>
						<cfoutput><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&viewType=day&calendarDate=#dateFormat(dayOfMonth,'short')#&filter=#filter#" class="bcd-inactive">#day(dayOfMonth)#</a><br></cfoutput>
					</cfif>
				</td>
				<cfset dayOfMonth = dateAdd("d", 1, dayOfMonth)>
			<cfelse>
				<td style="background-color:#f0f0f0;"></td>
			</cfif>
			
			<cfif (cell mod 7 eq 0) and month(dayOfMonth) eq month(monthStart)>
				</tr>
				<tr>
			</cfif>
		</cfloop>
	</tr>
</table>
