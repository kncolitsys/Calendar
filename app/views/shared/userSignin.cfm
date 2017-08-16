<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 UserLoginPanel::display
*
* Description:
*	 Displays an HTML login dialog box.
*
****************************************************************************
--->

<cfparam name="attributes.redirect" default="index.cfm">

<p><br></p>
<cfif request.event.isArgDefined("invalidMessage")>
	<div align="center" style="color:#ff0000;font-weight:bold;"><cfoutput>#request.event.getArg("invalidMessage")#</cfoutput></div><br>
</cfif>

<cfif len(attributes.redirect) eq 0>
	<cfset attributes.redirect = "index.cfm">	
</cfif>

<cfform action="index.cfm?cfevent=main.signin.submitted" method="post">
	<cfoutput><input name="redirect" type="hidden" value="#attributes.redirect#"></cfoutput>

<table align="center" border="0" cellspacing="0" cellpadding="0" style="width:350px;">
	<tr>
		<td align="right" style="font-size:10px;"><a href="#" onclick="javascript:window.open('index.cfm?cfevent=main.user.password.retrieve','forgot_password','width=400,height=250,toolbars=0,resizable=1,scrollbars=1')"><cfoutput>#application.resource.bundle.text.forgot_your_password#</cfoutput></a></td>	</tr>
</table>

<table class="bpd-style" align="center" border="0" cellspacing="0" cellpadding="0" bgcolor="#c0c0c0" style="width:350px;">
	<tr>
		<td bgcolor="#c0c0c0" colspan="2" height=20><span style="font-size:11px;color:#333333;font-weight:bold;font-family:Verdana,Arial,Helvetica,sans-serif;">&nbsp;<cfoutput>#application.resource.bundle.text.user_login#</cfoutput></span></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td align="right"><span style="font-size:12px;font-weight:bold;"><cfoutput>#application.resource.bundle.text.username#</cfoutput>:</span></td>
		<td><cfinput name="username" type="text" size="24" maxlength="24" required="yes" message="#application.resource.bundle.text.login_username_warning#"></td>
	</tr>
	<tr>
		<td align="right"><span style="font-size:12px;font-weight:bold;"><cfoutput>#application.resource.bundle.text.password#</cfoutput>:</span></td>
		<td><cfinput name="password" type="password" size="24" maxlength="24" required="yes" message="#application.resource.bundle.text.login_password_warning#"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input name="user_cookie" type="checkbox"> <span style="font-size:10px;"><cfoutput>#application.resource.bundle.text.sign_me_in_automatically#</cfoutput></span></td>
	</tr>
	<tr>
		<td align="right" colspan="2"><input type="submit" name="submit" value="<cfoutput>#application.resource.bundle.button.login#</cfoutput>"><br><br></td>
	</tr>
	<tr>
		<td colspan="2" style="border-top:1px solid;padding:8px;"><span style="font-size:12px;">&nbsp;<cfoutput>#application.resource.bundle.text.need_account_1#</cfoutput> <a href="#" onclick="javascript:window.open('index.cfm?cfevent=main.user.register&redirect=index.cfm','new_account','width=400,height=350,toolbars=0,resizable=1,scrollbars=1')"><cfoutput>#application.resource.bundle.text.need_account_2#</cfoutput></a>.<br></span></td>
	</tr>
</table>
</cfform>
<p><br></p>