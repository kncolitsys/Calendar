<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 GroupSelectionList::display
*
* Description:
*	 Display a panel for selecting a group.
*
****************************************************************************
--->
<cfoutput>
<div class="bp-title">#application.resource.bundle.text.group_management#</div><br>

<a href="index.cfm?cfevent=administrator.group.new">Create New Group</a><br><br>
<table width="100%" border="0" cellpadding="4" cellspacing="0" style="font-size:12px;">
	<tr>
		<th width="24" align="center">Edit</th>
		<th width="24" align="center">Delete</th>
		<th align="left">Group Name</th>
	</tr>
	<cfset toggle = true />
	<cfloop query="request.groups">
		<tr bgcolor="###iif(toggle,de('e9e9e9'),de('f3f3f3'))#">
			<td align="center"><a href="index.cfm?cfevent=administrator.group.edit&groupId=#trim(groupId)#"><img src="images/icon_edit.gif" border="0" alt="Edit" /></a></td>
			<td align="center"><a href="index.cfm?cfevent=administrator.group.delete&groupId=#trim(groupId)#"><img src="images/icon_delete.gif" border="0" alt="Delete" /></a></td>
			<td>#trim(groupName)#</td>
		</tr>
		<cfset toggle = not toggle />
	</cfloop>
</table>
</cfoutput>