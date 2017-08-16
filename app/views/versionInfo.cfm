<!---
****************************************************************************
* Method:			
*	 ApplicationProductPanel::display
*
* Description:
*	 Display a panel for viewing product information.
*
****************************************************************************
--->

<cfparam name="attributes.company" default="">
<cfparam name="attributes.companyUrl" default="">
<cfparam name="attributes.product" default="">
<cfparam name="attributes.version" default="">
<cfparam name="attributes.edition" default="">
<cfparam name="attributes.serial" default="">

<div class="bp-title"><cfoutput>#application.resource.bundle.text.product_information#</cfoutput></div>
<br>

<cfoutput>
<table border="0" cellpadding="0" cellspacing="0" class="bpd-style">
	<tr>
		<td width="20%" style="font-weight:bold;">#application.resource.bundle.text.company#</td>
		<td><a href="#attributes.companyUrl#">#attributes.company#</a></td>
	</tr>
	<tr>
		<td style="font-weight:bold;">#application.resource.bundle.text.product#</td>
		<td>#attributes.product#</td>
	</tr
	><tr>
		<td style="font-weight:bold;">#application.resource.bundle.text.version#</td>
		<td>#attributes.version#</td>
	</tr>
	<tr>
		<td style="font-weight:bold;">#application.resource.bundle.text.edition#</td>
		<td>#attributes.edition#</td>
	</tr>
	<tr>
		<td style="font-weight:bold;">#application.resource.bundle.text.serial_number#</td>
		<td>#attributes.serial#</td>
	</tr>
</table>
</cfoutput>
