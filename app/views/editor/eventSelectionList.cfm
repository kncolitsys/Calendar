<cfparam name="attributes.selected" default="">

<cfoutput>
<div class="bp-title">#application.resource.bundle.text.event_management#</div><br>

			<form action="index.cfm?cfevent=editor.events.approve&calendarId=#calendarId#" method="post">
				<input name="submit" type="submit" value="#application.resource.bundle.button.approve_events#">
			</form>

<a href="index.cfm?cfevent=editor.event.new&calendarId=#calendarId#">Create New event</a><br><br>
<table width="100%" border="0" cellpadding="4" cellspacing="0" style="font-size:12px;">
	<tr>
		<th width="24" align="center">#application.resource.bundle.text.edit#</th>
		<th width="24" align="center">#application.resource.bundle.text.delete#</th>
		<th align="left">#application.resource.bundle.text.event#</th>
	</tr>
	<cfset toggle = true />
	<cfloop query="request.events">
		<tr bgcolor="###iif(toggle,de('e9e9e9'),de('f3f3f3'))#">
			<td align="center"><a href="index.cfm?cfevent=editor.event.edit&calendarId=#calendarId#&seriesId=#seriesId#"><img src="images/icon_edit.gif" border="0" alt="#application.resource.bundle.text.edit#" /></a></td>
			<td align="center"><a href="index.cfm?cfevent=editor.event.delete&calendarId=#calendarId#&seriesId=#seriesId#"><img src="images/icon_delete.gif" border="0" alt="#application.resource.bundle.text.delete#" /></a></td>
			<td>#trim(title)#</td>
		</tr>
		<cfset toggle = not toggle />
	</cfloop>
</table>
</cfoutput>