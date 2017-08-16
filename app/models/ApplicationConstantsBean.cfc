<cfcomponent displayName="ApplicationConstantsBean" hint="An application constants bean.">
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="ApplicationConstantsBean" output="false" >
		<cfargument name="dbDsn" type="string" required="true" />
		<cfargument name="dbType" type="string" required="true"  />	
		<cfscript>
			variables.instance = structNew();
			setDbDsn(arguments.dbDsn);
			setDbType(arguments.dbType);
		</cfscript>
		<cfreturn this />
	</cffunction>
	
	<!--- GETTERS/SETTERS --->
	<cffunction name="getDbType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.dbType />
	</cffunction>
	<cffunction name="setDbType" access="public" returntype="void" output="false">
		<cfargument name="dbType" type="string" required="true" />
		<cfset variables.instance.dbType = arguments.dbType />
	</cffunction>
	
	<cffunction name="getDbDsn" access="public" returntype="string" output="false">
		<cfreturn variables.instance.dbDsn />
	</cffunction>
	<cffunction name="setDbDsn" access="public" returntype="void" output="false">
		<cfargument name="dsn" type="string" required="true" />
		<cfset variables.instance.dbDsn = arguments.dsn />
	</cffunction>

</cfcomponent>
