<cfcomponent displayname="mailserverGateway_msaccess" extends="mailserverGateway">

	<!------------------------------------------------------------------------------------
	// CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="create" access="public" returntype="void" output="false">
		<cfargument name="mailserver" type="mailserver" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />
		
		<cfquery name="q_create_mailserver" datasource="#variables.dsn#">
			INSERT INTO mailservers (
				mailserverId, server,
				port, timeout,
				mailerId, serverusername, serverpassword,
				createDate, createBy,
				updateDate, updateBy
			) VALUES (
				'#trim(mailserver.getMailserverId())#', '#trim(mailserver.getServer())#',
				#val(mailserver.getPort())#, #val(mailserver.getTimeout())#,
				'#trim(mailserver.getMailerId())#', '#trim(mailserver.getusername())#', '#trim(mailserver.getpassword())#',
				<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#',
				<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#'
			)
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="mailserver" output="false">
		<cfargument name="id" type="string" required="true" />
		
		<cfscript>
			object = findCacheItem(arguments.id);
			if (isObject(object)) { return object; }
		</cfscript>

		<!---// Query the mailserver info and load it into a struct, then return it to the caller --->
		<cfquery name="q_read_mailserver" datasource="#variables.dsn#">
			SELECT *
			FROM mailservers
			WHERE mailserverId = '#trim(arguments.id)#'
		</cfquery>
		
		<cfif val(q_read_mailserver.recordCount) gt 0>
			<cfscript>
				mailserverStruct = queryRowToStruct(q_read_mailserver);
				mailserver = createObject("component","mailserver").init(argumentcollection=mailserverStruct,username=mailserverStruct.serverusername,password=mailserverStruct.serverpassword);
				addCacheItem(mailserver.getMailServerId(), mailserver);
				return mailserver;
			</cfscript>
		<cfelse>
			<cfthrow type="MAILSERVER.MISSING" message="The requested mailserver does not exist" detail="Mailserver ID: #arguments.id#">
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="mailserver" type="mailserver" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />

		<cfquery name="q_update_mailserver" datasource="#variables.dsn#">
			UPDATE mailservers
			SET
				server = '#trim(mailserver.getServer())#',
				port = #val(mailserver.getPort())#,
				timeout = #val(mailserver.getTimeout())#,
				mailerId = '#trim(mailserver.getMailerId())#',
				serverusername = '#trim(mailserver.getUsername())#',
				serverpassword = '#trim(mailserver.getPassword())#',
				updateDate = <cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>,
				updateBy = '#trim(arguments.modifier)#'
			WHERE
				mailserverId = '#trim(mailserver.getMailserverId())#'
		</cfquery>
		<cfset removeCacheItem(arguments.mailserver.getMailServerId()) />
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />

		<cfquery name="q_delete_mailserver" datasource="#variables.dsn#">
			DELETE FROM mailservers
			WHERE mailserverId = '#trim(arguments.id)#'
		</cfquery>
		<cfset removeCacheItem(arguments.id) />
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Non-CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="getMailserver" access="public" returntype="mailserver" output="false">
		<cfscript>
			mxs = getMailservers();
			return read(mxs.mailserverId);
		</cfscript>
	</cffunction>

	<cffunction name="getMailservers" access="public" returntype="query" output="false">
		<cfquery name="q_mailservers" datasource="#variables.dsn#">
			SELECT *
			FROM mailservers
		</cfquery>
		<cfreturn q_mailservers />
	</cffunction>
	
</cfcomponent>