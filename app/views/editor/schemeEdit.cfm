<cfparam name="calendarId" default="">

<cfif request.event.isArgDefined("schemeBean")>
	<cfset schemeTO = request.event.getArg("schemeBean").getSchemeTO() />
<cfelse>
	<cfset schemeTO = request.scheme.getSchemeTO() />
</cfif>

<cfif compareNoCase(getToken(cfevent,1,'.'),"administrator") eq 0>
	<cfset globalScheme = true />
</cfif>

<script language="javascript">
<!--//
function validateDelete(form) {
	del = confirm("<cfoutput>#application.resource.bundle.text.delete_scheme_warning#</cfoutput>");
	if(del) {
		form.action='index.cfm?cfevent=scheme.delete&calendarId=<cfoutput>#calendarId#</cfoutput>';
		return true;
	} else {
		return false;
	}
}
//-->
</script>

<cfform action="index.cfm?cfevent=#cfevent#.submitted" method="post">
	<cfoutput>
		<input name="schemeId" type="hidden" value="#trim(schemeTO.schemeId)#" />
		<!---// CODE: Update and uncomment this code --->
<!---		<input name="calendarId" type="hidden" value="<cfif isDefined('schemeTO.calendar.id')>#trim(schemeTO.calendar.getCalendarId())#<cfelse>#calendarId#</cfif>"> --->
		<input name="calendarId" type="hidden" value="#trim(calendarId)#" />
		<input name="global" type="hidden" value="#iif(isDefined('globalScheme'),1,int(schemeTO.global))#">
	
		<table cellpadding="0" cellspacing="0" class="bpd-style">
			<tr>
				<td>#application.resource.bundle.text.title#:</td>
				<td><input name="title" type="text" size="50" maxlength="50" value="#trim(schemeTO.title)#"></td>
			</tr>
			<cfif len(schemeTO.filepath) gt 0>
			<tr>
				<td>#application.resource.bundle.text.filepath#:</td>
				<td>
					<input name="filepath" type="hidden" value="#trim(schemeTO.filepath)#">
					#trim(schemeTO.filepath)#
				</td>
			</tr>
			</cfif>
			<tr>
				<td valign="top">#application.resource.bundle.text.stylesheet#:</td>
				<td>
					<!---
					// If the content stored for the stylesheet is empty, then read
					// the stylesheet directly.
					--->
					<cfif len(trim(schemeTO.stylesheet)) eq 0>
						<cfset ssfile = "#expandPath('stylesheets/schemes/')##trim(schemeTO.filePath)#">
						<cfif fileExists(ssfile)>
							<cffile action="read" file="#ssfile#" variable="content">
							<cfset crlf = chr(13) & chr(10)>
							<cfif findNoCase(crlf,content) gt 0>
								<cfset content = replace(content, "#chr(13)##chr(10)#", "#chr(10)#", "ALL")>
							</cfif>
						<cfelse>
							<cfset content = "">
						</cfif>
					<cfelse>
						<cfset content = schemeTO.stylesheet>
					</cfif>
					<textarea name="stylesheet" rows="20" cols="50">#trim(content)#</textarea>
				</td>
			</tr>
		</table>
		<br>
		<table cellpadding="0" cellspacing="0" class="bpd-style">
			<tr>
				<td colspan="2" align="right">
					<input name="delete" type="submit" value="#application.resource.bundle.button.delete#" onclick="return validateDelete(this.form);">
					<input name="submit" type="submit" value="#application.resource.bundle.button.ok#">
				</td>
			</tr>
		</table>
	</cfoutput>
</cfform>
