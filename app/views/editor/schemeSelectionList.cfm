<cfparam name="calendarId" default="" />

<cfswitch expression="#lcase(cfevent)#">
	<cfcase value="administrator.schemes">
		<cfset newEvent = "administrator.scheme.new" />
		<cfset editEvent = "administrator.scheme.edit" />
		<cfset deleteEvent = "administrator.scheme.delete" />
	</cfcase>
	<cfcase value="editor.schemes">
		<cfset newEvent = "editor.scheme.new" />
		<cfset editEvent = "editor.scheme.edit" />
		<cfset deleteEvent = "editor.scheme.delete" />
	</cfcase>
</cfswitch>

<cfoutput>
<div class="bp-title">#application.resource.bundle.text.scheme_management#</div><br>
	
<a href="index.cfm?cfevent=#newEvent#&calendarId=#calendarId#">#application.resource.bundle.text.create_new_scheme#</a><br><br>
<table width="100%" border="0" cellpadding="4" cellspacing="0">
	<tr>
		<th width="24" align="center">#application.resource.bundle.text.edit#</th>
		<th width="24" align="center">#application.resource.bundle.text.delete#</th>
		<th align="left">#application.resource.bundle.text.scheme#</th>
	</tr>
		<cfset toggle = true />
		<cfloop query="request.schemes">
			<tr bgcolor="###iif(toggle,de('e9e9e9'),de('f3f3f3'))#">
				<td align="center"><a href="index.cfm?cfevent=#editEvent#&calendarId=#calendarId#&schemeId=#schemeId#"><img src="images/icon_edit.gif" border="0" alt="#application.resource.bundle.text.edit#" /></a></td>
				<td align="center"><a href="index.cfm?cfevent=#deleteEvent#&calendarId=#calendarId#&schemeId=#schemeId#"><img src="images/icon_delete.gif" border="0" alt="#application.resource.bundle.text.delete#" /></a></td>
				<td>#trim(title)#</td>
			</tr>
			<cfset toggle = not toggle />
		</cfloop>
	</table>
</cfoutput>