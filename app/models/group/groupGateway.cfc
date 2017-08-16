<cfcomponent displayname="groupGateway" extends="calendar.models.dao.Gateway">

	<cffunction name="init" access="public" returntype="groupGateway" output="false">
		<cfargument name="dsn" type="string" required="true" />
		<cfargument name="factory" type="calendar.models.dao.GatewayFactory" required="true" />
		<cfset variables.dsn = arguments.dsn />
		<cfset variables.factory = arguments.factory />
		<cfreturn this />
	</cffunction>

</cfcomponent>