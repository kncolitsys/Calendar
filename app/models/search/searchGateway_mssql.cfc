<cfcomponent displayname="searchGateway_mssql" extends="searchGateway">

	<!------------------------------------------------------------------------------------
	// CRUD methods
	------------------------------------------------------------------------------------->

	<!---// Search is a transient object, so there's no need for any CRUD methods --->

	<!------------------------------------------------------------------------------------
	// Non-CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="search" access="public" returntype="query" output="false">
		<cfargument name="calendar" required="true" type="calendar.models.calendar.calendar" />
		<cfargument name="criteria" required="true" type="calendar.models.search.search" />
		<cfargument name="searchIndex" required="true" type="calendar.models.searchIndex.searchIndex" />
		<cfargument name="status" required="false" type="numeric" default="1" />
		<cfargument name="startRow" required="false" type="numeric" default="1" />
		<cfargument name="maxRows" required="false" type="numeric" default="10" />
		
		<!---
		// If no search criteria was entered, then no results should be returned.
		// This is how most major search engines work.
		--->
		<cfset c = arguments.criteria />
		<cfif not (isDate(c.getStartDate()) or isDate(c.getEndDate()) or len(c.getCriteria()) gt 0 or len(c.getCategories()) gt 0)>
			<cfreturn queryNew("id")>
			<cfexit>
		</cfif>
		
		<!--- CODE: Currently, the search only matches full-word matches... let's see
		if we can modify it to do partial-word matches --->
		<!---// The first step is to search the Verity index. --->
		<cfparam name="verityList" default="">
		<cfif len(c.getCriteria()) gt 0>
			<cfsearch name="v_search" collection="#arguments.searchIndex.getCollection()#" criteria="#c.getCriteria()#" startRow="#val(arguments.startRow)#" maxRows="#val(arguments.maxRows)#" />
			<cfset verityList = quotedValueList(v_search.Key)>
		</cfif>
		
		<!---
		// If the user actually entered some search criteria and no records were
		// found in the search index, then the database need not be searched.	There
		// are no matching records.
		--->
		<cfif len(c.getCriteria()) gt 0 and len(verityList) lte 0 and len(c.getCategories()) eq 0>
			<!---// Return an empty query. --->
			<cfreturn queryNew("id")>
			<cfexit>
		<cfelse>
			<cfquery name="q_select_search_results" datasource="#variables.dsn#">
				SELECT e.*
				FROM events e INNER JOIN calendars_events ce ON ce.eventDsid = e.eventDsid
				WHERE ce.calendarDsid = (SELECT calendarDsid FROM calendars WHERE calendarId = '#arguments.calendar.getCalendarId()#')
				  AND ce.status = #val(arguments.status)#
				
				<cfif isDate(c.getStartDate())>
				  AND e.startDateTime > #createOdbcDateTime(c.getStartDate())#
				</cfif>
				<cfif isDate(c.getEndDate())>
				  AND e.startDateTime < #createOdbcDateTime(c.getEndDate())#
				</cfif>
				
				<cfif listLen(c.getCategories()) gt 0>
				  AND e.categoryDsid IN (SELECT categoryDsid FROM categories WHERE categoryId IN (listQualify(c.getCategories(),"'",",","ALL")))
				</cfif>
				
				<cfif listLen(verityList) gt 0>
				  AND e.eventId IN (#preserveSingleQuotes(verityList)#)
				</cfif>
				ORDER BY e.startDateTime DESC
			</cfquery>
			<cfreturn q_select_search_results />
		</cfif>
	</cffunction>
	
</cfcomponent>