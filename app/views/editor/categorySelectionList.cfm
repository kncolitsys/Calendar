<cfparam name="selected" default="">

<cfoutput>
<div class="bp-title">#application.resource.bundle.text.category_management#</div><br>

<a href="index.cfm?cfevent=editor.category.new&calendarId=#calendarId#">Create New Category</a><br><br>
<table width="100%" border="0" cellpadding="4" cellspacing="0" style="font-size:12px;">
	<tr>
		<th width="24" align="center">#application.resource.bundle.text.edit#</th>
		<th width="24" align="center">#application.resource.bundle.text.delete#</th>
		<th align="left">#application.resource.bundle.text.category#</th>
	</tr>
	<cfset toggle = true />
	<cfloop query="request.categories">
		<tr bgcolor="###iif(toggle,de('e9e9e9'),de('f3f3f3'))#">
			<td align="center"><a href="index.cfm?cfevent=editor.category.edit&calendarId=#calendarId#&categoryId=#categoryId#"><img src="images/icon_edit.gif" border="0" alt="#application.resource.bundle.text.edit#" /></a></td>
			<td align="center"><a href="index.cfm?cfevent=editor.category.delete&calendarId=#calendarId#&categoryId=#categoryId#"><img src="images/icon_delete.gif" border="0" alt="#application.resource.bundle.text.delete#" /></a></td>
			<td>#trim(title)#</td>
		</tr>
		<cfset toggle = not toggle />
	</cfloop>
</table>
</cfoutput>