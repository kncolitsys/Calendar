<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 SearchPanel::displayOptions
*
* Description:
*	 Displays a set of options for a user.
*
****************************************************************************
--->
<table border="0" cellpadding="0" cellspacing="0" style="width:100%;">
	<tr>
		<td align="right">
			<cfoutput>
				<a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&calendarDate=#dateFormat(calendarDate,'short')#"><img src="#application.resource.bundle.image.directory#/button_calendar.gif" border="0"></a>&nbsp;
			
				<cfif getProperty("sessionFacade").isSessionAuthorized(uCase("#calendarId#_SUBMIT_EVENTS"))><a href="index.cfm?cfevent=event.series.submit&calendarId=#calendarId#"><img src="#application.resource.bundle.image.directory#/button_addevent.gif" border="0"></a>&nbsp;</cfif>

				<cfif request.options.searchEnabled eq true><a href="index.cfm?cfevent=calendar.search&calendarId=#calendarId#"><img src="#application.resource.bundle.image.directory#/button_search.gif" border="0"></a>&nbsp;</cfif>
			</cfoutput>
		</td>
	</tr>
</table>
