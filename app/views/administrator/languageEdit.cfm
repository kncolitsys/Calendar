<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 LanguageEditPanel::display
*
* Description:
*	 Display a panel for editing the application language.
*
****************************************************************************
--->

<cfparam name="attributes.language" default="">
<cfparam name="attributes.contextId" default="">
<cfparam name="application.resource.language" default="en-us">

<cfoutput>
<div class="bp-title">#application.resource.bundle.text.language_management#</div><br>

<cfform action="index.cfm?cfevent=administrator.language.edit.submitted" method="post">
		<table cellpadding="0" cellspacing="0" class="bpd-style">
			<tr>
				<td>#application.resource.bundle.text.language#:</td>
				<td>
					<select name="language" size="1">
					<cfloop index="lang" list="#listSort(structKeyList(request.supportedLanguages),'textnocase')#">
						<option value="#lang#" <cfif compareNoCase(request.language,lang) eq 0>selected</cfif>>#lang#: #request.supportedLanguages[lang]#</option>
					</cfloop>
					</select>
				</td>
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
</cfform>
</cfoutput>