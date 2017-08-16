<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 GroupEditPanel::display
*
* Description:
*	 Display a panel for editing a group.
*
****************************************************************************
--->

<cfif arguments.event.isArgDefined("groupBean")>
	<cfset group = arguments.event.getArg("groupBean").getGroupTO() />
<cfelse>
	<cfset group = request.group.getGroupTO() />
</cfif>

<script language="javascript">
<!--//
function validateDelete(form) {
	del = confirm("<cfoutput>#application.resource.bundle.text.delete_group#</cfoutput>");
	if(del) {
		form.action='index.cfm?cfevent=administrator.group.delete';
		return true;
	} else {
		return false;
	}
}
//-->
</script>

<cfform action="index.cfm?cfevent=#cfevent#.submitted" method="post">
	<cfoutput>
		<input name="groupId" type="hidden" value="#group.groupId#" />
			
		<!---
		// Do not allow user to edit permissions or members if this is a new
		// group.	The group must first be created and stored in the database.
		--->
		<cfif compareNoCase(cfevent,"administrator.group.edit") eq 0>
			<table width="100%" border="0" cellpadding="2" cellspacing="0" class="bpd-style">
				<tr>
					<td align="center"><a href="index.cfm?cfevent=administrator.group.permissions&groupId=#group.groupId#">#application.resource.bundle.text.edit_group_permissions#</a></td>
					<td align="center"><a href="index.cfm?cfevent=administrator.group.membership&groupId=#group.groupId#">#application.resource.bundle.text.modify_group_members#</a></td>
				</tr>
			</table>
			<br>
		</cfif>

		<table width="100%" border="0" cellpadding="2" cellspacing="0" class="bpd-style">
			<tr>
				<td align="right">#application.resource.bundle.text.unique_id#:</td>
				<td><cfif compareNoCase(cfevent,"administrator.group.edit") eq 0>#trim(group.groupId)#<cfelse>(#application.resource.bundle.text.not_yet_assigned#)</cfif></td>
			</tr>
			<tr>
				<td align="right">#application.resource.bundle.text.name#:</td>
				<td><input name="groupName" type="text" size="30" maxlength="50" value="#trim(group.groupname)#"></td>
			</tr>
			<tr>
				<td align="right">#application.resource.bundle.text.description#:</td>
				<td><input name="comments" type="text" size="30" maxlength="100" value="#trim(group.comments)#"></td>
			</tr>
		</table>
		<br>
		
		<table width="100%" border="1" cellpadding="0" cellspacing="0" class="bpd-style">
			<tr>
				<td colspan="2" align="right">
					<input name="delete" type="submit" value="#application.resource.bundle.button.delete#" onclick="return validateDelete(this.form);">
					<input name="submit" type="submit" value="#application.resource.bundle.button.ok#">
				</td>
			</tr>
		</table>
	</cfoutput>
</cfform>
