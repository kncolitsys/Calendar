<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 com.infusion.passport.ui.PasswordAssistancePanel::displayError
*
* Description:
*	 Displays an error message if an error occurs while attempting to reset
*	 the user's password.
*
****************************************************************************
--->
<cfparam name="attributes.message" default="#application.resource.bundle.text.unknown_error#">

<p><br></p>
<p><br></p>
<table align="center" border="0" cellspacing="0" cellpadding="0" class="bpd-style" style="width:350px;">
	<tr class="bpd-title" style="background-color:#cccccc;">
		<td><img src="<cfoutput>#application.app.global.passport.url#</cfoutput>/shared/images/warning.gif" align="absmiddle"> <span style="font-size:18px;font-weight:bold;"><cfoutput>#application.resource.bundle.text.error_occurred#</cfoutput></span></td>
	</tr>
	<tr>
		<td><cfoutput>#application.resource.bundle.text.error_occurred_during_password_reset# #attributes.message#</cfoutput></td>
	</tr>
</table>
