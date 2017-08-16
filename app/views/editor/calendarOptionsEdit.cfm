<cfset calendarTO = request.calendar.getCalendarTO() />
<cfset schemeTO = calendarTO.scheme.getSchemeTO() />

<div class="bp-title"><cfoutput>#application.resource.bundle.text.calendar_options#</cfoutput></div><br>

<cfoutput>
<cfform action="index.cfm?cfevent=editor.calendar.edit.submitted&calendarId=#calendarId#" method="post">
	<input name="title" type="hidden" value="#calendarTO.title#" />
	<input name="description" type="hidden" value="#calendarTO.description#" />
	<input name="status" type="hidden" value="#calendarTO.status#" />

	<table cellpadding="0" cellspacing="0" class="bpd-style">
		<tr>
			<td colspan="2" class="bpd-title">#application.resource.bundle.text.layout#</td>
		</tr>
		<tr>
			<td>#application.resource.bundle.text.scheme#:</td>
			<td>
				<select name="schemeId">
					<cfloop query="request.schemes">
						<option value="#trim(schemeId)#" <cfif compareNoCase(trim(schemeTO.schemeId),trim(schemeId)) eq 0>selected</cfif>>#trim(title)#</option>
					</cfloop>
				</select>
			</td>
		</tr>
		<tr>
			<td>#application.resource.bundle.text.start_week_on#:</td>
			<td>
				<select name="startWeek">
					<cfloop index="dow" from="1" to="7">
						<option value="#dow#" <cfif request.options.weekStart eq dow>selected</cfif>>#dayOfWeekAsString(dow)#</option>
					</cfloop>
				</select>
			</td>
		</tr>
		<tr>
			<td>#application.resource.bundle.text.header#:</td>
			<td>
				<textarea name="header" rows="3" cols="60">#trim(calendarTO.header)#</textarea>
			</td>
		</tr>
		<tr>
			<td>#application.resource.bundle.text.footer#:</td>
			<td>
				<textarea name="footer" rows="3" cols="60">#trim(calendarTO.footer)#</textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="bpd-title">#application.resource.bundle.text.navigation#</td>
		</tr>
		<tr>
			<td>#application.resource.bundle.text.exit_url#:</td>
			<td>
				<input name="exitUrl" type="text" size="30" maxlength="100" value="#trim(calendarTO.exitUrl)#">
			</td>
		</tr>	
		<tr>
			<td colspan="2" class="bpd-title">#application.resource.bundle.text.security#/#application.resource.bundle.text.access#</td>
		</tr>
		<tr>
			<td colspan="2">#application.resource.bundle.text.public_user_permissions#:</td>
		</tr>
		<tr>
			<td colspan="2">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="font-size:12px;">
					<tr>
						<input name="permissionSet" type="hidden" value="#valueList(request.privileges.privilege)#">
						<cfset columns = 3>
						<cfset index = 0>
						<cfloop query="request.privileges">
							<cfset index = index + 1>
							<td><input name="permissions" type="checkbox" value="#privilege#" <cfif listContainsNoCase(request.options.publicPermissions,trim(privilege))>checked</cfif>>#trim(description)#</td>
							<cfif (index mod columns) eq 0></tr><tr></cfif>
						</cfloop>

						<cfloop condition="(index mod columns) neq 0">
							<td></td>
							<cfset index = index + 1>
						</cfloop>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<hr style="height:1px;width:90%;color:##cccccc;">
				<input name="userApprovalRequired" type="checkbox" <cfif yesNoFormat(request.options.userApprovalRequired) eq true>checked</cfif>> #application.resource.bundle.text.user_approval_required_to_access_calendar#
			</td>
		</tr>
		<tr>
			<td colspan="2" class="bpd-title">#application.resource.bundle.text.miscellaneous#</td>
		</tr>
		<tr>
			<td colspan="2">
				<input name="searchEnabled" type="checkbox" <cfif yesNoFormat(request.options.searchEnabled) eq true>checked</cfif>> #application.resource.bundle.text.verity_search_enabled#
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input name="calendarExportEnabled" type="checkbox" <cfif yesNoFormat(request.options.calendarExportEnabled) eq true>checked</cfif>> #application.resource.bundle.text.vcalendar_enabled#
			</td>
		</tr>
	</table>
	<br>
	<table cellpadding="0" cellspacing="0" class="bpd-style">
		<tr>
			<td colspan="2" align="right">
				<input name="submit" type="submit" value="#application.resource.bundle.button.ok#">
			</td>
		</tr>
	</table>
</cfform>
</cfoutput>
