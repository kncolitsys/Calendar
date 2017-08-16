<cfcomponent displayname="CalendarTO" access="public" hint="Calendar Tranfer Object">

	<cffunction name="init" access="public" returntype="calendarTO" output="false" displayname="CalendarTO Constructor" hint="Initializes the Calendar Transfer Object">
		<cfargument name="calendarId" type="string" required="false" default="#createUuid()#" />		
		<cfargument name="title" type="string" required="false" default="" />
		<cfargument name="status" type="string" required="false" default="pending" />
		<cfargument name="description" type="string" required="false" default="" />
		<cfargument name="header" type="string" required="false" default="" />
		<cfargument name="footer" type="string" required="false" default="" />
		<cfargument name="exitUrl" type="string" required="false" default="" />
		<cfargument name="scheme" type="calendar.models.scheme.scheme" required="false" default="#createobject('component','calendar.models.scheme.scheme').init()#" />
		<cfargument name="privileges" type="struct" required="false" default="#structNew()#" />
		<cfargument name="options" type="struct" required="false" default="#structNew()#" />

		<cfscript>
			this.calendarId = arguments.calendarId;
			this.title = arguments.title;
			this.status = arguments.status;
			this.description = arguments.description;
			this.header = arguments.header;
			this.footer = arguments.footer;
			this.exitUrl = arguments.exitUrl;
			this.scheme = arguments.scheme;
			this.privileges = arguments.privileges;
			this.options = arguments.options;
			return this;
		</cfscript>
	</cffunction>

</cfcomponent>