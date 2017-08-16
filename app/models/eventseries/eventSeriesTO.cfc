<cfcomponent displayname="eventSeriesTO" access="public" hint="Event Series Tranfer Object">

	<cffunction name="init" access="public" returntype="eventSeriesTO" output="false" displayname="EventSeriesTO Constructor" hint="Initializes the Event Series Transfer Object">
		<cfargument name="seriesId" type="string" required="false" default="#createUuid()#" />
		<cfargument name="title" type="string" required="false" default="" />
		<cfargument name="description" type="string" required="false" default="" />
		<cfargument name="category" type="calendar.models.category.category" required="false" default="#createObject('component','calendar.models.category.category')#" />
		<cfargument name="eventUrl" type="string" required="false" default="" />
		<cfargument name="duration" type="numeric" required="false" default="0" />
		<cfargument name="location" type="string" required="false" default="" />
		<cfargument name="allDay" type="boolean" required="false" default="false" />
		<cfargument name="recurrence" type="boolean" required="false" default="false" />
		<cfargument name="recurrenceRule" type="string" required="false" default="" />
		<cfargument name="recurrenceStartDate" type="date" required="false" default="#now()#" />
		<cfargument name="recurrenceEndDate" type="date" required="false" default="#now()#" />
		<cfargument name="contactFirstName" type="string" required="false" default="" />
		<cfargument name="contactLastName" type="string" required="false" default="" />
		<cfargument name="contactPhone" type="string" required="false" default="" />
		<cfargument name="contactEmail" type="string" required="false" default="" />
		<cfargument name="comments" type="string" required="false" default="" />
		<cfargument name="approvedDate" type="date" required="false" default="#now()#" />
		<cfargument name="approvedBy" type="string" required="false" default="" />

		<cfscript>
			this.seriesId = arguments.seriesId;
			this.title = arguments.title;
			this.description = arguments.description;
			this.category = arguments.category;
			this.eventUrl = arguments.eventUrl;
			this.duration = arguments.duration;
			this.location = arguments.location;
			this.allDay = arguments.allDay;
			this.recurrence = arguments.recurrence;
			this.recurrenceRule = arguments.recurrenceRule;
			this.recurrenceStartDate = arguments.recurrenceStartDate;
			this.recurrenceEndDate = arguments.recurrenceEndDate;
			this.contactFirstName = arguments.contactFirstName;
			this.contactLastName = arguments.contactLastName;
			this.contactPhone = arguments.contactPhone;
			this.contactEmail = arguments.contactEmail;
			this.comments = arguments.comments;
			this.approvedDate = arguments.approvedDate;
			this.approvedBy = arguments.approvedBy;
			return this;
		</cfscript>
	</cffunction>

</cfcomponent>