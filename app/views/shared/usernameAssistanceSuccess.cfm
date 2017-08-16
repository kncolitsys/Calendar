<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 com.infusion.passport.ui.UsernameAssistancePanel::displaySuccess
*
* Description:
*	 Displays a message that a username has been sent to a user's email
*	 address.
*
****************************************************************************
--->
<p><br></p>
<p><br></p>
<table align="center" border="0" cellspacing="0" cellpadding="0" class="bpd-style" style="width:350px;">
	<tr>
		<td bgcolor="#c0c0c0" height=20><span style="font-size:11px;color:#333333;font-weight:bold;font-family:Verdana,Arial,Helvetica,sans-serif;">&nbsp;<cfoutput>#application.resource.bundle.text.username_sent#</cfoutput></span></td>
	</tr>
	<tr>
		<td><cfoutput>#application.resource.bundle.text.username_has_been_sent#</cfoutput></td>
	</tr>
</table>

