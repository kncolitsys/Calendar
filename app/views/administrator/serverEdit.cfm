<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 MailServerEditPanel::display
*
* Description:
*	 Display a panel for editing a mail server.
*
****************************************************************************
--->

<cfparam name="attributes.contextId" default="">
<cfset mailServerTO = request.mailServer.getMailServerTO() />

<div class="bp-title"><cfoutput>#application.resource.bundle.text.mail_server_management#</cfoutput></div><br>

<cfform action="index.cfm?cfevent=administrator.server.edit.submitted" method="post">
	<cfoutput>
		<table cellpadding="0" cellspacing="0" class="bpd-style">
			<tr>
				<td>Server Timezone:</td>
				<td>
					<select name="timezone" size="1">
					<cfset timezones = getProperty("timezoneLibrary").getTimezones() />
					<cfloop query="timezones">
						<option value="#code#" <cfif compareNoCase(request.timezone, code) eq 0>selected</cfif>>(#offset#) #title#</option>
					</cfloop>
					</select>
				</td>
			</tr>
		</table>
		<br />
		
		<input name="mailServerId" type="hidden" value="#mailServerTO.mailServerId#" />
		<table cellpadding="0" cellspacing="0" class="bpd-style">
			<tr>
				<td>#application.resource.bundle.text.server#:</td>
				<td><input name="server" type="text" size="30" maxlength="50" value="#mailServerTO.server#"></td>
			</tr>
			<tr>
				<td>#application.resource.bundle.text.port#:</td>
				<td><input name="port" type="text" size="30" maxlength="100" value="#mailServerTO.port#"></td>
			</tr>
			<tr>
				<td>#application.resource.bundle.text.timeout#:</td>
				<td><input name="timeout" type="text" size="30" maxlength="100" value="#mailServerTO.timeout#"></td>
			</tr>
			<tr>
				<td>#application.resource.bundle.text.mailer_id#:</td>
				<td><input name="mailerId" type="text" size="30" maxlength="100" value="#mailServerTO.mailerId#"></td>
			</tr>
		</table>
		<br>
		
		<table cellpadding="0" cellspacing="0" class="bpd-style">
			<tr>
				<td class="bpd-style" colspan="2" align="right">
					<input name="submit" type="submit" value="#application.resource.bundle.button.ok#">
				</td>
			</tr>
		</table>
	</cfoutput>		
</cfform>
