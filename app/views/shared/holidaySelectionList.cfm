<cfparam name="selected" default="">
<cfparam name="calendarId" default="">

<cfswitch expression="#lcase(cfevent)#">
	<cfcase value="administrator.holidays">
		<cfset query = "request.holidays" />
		<cfset newEvent = "administrator.holiday.new" />
		<cfset editEvent = "administrator.holiday.edit" />
		<cfset deleteEvent = "administrator.holiday.delete" />
	</cfcase>
	<cfcase value="editor.holidays">
		<cfset query = "request.calendarHolidays" />
		<cfset newEvent = "editor.holiday.new" />
		<cfset editEvent = "editor.holiday.edit" />
		<cfset deleteEvent = "editor.holiday.delete" />
	</cfcase>
</cfswitch>

<cfoutput>
<div class="bp-title">#application.resource.bundle.text.holiday_management#</div><br>

<a href="index.cfm?cfevent=#newEvent#&calendarId=#calendarId#">Create New Holiday</a><br><br>
<table width="100%" border="0" cellpadding="4" cellspacing="0" style="font-size:12px;">
	<tr>
		<th width="24" align="center">#application.resource.bundle.text.edit#</th>
		<th width="24" align="center">#application.resource.bundle.text.delete#</th>
		<th align="left">#application.resource.bundle.text.holiday#</th>
	</tr>
	<cfset toggle = true />
	<cfloop query="#query#">
		<tr bgcolor="###iif(toggle,de('e9e9e9'),de('f3f3f3'))#">
			<td align="center"><a href="index.cfm?cfevent=#editEvent#&calendarId=#calendarId#&holidayId=#holidayId#"><img src="images/icon_edit.gif" border="0" alt="#application.resource.bundle.text.edit#" /></a></td>
			<td align="center"><a href="index.cfm?cfevent=#deleteEvent#&calendarId=#calendarId#&holidayId=#holidayId#"><img src="images/icon_delete.gif" border="0" alt="#application.resource.bundle.text.delete#" /></a></td>
			<td>#trim(title)#</td>
		</tr>
		<cfset toggle = not toggle />
	</cfloop>
</table>

</cfoutput>