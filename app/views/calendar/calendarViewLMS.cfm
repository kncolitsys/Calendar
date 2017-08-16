<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 CalendarViewPanel::displayListMonth
*
* Description:
*	 Displays a list view of a one month calendar.
*
****************************************************************************
--->

<cfparam name="filter" default="">
<cfset localDisplayType = "standard">
<cfset localViewType = "month">
<cfset localFormat = "list">

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
<cfset dayOfMonth = 1>


<!-- Title bar -->
<cfoutput>
	<table>
		<tr>
			<td>
				<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=#localViewType#&format=#localFormat#&calendarDate=#dateFormat(dateAdd('yyyy', -1, calendarDate),'short')#&filter=#filter#" style="padding: 0px 4px 0px 4px;"><img src="images/arrow_ld.gif" border="0"></a>
				<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=#localViewType#&format=#localFormat#&calendarDate=#dateFormat(dateAdd('m', -1, calendarDate),'short')#&filter=#filter#" style="padding: 0px 4px 0px 4px;"><img src="images/arrow_l.gif" border="0"></a>
			</td>
			<td width="180" style="text-align:center;"><span class="bp-title" style="padding:0px 4px 0px 4px;white-space:nowrap;">#lsDateFormat(calendarDate,application.resource.bundle.datetime.full_month_title)#</span></td>
			<td>
				<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=#localViewType#&format=#localFormat#&calendarDate=#dateFormat(dateAdd('m', +1, calendarDate), 'short')#&filter=#filter#" style="padding: 0px 4px 0px 4px;"><img src="images/arrow_r.gif" border="0"></a>
				<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=#localViewType#&format=#localFormat#&calendarDate=#dateFormat(dateAdd('yyyy', +1, calendarDate),'short')#&filter=#filter#" style="padding: 0px 4px 0px 4px;"><img src="images/arrow_rd.gif" border="0"></a>
			</td>
		</tr>
	</table>
	
	<cfinclude template="../shared/calendarViewOptions.cfm" />
	<cfinclude template="../shared/calendarViewMenu.cfm" />
</cfoutput>

<cfset i = 1 />
<cfset eventArray = arrayNew(1) />
<cfoutput query="request.events">
	<cfset eventDate = tz.toLocal(request.events.startDateTime,timezone) />
	<cfif dateCompare(eventDate, monthStart) gt 0 and dateCompare(eventDate, monthEnd) lt 0>
		<cfset eventArray[i] = eventDate />
		<cfset i = i+1 />
	</cfif>
</cfoutput>
<cfoutput query="request.holidays">
	<cfif dateCompare(startDateTime, monthStart) gt 0 and dateCompare(startDateTime, monthEnd) lt 0>
		<cfset eventArray[i] = request.holidays.startDateTime />
		<cfset i = i+1 />
	</cfif>
</cfoutput>
<cfset arraySort(eventArray, "numeric") />

<cfif arrayLen(eventArray) gt 0>
	<table border="0" cellpadding="0" cellspacing="0" class="bc-style">
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
				<cfset startDT = tz.toLocal(startDateTime,timezone) />
				<cfif dateCompare(startDT, datetime) eq 0>
					<tr>
						<td valign="top" style="padding:4px 8px 4px 8px;">		
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
						
							<div class="bct-event">
								<a href="index.cfm?cfevent=event.view&calendarId=#calendarId#&eventId=#eventId#" onmouseover="overlib('#preview_desc#', CAPTION, '#preview_title#');"  onmouseout="return nd();" style="font-weight:bold;">#title#</a>,
								<cfif allDay eq true>
									<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=day&format=#localFormat#&calendarDate=#lsDateFormat(parseDateTime(startDT),'short')#&filter=#filter#">#lsDateFormat(parseDateTime(startDT),'short')#</a><br>
								<cfelse>
									<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=day&format=#localFormat#&calendarDate=#lsDateFormat(parseDateTime(startDT),'short')#&filter=#filter#">#lsDateFormat(parseDateTime(startDT),'short')#</a>, #lsTimeFormat(parseDateTime(startDT),'short')# -
									<cfif dateCompare(startDT, dateAdd("s",duration,startDT), "d") neq 0><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=day&format=#localFormat#&calendarDate=#dateFormat(dateAdd('s',duration,startDT),'short')#&filter=#filter#">#lsDateFormat(dateAdd("s",duration,startDT),application.resource.bundle.datetime.short_month_day)#</a>,</cfif> #lsTimeFormat(dateAdd("s",duration,startDT),application.resource.bundle.datetime.short_hour_minute_marker)#<br>
								</cfif>
								<!--- <cfif len(description) gt 0>#description#<br></cfif> --->
							</div>
							<br>
						</td>
					</tr>
					<cfset success = querySetCell(request.events, "startDateTime", createOdbcDate(createDate(1970,1,1)), request.events.currentRow)>
				</cfif>
			</cfoutput>
		</cfloop>
	</table>
<cfelse>
	<table border="0" cellpadding="0" cellspacing="0" class="bc-style">
		<tr>
			<td align="center" valign="top" style="padding:4px 8px 4px 8px;"><div class="bct-event"><cfoutput>#application.resource.bundle.text.no_events_scheduled_for_month# #lsDateFormat(monthStart,application.resource.bundle.datetime.full_month_title)#</cfoutput></div></td>
		</tr>
	</table>
</cfif>
