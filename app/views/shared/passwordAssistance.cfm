<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 com.infusion.passport.ui.PasswordAssistancePanel::display
*
* Description:
*	 Display a panel for resetting a password.
*
****************************************************************************
--->
<p><br></p>
<p><br></p>

<cfform action="handler.cfm?event=PasswordResetRequested" method="post">
<table align="center" border="0" cellspacing="0" cellpadding="0" style="width:350px;">
	<tr>
		<td align="right" style="font-size:10px;"><a href="<cfoutput>#application.app.global.passport.url#</cfoutput>/public/assist/handler.cfm?event=ForgotUsername"><cfoutput>#application.resource.bundle.text.forgot_your_username#</cfoutput></a></td>
	</tr>
</table>

<table align="center" border="0" cellspacing="0" cellpadding="0" class="bpd-style" style="width:350px;">
	<tr>
		<td bgcolor="#c0c0c0" colspan="2" height=20><span style="font-size:11px;color:#333333;font-weight:bold;font-family:Verdana,Arial,Helvetica,sans-serif;">&nbsp;<cfoutput>#application.resource.bundle.text.reset_password#</cfoutput></span></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td align="right"><span style="font-size:12px;font-weight:bold;"><cfoutput>#application.resource.bundle.text.username#</cfoutput>:</span></td>
		<td><cfinput name="username" type="text" size="24" maxlength="24" required="yes" message="You must enter a username!"></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td align="right" colspan="2"><input type="submit" name="submit" value="<cfoutput>#application.resource.bundle.button.ok#</cfoutput>"></td>
	</tr>
</table>
</cfform>
