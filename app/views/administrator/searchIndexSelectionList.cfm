<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 SearchIndexSelectionList::display
*
* Description:
*	 Display a list for selecting a SearchIndex to edit.
*
****************************************************************************
--->

<cfparam name="attributes.selected" default="">
<cfparam name="attributes.contextId" default="">

<cfoutput>
<div class="bp-title">#application.resource.bundle.text.search_index_management#</div><br>

<table width="100%" border="0" cellpadding="4" cellspacing="0" style="font-size:12px;">
	<tr>
		<th align="left">Search Index for Calendar:</th>
		<th width="24" align="center">#application.resource.bundle.button.verity_refresh#</th>
		<th width="24" align="center">#application.resource.bundle.button.verity_update#</th>
		<th width="24" align="center">#application.resource.bundle.button.verity_optimize#</th>
	</tr>
	<cfset toggle = true />
	<cfloop query="request.searchIndexes">
		<tr bgcolor="###iif(toggle,de('e9e9e9'),de('f3f3f3'))#">
			<td>#title#</td>
			<td align="center"><a href="index.cfm?cfevent=administrator.search.edit.submitted&searchIndexId=#searchIndexId#&action=refresh"><img src="images/icon_edit.gif" border="0" alt="#application.resource.bundle.button.verity_refresh#" /></a></td>
			<td align="center"><a href="index.cfm?cfevent=administrator.search.edit.submitted&searchIndexId=#searchIndexId#&action=update"><img src="images/icon_edit.gif" border="0" alt="#application.resource.bundle.button.verity_update#" /></a></td>
			<td align="center"><a href="index.cfm?cfevent=administrator.search.edit.submitted&searchIndexId=#searchIndexId#&action=optimize" onClick="return confirm('#application.resource.bundle.text.verity_optimize_warning#');"><img src="images/icon_edit.gif" border="0" alt="#application.resource.bundle.button.verity_optimize#" /></a></td>
		</tr>
		<cfset toggle = not toggle />
	</cfloop>
</table>
</cfoutput>