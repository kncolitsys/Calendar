<cfcomponent displayname="group">

	<cfset variables.instance.groupId = createUuid() />
	<cfset variables.instance.groupName = "" />
	<cfset variables.instance.comments = "" />
	<cfset variables.instance.members = structNew() />
	<cfset variables.instance.permissions = structNew() />
	
	<cffunction name="init" access="public" returntype="group" output="false">
		<cfargument name="groupId" type="string" required="false" default="#createUuid()#" />
		<cfargument name="groupName" type="string" required="false" default="" />
		<cfargument name="comments" type="string" required="false" default="" />
		<cfargument name="members" type="struct" required="false" default="#structNew()#" />
		<cfargument name="permissions" type="struct" required="false" default="#structNew()#" />
		
		<cfinvoke component="#this#" method="setInfo" info="#arguments#" />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setInfo" access="public" returntype="void" output="false">
		<cfargument name="info" type="struct" required="true" />
		
		<cfscript>
			setGroupId(arguments.info.groupId);
			setGroupName(arguments.info.groupName);
			setComments(arguments.info.comments);
			setMembers(arguments.info.members);
			setPermissions(arguments.info.permissions);
		</cfscript>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Object Getter/Setter methods
	------------------------------------------------------------------------------------->

	<cffunction name="setGroupId" access="public" returntype="void" output="false">
		<cfargument name="groupId" type="string" required="true" />
		<cfset variables.instance.groupId = arguments.groupId />
	</cffunction>
	<cffunction name="getGroupId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.groupId />
	</cffunction>
	
	<cffunction name="setGroupName" access="public" returntype="void" output="false">
		<cfargument name="groupName" type="string" required="true" />
		<cfset variables.instance.groupName = arguments.groupName />
	</cffunction>
	<cffunction name="getGroupName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.groupName />
	</cffunction>
	
	<cffunction name="setComments" access="public" returntype="void" output="false">
		<cfargument name="comments" type="string" required="true" />
		<cfset variables.instance.comments = arguments.comments />
	</cffunction>
	<cffunction name="getComments" access="public" returntype="string" output="false">
		<cfreturn variables.instance.comments />
	</cffunction>
	
	<cffunction name="setMembers" access="public" returntype="void" output="false">
		<cfargument name="members" type="struct" required="true" />
		<cfset variables.instance.members = arguments.members />
	</cffunction>
	<cffunction name="getMembers" access="public" returntype="struct" output="false">
		<cfreturn variables.instance.members />
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
	
	<cffunction name="getGroupTO" access="public" returntype="groupTO" output="false">
		<cfreturn createGroupTO() />
	</cffunction>
			
	<cffunction name="setGroupFromTO" access="public" returntype="void" output="false" hint="set the instance data from TO">
		<cfargument name="groupTO" type="groupTO" required="true" />		
		<cfscript>
			setGroupId(arguments.groupTO.groupId);
			setGroupName(arguments.groupTO.groupName);
			setComments(arguments.groupTO.comments);
			setMembers(arguments.groupTO.members);
			setPermissions(arguments.groupTO.permissions);
		</cfscript>
	</cffunction>
	
	<cffunction name="createGroupTO" access="package" returntype="groupTO" output="false">
		<cfscript>
			var groupTO = createObject("component", "groupTO").init(argumentcollection=variables.instance);
			return groupTO;
		</cfscript>
	</cffunction>
	
</cfcomponent>