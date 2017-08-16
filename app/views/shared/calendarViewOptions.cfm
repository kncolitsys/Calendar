<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 CalendarViewPanel::displayOptions
*
* Description:
*	 Displays a set of options for a user.
*
****************************************************************************
--->

<cfparam name="calendarDate" default="#now()#">
<cfparam name="displayType" default="standard">
<cfparam name="viewType" default="month">
<cfparam name="format" default="calendar">
<cfparam name="contextId" default="">
<cfparam name="filter" default="">

<cfset options = request.calendar.getOptions() />
<table border="0" cellpadding="0" cellspacing="0" style="width:100%;">
	<tr>
		<td align="right">
			<cfoutput>
				<!---// CODE: Update and uncomment --->
				<cfif getProperty("sessionFacade").isSessionAuthorized(uCase("#calendarId#_APPROVE_EVENTS")) AND getProperty("sessionFacade").isSessionAuthorized(uCase("#calendarId#_ADMINISTER"))>
					<cfif val(request.unapprovedEvents.recordCount) gt 0>
						<a href="index.cfm?cfevent=editor.events.approve&calendarId=#calendarId#"><img src="#application.resource.bundle.image.directory#/button_approveevents.gif" border="0"></a>&nbsp;
					</cfif>
				</cfif>
		
				<cfif getProperty("sessionFacade").isSessionAuthorized(uCase("#calendarId#_SUBMIT_EVENTS"))>
					<a href="index.cfm?cfevent=event.series.submit&calendarId=#calendarId#"><img src="#application.resource.bundle.image.directory#/button_addevent.gif" border="0"></a>&nbsp;
				</cfif>
				<cfif options.searchEnabled eq true><a href="index.cfm?cfevent=calendar.search&calendarId=#calendarId#"><img src="#application.resource.bundle.image.directory#/button_search.gif" border="0"></a>&nbsp;</cfif>
			
				<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&calendarDate=#dateFormat(calendarDate,'short')#&displayType=#displayType#&viewType=#viewType#&format=print&filter=#filter#" target="_blank"><img src="#application.resource.bundle.image.directory#/button_print.gif" border="0"></a>
			</cfoutput>
		</td>
	</tr>
</table>
