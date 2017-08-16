<cfif request.event.isArgDefined("categoryBean")>
	<cfset categoryTO = request.event.getArg("categoryBean").getCategoryTO() />
<cfelse>
	<cfset categoryTO = request.category.getCategoryTO() />
</cfif>

<script language="javascript">
<!--//
function validateDelete(form) {
	del = confirm("<cfoutput>#application.resource.bundle.text.delete_category_warning#</cfoutput>");
	if(del) {
		form.action='index.cfm?cfevent=category.delete&calendarId=<cfoutput>#calendarId#</cfoutput>';
		return true;
	} else {
		return false;
	}
}
//-->
</script>

<cfoutput>
<cfform action="index.cfm?cfevent=#trim(cfevent)#.submitted&calendarId=#calendarId#" method="post">
	<input name="categoryId" type="hidden" value="#categoryTO.categoryId#" />
	<!---// CODE: Update and uncomment --->
	<!---<input name="calendarId" type="hidden" value="#trim(categoryTO.calendar.id)#">--->
	<input name="calendarId" type="hidden" value="#trim(calendarId)#">
	
	<table cellpadding="0" cellspacing="0" class="bpd-style">
		<tr>
			<td>#application.resource.bundle.text.title#:</td>
			<td><input name="title" type="text" size="30" maxlength="50" value="#trim(categoryTO.title)#"></td>
		</tr>
		<tr>
			<td>#application.resource.bundle.text.description#:</td>
			<td><input name="description" type="text" size="30" maxlength="100" value="#trim(categoryTO.description)#"></td>
		</tr>
		<tr>
			<td>#application.resource.bundle.text.background_color#:</td>
			<td>
				<input name="bgColor" type="text" size="6" maxlength="6" value="#trim(categoryTO.bgColor)#" onchange="document.all['colorBox'].style.backgroundColor=this.value;">
				<span id="colorBox" style="border:thin solid;background-color:#trim(categoryTO.bgColor)#;">&nbsp;&nbsp;&nbsp;</span>
			</td>
		</tr>
	</table>
	<br>
	<table cellpadding="0" cellspacing="0" class="bpd-style">
		<tr>
			<td class="bpd-style" colspan="2" align="right">
				<!---// CODE: Update and uncomment --->
				<!---<cfif val(categoryTO.dsid) gt 0><input name="delete" type="submit" value="#application.resource.bundle.button.delete#" onclick="return validateDelete(this.form);"></cfif>--->
				<input name="submit" type="submit" value="#application.resource.bundle.button.ok#">
			</td>
		</tr>
	</table>
</cfform>
</cfoutput>
