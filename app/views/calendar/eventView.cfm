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

<cfset eventTO = request.eventItem.getEventTO() />
<cfset seriesTO = request.eventSeries.getEventSeriesTO() />
<cfparam name="attributes.date" default="#eventTO.startDateTime#">

<!---// Determine the appropriate timezone adjustment. --->
<cfset tz = getProperty("timezoneLibrary") />
<cfset sessionFacade = getProperty("sessionFacade") />
<cfset timezone = iif(sessionFacade.hasUser(), sessionFacade.getUser().getTimezone(), request.timezone) />

<!---
// If the event is a recurring event, a specially-formatted date/time string
// may be required.
--->
<cfif eventTO.recurrence eq true>
	<!---
	// If the passed date argument is a valid date, the actual event instance 
	// should be loaded.	However, if it is not a valid date, simply a
	// specially-formatted date/time string.
	--->
	<cfif isDate(attributes.date)>
		<!---
		// Try to load the event instance.	If successful, display the date/time
		// information for that specific instance.	Otherwise, display the
		// specially-formatted recurrence string.
		--->
		<cftry>
			<cfinvoke component="#request.eventItem#" method="getInstanceDate" returnvariable="instanceDate" date="#attributes.date#">
			<cfif eventTO.allDay>
				<cfset dateTimeString = lsDateFormat(parseDateTime(instanceDate),application.resource.bundle.datetime.full_week_title) & " &##150; #application.resource.bundle.text.all_day#<br>">
			<cfelse>
				<cfset dateTimeString = lsDateFormat(parseDateTime(instanceDate),application.resource.bundle.datetime.full_week_title) & ", " & lsTimeFormat(parseDateTime(instanceDate),application.resource.bundle.datetime.short_hour_minute_marker) & "&##150;" & lsTimeFormat(dateAdd("s",eventTO.duration,parseDateTime(instanceDate)),application.resource.bundle.datetime.short_hour_minute_marker)>
			</cfif>
			<cfcatch type="InstanceNotFoundException">
				<cfset dateTimeString = request.event.generateRecurrenceString() />
			</cfcatch>
		</cftry>
	<cfelse>
		<!---// Generate the specially-formatted recurrence string. --->
		<cfset dateTimeString = request.event.generateRecurrenceString() />
	</cfif>
<cfelse>
	<cfset startDateTime = tz.toLocal(eventTO.startDateTime, timezone) />
	<cfif eventTO.allDay>
		<cfset dateTimeString = lsDateFormat(parseDateTime(startDateTime),application.resource.bundle.datetime.full_week_title) & " &##150; #application.resource.bundle.text.all_day#<br>">
	<cfelse>
		<cfset dateTimeString = lsDateFormat(parseDateTime(startDateTime),application.resource.bundle.datetime.full_week_title) & ", " & lsTimeFormat(parseDateTime(startDateTime),application.resource.bundle.datetime.short_hour_minute_marker) & "&##150;" & lsTimeFormat(dateAdd("s",eventTO.duration,parseDateTime(startDateTime)),application.resource.bundle.datetime.short_hour_minute_marker)>
	</cfif>
</cfif>

<!---// Get the status of the event. --->
<cfinvoke component="#request.eventItem#" method="getStatus" returnvariable="eventStatus" calendarId="#calendarId#">

<!-- Title bar -->
<span class="bp-title"><cfoutput>#trim(eventTO.title)#</cfoutput></span>

<!-- Calendar Options -->
<cfinclude template="../shared/eventViewOptions.cfm">

<cfoutput>
	<table class="bpd-style" width="100%" cellpadding="0" cellspacing="0" style="border:1px solid ##b9b9b9;">
		<tr>
			<td background="images/bg_gradient_silver.gif">
				<cfif not yesNoFormat(eventTO.recurrence) eq true or (yesNoFormat(eventTO.recurrence) eq true and isDate(attributes.date))>
					<cfif request.options.calendarExportEnabled eq true>
						<a href="index.cfm?cfevent=event.export&eventId=#eventTO.eventId#<cfif isDate(attributes.date)>&eventDate=#attributes.date#</cfif>&amp;cleanHtml=true" class="be-title"><img src="#application.resource.bundle.image.directory#/button_savetooutlook.gif" border="0"></a>
					</cfif>
				</cfif>
			
				<cfif sessionFacade.isSessionAuthorized("#calendarId#_EDIT_EVENTS")>
					<cfif seriesTO.recurrence eq true>
						<a href="index.cfm?cfevent=event.edit&calendarId=#calendarId#&eventId=#eventTO.eventId#&seriesId=#eventTO.seriesId#" class="be-title"><img src="#application.resource.bundle.image.directory#/button_edit_event.gif" border="0"></a>
						&nbsp;&nbsp;<a href="index.cfm?cfevent=event.series.edit&calendarId=#calendarId#&seriesId=#eventTO.seriesId#" class="be-title"><img src="#application.resource.bundle.image.directory#/button_editeventseries.gif" border="0"></a>
					<cfelse>
						<a href="index.cfm?cfevent=event.series.edit&calendarId=#calendarId#&seriesId=#eventTO.seriesId#" class="be-title"><img src="#application.resource.bundle.image.directory#/button_edit_event.gif" border="0"></a>
					</cfif>
				</cfif>
			</td>
		</tr>
	</table>
	<br />

	<table class="bpd-style" width="100%" cellpadding="0" cellspacing="0">
		<!-- Title -->
		<tr class="bpd-title">
			<td>
				<cfif len(trim(eventTO.eventUrl)) gt 0>URL: <a href="#trim(eventTO.eventUrl)#">#trim(eventTO.eventUrl)#</a><br></cfif>
				<cfinvoke component="#request.eventItem#" method="getStatus" returnvariable="globalEventStatus">
				<cfif globalEventStatus neq application.app.global.calendar.status.approved>(#application.resource.bundle.text.not_yet_approved#)</cfif>
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
						<td class="be-style">#eventTO.location#</td>
					</tr>
				</table>
			</td>
		</tr>
		<!-- End Detail Information -->
	
		<!-- Description -->
	<cfif len(eventTO.description) gt 0>
			<tr>
				<td colspan="2" style="padding:6px 0px 6px 12px;"><div class="be-description">#replace(eventTO.description,"#chr(13)##chr(10)#","<br>","ALL")#</div></td>
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
			<td class="be-style">#eventTO.contactFirstName# #eventTO.contactLastName#<BR></td>
		</tr>
		<tr>
			<td class="be-heading" style="padding:0px 0px 0px 12px;">#application.resource.bundle.text.email#:</td>
			<td class="be-style"><a href="mailto:#eventTO.contactEmail#">#eventTO.contactEmail#<BR></a></td>
		</tr>
		<tr>
			<td class="be-heading" style="padding:0px 0px 0px 12px;">#application.resource.bundle.text.phone#:</td>
			<td class="be-style">#eventTO.contactPhone#</td>
		</tr>
	</table>
	<!-- End Contact Information -->
</cfoutput>
<br>

<cfset username = getProperty("sessionFacade").getUser().getUsername() />
<cfif len(trim(username)) gt 0 and compareNoCase(username,"anonymous_guest_acct") neq 0>
	<cfinclude template="reminderEdit.cfm" />
</cfif>
