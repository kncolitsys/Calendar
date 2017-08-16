<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 SearchResultsPanel::display
*
* Description:
*	 Displays the results of a calendar search.
*
****************************************************************************
--->
<cfparam name="calendarDate" default="#now()#">
<cfparam name="request.results" default="">
<cfparam name="categories" default="">
<cfparam name="startRow" default="1">
<cfparam name="maxRows" default="4">
<cfparam name="maxPages" default="7">

<!---// Determine the appropriate timezone adjustment. --->
<cfset tz = getProperty("timezoneLibrary") />
<cfset sessionFacade = getProperty("sessionFacade") />
<cfset timezone = iif(sessionFacade.hasUser(), sessionFacade.getUser().getTimezone(), request.timezone) />

<cfif isQuery(request.results)>
	<cfset totalRecords = val(request.results.recordCount)>
<cfelse>
	<cfset totalRecords = 0>
</cfif>
<cfset minRecord = startRow>
<cfset maxRecord = min(evaluate(startRow+maxRows-1), totalRecords)>

<div class="bp-title"><cfoutput>#application.resource.bundle.text.search_results#</cfoutput></div>

<!-- Calendar Options -->
<cfinclude template="../shared/searchOptions.cfm" />

<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0" class="bpd-style">
	<tr class="bpd-title">
		<td valign="bottom">
			<cfif totalRecords gt 0>
				<cfoutput><div style="font-style:italic;font-size:18px;">#application.resource.bundle.text.search_results_records_1# #minRecord#-#maxRecord# #application.resource.bundle.text.search_results_records_2# #totalRecords#</div></cfoutput>
			<cfelse>
				<div align="center" style="font-weight:bold;"><cfoutput>#application.resource.bundle.text.no_matches_found#</cfoutput></div>
			</cfif>
		</td>
		<td align="right" valign="middle" >
			<cfif val(totalRecords) gt 0>
				<cfset totalPages = ceiling(totalRecords/maxRows)>
				<cfset currentPage = ceiling(startRow/maxRows)>
				<cfset minPage = iif(maxPages gt totalPages, 1, min(max(ceiling(currentPage-(maxPages/2)),1),evaluate(totalPages-maxPages+1)))>
				<cfset maxPage = iif(maxPages gt totalPages, totalPages, max(min(int(currentPage+(maxPages/2)),totalPages),maxPages))>
	
				<cfoutput>				
					<cfif currentPage gt minPage>
						<a href="index.cfm?cfevent=calendar.search.results&calendarId=#calendarId#&startRow=#evaluate(startRow-maxRows)#&maxRows=#maxRows#&criteria=#criteria#&startDate=#startDate#&endDate=#endDate#&categories=#categories#" style="font-size:10px;">&laquo;</a>
					<cfelse>
						&nbsp;
					</cfif>
					
					<cfset pageUrl = de("index.cfm?cfevent=calendar.search.results&calendarId=##calendarId##&startRow=##evaluate((page-1)*maxRows+1)##&maxRows=##maxRows##&criteria=##criteria##&startDate=##startDate##&endDate=##endDate##&categories=##categories##")>
					<cfloop index="page" from="#minPage#" to="#evaluate(currentPage-1)#">
						<a href="#evaluate(pageUrl)#" style="font-size:10px;">#page#</a>
					</cfloop>
	
					<span style="font-size:10px;border:2px solid ##666666;padding:2px;">#currentPage#</span>
	
					<cfloop index="page" from="#evaluate(currentPage+1)#" to="#maxPage#">
						<a href="#evaluate(pageUrl)#" style="font-size: 10px;">#page#</a>
					</cfloop>
					
					<cfif totalPages gt currentPage>
						<a href="index.cfm?cfevent=calendar.search.results&calendarId=#calendarId#&startRow=#evaluate(startRow+maxRows)#&maxRows=#maxRows#&criteria=#criteria#&startDate=#startDate#&endDate=#endDate#&categories=#categories#" style="font-size:10px;">&raquo;</a>
					<cfelse>
						&nbsp;
					</cfif>
				</cfoutput>
			<cfelse>
				&nbsp;
			</cfif>
		</td>
	</tr>
</table>
<br>

<cfif totalRecords gt 0>
	<table class="bpd-style" width="100%">
		<tr>
			<td>
				<cfoutput query="request.results" startrow="#startRow#" maxrows="#maxRows#">
					<cfset startDT = trim(tz.toLocal(startDateTime,timezone)) />
					<span style="font-weight:bold;text-decoration:underline;"><a href="index.cfm?cfevent=event.view&calendarId=#calendarId#&eventId=#trim(eventId)#&calendarDate=#dateFormat(trim(startDT),'short')#">#trim(title)#</a></span><br>
					#lsDateFormat(parseDateTime(startDT),application.resource.bundle.datetime.full_week_title)#<cfif allDay eq false>, #lsTimeFormat(parseDateTime(startDT),application.resource.bundle.datetime.short_hour_minute_marker)#</cfif><br>
					<br>
				</cfoutput>
			</td>
		</tr>
	</table>
	<br>
</cfif>
