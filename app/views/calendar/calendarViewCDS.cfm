<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 CalendarViewPanel::displayCalendarDay
*
* Description:
*	 Displays a calendar view of a single day.
*
****************************************************************************
--->

<cfparam name="attributes.contextId" default="">
<cfparam name="filter" default="">
<cfparam name="attributes.calendar" default="">
<cfset localDisplayType = "standard">
<cfset localViewType = "day">
<cfset localFormat = "calendar">

<!---// Determine the appropriate timezone adjustment. --->
<cfset tz = getProperty("timezoneLibrary") />
<cfset sessionFacade = getProperty("sessionFacade") />
<cfset timezone = iif(sessionFacade.hasUser(), sessionFacade.getUser().getTimezone(), request.timezone) />

<!---// Set the calendar date and validate it is a date. --->
<cfparam name="calendarDate" default="#now()#">
<cfif not isDate(arguments.event.getArg('calendarDate'))><cfset arguments.event.setArg('calendarDate', now()) /></cfif>

<cfset dayStart = createDateTime(year(arguments.event.getArg('calendarDate')),month(arguments.event.getArg('calendarDate')),day(arguments.event.getArg('calendarDate')),0,0,0)>
<cfset dayEnd	 = createDateTime(year(arguments.event.getArg('calendarDate')),month(arguments.event.getArg('calendarDate')),day(arguments.event.getArg('calendarDate')),23,59,59)>

<!---
// In order to properly format the page, the maximum number of events that
// occur during a single hour needs to be determined.
--->
<cfset maxColArray = arrayNew(1)>
<cfset success = arraySet(maxColArray,1,24,0)>
<cfoutput query="request.events">
	<!--- Adjust for the user's timezone --->
	<cfset startDT = tz.toLocal(startDateTime,timezone) />
	<cfif not allDay eq true>
		<cfset endDT = dateAdd("s",duration,startDT)>

		<cfset startHour = iif(dateCompare(startDT,dayStart,"s") lte 0, 1, hour(startDT)+1)>
		<cfset endHour	 = iif(dateCompare(endDT,dayEnd,"s") gt 0, 24, hour(dateAdd("n",-1,endDT))+1)>
		<cfloop index="h" from="#startHour#" to="#endHour#">
			<cfset maxColArray[h] = maxColArray[h] + 1>
		</cfloop>
	</cfif>
</cfoutput>
<cfset maxCol = arrayMax(maxColArray)>

<!---
// Once the maximum columns are determined, initialize an array to keep
// track of which page layout slots have been used.
--->
<cfset colArray = arrayNew(1)>
<cfif maxCol gt 0>
	<cfset success = arraySet(colArray,1,maxCol,0)>
</cfif>

<!-- Title bar -->
<cfoutput>
	<table>
		<tr>
			<td><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&viewType=#localViewType#&format=#localFormat#&calendarDate=#dateFormat(dateAdd('d', -1, calendarDate),'short')#&filter=#filter#" style="padding:0px 4px 0px 4px;"><img src="images/arrow_l.gif" border="0"></a></td>
			<td width="340" style="text-align:center;"><span class="bp-title" style="white-space:nowrap;">#lsDateFormat(calendarDate,application.resource.bundle.datetime.full_day_title)#</span></td>
			<td><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&viewType=#localViewType#&format=#localFormat#&calendarDate=#dateFormat(dateAdd('d', +1, calendarDate),'short')#&filter=#filter#" style="padding:0px 4px 0px 4px;"><img src="images/arrow_r.gif" border="0"></a></td>
		</tr>
	</table>

	<cfinclude template="../shared/calendarViewOptions.cfm" /><br />
	<cfinclude template="../shared/calendarViewMenu.cfm" />
</cfoutput>	

<!-- Event information by hour -->
<table width="100%" cellpadding="2" cellspacing="0" class="bc-style">
	<!-- All Day Events -->
	<tr>
		<td width="10%" valign="top"><div class="bct-time"><cfoutput>#application.resource.bundle.text.all_day_events#</cfoutput></div></td>
		<td>
			<cfif request.events.recordCount eq 0 and request.holidays.recordCount eq 0>
				<div class="bct-holiday"><cfoutput>#application.resource.bundle.text.none_scheduled#</cfoutput></div>
			<cfelse>
				<cfoutput query="request.holidays">
					<cfif dateCompare(startDateTime, calendarDate, "d") eq 0>
						<div class="bct-holiday">#title#</div>
					</cfif>
				</cfoutput>
				<cfoutput query="request.events">
					<cfif allDay eq true>
						<div class="bct-event"><a href="index.cfm?cfevent=event.view&calendarId=#calendarId#&eventId=#eventId#">#title#</a></div>
					</cfif>
				</cfoutput>
			</cfif>
		</td>
	</tr>
</table>
<br>

<table border="0" cellpadding="2" cellspacing="0" class="bc-style">
	<!-- The Day's Events -->
	<cfset showWorkHours = request.options.displayWorkHours />
	<cfloop index="ii" from="0" to="23">
		<!---// Format the time column. --->
		<cfif (ii lt 8 or ii gt 16) or (dayOfWeek(arguments.event.getArg('calendarDate')) eq 1 or dayOfWeek(arguments.event.getArg('calendarDate')) eq 7)>
			<cfif showWorkHours eq true>
				<cfset bg = "bc-alternate1">
			<cfelse>
				<cfset bg = "bc-alternate2">
			</cfif>
		<cfelse>
			<cfset bg = "bc-alternate1">
		</cfif>

		<cfset time = createTime(ii,0,0)>	
		<tr class="<cfoutput>#iif(hour(time) mod 2 eq 0, de('bc-alternate1'), de('bc-alternate2'))#</cfoutput>">
			<td width="10%" align="right" valign="middle"><div class="bct-time"><cfoutput>#lsTimeFormat(time,application.resource.bundle.datetime.short_hour_minute_marker)#</cfoutput></div></td>
			<cfif maxColArray[ii+1] lte 0>
				<td colspan="<cfoutput>#maxCol#</cfoutput>"></td>
			<cfelse>
				<cfset hourlyDate = createDateTime(year(arguments.event.getArg('calendarDate')),month(arguments.event.getArg('calendarDate')),day(arguments.event.getArg('calendarDate')),ii,0,0)>
				<cfoutput query="request.events">
					<!--- Adjust for the user's timezone --->
					<cfset startDT = tz.toLocal(startDateTime,timezone) />
					
					<cfif allDay neq true>
						<cfset endDT = dateAdd("s",duration,startDT)>
						<cfset eventLength = 0>
						<cfloop index="c" from="1" to="#maxCol#">
							<cfif dateCompare(hourlyDate,endDT) lt 0>
								<cfif colArray[c] lte 0>
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

									<cfif hour(hourlyDate) eq hour(startDT)>
										<cfset eventLength = iif(dateCompare(endDT,dayEnd) gt 0, 24, evaluate(hour(dateAdd("s",-1,endDT))+1)) - hour(startDT)>
										<cfset colArray[c] = eventLength>
										<td width="#evaluate(95/maxCol)#%" rowspan="#eventLength#" valign="top" class="bc-event"><a href="index.cfm?cfevent=event.view&calendarId=#calendarId#&eventId=#eventId#&date=#dateFormat(startDT,'short')#&seriesId=#seriesId#" onmouseover="overlib('#preview_desc#', CAPTION, '#preview_title#');"  onmouseout="return nd();">#title#</a></td>
										<cfbreak>
									<cfelseif ii eq 0 and dateCompare(startDT,dayStart) lte 0>
										<cfset eventLength =	evaluate(hour(endDT)+1)>
										<cfset colArray[c] = eventLength>
										<td width="#evaluate(95/maxCol)#%" rowspan="#eventLength#" valign="top" class="bc-event"><a href="index.cfm?cfevent=event.view&calendarId=#calendarId#&eventId=#eventId#&date=#dateFormat(startDT,'short')#&seriesId=#seriesId#" onmouseover="overlib('#preview_desc#', CAPTION, '#preview_title#');"  onmouseout="return nd();">#title#</a> (cont'd)</td>
										<cfbreak>
									</cfif>
								</cfif>
							</cfif>
						</cfloop>
					</cfif>
				</cfoutput>

				<cfloop index="c" from="1" to="#maxCol#">
					<cfif colArray[c] gt 0>
						<cfset colArray[c] = colArray[c] - 1>
					<cfelse>
						<td></td>
					</cfif>
				</cfloop>
			</cfif>
		</tr>
	</cfloop>
</table>
<br>
<cfoutput>#request.calendarCategories#</cfoutput>
<br>
