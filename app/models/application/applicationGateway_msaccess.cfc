<cfcomponent displayname="applicationGateway_msaccess" extends="applicationGateway">

	<!------------------------------------------------------------------------------------
	// CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="create" access="public" returntype="void" output="false">
		<cfargument name="application" type="application" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />
		
		<cfquery name="q_create_application" datasource="#variables.dsn#">
			INSERT INTO applications (
				applicationId, title,
				product, edition,
				version, serial,
				createDate, createBy,
				updateDate, updateBy
			) VALUES (
				'#trim(application.getApplicationId())#', '#trim(application.getTitle())#',
				'#trim(application.getProduct())#', '#trim(application.getEdition())#',
				'#trim(application.getVersion())#', '#trim(application.getSerial())#',
				<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#',
				<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#'
			)
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="application" output="false">
		<cfargument name="id" type="string" required="true" />

		<!---// Query the application info and load it into a struct, then return it to the caller --->
		<cfquery name="q_read_application" datasource="#variables.dsn#">
			SELECT *
			FROM applications
			WHERE applicationId = '#trim(arguments.id)#'
		</cfquery>

		<cfquery name="q_privileges" datasource="#variables.dsn#">
			SELECT privilege, description
			FROM rights
			WHERE calendarDsid = 0
		</cfquery>
		
		<cfif val(q_read_application.recordCount) gt 0>
			<cfscript>
				applicationStruct = queryRowToStruct(q_read_application);
				privileges = queryToStruct(q_privileges,"privilege");
				return createObject("component","application").init(argumentcollection=applicationStruct,privileges=privileges);
			</cfscript>
		<cfelse>
			<cfthrow type="APPLICATION.MISSING" message="The requested application does not exist" detail="Application ID: #arguments.id#">
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="application" type="application" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />

		<cfquery name="q_update_application" datasource="#variables.dsn#">
			UPDATE applications
			SET
				title = '#trim(application.getTitle())#',
				product = '#trim(application.getProduct())#',
				edition = '#trim(application.getEdition())#',
				version = '#trim(application.getVersion())#',
				serial = '#trim(application.getSerial())#',
				updateDate = <cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>,
				updateBy = '#trim(arguments.modifier)#'
			WHERE
				applicationId = '#trim(application.getApplicationId())#'
		</cfquery>
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />

		<cfquery name="q_delete_application" datasource="#variables.dsn#">
			DELETE FROM applications
			WHERE applicationId = '#trim(arguments.id)#'
		</cfquery>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Non-CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="deleteConfiguration" access="public" returntype="void" output="false">
		<cfargument name="configuration" type="string" required="true" />
		
		<cfquery name="q_delete_configuration" datasource="#variables.dsn#">
			DELETE FROM configLookup
			WHERE objectType = (SELECT dsid FROM configObject WHERE title = 'application')
			  AND configType = (SELECT dsid FROM configCatalog WHERE title = '#trim(arguments.configuration)#')
			  AND objectValue = (SELECT TOP 1 applicationDsid FROM applications)
		</cfquery>
	</cffunction>

	<cffunction name="getApplications" access="public" returntype="query" output="false">
		<cfquery name="q_applications" datasource="#variables.dsn#">
			SELECT *
			FROM applications
		</cfquery>
		<cfreturn q_applications />
	</cffunction>

	<cffunction name="getConfiguration" access="public" returntype="string" output="false">
		<cfargument name="configuration" type="string" required="true" />

		<cfquery name="q_configuration" datasource="#variables.dsn#">
			SELECT configValue
			FROM configLookup
			WHERE objectType = (SELECT dsid FROM configObject WHERE title = 'application')
			  AND configType = (SELECT dsid FROM configCatalog WHERE title = '#trim(arguments.configuration)#')
			  AND objectValue = (SELECT TOP 1 applicationDsid FROM applications)
		</cfquery>
		<cfreturn q_configuration.configValue />
	</cffunction>
	
	<cffunction name="getLanguages" access="public" returntype="struct" output="false">
		<cfscript>
			languages = structNew();
			languages["en-us"] = "English (US)";
			languages["fr"] = "French";
			return languages;
		</cfscript>
	</cffunction>

	<cffunction name="setConfiguration" access="public" returntype="void" output="false">
		<cfargument name="configuration" type="string" required="true" />
		<cfargument name="value" type="string" required="true" />

		<cfquery name="q_configuration" datasource="#variables.dsn#">
			SELECT configValue
			FROM configLookup
			WHERE objectType = (SELECT dsid FROM configObject WHERE title = 'application')
			  AND configType = (SELECT dsid FROM configCatalog WHERE title = '#trim(arguments.configuration)#')
			  AND objectValue = (SELECT TOP 1 applicationDsid FROM applications)
		</cfquery>
		
		<cfif val(q_configuration.recordCount) gt 0>
			<cfquery name="q_update_configuration" datasource="#variables.dsn#">
				UPDATE configLookup
				SET configValue = '#trim(arguments.value)#'
				WHERE objectType = (SELECT dsid FROM configObject WHERE title = 'application')
				  AND configType = (SELECT dsid FROM configCatalog WHERE title = '#trim(arguments.configuration)#')
				  AND objectValue = (SELECT TOP 1 applicationDsid FROM applications)
			</cfquery>
		<cfelse>
			<cftransaction>
				<cfquery name="q_objectType" datasource="#variables.dsn#" maxrows="1">
					SELECT dsid
					FROM configObject
					WHERE title = 'application'
				</cfquery>
				
				<cfquery name="q_objectValue" datasource="#variables.dsn#" maxrows="1">
				SELECT TOP 1 dsid FROM applications
				</cfquery>
				
				<cfquery name="q_configType" datasource="#variables.dsn#" maxrows="1">
					SELECT dsid
					FROM configCatalog
					WHERE title = '#trim(arguments.configuration)#'				
				</cfquery>
				
				<cfquery name="q_insert_configuration" datasource="#variables.dsn#">
					INSERT INTO configLookup (objectType, objectValue, configType, configValue)
					VALUES (#val(q_objectType.dsid)#, #val(q_objectValue.dsid)#, #val(q_configType.dsid)#, '#trim(arguments.value)#')
				</cfquery>
			</cftransaction>
		</cfif>
	</cffunction>
	
</cfcomponent>