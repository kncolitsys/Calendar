<cfcomponent displayname="userTO" access="public" hint="User Tranfer Object">

	<cffunction name="init" access="public" returntype="userTO" output="false" displayname="UserTO Constructor" hint="Initializes the User Transfer Object">
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

		<cfscript>
			this.userId = arguments.userId;
			this.firstName = arguments.firstName;
			this.lastName = arguments.lastName;
			this.phone = arguments.phone;
			this.email = arguments.email;
			this.comments = arguments.comments;
			this.username = arguments.username;
			this.password = arguments.password;
			this.timezone = arguments.timezone;
			this.permissions = arguments.permissions;
			return this;
		</cfscript>
	</cffunction>

</cfcomponent>