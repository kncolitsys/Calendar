<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 CalendarViewPanel::displayPrintDay
*
* Description:
*	 Displays a printable view of a one day calendar.
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
<cfset dayStart = createDateTime(year(calendarDate), month(calendarDate), day(calendarDate), 0, 0, 0)>
<cfset dayEnd = createDateTime(year(calendarDate), month(calendarDate), day(calendarDate), 23, 59, 59)>


<!-- Title bar -->
<table align="center" style="width:610;">
	<cfoutput>
		<tr>
			<td align="center">
				<span class="bp-title">#lsDateFormat(calendarDate,application.resource.bundle.datetime.full_day_title)#</span>
			</td>
		</tr>
	</cfoutput>	
</table>

<!-- Event information by hour -->
<table border="0" cellpadding="2" cellspacing="0" align="center" class="bc-style" style="width:610;">
	<!-- All Day Events -->
	<tr>
		<td width="10%" valign="top" nowrap>
			<div class="bct-printtime" style="font-weight:bold;"><cfoutput>#application.resource.bundle.text.all_day_events#</cfoutput>&nbsp;</div>
		</td>
		<td>
			<span class="bct-printholiday">
				<cfif request.events.recordCount eq 0 and request.holidays.recordCount eq 0>
					<cfoutput>#application.resource.bundle.text.none_scheduled#</cfoutput>
				<cfelse>
					<cfoutput query="request.holidays">
						<!---// CODE: Update and uncomment --->
						<!---
						<cfif dateCompare(startDateTime, dayOfMonth, "d") eq 0>
							#title#<br />
						</cfif>
						--->
					</cfoutput>
					<cfoutput query="request.events">
						<cfif allDay eq true>
							<a href="index.cfm?cfevent=event.view&calendarId=#calendarId#&eventId=#eventId#">#title#</a><br>
						</cfif>
					</cfoutput>
				</cfif>
			</span>
		</td>
	</tr>
</table>
<br>

<table border="0" cellpadding="2" cellspacing="0" align="center" class="bc-style" style="width:610px;">
	<!-- The Day's Events -->
	<cfif val(request.events.recordCount) gt 0>
		<cfset classToggle = 1>
		<cfoutput query="request.events">
			<cfset startDT = tz.toLocal(startDateTime,timezone) />
			<cfset endDT = dateAdd("s",duration,startDT)>
			<cfset eventLength = 0>
			<cfif allDay neq true>
				<cfset classToggle = classToggle + 1>
				<tr class="#iif(classToggle mod 2 eq 0, de('calendarbc-alternate1'), de('bc-alternate2'))#">
					<td valign="top">
						<div class="bct-printevent">
							<span style="white-space:nowrap;">
								#lsTimeFormat(parseDateTime(startDT),application.resource.bundle.datetime.short_hour_minute_marker)# <cfif dateCompare(startDT,calendarDate,"d") lt 0>(#lsDateFormat(parseDateTime(startDT),application.resource.bundle.datetime.abbrev_month_day)#)</cfif> -
								#lsTimeFormat(dateAdd("s",duration,startDT),application.resource.bundle.datetime.short_hour_minute_marker)# <cfif dateCompare(endDT,calendarDate,"d") gt 0>(#lsDateFormat(endDT,application.resource.bundle.datetime.abbrev_month_day)#)</cfif>
							</span>
						</div>
					</td>
					<td valign="top" align="left">
						<div class="bct-printevent">
							#title#<br>
							<cfif len(location) gt 0>#application.resource.bundle.text.location#: #location#<br></cfif>
							<cfif len(description) gt 0>#description#<br></cfif>
						</div>
					</td>
				</tr>
			</cfif>
		</cfoutput>
	<cfelse>
		<tr class="bc-alternate1" align="center">
			<td><div class="bct-printevent"><cfoutput>#application.resource.bundle.text.no_events_scheduled#</cfoutput></div></td>
		</tr>
	</cfif>
</table>