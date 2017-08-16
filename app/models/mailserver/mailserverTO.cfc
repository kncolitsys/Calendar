<cfcomponent displayname="mailserverTO" access="public" hint="Mailserver Tranfer Object">

	<cffunction name="init" access="public" returntype="mailserverTO" output="false" displayname="MailserverTO Constructor" hint="Initializes the Mailserver Transfer Object">
		<cfargument name="mailserverId" type="string" required="false" default="#createUuid()#" />		
		<cfargument name="server" type="string" required="false" default="" />
		<cfargument name="port" type="numeric" required="false" default="25" />
		<cfargument name="timeout" type="numeric" required="false" default="0" />
		<cfargument name="mailerId" type="string" required="false" default="" />
		<cfargument name="username" type="string" required="false" default="" />
		<cfargument name="password" type="string" required="false" default="" />

		<cfscript>
			this.mailserverId = arguments.mailserverId;
			this.server = arguments.server;
			this.port = arguments.port;
			this.timeout = arguments.timeout;
			this.mailerId = arguments.mailerId;
			this.username = arguments.username;
			this.password = arguments.password;
			return this;
		</cfscript>
	</cffunction>

</cfcomponent>