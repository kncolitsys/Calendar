<cfcomponent displayname="schemeGateway_msaccess" extends="schemeGateway">

	<cfset variables.schemepath = "stylesheets/schemes" />

	<!------------------------------------------------------------------------------------
	// CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="create" access="public" returntype="void" output="false">
		<cfargument name="scheme" type="scheme" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />

		<cftry>
			<!---// Create a CSS file with the object ID as the filename --->
			<cfset abspath = "#getDirectoryFromPath(getBaseTemplatePath())##variables.schemepath#/#trim(scheme.getSchemeId())#.css" />
			<cffile action="write" file="#abspath#" output="#scheme.getStylesheet()#" mode="644" />
			<cfcatch type="any"></cfcatch>
		</cftry>
		
		<cfquery name="q_create_scheme" datasource="#variables.dsn#">
			INSERT INTO schemes (
				schemeId, title, globalObject, 
				stylesheet, filepath,
				createDate, createBy,
				updateDate, updateBy
			) VALUES (
				'#trim(scheme.getSchemeId())#', '#trim(scheme.getTitle())#', #int(scheme.getGlobal())#,
				'#trim(scheme.getStylesheet())#', '#trim(scheme.getFilepath())#',
				<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#',
				<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#'
			)
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="scheme" output="false">
		<cfargument name="id" type="string" required="true" />

		<!---// Query the scheme info and load it into a struct, then return it to the caller --->
		<cfquery name="q_read_scheme" datasource="#variables.dsn#">
			SELECT *
			FROM schemes
			WHERE schemeId = '#trim(arguments.id)#'
		</cfquery>
	
		<cfif val(q_read_scheme.recordCount) gt 0>
			<cfscript>
				schemeStruct = queryRowToStruct(q_read_scheme);
				scheme = createObject("component","scheme").init(argumentcollection=schemeStruct);
				addCacheItem(scheme.getSchemeId(), scheme);
				return scheme;
			</cfscript>
		<cfelse>
			<cfthrow type="SCHEME.MISSING" message="The requested scheme does not exist" detail="Scheme ID: #arguments.id#">
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="scheme" type="scheme" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />

		<cftry>
			<!---// Overwrite the CSS file --->
			<cfset abspath = "#getDirectoryFromPath(getBaseTemplatePath())##variables.schemepath#/#trim(scheme.getSchemeId())#.css" />
			<cffile action="write" file="#abspath#" output="#scheme.getStylesheet()#" mode="644" />
			<cfcatch type="any"></cfcatch>
		</cftry>

		<cfquery name="q_update_scheme" datasource="#variables.dsn#">
			UPDATE schemes
			SET
				title = '#trim(scheme.getTitle())#',
				globalObject = #int(scheme.getGlobal())#,
				stylesheet = '#trim(scheme.getStylesheet())#',
				filepath = '#trim(scheme.getFilepath())#',
				updateDate = <cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>,
				updateBy = '#trim(arguments.modifier)#'
			WHERE
				schemeId = '#trim(scheme.getSchemeId())#'
		</cfquery>
		<cfset removeCacheItem(arguments.scheme.getSchemeId()) />
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />

		<!---// Delete the CSS file --->
		<cftry>
			<cfset abspath = "#getDirectoryFromPath(getBaseTemplatePath())##variables.schemepath#/#trim(arguments.id)#.css" />
			<cffile action="delete" file="#abspath#" />
			<cfcatch type="any"></cfcatch>
		</cftry>
		
		<cfquery name="q_delete_scheme" datasource="#variables.dsn#">
			DELETE FROM schemes
			WHERE schemeId = '#trim(arguments.id)#'
		</cfquery>
		<cfset removeCacheItem(arguments.id) />
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Non-CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="getSchemes" access="public" returntype="query" output="false">
		<cfargument name="calendarId" type="uuid" required="false" default="00000000-0000-0000-0000000000000000" />
		<cfargument name="global" type="boolean" required="false" default="false" />
		<cfquery name="q_schemes" datasource="#variables.dsn#">
			SELECT *
			FROM schemes
			WHERE 1 = 1
			<cfif arguments.global eq true>AND globalObject = #int(arguments.global)#</cfif>
			<cfif compareNoCase(arguments.calendarId, "00000000-0000-0000-0000000000000000") neq 0>AND calendarDsid = (SELECT calendarDsid FROM calendars WHERE calendarId = '#trim(arguments.calendarId)#')</cfif>
		</cfquery>
		<cfreturn q_schemes />
	</cffunction>

</cfcomponent>