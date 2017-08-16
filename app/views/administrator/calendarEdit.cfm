<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 CalendarEditPanel::display
*
* Description:
*	 Display a panel for managing a calendar
*
****************************************************************************
--->

<cfparam name="attributes.contextId" default="">
<cfif arguments.event.isArgDefined("calendarBean")>
	<cfset calendarTO = arguments.event.getArg("calendarBean").getCalendarTO() />
	<cfset newCalendar = true />
<cfelse>
	<cfset calendarTO = request.calendar.getCalendarTO() />
	<cfset newCalendar = false />
</cfif>

<script language="javascript">
<!--//
function validateDelete(form) {
	del = confirm("<cfoutput>#application.resource.bundle.text.delete_calendar_warning#</cfoutput>");
	if(del) {
		form.action='index.cfm?cfevent=calendar.deleted&cid=<cfoutput>#attributes.contextId#</cfoutput>';
		return true;
	} else {
		return false;
	}
}
//-->
</script>

<!---// CODE: update and uncomment this code --->
<cfif not newCalendar>
	<cfoutput><div align="right">[<a href="index.cfm?cfevent=administrator.calendar.searchIndex.edit&calendarId=#trim(calendarTO.calendarId)#&calendarId=#trim(calendarTO.calendarId)#">#application.resource.bundle.text.manage_search_index#</a>]</div></cfoutput>
</cfif>

<cfoutput>
<cfform action="index.cfm?cfevent=#trim(cfevent)#.submitted" method="post">
<input name="calendarId" type="hidden" value="#trim(calendarTO.calendarId)#">
<!---// CODE: update and uncomment this code --->
<!---<input name="schemeId" type="hidden" value="#trim(calendarTO.scheme.id)#">--->

<table cellpadding="0" cellspacing="0" class="bpd-style">
	<tr>
		<td>#application.resource.bundle.text.title#:</td>
		<td><input name="title" type="text" size="30" maxlength="50" value="#trim(calendarTO.title)#"></td>
	</tr>
	<tr>
		<td>#application.resource.bundle.text.description#:</td>
		<td><input name="description" type="text" size="30" maxlength="100" value="#trim(calendarTO.description)#"></td>
	</tr>
	<tr>
		<td>#application.resource.bundle.text.status#:</td>
		<td>
			<select name="status" size="1">
				<option value="#application.app.global.calendar.status.approved#" <cfif compareNoCase(calendarTO.status, application.app.global.calendar.status.approved) eq 0>selected</cfif>>#application.resource.bundle.text.approved#</option>
				<option value="#application.app.global.calendar.status.pending#" <cfif compareNoCase(calendarTO.status, application.app.global.calendar.status.pending) eq 0>selected</cfif>>#application.resource.bundle.text.pending#</option>				
			</select>
		</td>
	</tr>
	<tr>
		<td>#application.resource.bundle.text.default_group#:</td>
		<td>
			<cfif isQuery(request.groups)>
				<select name="defaultGroup">
					<option value="">(#application.resource.bundle.text.select_group#)</option>
					<cfloop query="request.groups">
						<option value="#trim(groupId)#" <cfif compareNoCase(trim(request.options.defaultGroup),trim(groupId)) eq 0>selected</cfif>>#trim(groupName)#</option>
					</cfloop>
				</select>						
			<cfelse>
				<a href="index.cfm?cfevent=group.edit" target="_blank">#application.resource.bundle.text.create_new_group#</a> - #application.resource.bundle.text.refresh_page_when_done#
			</cfif>
		</td>
	</tr>
</table>
<br>
<table cellpadding="0" cellspacing="0" class="bpd-style">
	<tr>
		<td class="bpd-style" colspan="2" align="right">
		<!---// CODE: update and uncomment this code --->
<!---			<cfif calendarTO.dsid gt 0><input name="submit" type="submit" value="#application.resource.bundle.button.delete#" onclick="return validateDelete(this.form);"></cfif>--->
			<input name="submit" type="submit" value="#application.resource.bundle.button.ok#">
		</td>
	</tr>
</table>
</cfform>
</cfoutput>
