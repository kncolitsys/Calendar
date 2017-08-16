<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 EventViewPanel::displayOptions
*
* Description:
*	 Displays a set of options for a user.
*
****************************************************************************
--->
<cfparam name="request.eventItem" default="">
<cfparam name="displayType" default="standard">
<cfparam name="viewType" default="month">
<cfparam name="format" default="calendar">
<cfparam name="filter" default="">
<cfparam name="calendarDate" default="#now()#">

<table border="0" cellpadding="0" cellspacing="0" style="width:100%;">
	<tr>
		<td align="right">
			<cfoutput>
				<cfif getProperty("sessionFacade").isSessionAuthorized(uCase("#calendarId#_APPROVE_EVENTS")) AND getProperty("sessionFacade").isSessionAuthorized(uCase("#calendarId#_ADMINISTER"))>
					<cfif val(request.unapprovedEvents.recordCount) gt 0>
						<a href="index.cfm?cfevent=events.approve&calendarId=#calendarId#"><img src="#application.resource.bundle.image.directory#/button_approveevents.gif" border="0"></a>&nbsp;
					</cfif>
				</cfif>

				<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&calendarDate=#dateFormat(calendarDate,'short')#"><img src="#application.resource.bundle.image.directory#/button_calendar.gif" border="0"></a>&nbsp;
				
				<cfif getProperty("sessionFacade").isSessionAuthorized(uCase("#calendarId#_SUBMIT_EVENTS"))><a href="index.cfm?cfevent=event.series.submit&calendarId=#calendarId#"><img src="#application.resource.bundle.image.directory#/button_addevent.gif" border="0"></a>&nbsp;</cfif>

				<cfif request.options.searchEnabled eq true><a href="index.cfm?cfevent=calendar.search&calendarId=#calendarId#"><img src="#application.resource.bundle.image.directory#/button_search.gif" border="0"></a>&nbsp;</cfif>
			
				<!---// CODE: Correct this code... remove the eventItem.getEventId() code, since this template can be used for eventSeries as well --->
				<!---<a href="index.cfm?cfevent=event.view&calendarId=#calendarId#&eventId=#request.eventItem.getEventId()#&format=print" target="_blank"><img src="#application.resource.bundle.image.directory#/button_print.gif" border="0"></a>--->
			</cfoutput>
		</td>
	</tr>
</table>
