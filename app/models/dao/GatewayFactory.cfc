<cfcomponent displayname="Abstract GatewayFactory">
 
	<cffunction name="init" access="public" returntype="GatewayFactory">		
		<cfargument name="dsn" type="string" required="true" />
		<cfscript>			
			variables.dsn = arguments.dsn;
		</cfscript>		
		<cfreturn this />
	</cffunction>
 
	<cffunction name="getGatewayFactory" access="public" returntype="GatewayFactory" output="false">
		<cfargument name="factoryType" type="string" required="Yes" />  
		<cfset var returnGatewayFactory = "">	  
		<cfswitch expression="#ucase(arguments.factoryType)#">
			<cfcase value="MSACCESS">
				<cfset returnGatewayFactory = createObject("component","GatewayFactory_msaccess").init(variables.dsn) />
			</cfcase>
			<cfcase value="MSSQL">
				<cfset returnGatewayFactory = createObject("component","GatewayFactory_mssql").init(variables.dsn) />
			</cfcase>
<!--- 			<cfcase value="MYSQL">
				<cfset returnGatewayFactory = createObject("component","GatewayFactory_mysql").init(variables.dsn) />
			</cfcase> --->
<!--- 			<cfcase value="POSTGRESQL">
				<cfset returnGatewayFactory = createObject("component","GatewayFactory_postgresql").init(variables.dsn) />
			</cfcase> --->
		</cfswitch>
		<cfreturn returnGatewayFactory />
	</cffunction>

	<cffunction name="getApplicationGateway" access="public" >
		<cfabort showerror="This Method is Abstract and needs to be overridden">
	</cffunction>

	<cffunction name="getCalendarGateway" access="public" >
		<cfabort showerror="This Method is Abstract and needs to be overridden">
	</cffunction>

	<cffunction name="getCategoryGateway" access="public" >
		<cfabort showerror="This Method is Abstract and needs to be overridden">
	</cffunction>

	<cffunction name="getEventGateway" access="public" >
		<cfabort showerror="This Method is Abstract and needs to be overridden">
	</cffunction>

	<cffunction name="getEventSeriesGateway" access="public" >
		<cfabort showerror="This Method is Abstract and needs to be overridden">
	</cffunction>

	<cffunction name="getGroupGateway" access="public" >
		<cfabort showerror="This Method is Abstract and needs to be overridden">
	</cffunction>

	<cffunction name="getHolidayGateway" access="public" >
		<cfabort showerror="This Method is Abstract and needs to be overridden">
	</cffunction>

	<cffunction name="getMailServerGateway" access="public" >
		<cfabort showerror="This Method is Abstract and needs to be overridden">
	</cffunction>

	<cffunction name="getMessageGateway" access="public" >
		<cfabort showerror="This Method is Abstract and needs to be overridden">
	</cffunction>
	
	<cffunction name="getReminderGateway" access="public" >
		<cfabort showerror="This Method is Abstract and needs to be overridden">
	</cffunction>

	<cffunction name="getSchemeGateway" access="public" >
		<cfabort showerror="This Method is Abstract and needs to be overridden">
	</cffunction>

	<cffunction name="getSearchIndexGateway" access="public" >
		<cfabort showerror="This Method is Abstract and needs to be overridden">
	</cffunction>

	<cffunction name="getUserGateway" access="public" >
		<cfabort showerror="This Method is Abstract and needs to be overridden">
	</cffunction>

</cfcomponent>