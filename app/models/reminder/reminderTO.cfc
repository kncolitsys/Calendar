<cfcomponent displayname="reminderTO" access="public" hint="Reminder Tranfer Object">

	<cffunction name="init" access="public" returntype="reminderTO" output="false" displayname="ReminderTO Constructor" hint="Initializes the Reminder Transfer Object">
		<cfargument name="reminderId" type="string" required="false" default="#createUuid()#" />		
		<cfargument name="schedule" type="numeric" required="false" default="3600" />
		<cfargument name="methods" type="struct" required="false" default="#structNew()#" />
		<cfargument name="user" type="calendar.models.user.user" required="false" default="#createObject('component','calendar.models.user.user')#" />

		<cfscript>
			this.reminderId = arguments.reminderId;
			this.schedule = arguments.schedule;
			this.methods = arguments.methods;
			this.user = arguments.user;
			return this;
		</cfscript>
	</cffunction>

</cfcomponent>