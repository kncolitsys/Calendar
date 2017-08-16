<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 com.infusion.passport.ui.PasswordAssistancePanel::displaySuccess
*
* Description:
*	 Displays a message that a user password has successfully been reset.
*
****************************************************************************
--->
<cfparam name="attributes.message" default="">

<p><br></p>
<p><br></p>
<table align="center" border="0" cellspacing="0" cellpadding="0" class="bpd-style" style="width:350px;">
	<tr>
		<td bgcolor="#c0c0c0" height=20><span style="font-size:11px;color:#333333;font-weight:bold;font-family:Verdana,Arial,Helvetica,sans-serif;">&nbsp;<cfoutput>#application.resource.bundle.text.password_reset#</cfoutput></span></td>
	</tr>
	<tr>
		<td>
			<cfif len(attributes.message) gt 0>
				<cfoutput>#attributes.message#</cfoutput>
			<cfelse>
				<cfoutput>#application.resource.bundle.text.password_reset_instructions#</cfoutput>
			</cfif>
		</td>
	</tr>
</table>
