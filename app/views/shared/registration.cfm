<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 com.infusion.passport.ui.RegistrationPanel::display
*
* Description:
*	 Displays a panel to allow a user to register with Passport.
*
****************************************************************************
--->
<cfparam name="attributes.firstName" default="">
<cfparam name="attributes.lastName" default="">
<cfparam name="attributes.email" default="">
<cfparam name="attributes.username" default="">
<cfparam name="attributes.password" default="">
<cfparam name="attributes.message" default="">
<cfparam name="attributes.redirect" default="">

<cfoutput><script src="scripts/validation.js"></script></cfoutput>

<script language="javascript">
	function validateForm(form) {
		if(!isEmail(form.email.value)) {
			alert("<cfoutput>#application.resource.bundle.text.email_address_not_valid#</cfoutput>");
			return false;
		}
		return true;
	}
</script>

<cfoutput>
	<cfform name="main" action="handler.cfm?event=RegistrationSubmitted" method="post">
		<input name="redirect" type="hidden" value="#attributes.redirect#">
		
		<cfif len(attributes.message) gt 0>
			<br>
			<table class="bpd-style" width="360" align="center" border="0" cellpadding="5" cellspacing="0">
				<tr>
					<td colspan="2" align="center"><span style="font-weight:bold;font-size:12px;color:##ff0000;">#attributes.message#</span></td>
				</tr>
			</table>
		</cfif>

		<br>
		<table width="360" class="bpd-style" align="center" border="0" cellpadding="5" cellspacing="0">
			<tr>
				<td colspan="2" class="bpd-title"><span style="font-size:11px;color:##333333;font-weight:bold;font-family:Verdana,Arial,Helvetica,sans-serif;">#application.resource.bundle.text.passport_registration#</span></td>
			</tr>
			<tr>
				<td colspan="2">
					#application.resource.bundle.text.enter_registration_information#
				</td>
			</tr>
			<tr>
				<td colspan="2"><span style="font-weight:bold;">#application.resource.bundle.text.user_information#</span></td>
			</tr>
			<tr>
				<td>#application.resource.bundle.text.first_name#:</td>
				<td><cfinput name="firstName" type="text" size="30" maxlength="40" required="yes" message="#application.resource.bundle.text.first_name_required_to_register#" value="#attributes.firstName#"></td>
			</tr>
			<tr>
				<td>#application.resource.bundle.text.last_name#:</td>
				<td><cfinput name="lastName" type="text" size="30" maxlength="40" required="yes" message="#application.resource.bundle.text.last_name_required_to_register#" value="#attributes.lastName#"></td>
			</tr>						
			<tr>
				<td>#application.resource.bundle.text.email#</td>
				<td><cfinput name="email" type="text" size="30" maxlength="40" required="yes" message="#application.resource.bundle.text.email_required_to_register#" value="#attributes.email#"></td>
			</tr>
			<tr>
				<td>#application.resource.bundle.text.username#</td>
				<td><cfinput name="username" type="text" size="25" maxlength="25" required="yes" message="#application.resource.bundle.text.username_required_to_register#" value="#attributes.username#"></td>
			</tr>
			<tr>
				<td>#application.resource.bundle.text.password#</td>
				<td><cfinput name="password" type="password" size="25" maxlength="25" required="yes" message="#application.resource.bundle.text.password_required_to_register#" value="#attributes.password#"></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input name="reset" type="reset" value="#application.resource.bundle.button.reset#"><input name="Submit" type="submit" value="#application.resource.bundle.button.register#" onclick="return validateForm(this.form);">
				</td>
			</tr>
		</table>

		<!---// Server-side validation rules. --->
		<input name="firstName_required" type="hidden" value="#application.resource.bundle.text.first_name_required_to_register#">		
		<input name="lastName_required" type="hidden" value="#application.resource.bundle.text.last_name_required_to_register#">
		<input name="email_required" type="hidden" value="#application.resource.bundle.text.email_required_to_register#">
		<input name="username_required" type="hidden" value="#application.resource.bundle.text.username_required_to_register#">
		<input name="password_required" type="hidden" value="#application.resource.bundle.text.password_required_to_register#">
	</cfform>
</cfoutput>