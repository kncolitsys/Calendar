<cfcomponent hint="SessionFacade" extends="MachII.framework.Listener">

	<cffunction name="init" access="public" returntype="SessionFacade" output="false" displayname="Init" >		
		<cfscript>
			return this;
		</cfscript>
	</cffunction>

	<cffunction name="closeSession" access="public" returntype="void" output="false" displayname="" hint="" >
		<cflogout>
		<cfset structDelete(session, "user", false) />
	</cffunction>

	<cffunction name="getStyle" access="public" returntype="struct" output="false" displayname="" hint="">
		<cfscript>
			if(not structKeyExists(session,"style")) {
				setStyle();
			}
			return session.style;
		</cfscript>
	</cffunction>

	<cffunction name="getUser" access="public" returntype="calendar.models.user.user" output="false" displayname="" hint="">
		<cfscript>
			if(hasUser())
				return session.user;
			else
				return createobject("component","calendar.models.user.user");
		</cfscript>
	</cffunction>

	<cffunction name="hasUser" access="public" returntype="boolean" output="false" displayname="" hint="" >
		<cfscript>
			return structKeyExists(session, "user");
		</cfscript>
	</cffunction>

	<cffunction name="isSessionAuthorized" access="public" returntype="boolean" output="false" displayname="" hint="">
		<cfargument name="requiredPrivileges" type="string" required="true" />

		<cfset var authorized = true />
		<cfloop index="permission" list="#arguments.requiredPrivileges#" delimiters=",">
			<cfif not isUserInRole(permission)>
				<cfset authorized = false />
			</cfif>
		</cfloop>
		<cfreturn authorized />
	</cffunction>

	<cffunction name="openSession" access="public" returntype="void" output="false" displayname="" hint="" >
		<cfargument name="user" type="calendar.models.user.user" required="true" />
		<cfargument name="privileges" type="string" required="true" />
	
		<cflogin idletimeout="1800">
			<cfloginuser name="#arguments.user.getUsername()#" password="apassword" roles="#arguments.privileges#">
		</cflogin>
		<cfscript>
			setUser(arguments.user);
		</cfscript>
	</cffunction>
	
	<cffunction name="setStyle" access="public" returntype="void" output="false">
		<cfargument name="type" type="string" required="false" default="file" />
		<cfargument name="stylesheet" type="string" required="false" default="stylesheets/schemes/2AE73F9F-F0E8-47EA-81242461228343B2.css" />
		
		<cfif not isDefined("session.style")>
			<cfset session.style = structNew() />
		</cfif>
		<cfset session.style.type = arguments.type />
		<cfset session.style.stylesheet = arguments.stylesheet />
	</cffunction>

	<cffunction name="setUser" access="public" returntype="void" output="false" displayname="" hint="">
		<cfargument name="user" required="true" type="calendar.models.user.user" />
		<cfset session.user = arguments.user >		
	</cffunction>

</cfcomponent>