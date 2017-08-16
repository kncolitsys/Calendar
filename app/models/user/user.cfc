<cfcomponent displayname="user">

	<cfset variables.instance.userId = createUuid() />
	<cfset variables.instance.firstName = "" />
	<cfset variables.instance.lastName = "" />
	<cfset variables.instance.phone = "" />
	<cfset variables.instance.email = "" />
	<cfset variables.instance.comments = "" />
	<cfset variables.instance.username = "" />
	<cfset variables.instance.password = "" />
	<cfset variables.instance.timezone = "085" />
	<cfset variables.instance.permissions = structNew() />
	
	<cffunction name="init" access="public" returntype="user" output="false">
		<cfargument name="userId" type="string" required="false" default="#createUuid()#" />
		<cfargument name="firstName" type="string" required="false" default="" />
		<cfargument name="lastName" type="string" required="false" default="" />
		<cfargument name="phone" type="string" required="false" default="" />
		<cfargument name="email" type="string" required="false" default="" />
		<cfargument name="comments" type="string" required="false" default="" />
		<cfargument name="username" type="string" required="false" default="" />
		<cfargument name="password" type="string" required="false" default="" />
		<cfargument name="timezone" type="string" required="false" default="085" /> <!--- 085 = GMT --->
		<cfargument name="permissions" type="struct" required="false" default="#structNew()#" />
		
		<cfinvoke component="#this#" method="setInfo" info="#arguments#" />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setInfo" access="public" returntype="void" output="false">
		<cfargument name="info" type="struct" required="true" />
		
		<cfscript>
			setUserId(arguments.info.userId);
			setFirstName(arguments.info.firstName);
			setLastName(arguments.info.lastName);
			setPhone(arguments.info.phone);
			setEmail(arguments.info.email);
			setComments(arguments.info.comments);
			setUsername(arguments.info.username);
			setPassword(arguments.info.password);
			setTimeZone(arguments.info.timezone);
			setPermissions(arguments.info.permissions);
		</cfscript>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Object Getter/Setter methods
	------------------------------------------------------------------------------------->

	<cffunction name="setUserId" access="public" returntype="void" output="false">
		<cfargument name="userId" type="string" required="true" />
		<cfset variables.instance.userId = arguments.userId />
	</cffunction>
	<cffunction name="getUserId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.userId />
	</cffunction>
	
	<cffunction name="setFirstName" access="public" returntype="void" output="false">
		<cfargument name="firstName" type="string" required="true" />
		<cfset variables.instance.firstName = arguments.firstName />
	</cffunction>
	<cffunction name="getFirstName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.firstName />
	</cffunction>
	
	<cffunction name="setLastName" access="public" returntype="void" output="false">
		<cfargument name="lastName" type="string" required="true" />
		<cfset variables.instance.lastName = arguments.lastName />
	</cffunction>
	<cffunction name="getLastName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.lastName />
	</cffunction>
	
	<cffunction name="setPhone" access="public" returntype="void" output="false">
		<cfargument name="phone" type="string" required="true" />
		<cfset variables.instance.phone = arguments.phone />
	</cffunction>
	<cffunction name="getPhone" access="public" returntype="string" output="false">
		<cfreturn variables.instance.phone />
	</cffunction>
	
	<cffunction name="setEmail" access="public" returntype="void" output="false">
		<cfargument name="email" type="string" required="true" />
		<cfset variables.instance.email = arguments.email />
	</cffunction>
	<cffunction name="getEmail" access="public" returntype="string" output="false">
		<cfreturn variables.instance.email />
	</cffunction>
	
	<cffunction name="setComments" access="public" returntype="void" output="false">
		<cfargument name="comments" type="string" required="true" />
		<cfset variables.instance.comments = arguments.comments />
	</cffunction>
	<cffunction name="getComments" access="public" returntype="string" output="false">
		<cfreturn variables.instance.comments />
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
	
	<cffunction name="setTimeZone" access="public" returntype="void" output="false">
		<cfargument name="timezone" type="string" required="true" />
		<cfset variables.instance.timezone = arguments.timezone />
	</cffunction>
	<cffunction name="getTimeZone" access="public" returntype="string" output="false">
		<cfreturn variables.instance.timezone />
	</cffunction>

	<cffunction name="setPermissions" access="public" returntype="void" output="false">
		<cfargument name="permissions" type="struct" required="true" />
		<cfset variables.instance.permissions = arguments.permissions />
	</cffunction>
	<cffunction name="getPermissions" access="public" returntype="struct" output="false">
		<cfreturn variables.instance.permissions />
	</cffunction>
	
	<!------------------------------------------------------------------------------------
	// Transfer Object methods
	------------------------------------------------------------------------------------->
	
	<cffunction name="getUserTO" access="public" returntype="userTO" output="false">
		<cfreturn createUserTO() />
	</cffunction>
			
	<cffunction name="setUserFromTO" access="public" returntype="void" output="false" hint="set the instance data from TO">
		<cfargument name="userTO" type="userTO" required="true" />		
		<cfscript>
			setUserId(arguments.userTO.userId);
			setFirstName(arguments.userTO.firstName);
			setLastName(arguments.userTO.lastName);
			setPhone(arguments.userTO.phone);
			setEmail(arguments.userTO.email);
			setComments(arguments.userTO.comments);
			setUsername(arguments.userTO.username);
			setPassword(arguments.userTO.password);
			setTimeZone(arguments.userTO.timezone);
			setPermissions(arguments.userTO.permission);
		</cfscript>
	</cffunction>
	
	<cffunction name="createUserTO" access="package" returntype="userTO" output="false">
		<cfscript>
			var userTO = createObject("component", "userTO").init(argumentcollection=variables.instance);
			return userTO;
		</cfscript>
	</cffunction>
	
</cfcomponent>