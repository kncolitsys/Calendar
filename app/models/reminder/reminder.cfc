<cfcomponent displayname="reminder">

	<cfset variables.instance.reminderId = createUuid() />
	<cfset variables.instance.schedule = 3600 />
	<cfset variables.instance.methods = structNew() />
	<cfset variables.instance.user = createObject('component','calendar.models.user.user') />
	
	<cffunction name="init" access="public" returntype="reminder" output="false">
		<cfargument name="reminderId" type="string" required="false" default="#createUuid()#" />
		<cfargument name="schedule" type="numeric" required="false" default="3600" />
		<cfargument name="methods" type="struct" required="false" default="#structNew()#" />
		<cfargument name="user" type="calendar.models.user.user" required="false" default="#createObject('component','calendar.models.user.user')#" />
		
		<cfinvoke component="#this#" method="setInfo" info="#arguments#" />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setInfo" access="public" returntype="void" output="false">
		<cfargument name="info" type="struct" required="true" />
		
		<cfscript>
			setReminderId(arguments.info.reminderId);
			setSchedule(arguments.info.schedule);
			setMethods(arguments.info.methods);
			setUser(arguments.info.user);
		</cfscript>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Object Getter/Setter methods
	------------------------------------------------------------------------------------->

	<cffunction name="setReminderId" access="public" returntype="void" output="false">
		<cfargument name="reminderId" type="string" required="true" />
		<cfset variables.instance.reminderId = arguments.reminderId />
	</cffunction>
	<cffunction name="getReminderId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.reminderId />
	</cffunction>
	
	<cffunction name="setSchedule" access="public" returntype="void" output="false">
		<cfargument name="schedule" type="numeric" required="true" />
		<cfset variables.instance.schedule = arguments.schedule />
	</cffunction>
	<cffunction name="getSchedule" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.schedule />
	</cffunction>
	
	<cffunction name="setMethods" access="public" returntype="void" output="false">
		<cfargument name="methods" type="struct" required="true" />
		<cfset variables.instance.methods = arguments.methods />
	</cffunction>
	<cffunction name="getMethods" access="public" returntype="struct" output="false">
		<cfreturn variables.instance.methods />
	</cffunction>

	<cffunction name="setUser" access="public" returntype="void" output="false">
		<cfargument name="user" type="calendar.models.user.user" required="true" />
		<cfset variables.instance.user = arguments.user />
	</cffunction>
	<cffunction name="getUser" access="public" returntype="calendar.models.user.user" output="false">
		<cfreturn variables.instance.user />
	</cffunction>
	
	<!------------------------------------------------------------------------------------
	// Transfer Object methods
	------------------------------------------------------------------------------------->
	
	<cffunction name="getReminderTO" access="public" returntype="reminderTO" output="false">
		<cfreturn createReminderTO() />
	</cffunction>
			
	<cffunction name="setReminderFromTO" access="public" returntype="void" output="false" hint="set the instance data from TO">
		<cfargument name="reminderTO" type="reminderTO" required="true" />		
		<cfscript>
			setReminderId(arguments.reminderTO.reminderId);
			setSchedule(arguments.reminderTO.schedule);
			setMethods(arguments.reminderTO.methods);
			setUser(arguments.reminderTO.user);
		</cfscript>
	</cffunction>
	
	<cffunction name="createReminderTO" access="package" returntype="reminderTO" output="false">
		<cfscript>
			var reminderTO = createObject("component", "reminderTO").init(argumentcollection=variables.instance);
			return reminderTO;
		</cfscript>
	</cffunction>
	
</cfcomponent>