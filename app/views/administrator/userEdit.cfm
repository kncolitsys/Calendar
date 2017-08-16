<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 UserEditPanel::display
*
* Description:
*	 Display a panel for editing a user.
*
****************************************************************************
--->

<cfif arguments.event.isArgDefined("userBean")>
	<cfset user = arguments.event.getArg("userBean").getUserTO() />
<cfelse>
	<cfset user = request.user.getUserTO() />
</cfif>

<script language="javascript">
<!--//
// validate Delete
function validateDelete(form) {
	del = confirm("<cfoutput>#application.resource.bundle.text.delete_user#</cfoutput>");
	if(del) {
		form.action='index.cfm?cfevent=administrator.user.delete';
		return true;
	} else {
		return false;
	}
}

// linkToPermissions
function linkToPermissions() {
	window.location='index.cfm?cfevent=administrator.user.permissions&userId=<cfoutput>#user.userId#</cfoutput>';
	return false;
}
//-->
</script>

<cfform action="index.cfm?cfevent=#cfevent#.submitted" method="post">
	<cfoutput>
		<input name="userId" type="hidden" value="#user.userId#" />
	
		<cfif compareNoCase(cfevent,"administrator.user.edit") eq 0>
			<table class="bpd-style" width="100%" border="1" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2" align="center">
						<a href="index.cfm?cfevent=administrator.user.permissions&userId=#user.userId#">#application.resource.bundle.text.edit_user_permissions#</a>
					</td>
				</tr>
			</table>			
			<br>
		</cfif>
		
		<table border="0" cellpadding="2" cellspacing="0" class="bpd-style">
			<tr>
				<td align="right">#application.resource.bundle.text.unique_identifier#:</td>
				<td><cfif compareNoCase(cfevent,"administrator.user.edit") eq 0>#user.userId#<cfelse>(#application.resource.bundle.text.not_yet_assigned#)</cfif></td>
			</tr>
			<tr>
				<td align="right">#application.resource.bundle.text.username#:</td>
				<td><cfinput name="username" type="text" size="16" maxlength="16" value="#trim(user.username)#" required="yes" message="#application.resource.bundle.text.username_required#"></td>
			</tr>
			<tr>
				<td align="right">#application.resource.bundle.text.password#:</td>
				<td>
					<!---<cfinvoke component="#user#" method="getPasswordMask" returnvariable="passwordMask">--->
					<input name="resetPassword" type="hidden" value="#iif(len(trim(user.password)) eq 0,1,0)#">
					<cfinput name="password" type="password" size="16" maxlength="16" value="#repeatString('*',len(trim(user.password)))#" onchange="this.form.resetPassword.value=1;" required="yes" message="#application.resource.bundle.text.password_required#">
				</td>
			</tr>
			<tr>
				<td align="right">#application.resource.bundle.text.first_name#:</td>
				<td><input name="firstName" type="text" size="30" maxlength="50" value="#trim(user.firstName)#"></td>
			</tr>
			<tr>
				<td align="right">#application.resource.bundle.text.last_name#:</td>
				<td><input name="lastName" type="text" size="30" maxlength="100" value="#trim(user.lastName)#"></td>
			</tr>
			<tr>
				<td align="right">#application.resource.bundle.text.phone#:</td>
				<td><input name="phone" type="text" size="30" maxlength="100" value="#trim(user.phone)#"></td>
			</tr>
			<tr>
				<td align="right">#application.resource.bundle.text.email#:</td>
				<td><input name="email" type="text" size="30" maxlength="100" value="#trim(user.email)#"></td>
			</tr>	
			<tr>
				<td align="right">#application.resource.bundle.text.comments#:</td>
				<td><input name="comments" type="text" size="30" maxlength="100" value="#trim(user.comments)#"></td>
			</tr>
		</table>
		<br>

		<table class="bpd-style" width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="1" align="right">
					<input name="reset" type="reset" value="#application.resource.bundle.button.reset#">
					<input name="delete" type="submit" value="#application.resource.bundle.button.delete#" onclick="return validateDelete(this.form);">
					<input name="submit" type="submit" value="#application.resource.bundle.button.ok#">
				</td>
			</tr>
		</table>
	</cfoutput>
</cfform>
