<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 GroupMembershipPanel::display
*
* Description:
*	 Display a panel for adding nonmembers to a group.
*
****************************************************************************
--->
<cfset group = request.group.getGroupTO() />
<cfset users = request.users />

<cfoutput>
	<div class="bp-title">#application.resource.bundle.text.group_membership_management#</div><br>
	<div class="bp-subtitle">#application.resource.bundle.text.modify_members_of_group# '#trim(group.groupName)#'</div>
	<span>#application.resource.bundle.text.modify_members_instructions#</span>
</cfoutput>

<script language="javascript">
	// Moves users between nonmember and member menus
	function moveUserTo(src, dest, all) {
		if(all==true) {
			while(src.length > 0) {
				dest.options[dest.length] = new Option(src.options[0].text, src.options[0].value);
				src.options[0] = null;
			}
		} else {
			for(i=0; i<src.length; i++) {
				if(src.options[i].selected == true) {
					dest.options[dest.length] = new Option(src.options[i].text, src.options[i].value);
					src.options[i] = null;
					i--; // since an option was moved, i must be decremented
				}
			}
		}
	}
	
	/** Selects all options in a selection list */
	function selectAll(col) {
		for(i=0; i<col.length; i++) {
			col.options[i].selected = true;
		}
		return true;
	} 
</script>

<form action="index.cfm?cfevent=administrator.group.membership.submitted" method="post" onsubmit="selectAll(this.members);selectAll(this.nonmembers);">
<input name="groupId" type="hidden" value="<cfoutput>#group.groupId#</cfoutput>">
<cfif isStruct(group.members)>
	<input name="currentMembers" type="hidden" value="<cfoutput>#structKeyList(group.members)#</cfoutput>">
<cfelse>
	<input name="currentMembers" type="hidden" value="">
</cfif>

<table class="bpd-style" width="100%" border="0	" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="1"><cfoutput>#application.resource.bundle.text.non_members#</cfoutput>:</td>
		<td colspan="1">&nbsp;</td>
		<td colspan="1"><cfoutput>#application.resource.bundle.text.members#</cfoutput>:</td>
	</tr>
	<tr>
		<td width="45%" align="right">
			<select name="nonmembers" size="10" multiple>
				<cfif isStruct(group.members)>
					<cfoutput query="users">
						<cfif not structKeyExists(group.members,trim(userId))>
							<option value="#trim(userId)#">#trim(lastName)#, #trim(firstName)#</option>
						</cfif>
					</cfoutput>
				<cfelse>
					<option value=""></option>
				</cfif>
			</select>
		</td>
		<td width="10%" align="center">
			<button name="addAll" onclick="moveUserTo(this.form.nonmembers,this.form.members,true)">&nbsp;&nbsp;&gt;&gt;&nbsp;&nbsp;</button><br>
			<button name="add" onclick="moveUserTo(this.form.nonmembers,this.form.members,false)">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</button><br><br>
			<button name="remove" onclick="moveUserTo(this.form.members,this.form.nonmembers,false)">&nbsp;&nbsp;&nbsp;&lt;&nbsp;&nbsp;&nbsp;</button><br>
			<button name="removeAll" onclick="moveUserTo(this.form.members,this.form.nonmembers,true)">&nbsp;&nbsp;&lt;&lt;&nbsp;&nbsp;</button><br>
		</td>
		<td width="45%" align="left">
			<select name="members" size="10" multiple>
				<cfif isStruct(group.members)>
					<cfloop index="member" list="#structKeyList(group.members)#">
						<cfset user = group.members[member]>
						<cfoutput><option value="#trim(user.userId)#">#trim(user.lastName)#, #trim(user.firstName)#</option></cfoutput>
					</cfloop>
				<cfelse>
					<option value=""></option>
				</cfif>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan="3" align="right">
			<input name="submit" type="submit" value="<cfoutput>#application.resource.bundle.button.ok#</cfoutput>">
		</td>
	</tr>
</table>
</form>