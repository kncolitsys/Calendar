<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 CalendarViewPanel::displayCalendarWeek
*
* Description:
*	 Displays a calendar view of a week.
*
****************************************************************************
--->

<cfparam name="attributes.contextId" default="">
<cfparam name="weekStart" default="1">
<cfparam name="filter" default="">
<cfset localDisplayType = "standard">
<cfset localViewType = "week">
<cfset localFormat = "calendar">

<!---// Determine the appropriate timezone adjustment. --->
<cfset tz = getProperty("timezoneLibrary") />
<cfset sessionFacade = getProperty("sessionFacade") />
<cfset timezone = iif(sessionFacade.hasUser(), sessionFacade.getUser().getTimezone(), request.timezone) />

<!---// Set the calendar date and validate it is a date. --->
<cfparam name="calendarDate" default="#now()#">
<cfif not isDate(arguments.event.getArg('calendarDate'))><cfset arguments.event.setArg('calendarDate', now()) /></cfif>

<!---// Create the date range variables for display purposes. --->
<cfset dayOffset = dayOfWeek(arguments.event.getArg('calendarDate'))>
<cfset firstDay = dateAdd('d', evaluate(1-dayOffset+(weekStart-1)), arguments.event.getArg('calendarDate'))>
<cfif dateCompare(firstDay, arguments.event.getArg('calendarDate')) gt 0>
	<cfset firstDay = dateAdd('d', -7, firstDay)>
</cfif>
<cfset lastDay = dateAdd('d', 6, firstDay)>
<cfset weekStart = createDateTime(year(firstDay), month(firstDay), day(firstDay), 0, 0, 0)>
<cfset weekEnd = createDateTime(year(lastDay), month(lastDay), day(lastDay), 23, 59, 59)>

<!-- Title bar -->
<cfoutput>
	<table>
		<tr>
			<td><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=#localViewType#&format=#localFormat#&calendarDate=#dateFormat(dateAdd('d', -7, arguments.event.getArg('calendarDate')),'short')#&filter=#filter#" style="padding:0px 4px 0px 4px;"><img src="images/arrow_l.gif" border="0"></a></td>
			<td width="320" style="text-align:center;"><span class="bp-title" style="white-space:nowrap;">#lsDateFormat(weekStart,application.resource.bundle.datetime.full_week_title)# &##150; #lsDateFormat(weekEnd,application.resource.bundle.datetime.full_week_title)#</span></td>
			<td><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=#localViewType#&format=#localFormat#&calendarDate=#dateFormat(dateAdd('d', +7, arguments.event.getArg('calendarDate')),'short')#&filter=#filter#" style="padding:0px 4px 0px 4px;"><img src="images/arrow_r.gif" border="0"></a></td>
		</tr>
	</table>
	
	<cfinclude template="../shared/calendarViewOptions.cfm" />
	<cfinclude template="../shared/calendarViewMenu.cfm" />
</cfoutput>

<table cellpadding="0" cellspacing="0" class="bc-style">
	<tr class="bc-style">
		<td width="50%" valign="top" class="bc-style" style="#bgStyle#">
			<cfset dayOfMonth = dateAdd('d', -1, weekStart)>
			<cfloop index="ii" from="1" to="7">
				<cfset dayOfMonth = dateAdd('d', 1, dayOfMonth)>
			
				<cfif (ii eq 1) or (ii eq 7)>
					<cfset bgStyle="bc-weekend">
				<cfelse>
					<cfset bgStyle="bc-weekday">
				</cfif>
				
				<cfoutput>
					<cfset record = false />
					<!---// CODE: I should define a new style here, rather than use bcm-text, which is intended for the calendar tabs --->
					<div class="bcm-text"><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=day&format=#localFormat#&calendarDate=#dateFormat(dayOfMonth,'short')#&filter=#filter#" class="bcm-text">#lsDateFormat(dayOfMonth, 'ddd mmm d')#</a></div>
					<cfloop query="request.holidays">
						<cfif dateCompare(startDateTime, dayOfMonth, "d") eq 0>
							<cfset record = true />
							<div class="bct-holiday" style="padding:1px;">#title#</div>
						</cfif>
					</cfloop>
					<cfloop query="request.events">
						<cfset startDT = tz.toLocal(startDateTime,timezone) />
						<cfif dateCompare(startDT, dayOfMonth, "d") eq 0>
							<cfset record = true />
							<cfset preview_desc = "">
							<cfif allDay eq true>
								<cfset preview_desc = preview_desc & "<b>Time:</b> All day<br>">
							<cfelseif isDate(parseDateTime(startDT))>
								<cfset preview_desc = preview_desc & "<b>Time:</b> " & lsTimeFormat(parseDateTime(startDT),"short") & "<br>">
							</cfif>
							<cfif len(location) gt 0><cfset preview_desc = preview_desc & "<b>Location:</b> " & location & "<br>"></cfif>
							<cfif len(trim(description)) gt application.app.global.calendar.overlib.description_limit>
								<cfset preview_desc = preview_desc & "<br>" & left(trim(description),application.app.global.calendar.overlib.description_limit) & "...">
							<cfelseif len(trim(description)) gt 0>
								<cfset preview_desc = preview_desc & "<br>" & description>
							</cfif>
							<cfif len(preview_desc) eq 0><cfset preview_desc = "No details are available"></cfif>
							<cfset orig_list = "',"",#chr(10)#,#chr(13)#">
							<cfset repl_list = "\',\',,">
							<cfset preview_desc = replaceList(preview_desc,orig_list,repl_list)>
							<cfset preview_title = replaceList(title,orig_list,repl_list)>
						
							<div class="bct-event"><div class="category_events.category" style="padding:1px;"><a href="index.cfm?cfevent=event.view&calendarId=#calendarId#&eventId=#eventId#&date=#dateFormat(dayOfMonth,'short')#" onmouseover="overlib('#preview_desc#', CAPTION, '#preview_title#');"  onmouseout="return nd();">#title#</a></div></div>
						</cfif>
					</cfloop>
					<cfif record eq false>
						<br>
					</cfif>
				</cfoutput>
				<cfif val(ii) eq 4></td><td width="50%" valign="top"></cfif>
			</cfloop>
		</td>
	</tr> 
</table>
<br>
<cfoutput>#request.calendarCategories#</cfoutput>
<br>
