<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 ProfilePasswordEditPanel::display
*
* Description:
*	 Displays a panel to allow user to update their password.
*
****************************************************************************
--->

<script language="javascript">
	function validate(form) {
		if(form.new_password.value != form.new_password_confirm.value) {
			alert("<cfoutput>#application.resource.bundle.text.passwords_do_not_match_warning#</cfoutput>");
			form.new_password.value = "";
			form.new_password_confirm.value = "";
			return false;
		}
	}
</script>

<div class="bp-title"><cfoutput>#application.resource.bundle.text.change_password#</cfoutput></div><br>

<cfinclude template="../shared/profileViewOptions.cfm" />

<cfform action="index.cfm?cfevent=profile.password.edit.submitted&calendarId=#calendarId#" method="post">
	<input name="username" type="hidden" value="#arguments.event.getArg('sessionFacade').getUser().getUsername()#">

	<cfoutput>
	<table width="100%" class="bpd-style" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="right">#application.resource.bundle.text.new_password#:</td>
			<td><cfinput name="new_password" type="password" size="30" required="yes" message="#application.resource.bundle.text.enter_new_password#"></td>
		</tr>
		<tr>
			<td align="right">#application.resource.bundle.text.confirm_password#:</td>
			<td><input name="new_password_confirm" type="password" size="30"></td>
		</tr>
	</table>
	<br>

	<table width="100%" class="bpd-style" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td colspan="2" align="right"><input name="submit" type="submit" value="#application.resource.bundle.button.ok#" onclick="return validate(this.form);"></td>
		</tr>
	</table>
	</cfoutput>
</cfform>
