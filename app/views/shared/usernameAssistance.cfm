<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 com.infusion.passport.ui.UsernameAssistancePanel::display
*
* Description:
*	 Display a panel for getting a reminder of a username.
*
****************************************************************************
--->
<p><br></p>
<p><br></p>
<cfform action="handler.cfm?event=UsernameReminderRequested" method="post">
<table align="center" border="0" cellspacing="0" cellpadding="0" style="width:350px;">
	<tr>
		<td align="right" style="font-size:10px;">&nbsp;</td>
	</tr>
</table>

<table align="center" border="0" cellspacing="0" cellpadding="0" class="bpd-style" style="width:350px;">
	<tr>
		<td bgcolor="#c0c0c0" colspan="2" height=20><span style="font-size:11px;color:#333333;font-weight:bold;font-family:Verdana,Arial,Helvetica,sans-serif;">&nbsp;<cfoutput>#application.resource.bundle.text.send_email_with_username#</cfoutput></span></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td align="right"><span style="font-size:12px;font-weight:bold;"><cfoutput>#application.resource.bundle.text.email_address#</cfoutput>:</span></td>
		<td><cfinput name="email" type="text" size="30" maxlength="75" required="yes" message="#application.resource.bundle.text.must_enter_valid_email_address#"></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td align="right" colspan="2"><input type="submit" name="submit" value="<cfoutput>#application.resource.bundle.button.ok#</cfoutput>"></td>
	</tr>
</table>
</cfform>
