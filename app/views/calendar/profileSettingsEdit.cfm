<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 ProfileContactEditPanel::display
*
* Description:
*	 Displays a panel to allow user to edit their contact information.
*
****************************************************************************
--->

<cfset userTO = request.user.getUserTO() />

<div class="bp-title"><cfoutput>#application.resource.bundle.text.update_settings#</cfoutput></div><br>

<cfinclude template="../shared/profileViewOptions.cfm" />

<cfform action="index.cfm?cfevent=profile.settings.edit.submitted&calendarId=#calendarId#" method="post">
	<cfoutput>
		<input name="userId" type="hidden" value="#userTO.userId#" />
		<input name="username" type="hidden" value="#userTO.username#" />
		
		<table width="100%" class="bpd-style" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right">#application.resource.bundle.text.first_name#:</td>
				<td><input name="firstName" type="text" size="30" maxlength="50" value="#userTO.firstName#"></td>
			</tr>
			<tr>
				<td align="right">#application.resource.bundle.text.last_name#:</td>
				<td><input name="lastName" type="text" size="30" maxlength="100" value="#userTO.lastName#"></td>
			</tr>
			<tr>
				<td align="right">#application.resource.bundle.text.phone#:</td>
				<td><input name="phone" type="text" size="30" maxlength="100" value="#userTO.phone#"></td>
			</tr>
			<tr>
				<td align="right">#application.resource.bundle.text.email#:</td>
				<td><input name="email" type="text" size="30" maxlength="100" value="#userTO.email#"></td>
			</tr>
		</table>
		<br>

		<table width="100%" class="bpd-style" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>Timezone: 
					<select name="timezone" size="1">
						<option value="085">Select...</option> <!--- 085 matches GMT --->
						<cfset timezones = getProperty("timezoneLibrary").getTimezones() />
						<cfloop query="timezones">
							<option value="#code#" <cfif compareNoCase(trim(userTO.timezone),trim(code)) eq 0>selected</cfif>>(#offset#) #location#</option>
						</cfloop>
					</select>
				</td>
			</tr>
		</table>
		<br>
		
		<table width="100%" class="bpd-style" align="center" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="2" align="right">
					<input name="submit" type="submit" value="#application.resource.bundle.button.ok#">
				</td>
			</tr>
		</table>
	</cfoutput>
</cfform>
