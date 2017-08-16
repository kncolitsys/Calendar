<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 EventViewPanel::display
*
* Description:
*	 Displays the default event view.
*
****************************************************************************
--->
<cfparam name="eventDate" default="" />

<cfset seriesTO = request.eventSeries.getEventSeriesTO() />

<!---// Determine the appropriate timezone adjustment. --->
<cfset tz = getProperty("timezoneLibrary") />
<cfset sessionFacade = getProperty("sessionFacade") />
<cfset timezone = iif(sessionFacade.hasUser(), sessionFacade.getUser().getTimezone(), request.timezone) />
<cfset tzoffset = tz.getOffset(timezone) />

<!---
// If the event is a recurring event, a specially-formatted date/time string
// may be required.
--->
<cfif seriesTO.recurrence eq true>
	<!---
	// If the passed date argument is a valid date, the actual event instance 
	// should be loaded.	However, if it is not a valid date, simply a
	// specially-formatted date/time string.
	--->
	<cfif isDate(eventDate)>
		
		<!---
		// CODE: Rather than handling this code here, when an eventDate parameter is
		// specified, I should be redirecting the user to the event.view cfevent,
		// rather than the event.series.view cfevent.		
		--->
		
		<!---
		// Try to load the event instance.	If successful, display the date/time
		// information for that specific instance.	Otherwise, display the
		// specially-formatted recurrence string.
		--->
		<cftry>
			<cfset instanceDate = tz.toLocal(parseDateTime(request.eventSeries.getInstanceDate(date=eventDate)),timezone) />
			<cfif seriesTO.allDay>
				<cfset dateTimeString = lsDateFormat(parseDateTime(instanceDate),application.resource.bundle.datetime.full_week_title) & " &##150; #application.resource.bundle.text.all_day#<br>">
			<cfelse>
				<cfset dateTimeString = lsDateFormat(parseDateTime(instanceDate),application.resource.bundle.datetime.full_week_title) & ", " & lsTimeFormat(parseDateTime(instanceDate),application.resource.bundle.datetime.short_hour_minute_marker) & "&##150;" & lsTimeFormat(dateAdd("s",seriesTO.duration,parseDateTime(instanceDate)),application.resource.bundle.datetime.short_hour_minute_marker)>
			</cfif>
			<cfcatch type="InstanceNotFoundException">
				<cfset dateTimeString = request.eventSeries.generateRecurrenceString(tzoffset) />
			</cfcatch>
		</cftry>
	<cfelse>
		<!---// Generate the specially-formatted recurrence string. --->
		<cfset dateTimeString = request.eventSeries.generateRecurrenceString(tzoffset) />
	</cfif>
<cfelse>
	<cfset startDateTime = tz.toLocal(parseDateTime(seriesTO.recurrenceStartDate),timezone) />
	<cfif seriesTO.allDay>
		<cfset dateTimeString = lsDateFormat(startDateTime,application.resource.bundle.datetime.full_week_title) & " &##150; #application.resource.bundle.text.all_day#<br>">
	<cfelse>
		<cfset dateTimeString = lsDateFormat(startDateTime,application.resource.bundle.datetime.full_week_title) & ", " & lsTimeFormat(startDateTime,application.resource.bundle.datetime.short_hour_minute_marker) & "&##150;" & lsTimeFormat(dateAdd("s",seriesTO.duration,startDateTime),application.resource.bundle.datetime.short_hour_minute_marker)>
	</cfif>
</cfif>

<!---// Get the status of the event. --->
<cfset eventStatus = request.eventSeries.getStatus(calendarId=calendarId) />

<!-- Title bar -->
<span class="bp-title"><cfoutput>#application.resource.bundle.text.view_an_event#</cfoutput></span><br>

<!-- Calendar Options -->
<cfinclude template="../shared/eventViewOptions.cfm" />

<cfoutput>
	<table class="bpd-style" width="100%" cellpadding="0" cellspacing="0">
		<!-- Title -->
		<tr class="bpd-title">
			<td>
				<cfif len(trim(seriesTO.eventUrl)) gt 0>
					<div class="be-title"><a href="#trim(seriesTO.eventUrl)#">#trim(seriesTO.title)#</a></div>
				<cfelse>
					<div class="be-title">#trim(seriesTO.title)#</div>
				</cfif>
				<cfset globalEventStatus = request.eventSeries.getStatus() />
				<cfif globalEventStatus neq application.app.global.calendar.status.approved>(#application.resource.bundle.text.not_yet_approved#)</cfif>
			</td>
			<td align="right">
				<cfif not yesNoFormat(seriesTO.recurrence) eq true or (yesNoFormat(seriesTO.recurrence) eq true and isDate(eventDate))>
					<cfif request.options.calendarExportEnabled eq true>
						<a href="index.cfm?cfevent=event.export&seriesId=#seriesTO.seriesId#<cfif isDate(eventDate)>&eventDate=#eventDate#</cfif>&amp;cleanHtml=true" class="be-title"><img src="#application.resource.bundle.image.directory#/button_savetooutlook.gif" border="0"></a>
					</cfif>
				</cfif>
			
				<!---// CODE: Update and uncomment --->
<!---				<cfinvoke component="#application.passport#" method="getPermissions" returnvariable="perms">
					<cfinvokeargument name="username" value="#getProperty("sessionFacade").getUser().getUsername()#">
				</cfinvoke>
				<cfset externalAuthorization = listFindNoCase(perms,"#calendarId#_EDIT_EVENTS") gt 0>
				<cfset internalAuthorization = getProperty("sessionFacade").isSessionAuthorized(uCase("#calendarId#_APPROVE_EVENTS"))>
	
				<cfif externalAuthorization>
					<a href="index.cfm?cfevent=event.edit&cid=#calendarId#&seriesId=#seriesTO.id#" class="be-title"><img src="#application.resource.bundle.image.directory#/button_edit_event.gif" border="0"></a>
				<cfelseif internalAuthorization>
					<a href="index.cfm?cfevent=event.share.remove&cid=#calendarId#&seriesId=#seriesTO.id#" class="be-title"><img src="#application.resource.bundle.image.directory#/button_remove.gif" border="0"></a>
				</cfif>
			--->
				<cfif getProperty("sessionFacade").isSessionAuthorized(uCase("#calendarId#_EDIT_EVENTS"))>
					<a href="index.cfm?cfevent=event.series.edit&calendarId=#calendarId#&seriesId=#seriesTO.seriesId#" class="be-title"><img src="#application.resource.bundle.image.directory#/button_editeventseries.gif" border="0"></a>
				</cfif>
				<!---<cfif eventStatus eq application.app.global.calendar.status.approved>
					[<a href="index.cfm?cfevent=event.share&cid=#calendarId#&seriesId=#seriesTO.id#" class="be-title">#application.resource.bundle.text.submit#</a>]
				</cfif>--->
			</td>
		</tr>
		<!-- End Title -->

		<!-- Detail Information -->
		<tr>
			<td colspan="2" style="padding:6px 0px 6px 12px;border-bottom:1px solid">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top" class="be-heading">#application.resource.bundle.text.time#:&nbsp;</td>
						<td class="be-style">#dateTimeString#</td>
					</tr>
					<tr>
						<td class="be-heading">#application.resource.bundle.text.location#:&nbsp;</td>
						<td class="be-style">#seriesTO.location#</td>
					</tr>
				</table>
			</td>
		</tr>
		<!-- End Detail Information -->
	
		<!-- Description -->
		<cfif len(seriesTO.description) gt 0>
			<tr>
				<td colspan="2" style="padding:6px 0px 6px 12px;"><div class="be-description">#replace(seriesTO.description,"#chr(13)##chr(10)#","<br>","ALL")#</div></td>
			</tr>
		</cfif>
		<!-- End Description -->
	</table>
	<br>
		
	<!-- Begin Contact Information -->
	<table class="bpd-style" width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr class="bpd-title">
			<td colspan="3">#application.resource.bundle.text.contact_information#</td>
		</tr>
		<tr>
			<td class="be-heading" style="padding:0px 0px 0px 12px;">#application.resource.bundle.text.name#:</td>
			<td class="be-style">#seriesTO.contactFirstName# #seriesTO.contactLastName#<BR></td>
		</tr>
		<tr>
			<td class="be-heading" style="padding:0px 0px 0px 12px;">#application.resource.bundle.text.email#:</td>
			<td class="be-style"><a href="mailto:#seriesTO.contactEmail#">#seriesTO.contactEmail#<BR></a></td>
		</tr>
		<tr>
			<td class="be-heading" style="padding:0px 0px 0px 12px;">#application.resource.bundle.text.phone#:</td>
			<td class="be-style">#seriesTO.contactPhone#</td>
		</tr>
	</table>
	<!-- End Contact Information -->
</cfoutput>
<br>

<!---
// CODE: Fix this section!!!
<cfif len(trim(getProperty("sessionFacade").getUser().getUsername())) gt 0 and compareNoCase(getProperty("sessionFacade").getUser().getUsername(),"anonymous_guest_acct") neq 0>
	<cftry>
		<cfinvoke component="#request.event#" method="getReminder" returnvariable="oReminder">
			<cfinvokeargument name="username" value="#getProperty("sessionFacade").getUser().getUsername()#">
		</cfinvoke>
		
		<cfcatch type="any">
			<cfset oReminder = createObject("component","calendar.models.reminder.reminder") />
			<cfset oReminder.event = seriesTO>
		</cfcatch>
	</cftry>

	<cfoutput>#request.reminderPod#</cfoutput>
</cfif>
--->
