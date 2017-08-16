<cfcomponent displayname="groupTO" access="public" hint="Group Tranfer Object">

	<cffunction name="init" access="public" returntype="groupTO" output="false" displayname="GroupTO Constructor" hint="Initializes the Group Transfer Object">
		<cfargument name="groupId" type="string" required="false" default="#createUuid()#" />		
		<cfargument name="groupName" type="string" required="false" default="" />
		<cfargument name="comments" type="string" required="false" default="" />
		<cfargument name="members" type="struct" required="false" default="#structNew()#" />
		<cfargument name="permissions" type="struct" required="false" default="#structNew()#" />

		<cfscript>
			this.groupId = arguments.groupId;
			this.groupName = arguments.groupName;
			this.comments = arguments.comments;
			this.members = arguments.members;
			this.permissions = arguments.permissions;
			return this;
		</cfscript>
	</cffunction>

</cfcomponent>