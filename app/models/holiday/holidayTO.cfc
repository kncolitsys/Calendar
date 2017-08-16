<cfcomponent displayname="holidayTO" access="public" hint="Holiday Tranfer Object">

	<cffunction name="init" access="public" returntype="holidayTO" output="false" displayname="HolidayTO Constructor" hint="Initializes the Holiday Transfer Object">
		<cfargument name="holidayId" type="string" required="false" default="#createUuid()#" />		
		<cfargument name="title" type="string" required="false" default="" />
		<cfargument name="global" type="string" required="false" default="" />
		<cfargument name="recurrenceRule" type="string" required="false" default="" />
		<cfargument name="comments" type="string" required="false" default="" />

		<cfscript>
			this.holidayId = arguments.holidayId;
			this.title = arguments.title;
			this.global = arguments.global;
			this.recurrenceRule = arguments.recurrenceRule;
			this.comments = arguments.comments;
			return this;
		</cfscript>
	</cffunction>

</cfcomponent>

