<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 CalendarViewPanel::displaySmallListMonth
*
* Description:
*	 Displays a "small" version of a list view of an entire month.	This is
*	 for inclusion with such views as the list year view.
*
****************************************************************************
--->
<cfparam name="monthCalendarDate" default="#monthCalendarDate#">
<cfparam name="filter" default="">
<cfset localDisplayType = "standard">
<cfset localViewType = "year">
<cfset localFormat = "list">

<!---// Set the calendar date and validate it is a date. --->
<cfif not isDate(monthCalendarDate)><cfset monthCalendarDate = now()></cfif>

<!---// Create the date range variables for display purposes. --->
<cfset monthStart = createDateTime(year(monthCalendarDate), month(monthCalendarDate), 1, 0, 0, 0)>
<cfset monthEnd = createDateTime(year(monthCalendarDate), month(monthCalendarDate), daysInMonth(monthStart), 23, 59, 59)>

<table border="0" cellpadding="0" cellspacing="0" class="bc-style">
	<tr align="center" class="bc-style">
		<cfoutput>
			<th colspan="2" align="center" class="bc-style">
				<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&viewType=month&format=list&calendarDate=#dateFormat(monthCalendarDate,'short')#&filter=#filter#">#lsDateFormat(monthCalendarDate,application.resource.bundle.datetime.full_month_title)#</a>
			</th>
		</cfoutput>
	</tr>

	<cfset i = 1 />
	<cfset eventArray = arrayNew(1) />
	<cfoutput query="request.events">
		<cfset eventDate = tz.toLocal(request.events.startDateTime,timezone) />
		<cfif dateCompare(eventDate, monthStart) gte 0 and dateCompare(eventDate, monthEnd) lte 0>
			<cfset eventArray[i] = eventDate />
			<cfset i = i+1 />
		</cfif>
	</cfoutput>
	<cfoutput query="request.holidays">
		<cfif dateCompare(startDateTime, monthStart) gte 0 and dateCompare(startDateTime, monthEnd) lte 0>
			<cfset eventArray[i] = request.holidays.startDateTime />
			<cfset i = i+1 />
		</cfif>
	</cfoutput>
	<cfset arraySort(eventArray, "numeric") />

	<cfif arrayLen(eventArray) gt 0>
		<cfloop index="i" from="1" to="#arrayLen(eventArray)#">
			<cfset datetime = eventArray[i]>
			<cfoutput query="request.holidays">
				<cfif dateCompare(startDateTime, datetime, "d") eq 0>
					<tr>
						<td valign="top" style="padding:4px 8px 4px 8px;">
							<div class="bct-holiday">#title#, #lsDateFormat(parseDateTime(startDateTime),application.resource.bundle.datetime.short_month_day)#</div>
						</td>
					</tr>
				</cfif>
			</cfoutput>			
			<cfoutput query="request.events">
				<cfif dateCompare(startDateTime, datetime,"d") eq 0>
					<tr>
						<td valign="top" style="padding:4px 8px 4px 8px;">		
								<cfset preview_desc = "">
								<cfif allDay eq true>
									<cfset preview_desc = preview_desc & "<b>Time:</b> All day<br>">
								<cfelseif isDate(parseDateTime(startDateTime))>
									<cfset preview_desc = preview_desc & "<b>Time:</b> " & lsTimeFormat(parseDateTime(startDateTime),"short") & "<br>">
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
							
								<div class="bct-event">
									<a href="index.cfm?cfevent=event.view&calendarId=#calendarId#&eventId=#eventId#" onmouseover="overlib('#preview_desc#', CAPTION, '#preview_title#');"  onmouseout="return nd();" style="font-weight:bold;">#title#</a>,
									<cfif allDay eq true>
										<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=day&format=#localFormat#&calendarDate=#lsDateFormat(parseDateTime(startDateTime),'short')#&filter=#filter#">#lsDateFormat(parseDateTime(startDateTime),application.resource.bundle.datetime.short_month_day)#</a><br>
									<cfelse>
										<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=day&format=#localFormat#&calendarDate=#lsDateFormat(parseDateTime(startDateTime),'short')#&filter=#filter#">#lsDateFormat(parseDateTime(startDateTime), application.resource.bundle.datetime.short_month_day)#</a>, #lsTimeFormat(parseDateTime(startDateTime),application.resource.bundle.datetime.short_hour_minute_marker)# -
										<cfif dateCompare(startDateTime, dateAdd("s",duration,startDateTime), "d") neq 0><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=day&format=#localFormat#&calendarDate=#dateFormat(dateAdd('s',duration,startDateTime),'short')#&filter=#filter#">#lsDateFormat(dateAdd("s",duration,startDateTime),application.resource.bundle.datetime.short_month_day)#</a>,</cfif> #lsTimeFormat(dateAdd("s",duration,startDateTime),application.resource.bundle.datetime.short_hour_minute_marker)#<br>
									</cfif>
									<!--- <cfif len(description) gt 0>#description#<br></cfif> --->
								</div>
						</td>
					</tr>
					<cfset success = querySetCell(request.events, "startDateTime", createOdbcDate(createDate(1970,1,1)), request.events.currentRow)>
				</cfif>
			</cfoutput>
		</cfloop>
<cfelse>
		<tr class="bc-style">
			<td align="center" valign="top" style="padding:4px 8px 4px 8px;"><div class="bct-event"><cfoutput>#application.resource.bundle.text.no_events_scheduled_for_month# #lsDateFormat(monthStart,application.resource.bundle.datetime.full_month_title)#</cfoutput></div></td>
		</tr>
</cfif>
</table>