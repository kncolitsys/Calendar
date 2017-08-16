<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 GroupPermissionsPanel::display
*
* Description:
*	 Display a panel for editing group permissions.
*
****************************************************************************
--->
<cfset group = request.group.getGroupTO() />
<cfset calendars = request.calendars />
<cfset app = request.application.getApplicationTO() />

<cfif isDefined("request.calendar")>
	<cfset context = request.calendar.getCalendarTO() />
	<cfset contextId = request.calendar.getCalendarId() />
<cfelse>
	<cfset context = app />
	<cfset contextId = app.applicationId />
</cfif>


<cfoutput>
<div class="bp-title">#application.resource.bundle.text.group_permissions_management#</div><br>
<div class="bp-subtitle">#application.resource.bundle.text.change_permissions_for_group# '#group.groupname#'</div>
<span>#application.resource.bundle.text.change_permissions_instructions#</span>
</cfoutput>

<cfoutput>
<script language="JavaScript">
	function changeContext(contextId) {
		if (contextId == '#trim(app.applicationId)#') {
			document.location='index.cfm?cfevent=administrator.group.permissions&groupId=#trim(group.groupId)#';
		} else {
			document.location='index.cfm?cfevent=administrator.group.calendar.permissions&groupId=#trim(group.groupId)#&calendarId=' + contextId;
		}
	}
</script>
</cfoutput>

<cfform action="index.cfm?cfevent=administrator.group.permissions.submitted" method="post">
	<cfoutput>
		<input name="groupId" type="hidden" value="#group.groupId#" />
	

	
		<table width="100%" border="0" cellpadding="2" cellspacing="0" class="bpd-style">
			<tr class="bpd-style">
				<td>#application.resource.bundle.text.context#</td>
				<td>
					<select id="changeContextId" name="changeContextId" size="1">
						<option value="#trim(app.applicationId)#" <cfif contextId eq app.applicationId>selected</cfif>>Application-level Permissions</option>
						<cfloop query="calendars">
							<option value="#trim(calendars.calendarId)#" <cfif contextId eq calendars.calendarId>selected</cfif>>#trim(title)#</option>
						</cfloop>
					</select>
					<input type="button" onclick="changeContext(document.getElementById('changeContextId').value);" value="#application.resource.bundle.button.change_context#">
				</td>
			</tr>
			<tr class="bpd-style">
				<td valign="top">#application.resource.bundle.text.permissions#:</td>
				<td>
					<cfset privileges = context.privileges />
					<cfset groupPermissions = structKeyList(group.permissions) />
					<input name="contextType" type="hidden" value="#iif(isDefined('request.calendar'),de('calendar'),de('application'))#" />
					<input name="contextId" type="hidden" value="#contextId#" />
					<cfif not structIsEmpty(privileges)>
						<input name="permissionSet" type="hidden" value="#structKeyList(privileges)#">
						<cfloop index="permission" list="#structKeyList(privileges)#">
							<input name="permissions" type="checkbox" value="#permission#" <cfif listFindNoCase(groupPermissions,trim(contextId) & "_" & trim(permission)) gt 0>checked</cfif>> #privileges[permission].description#<br/>
						</cfloop>
					<cfelse>
						<input name="permissions" type="text" size="100" maxlength="100" value="">
					</cfif>
				</td>
			</tr>
		</table>
		<br/>
	
		<table class="bpd-style" width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="2" align="right">
					<input name="delete" type="reset" value="#application.resource.bundle.button.reset#">
					<input name="submit" type="submit" value="#application.resource.bundle.button.ok#">
				</td>
			</tr>
		</table>
	</cfoutput>
</cfform>