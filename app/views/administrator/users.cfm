<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 UserSelectionList::display
*
* Description:
*	 Display a list for selecting a user.
*
****************************************************************************
--->

<cfoutput>
<div class="bp-title">#application.resource.bundle.text.user_management#</div><br>

<a href="index.cfm?cfevent=administrator.user.new">Create New User</a><br><br>
<table width="100%" border="0" cellpadding="4" cellspacing="0" style="font-size:12px;">
	<tr>
		<th width="24" align="center">Edit</th>
		<th width="24" align="center">Delete</th>
		<th align="left">Name</th>
		<th align="left">Login</th>
	</tr>
	<cfset toggle = true />
	<cfloop query="request.users">
		<tr bgcolor="###iif(toggle,de('e9e9e9'),de('f3f3f3'))#">
			<td align="center"><a href="index.cfm?cfevent=administrator.user.edit&userId=#trim(userId)#"><img src="images/icon_edit.gif" border="0" alt="Edit" /></a></td>
			<td align="center"><a href="index.cfm?cfevent=administrator.user.delete&userId=#trim(userId)#"><img src="images/icon_delete.gif" border="0" alt="Delete" /></a></td>
			<td>#trim(lastName)#, #trim(firstName)#</td>
			<td>#trim(userlogin)#</td>
		</tr>
		<cfset toggle = not toggle />
	</cfloop>
</table>
</cfoutput>
