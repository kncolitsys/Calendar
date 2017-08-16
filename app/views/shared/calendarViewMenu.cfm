<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 CalendarViewPanel::displayMenu
*
* Description:
*	 Displays a menu for the calendar view.
*
****************************************************************************
--->

<cfparam name="calendarDate" default="#now()#">
<cfparam name="displayType" default="standard">
<cfparam name="viewType" default="month">
<cfparam name="format" default="calendar">
<cfparam name="contextId" default="">
<cfparam name="filter" default="">

<cfoutput>
	<table cellpadding="0" cellspacing="0" style="width:100%;">
		<tr>
			<td>
				<table border="0" cellspacing="0" cellpadding="0">
					<tr valign="bottom">
						<td style="padding:0px 4px 0px 0px;"><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=standard&viewType=year&format=#format#&calendarDate=#dateFormat(calendarDate,'short')#&filter=#filter#" class="bcm-text">#application.resource.bundle.text.year_ucase#</a></td>
						<td style="padding:0px 4px 0px 4px;"><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=standard&viewType=month&format=#format#&calendarDate=#dateFormat(calendarDate,'short')#&filter=#filter#" class="bcm-text">#application.resource.bundle.text.month_ucase#</a></td>
						<td style="padding:0px 4px 0px 4px;"><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=standard&viewType=week&format=#format#&calendarDate=#dateFormat(calendarDate,'short')#&filter=#filter#" class="bcm-text">#application.resource.bundle.text.week_ucase#</a></td>
						<td style="padding:0px 0px 0px 4px;"><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&displayType=standard&viewType=day&format=#format#&calendarDate=#dateFormat(calendarDate,'short')#&filter=#filter#" class="bcm-text">#application.resource.bundle.text.day_ucase#</a></td>
					</tr>
				</table>
			</td>
			<td align="right">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr valign="bottom">
						<td style="padding:0px 4px 0px 0px;"><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&calendarDate=#dateFormat(calendarDate,'short')#&displayType=standard&viewType=#viewType#&format=calendar&filter=#filter#" class="bcm-text">#application.resource.bundle.text.calendar_ucase#</a></td>
						<td style="padding:0px 0px 0px 4px;"><a href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#&calendarDate=#dateFormat(calendarDate,'short')#&displayType=standard&viewType=#viewType#&format=list&filter=#filter#" class="bcm-text">#application.resource.bundle.text.list_ucase#</a></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</cfoutput>