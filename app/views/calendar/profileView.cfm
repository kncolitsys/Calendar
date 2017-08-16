<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 ProfileEditPanel::display
*
* Description:
*	 Displays a panel to allow user to edit their options.
*
****************************************************************************
--->

<cfoutput>
<div class="bp-title">#application.resource.bundle.text.profile_options#</div><br>

<cfinclude template="../shared/profileViewOptions.cfm" />

<table class="bpd-style" width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td class="bpd-title">#application.resource.bundle.text.options#</td>
		</tr>
		<tr>
			<td>
				<br>
				<ul>
					<li><a href="index.cfm?cfevent=profile.settings.edit&calendarId=#calendarId#">#application.resource.bundle.text.update_your_settings#</a></li>
					<li><a href="index.cfm?cfevent=profile.password.edit&calendarId=#calendarId#">#application.resource.bundle.text.change_your_password#</a></li>
				</ul>
			</td>
		</tr>
</table>
</cfoutput>