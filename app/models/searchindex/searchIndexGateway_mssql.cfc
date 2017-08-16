<cfcomponent displayname="searchIndexGateway_mssql" extends="searchIndexGateway">

	<!------------------------------------------------------------------------------------
	// CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="create" access="public" returntype="void" output="false">
		<cfargument name="searchIndex" type="searchIndex" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />

		<cfset verityPath = server.coldfusion.rootdir & iif(compareNoCase(server.os.name,"UNIX") eq 0, de("/verity/collections"), de("\Verity\Collections")) />
		<cftry>
			<cfcollection action="create" collection="#trim(searchIndex.getCollection())#" language="#trim(searchIndex.getLanguage())#" path="#verityPath#" />
			<cfcatch type="any"></cfcatch>
		</cftry>
		<cfset searchIndex.setPath(verityPath & iif(compareNoCase(server.os.name,"UNIX") eq 0, de("/"), de("\")) & searchIndex.getCollection()) />
		
		<cfquery name="q_create_searchIndex" datasource="#variables.dsn#">
			INSERT INTO searchindexes (
				searchIndexId, title, collection,
				path, indexLanguage,
				createDate, createBy,
				updateDate, updateBy
			) VALUES (
				'#trim(searchIndex.getSearchIndexId())#', '#trim(searchIndex.getTitle())#', '#trim(searchIndex.getCollection())#',
				'#trim(searchIndex.getPath())#', '#trim(searchIndex.getLanguage())#',
				<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#',
				<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#'
			)
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="searchIndex" output="false">
		<cfargument name="id" type="string" required="true" />

		<!---// Query the searchIndex info and load it into a struct, then return it to the caller --->
		<cfquery name="q_read_searchIndex" datasource="#variables.dsn#">
			SELECT *
			FROM searchindexes
			WHERE searchIndexId = '#trim(arguments.id)#'
		</cfquery>
		
		<cfif val(q_read_searchIndex.recordCount) gt 0>
			<cfscript>
				searchIndexStruct = queryRowToStruct(q_read_searchIndex);
				searchIndex = createObject("component","searchIndex").init(argumentcollection=searchIndexStruct,langugage=searchIndexStruct.indexLanguage);
				addCacheItem(searchIndex.getSearchIndexId(), searchIndex);
				return searchIndex;
			</cfscript>
		<cfelse>
			<cfthrow type="SEARCHINDEX.MISSING" message="The requested searchIndex does not exist" detail="SearchIndex ID: #arguments.id#">
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="searchIndex" type="searchIndex" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />

		<cftry>
			<cfcollection action="delete" collection="#trim(searchIndex.getCollection())#" />
			<cfcatch type="any"></cfcatch>
		</cftry>
		<cfquery name="q_update_searchIndex" datasource="#variables.dsn#">
			UPDATE searchindexes
			SET
				title = '#trim(searchIndex.getTitle())#',
				collection = '#trim(searchIndex.getCollection())#',
				path = '#trim(searchIndex.getPath())#',
				indexLanguage = '#trim(searchIndex.getLanguage())#',
				updateDate = <cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>,
				updateBy = '#trim(arguments.modifier)#'
			WHERE
				searchIndexId = '#trim(searchIndex.getSearchIndexId())#'
		</cfquery>
		<cfset removeCacheItem(searchIndex.getSearchIndexId()) />
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />

		<cfquery name="q_delete_searchIndex" datasource="#variables.dsn#">
			DELETE FROM searchindexes
			WHERE searchIndexId = '#trim(arguments.id)#'
		</cfquery>
		<cfset removeCacheItem(searchIndex.getSearchIndexId()) />
	</cffunction>
	
	<!------------------------------------------------------------------------------------
	// Non-CRUD methods
	------------------------------------------------------------------------------------->
	
	<cffunction name="getSearchIndexByCalendar" access="public" returntype="calendar.models.searchIndex.searchIndex" output="false">
		<cfargument name="calendarId" type="string" required="true" />
		
		<cfquery name="q_searchIndex" datasource="#variables.dsn#">
			SELECT si.*
			FROM searchindexes si INNER JOIN calendars c ON si.calendarDsid = c.calendarDsid
			WHERE c.calendarId = '#trim(arguments.calendarId)#'
		</cfquery>
		<cfreturn read(q_searchIndex.searchIndexId) />
	</cffunction>

	<cffunction name="getSearchData" access="public" returntype="query" output="false">
		<cfquery name="q_status" datasource="#variables.dsn#">
			SELECT statusDsid
			FROM status
			WHERE code = 'approved'
		</cfquery>
		
		<!---// Shouldn't I be including calendarId somewhere in this query??? --->
		<cfquery name="q_select_search_data" datasource="#variables.dsn#">
			SELECT e.eventId, e.description, e.title
			FROM events e INNER JOIN calendars_events ce ON ce.eventDsid = e.eventDsid
			WHERE ce.status = #val(q_status.statusDsid)#
		</cfquery>
		
		<cfreturn q_select_search_data />
	</cffunction>
	
	<cffunction name="getSearchIndexes" access="public" returntype="query" output="false">
		<cfquery name="q_searchIndexes" datasource="#variables.dsn#">
			SELECT s.*, c.calendarId, c.title AS calendarTitle
			FROM searchindexes s LEFT JOIN calendars c ON s.calendarDsid = c.calendarDsid
		</cfquery>
		<cfreturn q_searchIndexes />
	</cffunction>

</cfcomponent>