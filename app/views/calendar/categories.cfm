<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 CalendarViewPanel::displayCategories
*
* Description:
*	 Displays the categories associated with a calendar in a formatted table.
*
****************************************************************************
--->

<cfparam name="cfevent" default="calendar.view">

<cfparam name="attributes.calendar" default="">
<cfparam name="calendarDate" default="#now()#">
<cfparam name="displayType" default="standard">
<cfparam name="viewType" default="month">
<cfparam name="attributes.format" default="calendar">
<cfparam name="filter" default="">


<cfif isDefined("request.categories") and isQuery(request.categories) and val(request.categories.recordCount) gt 0>
	<style type="text/css">
		<cfloop query="request.categories">
			<cfoutput>.category_#lCase(replace(categoryId,'-','','ALL'))# { background-color: #trim(bgColor)#; } </cfoutput> 
		</cfloop>
	</style>
	
	<!-- Category table -->
	<table cellpadding="0" cellspacing="0" class="bcc-style">
		<tr>
			<cfset num = request.categories.recordCount+1>
			<cfset columns = ceiling(num/(ceiling(num/7)))>
			<cfset colWidth = 100/columns>
			
			<cfoutput><td class="bcc-style" style="width:#colWidth#%;"><a href="index.cfm?cfevent=#cfevent#&calendarId=#calendarId#&displayType=#displayType#&viewType=#viewType#&format=#attributes.format#&calendarDate=#dateFormat(calendarDate,'short')#">#application.resource.bundle.text.display_all#</a></td></cfoutput>
			<cfset index = 1>

			<cfoutput query="request.categories">
				<cfset index = index + 1>		

				<td class="bcc-style" style="width:#colWidth#%;background-color: #trim(bgColor)#;"><a href="index.cfm?cfevent=#cfevent#&calendarId=#calendarId#&displayType=#displayType#&viewType=#viewType#&format=#attributes.format#&calendarDate=#dateFormat(calendarDate,'short')#&filter=categories:#categoryId#">#trim(categoryTitle)#</a></td>
				<cfif (index mod columns) eq 0></tr><tr></cfif>
			</cfoutput>
			
			<cfloop condition="(index mod columns) neq 0">
				<td></td>
				<cfset index = index + 1>
			</cfloop> 
		</tr>
	</table>
</cfif>