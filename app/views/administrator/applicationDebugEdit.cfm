<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 ApplicationDebugPanel::display
*
* Description:
*	 Displays a panel for managing debugging output.
*
****************************************************************************
--->

<cfparam name="attributes.enabled" default="false">
<cfparam name="attributes.message" default="">
<cfparam name="attributes.filepath" default="">

<div class="bp-title"><cfoutput>#application.resource.bundle.text.application_debugging#</cfoutput></div>

<cfif len(attributes.message) gt 0>
	<br>
	<table border="0" cellpadding="0" cellspacing="0" class="bpd-style">
		<tr>
			<td colspan="2" style="color:#ff0000;font-weight:bold;text-align:center;"><cfoutput>#attributes.message#</cfoutput></td>
		</tr>
	</table>
</cfif>

<form action="index.cfm?cfevent=administrator.debug.edit.submitted" method="post">
	<table border="0" cellpadding="0" cellspacing="0" class="bpd-style">
		<tr>
			<td colspan="2"><input name="enabled" type="checkbox" value="1" <cfif request.debug.enabled eq true>checked</cfif>><cfoutput>#application.resource.bundle.text.enable_debugging#</cfoutput></td>
		</tr>
		<tr>
			<td colspan="2"><input name="filepath" type="text" size="50" maxlength="255" value="<cfoutput>#request.debug.filepath#</cfoutput>"><br><span style="font-size:10px;"><cfoutput>#application.resource.bundle.text.physical_path_to_log_file#</cfoutput></span></td>
		</tr>
	</table>
	<br>
	<table border="0" cellpadding="0" cellspacing="0" class="bpd-style">
		<tr>
			<td colspan="2" style="text-align:right;"><input name="submit" type="submit" value="<cfoutput>#application.resource.bundle.button.ok#</cfoutput>"></td>
		</tr>
	</table>
</form>
