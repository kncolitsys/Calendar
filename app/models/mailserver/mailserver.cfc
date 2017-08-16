<cfcomponent displayname="mailserver">

	<cfset variables.instance.mailserverId = createUuid() />
	<cfset variables.instance.server = "" />
	<cfset variables.instance.port = 25 />
	<cfset variables.instance.timeout = 0 />
	<cfset variables.instance.mailerId = "" />
	<cfset variables.instance.username = "" />
	<cfset variables.instance.password = "" />
	
	<cffunction name="init" access="public" returntype="mailserver" output="false">
		<cfargument name="mailserverId" type="string" required="false" default="#createUuid()#" />
		<cfargument name="server" type="string" required="false" default="" />
		<cfargument name="port" type="numeric" required="false" default="25" />
		<cfargument name="timeout" type="string" required="false" default="0" />
		<cfargument name="mailerId" type="string" required="false" default="" />
		<cfargument name="username" type="string" required="false" default="" />
		<cfargument name="password" type="string" required="false" default="" />
		
		<cfinvoke component="#this#" method="setInfo" info="#arguments#" />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setInfo" access="public" returntype="void" output="false">
		<cfargument name="info" type="struct" required="true" />
		
		<cfscript>
			setMailserverId(arguments.info.mailserverId);
			setServer(arguments.info.server);
			setPort(arguments.info.port);
			setTimeout(arguments.info.timeout);
			setMailerId(arguments.info.mailerId);
			setUsername(arguments.info.username);
			setPassword(arguments.info.password);
		</cfscript>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Object Getter/Setter methods
	------------------------------------------------------------------------------------->

	<cffunction name="setMailserverId" access="public" returntype="void" output="false">
		<cfargument name="mailserverId" type="string" required="true" />
		<cfset variables.instance.mailserverId = arguments.mailserverId />
	</cffunction>
	<cffunction name="getMailserverId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.mailserverId />
	</cffunction>
	
	<cffunction name="setServer" access="public" returntype="void" output="false">
		<cfargument name="server" type="string" required="true" />
		<cfset variables.instance.server = arguments.server />
	</cffunction>
	<cffunction name="getServer" access="public" returntype="string" output="false">
		<cfreturn variables.instance.server />
	</cffunction>
	
	<cffunction name="setPort" access="public" returntype="void" output="false">
		<cfargument name="port" type="numeric" required="true" />
		<cfset variables.instance.port = arguments.port />
	</cffunction>
	<cffunction name="getPort" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.port />
	</cffunction>
	
	<cffunction name="setTimeout" access="public" returntype="void" output="false">
		<cfargument name="timeout" type="numeric" required="true" />
		<cfset variables.instance.timeout = arguments.timeout />
	</cffunction>
	<cffunction name="getTimeout" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.timeout />
	</cffunction>
	
	<cffunction name="setMailerId" access="public" returntype="void" output="false">
		<cfargument name="mailerId" type="string" required="true" />
		<cfset variables.instance.mailerId = arguments.mailerId />
	</cffunction>
	<cffunction name="getMailerId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.mailerId />
	</cffunction>
	
	<cffunction name="setUsername" access="public" returntype="void" output="false">
		<cfargument name="username" type="string" required="true" />
		<cfset variables.instance.username = arguments.username />
	</cffunction>
	<cffunction name="getUsername" access="public" returntype="string" output="false">
		<cfreturn variables.instance.username />
	</cffunction>
	
	<cffunction name="setPassword" access="public" returntype="void" output="false">
		<cfargument name="password" type="string" required="true" />
		<cfset variables.instance.password = arguments.password />
	</cffunction>
	<cffunction name="getPassword" access="public" returntype="string" output="false">
		<cfreturn variables.instance.password />
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------
	// Transfer Object methods
	------------------------------------------------------------------------------------->
	
	<cffunction name="getMailserverTO" access="public" returntype="mailserverTO" output="false">
		<cfreturn createMailserverTO() />
	</cffunction>
			
	<cffunction name="setMailserverFromTO" access="public" returntype="void" output="false" hint="set the instance data from TO">
		<cfargument name="mailserverTO" type="mailserverTO" required="true" />		
		<cfscript>
			setMailserverId(arguments.mailserverTO.mailserverId);
			setServer(arguments.mailserverTO.server);
			setPort(arguments.mailserverTO.port);
			setTimeout(arguments.mailserverTO.timeout);
			setMailerId(arguments.mailserverTO.mailerId);
			setUsername(arguments.mailserverTO.username);
			setPassword(arguments.mailserverTO.password);
		</cfscript>
	</cffunction>
	
	<cffunction name="createMailserverTO" access="package" returntype="mailserverTO" output="false">
		<cfscript>
			var mailserverTO = createObject("component", "mailserverTO").init(argumentcollection=variables.instance);
			return mailserverTO;
		</cfscript>
	</cffunction>
	
</cfcomponent>