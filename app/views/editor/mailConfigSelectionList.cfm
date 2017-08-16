<cfparam name="attributes.selected" default="">
<cfparam name="attributes.contextId" default="">

<cfoutput>
<div class="bp-title">#application.resource.bundle.text.automated_email_management#</div><br>

<cfset mailOptions = "user_registration_received,user_registration_approved,user_registration_denied" />
<cfset mailOptionCodes = "mail_registrationreceived,mail_registrationapproved,mail_registrationdenied" />
<table width="100%" border="0" cellpadding="4" cellspacing="0" style="font-size:12px;">
	<tr>
		<th width="24" align="center">#application.resource.bundle.text.edit#</th>
		<th align="left">#application.resource.bundle.text.scheme#</th>
	</tr>
	<cfset toggle = true />
	<cfloop index="option" list="#mailOptions#">
		<tr bgcolor="###iif(toggle,de('e9e9e9'),de('f3f3f3'))#">
			<td align="center"><a href="index.cfm?cfevent=editor.mail.configuration.edit&calendarId=#calendarId#&configuration=#listGetAt(mailOptionCodes,listFindNoCase(mailOptions,option))#"><img src="images/icon_edit.gif" border="0" alt="#application.resource.bundle.text.edit#" /></a></td>
			<td>#evaluate('application.resource.bundle.text.' & option)#</td>
		</tr>
		<cfset toggle = not toggle />
	</cfloop>
</table>
</cfoutput>