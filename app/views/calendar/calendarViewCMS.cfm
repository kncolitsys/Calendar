<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 CalendarViewPanel::displayCalendarMonth
*
* Description:
*	 Displays a calendar view of a month.
*
****************************************************************************
--->
<cfparam name="calendarId">
<cfparam name="weekStart" default="1">
<cfparam name="categories" default="">
<cfparam name="request.calendar">
<cfparam name="calendarDate" default="#now()#">
<cfparam name="calendar" default="">
<cfparam name="displayType" default="standard">
<cfparam name="viewType" default="month">
<cfparam name="format" default="calendar">
<cfparam name="contextId" default="">
<cfparam name="filter" default="">

<cfset localDisplayType = "standard">
<cfset localViewType = "month">
<cfset localFormat = "calendar">
<cfset application.app.global.calendar.overlib.description_limit = 10 />

<!---// Determine the appropriate timezone adjustment. --->
<cfset tz = getProperty("timezoneLibrary") />
<cfset sessionFacade = getProperty("sessionFacade") />
<cfset timezone = iif(sessionFacade.hasUser(), sessionFacade.getUser().getTimezone(), request.timezone) />

<!---// Set the calendar view date and validate it is a date. --->
<cfparam name="calendarDate" default="#now()#">
<cfif not isDate(arguments.event.getArg('calendarDate'))><cfset arguments.event.setArg('calendarDate', now()) /></cfif>

<!---// Create the date range variables for display purposes. --->
<cfset monthStart = createDateTime(year(arguments.event.getArg('calendarDate')), month(arguments.event.getArg('calendarDate')), 1, 0, 0, 0)>
<cfset monthEnd = createDateTime(year(arguments.event.getArg('calendarDate')), month(arguments.event.getArg('calendarDate')), daysInMonth(monthStart), 23, 59, 59)>

<cfset options = request.calendar.getOptions() />
<!-- Title bar -->
<cfoutput>
	<table width="100%">
		<tr>
			<td>
				<table>
					<tr>
						<td>
							<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=#localViewType#&format=#localFormat#&calendarDate=#dateFormat(dateAdd('yyyy', -1, arguments.event.getArg('calendarDate')),'short')#&filter=#filter#" style="padding:0px 4px 0px 4px;"><img src="images/arrow_ld.gif" border="0"></a>
							<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=#localViewType#&format=#localFormat#&calendarDate=#dateFormat(dateAdd('m', -1, arguments.event.getArg('calendarDate')),'short')#&filter=#filter#" style="padding:0px 4px 0px 4px;"><img src="images/arrow_l.gif" border="0"></a>
						</td>
						<td width="180" style="text-align:center;"><span class="bp-title" style="padding:0px 4px 0px 4px;white-space:nowrap;">#lsDateFormat(arguments.event.getArg('calendarDate'),'mmmm yyyy')#</span></td>
						<td>
							<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=#localViewType#&format=#localFormat#&calendarDate=#dateFormat(dateAdd('m', +1, arguments.event.getArg('calendarDate')),'short')#&filter=#filter#" style="padding:0px 4px 0px 4px;"><img src="images/arrow_r.gif" border="0"></a>
							<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=#localViewType#&format=#localFormat#&calendarDate=#dateFormat(dateAdd('yyyy', +1, arguments.event.getArg('calendarDate')),'short')#&filter=#filter#" style="padding:0px 4px 0px 4px;"><img src="images/arrow_rd.gif" border="0"></a>
						</td>
					</tr>
				</table>
			</td>
			<td align="right">
				<table border="0" cellpadding="0" cellspacing="0" style="width:100%;">
					<tr>
						<td align="right">
							<cfinclude template="../shared/calendarViewOptions.cfm" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

	<cfinclude template="../shared/calendarViewMenu.cfm" />
</cfoutput>

<table border="0" cellpadding="0" cellspacing="0" class="bc-style">		
	<!-- Days of Month -->
	<tr class="bc-style">
		<cfoutput>
			<cfset headerStart = weekStart>
			<cfset headerDays = 7>
			<cfset headerWidth = Int((100 - 5) / 7)>
			<th width="2%" class="bc-style">&nbsp;</th>
			<cfloop index="i" from="#headerStart#" to="#evaluate(headerStart + headerDays - 1)#">
				<cfset headerDay = i mod headerDays>
				<cfif headerDay eq 0><cfset headerDay = 7></cfif>
				<th width="#headerWidth#%" class="bc-style">#left(dayOfWeekAsString(headerDay),3)#</th>
			</cfloop>
		</cfoutput>
	</tr>
	
	<!-- Days -->
	<tr class="bcl-layout">
		<cfset colOffset = (dayOfWeek(monthStart) + (7 - weekStart)) mod 7 + 1>
		<cfset colLast = colOffset + daysInMonth(monthStart) - 1>
		<cfset cells = (ceiling(colLast/7)) * 7>
		<cfset dayOfMonth = createDateTime(year(arguments.event.getArg('calendarDate')), month(arguments.event.getArg('calendarDate')), 1, 0, 0, 0)>
		
		<td width="2%" align="center" class="bc-style"><a href="index.cfm?cfevent=calendar.view&calendarId=<cfoutput>#calendarId#</cfoutput>&displayType=standard&viewType=week&format=calendar&calendarDate=<cfoutput>#dateFormat(dayOfMonth,'mm/dd/yyyy')#</cfoutput>&filter="><img src="images/arrow_r.gif" border="0"></a></td>
		
		<cfloop index="cell" from="1" to="#cells#">
			<cfif cell gte colOffset and cell lte colLast>
				<td valign="top" height="70" class="bc-style">
					<cfoutput>
						<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=#localDisplayType#&viewType=day&format=#localFormat#&calendarDate=#dateFormat(dayOfMonth,'short')#&filter=#filter#" class="bcd-style">#day(dayOfMonth)#</a><br>
					</cfoutput>

					<cfoutput query="request.holidays">
						<cfif dateCompare(startDateTime, dayOfMonth, "d") eq 0>
							<div class="bct-smallholiday" style="padding:1px;">#title#</div>
						</cfif>
					</cfoutput>
					<cfoutput query="request.events">
						<cfset startDT = tz.toLocal(startDateTime,timezone) />
						<cfif dateCompare(startDT, dayOfMonth, "d") eq 0>
							<cfscript>
								orig_list = "',"",#chr(10)#,#chr(13)#";
								repl_list = "\',\',,";
								wrap_limit = 14;

								preview_desc = "";								
								if(allDay eq true)
									preview_desc = preview_desc & "<b>Time:</b> All day<br>";
								else if(isDate(parseDateTime(startDT)))
									preview_desc = preview_desc & "<b>Time:</b> " & lsTimeFormat(parseDateTime(startDT),"short") & "<br>";
								if(len(location) gt 0)	
									preview_desc = preview_desc & "<b>Location:</b> " & location & "<br>";
								if(len(trim(description)) gt application.app.global.calendar.overlib.description_limit)
									preview_desc = preview_desc & "<br>" & left(trim(description),application.app.global.calendar.overlib.description_limit) & "...";
								if(len(trim(description)) gt 0) 
									preview_desc = preview_desc & "<br>" & description;
								if(len(preview_desc) eq 0)
									preview_desc = "No details are available";
									
								preview_desc = replaceList(preview_desc,orig_list,repl_list);
								preview_title = replaceList(title,orig_list,repl_list);
								mod_title = trim(title);
								for(i=1; i lte int(len(title)/wrap_limit); i=i+1) {
									loc = findOneOf(' ',mod_title,i*wrap_limit+(i-1)*4);
									if(loc gt 0) 
										mod_title = insert('<br>',mod_title,loc);
								}
							</cfscript>
							<div class="bct-smallevent"><div class="category_#lCase(replace(categoryId,'-','','ALL'))#" style="padding:1px;" onmouseover="overlib('#preview_desc#', CAPTION, '#preview_title#');"  onmouseout="return nd();"><a href="index.cfm?cfevent=event.view&calendarId=#calendarId#&eventId=#eventId#" onmouseover="overlib('#preview_desc#', CAPTION, '#preview_title#');"  onmouseout="return nd();">#mod_title#</a></div></div>
						</cfif>
					</cfoutput>
				</td>
				<cfset dayOfMonth = dateAdd("d", 1, dayOfMonth)>
			<cfelse>
				<td valign="top" class="bcd-empty">&nbsp;</td>
			</cfif>
			
			<cfif (cell mod 7 eq 0) and month(dayOfMonth) eq month(monthStart)>
				</tr>
				<tr>
					<td width="2%" align="center" class="bc-style"><a href="index.cfm?cfevent=calendar.view&calendarId=<cfoutput>#calendarId#</cfoutput>&displayType=standard&viewType=week&format=calendar&calendarDate=<cfoutput>#dateFormat(dayOfMonth,'mm/dd/yyyy')#</cfoutput>&filter="><img src="images/arrow_r.gif" border="0"></a></td>
			</cfif>
		</cfloop>
	</tr>
</table>
<br>
<cfoutput>#request.calendarCategories#<br /></cfoutput>

<cfoutput> 
<form action="index.cfm?cfevent=calendar.view&calendarId=#calendarId#" method="post">
	<input name="displayType" type="hidden" value="#displayType#">
	<input name="viewType" type="hidden" value="#viewType#">
	<input name="format" type="hidden" value="#format#">
	<input name="filter" type="hidden" value="#filter#">

	<table align="center" cellpadding="4" cellspacing="0" class="bpd-style">
		<tr>	
			<td align="center">
				<cfif false>
					<script language="JavaScript" src="scripts/popcalendar.js"></script>
					<input name="calendarDate" type="text" size="10" maxlength="10" value="#dateformat(calendarDate,'mm/dd/yyyy')#" />
					<img src="images/icon_calendar.gif" border="0" align="absmiddle" onClick="popUpCalendar(this, document.all.calendarDate, 'mm/dd/yyyy', 0, -150)" style="cursor:hand;cursor:pointer;">
					&nbsp;&nbsp;
					<input name="btn_GoToDate" type="submit" value="#application.resource.bundle.button.go#">
				<cfelse>
					<select name="calendarDate_m">
						<cfloop index="month" from="1" to="12">
							<option value="#month#" <cfif month(calendarDate) eq month>selected</cfif>>#monthAsString(month)#</option>
						</cfloop>
					</select>
	
					<input name="calendarDate_d" type="hidden" value="2">
					<!---<select name="calendarDate_d">
						<cfloop index="dayOfMonth" from="1" to="31">
							<option value="#dayOfMonth#" <cfif day(calendarDate) eq dayOfMonth>selected</cfif>>#dayOfMonth#</option>
						</cfloop>
					</select>--->
	
					<select name="calendarDate_y">
						<cfloop index="year" from="#evaluate(year(now())-1)#" to="#evaluate(year(now())+7)#">
							<option value="#year#" <cfif year(calendarDate) eq year>selected</cfif>>#year#</option>
						</cfloop>
					</select>
					
					<input name="btn_GoToDate" type="submit" value="#application.resource.bundle.button.go#">
				</cfif>
			</td>
		</tr>
	</table>
</form>
</cfoutput>